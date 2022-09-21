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
    let nightTemperature: String
    let dayTemperature: String
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
        
        self.nightTemperature = {
            let tempInCelsius = dailyWeather.nightTemperature
            return Converter.shared.convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.dayTemperature = {
            let tempInCelsius = dailyWeather.dayTemperature
            return Converter.shared.convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.onSelect = onSelect
        
    }
}
