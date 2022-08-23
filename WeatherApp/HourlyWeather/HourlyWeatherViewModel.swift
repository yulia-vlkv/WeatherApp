//
//  HourlyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import CoreLocation


enum HourlyWeatherDataSourceSection {
    
    case basic([HourlyWeatherDataSourceItem])
    case withHeader(WeatherTableHeaderModel, [HourlyWeatherDataSourceItem])
}

enum HourlyWeatherDataSourceItem {
    
    case temperatureChart(MainInfoTableCellModel)
    case hourlyWeatherDetails(HourlyWeatherTableCellModel)

}


class HourlyWeatherViewModel {
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: HourlyWeatherView!
    
    init(view: HourlyWeatherView) {
        self.view = view
    }
    
    private let currentDate = Date()
    
    var city: String = "Город, страна"
    var sections: [HourlyWeatherDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }


    
}
