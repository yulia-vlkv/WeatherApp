//
//  HourlyWeatherDetailsTableCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 21.08.2022.
//

import Foundation
import UIKit

struct HourlyWeatherDetailsTableCellModel {
    
    var date: String
    var time: String
    var currentTemperature: String
    var feelsLikeTemperature: String
    var probabilityOfRain: String
    var clouds: String
    var windSpeed: String
    var windDirection: String
    var description: String
    var icon: UIImage
    
}


extension HourlyWeatherDetailsTableCellModel  {
    
    init(with hourlyWeather: HourlyWeather) {
        self.date = {
            let stringToFormat = hourlyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date!)
        }()
        
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
        
        self.currentTemperature = {
            let tempInCelsius = hourlyWeather.currentTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.feelsLikeTemperature = {
            let tempInCelsius = hourlyWeather.feelsLikeTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.probabilityOfRain = String(Int(hourlyWeather.probabilityOfRain))
        
        self.clouds = String((Int(hourlyWeather.clouds)))
        
        self.windSpeed = {
            let speedInMetric = hourlyWeather.windSpeed
            return convertSpeed(speedInMetric: speedInMetric)
        }()

        self.windDirection = hourlyWeather.windDirection
        
        self.description = hourlyWeather.description.verbalDesctiption
        
        self.icon = {
            let code = hourlyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.dayImage
        }()
        
    }
    
}

