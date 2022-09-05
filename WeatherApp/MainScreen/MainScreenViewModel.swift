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
    
    public var onOpenSettings: (() -> Void)?
    public var onOpenHourlyWeather: (([HourlyWeather]) -> Void)?
    public var onOpenDailyWeather: (([DailyWeather]) -> Void)?
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: MainScreenView!
    
    init(view: MainScreenView) {
        self.view = view
    }
    
    private let currentDate = Date()
    
    var sections: [MainScreenDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    var city: String = {
        let location = LocationService.shared.locations?[0] ?? Location(city: "Белград", country: "Сербия", longitude: "44.787197", latitude: "20.457273")
        return "\(location.city), \(location.country)"
    }()
    
    func fetchData() {
//        guard let location = locationService.currentLocation else {
//            print("No current location!")
//            return
//        }
        
        let location = locationService.locations?[0] ?? Location(city: "Белград", country: "Сербия", longitude: "44.787197", latitude: "20.457273")
        
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
                                                        hourlyWeather.map { HourlyWeatherCellModel(with: $0) }
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
                            self?.onOpenDailyWeather?(dailyWeather)
                        }
                    ),
                    dailyWeather.map {
                        MainScreenDataSourceItem.dailyWeather(
                            DailyWeatherTableCellModel(
                                with: $0,
                                onSelect: { [weak self] in
                                    self?.onOpenDailyWeather?(dailyWeather)
                                    // To do? 
                                }
                            )
                        )}
            )
        )
        
        return resultSections
    }
    
}
