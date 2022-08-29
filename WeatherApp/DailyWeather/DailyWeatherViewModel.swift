//
//  DailyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 26.08.2022.
//

import Foundation


enum DailyWeatherDataSourceSection {
    
    case dateScroll(DateScrollTableCellModel)
    case dailyWeatherDetails([DailyWeatherDetailTableCellModel])
}

class DailyWeatherViewModel: DailyWeatherScreenViewOutput {
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: DailyWeatherView!
    private var dailyWeather: [DailyWeather]
    
    init(view: DailyWeatherView, model: [DailyWeather]) {
        self.view = view
        self.dailyWeather = model
    }
    
    private let currentDate = Date()
    
    var city: String = "Город, страна"
    
    var sections: [DailyWeatherDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    func mapToViewModel() -> [DailyWeatherDataSourceSection] {
        var resultSections: [DailyWeatherDataSourceSection] = []
        
        resultSections.append(
            .dateScroll(
                DateScrollTableCellModel(
                    cells:
                        dailyWeather.map { DateScrollCellModel(with: $0) }
                )
            )
        )
        
        resultSections.append(
            .dailyWeatherDetails(
                dailyWeather.map { DailyWeatherDetailTableCellModel(with: $0) }
            )
        )
        
        return resultSections
    }
    
}
