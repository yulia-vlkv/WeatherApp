//
//  HourlyWeatherCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 19.08.2022.
//

import Foundation
import UIKit


struct HourlyWeatherCellModel {
    
    let time: String
    let icon: UIImage
    let temperature: String
    
}

extension HourlyWeatherCellModel  {
    
    init(with hourlyWeather: HourlyWeather) {
        self.time =  {
            let stringToFormat = hourlyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "HH"
            let time = dateFormatter.string(from: date!)
            return time
        }()
        
        self.icon = {
            let code = hourlyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.dayImage
        }()
        
        self.temperature = {
            let tempInCelsius = hourlyWeather.currentTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
    }
}
