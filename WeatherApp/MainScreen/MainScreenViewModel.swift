//
//  MainScreenViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 06.08.2022.
//

import Foundation
import UIKit
import CoreLocation


protocol MainScreenViewOutput: AnyObject {
    
    var onOpenHourlyWeather: (([HourlyWeather]) -> Void)? { get set }
    
    var onOpenDailyWeather: (([DailyWeather], DailyWeather) -> Void)? { get set }
    
    var onOpenSettings: (() -> Void)? { get set }
    
    var onOpenLocationSelection: (() -> Void)? { get set }
    
}

enum MainScreenDataSourceSection {
    
    case basic([MainScreenDataSourceItem])
    case withHeader(WeatherTableHeaderModel, [MainScreenDataSourceItem])
}

enum MainScreenDataSourceItem {
    
    case currentWeatherCard(MainInfoTableCellModel)
    case hourlyWeather(HourlyWeatherTableCellModel)
    case dailyWeather(DailyWeatherTableCellModel)
}

struct MainScreenWeatherFetchResponse: Codable {
    
    var currentWeather: CurrentWeather
    var hourlyWeather: [HourlyWeather]
    var dailyWeather: [DailyWeather]
    
}


class MainScreenViewModel: MainScreenViewOutput {
    
    private let userDefaults = UserDefaults.standard
    private let key = "savedWeather"
    
    public var onOpenSettings: (() -> Void)?
    public var onOpenLocationSelection: (() -> Void)?
    public var onOpenHourlyWeather: (([HourlyWeather]) -> Void)?
    public var onOpenDailyWeather: (([DailyWeather], DailyWeather) -> Void)?
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: MainScreenView!
    
    private var location: Location {
        if let savedLocation = userDefaults.object(forKey: "selectedLocation") {
            do {
                let location = try JSONDecoder().decode(Location.self, from: savedLocation as! Data)
                return location
            } catch {
                print("Unable to decode weather (\(error))")
            }
        } else {
            return staticLocation ?? locationService.currentLocation ?? Location(city: "000", country: "000", longitude: "0000", latitude: "0000")
        }
        return Location(city: "000", country: "000", longitude: "0000", latitude: "0000")
    }
    
    private var staticLocation: Location?
    
    init(view: MainScreenView, location: Location?) {
        self.view = view
        self.staticLocation = location
        
        subscribeToSettingsUpdates()
    }
    
    private let currentDate = Date()
    
    var sections: [MainScreenDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    private var fetchResults: MainScreenWeatherFetchResponse? {
        didSet {
            if let fetchResults = fetchResults {
                sections = mapToViewModel(fetchResults: fetchResults)
            } else {
                sections = []
            }
        }
    }
    
    var city: String {
        return "\(location.city), \(location.country)"
    }
    
    public func showSettings(){
        onOpenSettings?()
    }
    
    public func showLocationSelection(){
        onOpenLocationSelection?()
    }
    
    private func subscribeToSettingsUpdates() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SettingsUpdated"), object: nil, queue: .main) { notification in
            guard let fetchResults = self.fetchResults else { return }
            self.sections = self.mapToViewModel(fetchResults: fetchResults)
        }
    }
    
    func onViewDidLoad() {
        configureDataFromCache()
        fetchData()
    }
    
    private func configureDataFromCache() {
        if let savedWeather = userDefaults.object(forKey: key) {
            do {
                let savedWeather = try JSONDecoder().decode(MainScreenWeatherFetchResponse.self, from: savedWeather as! Data)
                self.sections = self.mapToViewModel(fetchResults: savedWeather)
            } catch {
                print("Unable to decode weather (\(error))")
            }
        }
    }
    
    
    private func fetchData() {

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
                self.fetchResults = nil
                return
            }
            
            guard let resultHourlyWeather = resultHourlyWeather else {
                self.fetchResults = nil
                return
            }
            
            guard let resultDailyWeather = resultDailyWeather else {
                self.fetchResults = nil
                return
            }
            
            self.fetchResults = MainScreenWeatherFetchResponse(
                currentWeather: resultCurrentWeather,
                hourlyWeather:resultHourlyWeather,
                dailyWeather: resultDailyWeather
            )
            
            self.saveDataToCache()
        }
    }
    
    private func saveDataToCache() {
        do {
            let data = try JSONEncoder().encode(fetchResults)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Unable to encode weather (\(error))")
        }
    }
    
    private func mapToViewModel(fetchResults: MainScreenWeatherFetchResponse) -> [MainScreenDataSourceSection] {
        var resultSections: [MainScreenDataSourceSection] = []
        
        resultSections.append(.basic([
            .currentWeatherCard(
                MainInfoTableCellModel(
                    cells: [
                        MainInfoCellModel(
                            with: fetchResults.currentWeather,
                            dailyWeather: fetchResults.dailyWeather[0],
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
                        self?.onOpenHourlyWeather?(fetchResults.hourlyWeather)
                    }
                ),
                [
                    .hourlyWeather(
                        HourlyWeatherTableCellModel(
                            cells: fetchResults.hourlyWeather.map { HourlyWeatherCellModel(with: $0) }
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
                        self?.onOpenDailyWeather?(fetchResults.dailyWeather, fetchResults.dailyWeather[0])
                    }
                ),
                fetchResults.dailyWeather.map { model in
                    MainScreenDataSourceItem.dailyWeather(
                        DailyWeatherTableCellModel(
                            with: model,
                            onSelect: { [weak self] in
                                self?.onOpenDailyWeather?(fetchResults.dailyWeather, model)
                                // To do?
                            }
                        )
                    )}
            )
        )
        
        return resultSections
    }
    
}
