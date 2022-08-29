//
//  DailyWeatherDetailTableCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.08.2022.
//

import Foundation
import UIKit

struct DailyWeatherDetailTableCellModel {
    
    let date: String
    let feelsLikeDay: String
    let feelsLikeNight: String
    let dayTemperature: String
    let nightTemperature: String
    let probabilityOfRain: String
    let clouds: String
    let windSpeed: String
    let windDirection: String
    let description: String
    let dayIcon: UIImage
    let nightIcon: UIImage
//    let moonrise: String
//    let moonset: String
//    let sunrise: String
//    let sunset: String
    
}


extension DailyWeatherDetailTableCellModel  {
    
    init(with dailyWeather: DailyWeather) {
        self.date = {
            let stringToFormat = dailyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date!)
        }()
        
        self.dayTemperature = {
            let tempInCelsius = dailyWeather.dayTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.nightTemperature = {
            let tempInCelsius = dailyWeather.nightTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.feelsLikeDay = {
            let tempInCelsius = dailyWeather.feelsLikeMaxTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.feelsLikeNight = {
            let tempInCelsius = dailyWeather.feelsLikeMaxTemperature
            return convertTemperature(tempInCelsius: tempInCelsius)
        }()
        
        self.probabilityOfRain = String(Int(dailyWeather.probabilityOfRain))
        
        self.clouds = String((Int(dailyWeather.clouds)))
        
        self.windSpeed = {
            let speedInMetric = dailyWeather.windSpeed
            return convertSpeed(speedInMetric: speedInMetric)
        }()

        self.windDirection = dailyWeather.windDirection
        
        self.description = dailyWeather.description.verbalDesctiption
        
        self.dayIcon = {
            let code = dailyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.dayImage
        }()
        
        self.nightIcon = {
            let code = dailyWeather.description.iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage.nightImage
        }()
        
        // to do: timestamp
//        self.moonrise = dailyWeather.moonrise
//        self.moonset = dailyWeather.moonset
//        self.sunrise = dailyWeather.sunrise
//        self.sunset = dailyWeather.sunset
        
    }
    
}
