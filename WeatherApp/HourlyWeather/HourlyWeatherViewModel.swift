//
//  HourlyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import UIKit
import Foundation
import CoreLocation


protocol HourlyWeatherScreenViewOutput: AnyObject {
    
}


enum HourlyWeatherDataSourceSection {
    
    case temperatureChart([PointEntry])
    case hourlyWeatherDetails([HourlyWeatherDetailsTableCellModel])
    
}


class HourlyWeatherViewModel: HourlyWeatherScreenViewOutput {
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: HourlyWeatherView!
    private var hourlyWeather: [HourlyWeather]
    
    init(view: HourlyWeatherView, model: [HourlyWeather]) {
        self.view = view
        self.hourlyWeather = model
    }
    
    var sections: [HourlyWeatherDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    public func viewDidLoad() {
        reloadData()
    }
    
    private func reloadData() {
        sections = mapToViewModel()
    }
    
    func mapToViewModel() -> [HourlyWeatherDataSourceSection] {
        var resultSections: [HourlyWeatherDataSourceSection] = []
        
        resultSections.append(
            .temperatureChart(
                hourlyWeather.map { PointEntry(with: $0) }
            )
        )
        
        resultSections.append(
            .hourlyWeatherDetails(
                hourlyWeather.map { HourlyWeatherDetailsTableCellModel(with: $0)}
            )
        )
        
        return resultSections
    }
    
}
