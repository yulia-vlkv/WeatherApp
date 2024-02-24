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
            return Converter.shared.convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.lowestTemperature = {
            let tempInCelsius = dailyWeather.lowestTemperature
            return  Converter.shared.convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.highestTemperature = {
            let tempInCelsius = dailyWeather.highestTemperature
            return Converter.shared.convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.verbalDescription = currentWeather.description.verbalDesctiption
        
        self.clouds = String(Int(currentWeather.clouds))
        
        self.windSpeed = {
            let speedInMetric = currentWeather.windSpeed
            return Converter.shared.convertSpeed(speedInMetric: speedInMetric)
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


