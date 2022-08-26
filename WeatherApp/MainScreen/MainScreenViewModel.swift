//
//  MainScreenViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 06.08.2022.
//

import Foundation
import UIKit
import CoreLocation

enum MainScreenDataSourceSection {
    
    case basic([MainScreenDataSourceItem])
    case withHeader(WeatherTableHeaderModel, [MainScreenDataSourceItem])
}

enum MainScreenDataSourceItem {
    
    case currentWeatherCard(MainInfoTableCellModel)
    case hourlyWeather(HourlyWeatherTableCellModel)
    case dailyWeather(DailyWeatherTableCellModel)
}


class MainScreenViewModel: MainScreenViewOutput {
    
    public var onOpenHourlyWeather: (([HourlyWeather]) -> Void)?
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: MainScreenView!
    
    init(view: MainScreenView) {
        self.view = view
    }
    
    private let currentDate = Date()
    
    var city: String = "Город, страна"
    var sections: [MainScreenDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }

    func fetchData() {
//        guard let location = locationService.currentLocation else {
//            print("No current location!")
//            return
//        }
        
        let location = locationService.currentLocation ?? CLLocationCoordinate2D(latitude: 20.457273, longitude: 44.787197)
        
        let group = DispatchGroup()
        
        group.enter()
        var resultCurrentWeather: CurrentWeather?
        forecastService.getCurrentWeather(
            with: .init(
                longitude: location.longitude,
                latitude: location.latitude,
                units: .metric
            )) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let currentWeather):
                    resultCurrentWeather = currentWeather
                }
                group.leave()
            }
        
        group.enter()
        var resultHourlyWeather: [HourlyWeather]?
        forecastService.getHourlyWeather (
            with: .init(
                longitude: location.longitude,
                latitude: location.latitude,
                units: .metric
            )) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let hourlyWeather):
                    resultHourlyWeather = hourlyWeather
                }
                group.leave()
            }

        group.enter()
        var resultDailyWeather: [DailyWeather]?
        forecastService.getDailyWeather(
            with: .init(
                longitude: location.longitude,
                latitude: location.latitude,
                units: .metric
            )) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let dailyWeather):
                    resultDailyWeather = dailyWeather
                }
                group.leave()
            }

        group.notify(queue: .main) {
            guard let resultCurrentWeather = resultCurrentWeather else {
                self.sections = []
                return
            }
            
            guard let resultHourlyWeather = resultHourlyWeather else {
                self.sections = []
                return
            }
            
            guard let resultDailyWeather = resultDailyWeather else {
                self.sections = []
                return
            }
            
            self.sections = self.mapToViewModel(currentWeather: resultCurrentWeather, hourlyWeather: resultHourlyWeather, dailyWeather: resultDailyWeather)
        }
    }
    
    func mapToViewModel(currentWeather: CurrentWeather, hourlyWeather: [HourlyWeather], dailyWeather: [DailyWeather]) -> [MainScreenDataSourceSection] {
        var resultSections: [MainScreenDataSourceSection] = []
        
        resultSections.append(.basic([
            .currentWeatherCard(
                MainInfoTableCellModel(
                    cells: [
                        MainInfoCellModel(
                            with: currentWeather,
                            dailyWeather: dailyWeather[0],
                            currentDate: currentDate
                        )
                    ]
                )
            )
        ]))
        
        resultSections.append(
            .withHeader(
                WeatherTableHeaderModel(
                    titleText: nil,
                    buttonText: "Подробнее на 24 часа",
                    onButtonTap: { [weak self] in
                        self?.onOpenHourlyWeather?(hourlyWeather)
                    }
                ),
                [
                    .hourlyWeather(
                        HourlyWeatherTableCellModel(cells:
                            getEveryThirdCell(cellsArray: hourlyWeather)
                        )
                    )
                ]
            )
        )
        
        resultSections.append(
            .withHeader(
                    WeatherTableHeaderModel(
                        titleText: "Ежедневный прогноз",
                        buttonText: "16 дней",
                        onButtonTap: { [weak self] in
                            self?.onOpenHourlyWeather?(hourlyWeather)
                        }
                    ),
                    getEveryDailyCell(cellsArray: dailyWeather)
            )
        )
        
        return resultSections
    }
    
    // To do 
    private func getEveryThirdCell(cellsArray: [HourlyWeather]) -> [HourlyWeatherCellModel] {
        var newArray: [HourlyWeatherCellModel] = []
        var i = 0
        while i < cellsArray.count {
            let item = HourlyWeatherCellModel(with: cellsArray[i])
            i += 3
            newArray.append(item)
        }
        return newArray
    }
    
    private func getEveryDailyCell(cellsArray: [DailyWeather]) -> [MainScreenDataSourceItem] {
        var newArray: [MainScreenDataSourceItem] = []
        for i in cellsArray {
            let item = MainScreenDataSourceItem.dailyWeather(DailyWeatherTableCellModel(with: i))
            newArray.append(item)
        }
        return newArray
    }
    
}
