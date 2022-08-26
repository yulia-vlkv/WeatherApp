//
//  MainInfoCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 19.08.2022.
//

import Foundation


struct MainInfoCellModel {
    
    let currentTemperature: String
    let lowestTemperature: String
    let highestTemperature: String
    let verbalDescription: String
    let clouds: String
    let windSpeed: String
    let humidity: String
    let sunriseTime: String
    let sunsetTime: String
    let dateTime: String
    let dayOfWeek: String
    
    init(with currentWeather: CurrentWeather, dailyWeather: DailyWeather, currentDate: Date) {
        
        self.currentTemperature = {
            let tempInCelsius = currentWeather.currentTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.lowestTemperature = {
            let tempInCelsius = dailyWeather.lowestTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.highestTemperature = {
            let tempInCelsius = dailyWeather.highestTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.verbalDescription = currentWeather.description.verbalDesctiption
        
        self.clouds = String(Int(currentWeather.clouds))
        
        self.windSpeed = {
            let speedInMetric = currentWeather.windSpeed
            return convertSpeed(speedInMetric: speedInMetric)
        }()
        
        self.humidity = String(Int(currentWeather.humidity))
        
        self.sunriseTime = currentWeather.sunrise
        
        self.sunsetTime = currentWeather.sunset
        
        self.dateTime =  {
            let date = currentDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            if SettingsModel.shared.timeFormatSettings.rawValue == "24" {
                dateFormatter.dateFormat = "HH:mm, d MMMM"
            } else {
                dateFormatter.dateFormat = "h:mm a, d MMMM"
            }
            return dateFormatter.string(from: date)
        }()
        
        self.dayOfWeek = {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "EE"
            let result = dateFormatter.string(from: date)
            return result.lowercased()
        }()
    }
}

public func convertTemperature(tempInCelsius: Float) -> String {
    let currentSettings = SettingsModel.shared.temperatureSettings
    if currentSettings == .celsius {
        return String(Int(tempInCelsius.rounded()))
    } else {
        let fahrenheit = tempInCelsius * 1.8 + 32
        return String(Int(fahrenheit.rounded()))
    }
}

public func convertSpeed(speedInMetric: Float) -> String {
    let currentSettings = SettingsModel.shared.windSpeedSettingss
    if currentSettings == .metric {
        return "\(Int((speedInMetric * 3600).rounded())) км/ч"
    } else {
        let milesPerHour =  Int((speedInMetric * 2.236942).rounded())
        return "\(milesPerHour) mph"
    }
}
