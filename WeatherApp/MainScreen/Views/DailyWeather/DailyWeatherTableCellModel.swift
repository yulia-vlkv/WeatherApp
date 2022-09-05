//
//  DailyWeatherTableCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 19.08.2022.
//

import Foundation
import UIKit


struct DailyWeatherTableCellModel {
    
    let date: String
    let icon: UIImage
    let description: String
    let lowestTemperature: String
    let highestTemperature: String
    let onSelect: (() -> Void)?
    
}

extension DailyWeatherTableCellModel  {
    
    init(with dailyWeather: DailyWeather, onSelect: (() -> Void)?) {
        
        self.date = {
            let stringToFormat = dailyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date!)
        }()
        
        self.icon = {
            let code = dailyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.dayImage
        }()
        
        self.description = dailyWeather.description.verbalDesctiption
        
        self.lowestTemperature = {
            let tempInCelsius = dailyWeather.lowestTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.highestTemperature = {
            let tempInCelsius = dailyWeather.highestTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.onSelect = onSelect
        
    }
}
