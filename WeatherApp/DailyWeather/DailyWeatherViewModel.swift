//
//  DailyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 26.08.2022.
//

import Foundation


enum DailyWeatherDataSourceSection {
    
    case dateScroll(DateScrollTableCellModel)
    case dailyWeatherDetails(DailyWeatherDetailTableCellModel)
}

class DailyWeatherViewModel: DailyWeatherScreenViewOutput {
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let settings = SettingsModel.shared
    
    private weak var view: DailyWeatherView!
    private var dailyWeather: [DailyWeather]
    private var selectedWeather: DailyWeather?
    
    init(view: DailyWeatherView, model: [DailyWeather], selectedModel: DailyWeather?) {
        self.view = view
        self.dailyWeather = model
        self.selectedWeather = selectedModel ?? model.first
    }
    
    private let currentDate = Date()
    
//    var city: String = "Город, страна"
    
    var sections: [DailyWeatherDataSourceSection] = [] {
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
    
    private func mapToViewModel() -> [DailyWeatherDataSourceSection] {
        var resultSections: [DailyWeatherDataSourceSection] = []
        
        resultSections.append(
            .dateScroll(
                DateScrollTableCellModel(
                    cells: dailyWeather.map { currentWeather in
                        DateScrollCellModel(with: currentWeather, onSelect: { [weak self] in
                            self?.selectedWeather = currentWeather
                            self?.reloadData()
                        })
                    }
                )
            )
        )
        
        if let selectedWeather = selectedWeather {
            resultSections.append(
                .dailyWeatherDetails(
                    DailyWeatherDetailTableCellModel(with: selectedWeather)
                )
            )
        }
        
        return resultSections
    }
    
}
