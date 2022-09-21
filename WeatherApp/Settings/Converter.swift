//
//  Converter.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 12.09.2022.
//

import Foundation


class Converter {
    
    static var shared = Converter()
    
    private var currentSettings = SettingsModel.shared
    
    public func convertTemperature(tempInCelsius: Float) -> String {
        let currentSettings = currentSettings.temperatureSettings
        if currentSettings == .celsius {
            return String(Int(tempInCelsius.rounded()))
        } else {
            let fahrenheit = tempInCelsius * 1.8 + 32
            return String(Int(fahrenheit.rounded()))
        }
    }

    public func convertSpeed(speedInMetric: Float) -> String {
        let currentSettings = currentSettings.windSpeedSettingss
        if currentSettings == .metric {
            return "\(Int((speedInMetric * 3.6).rounded())) км/ч"
        } else {
            let milesPerHour =  Int((speedInMetric * 2.236942).rounded())
            return "\(milesPerHour) mph"
        }
    }
    
    public func convertTime(timeFormat: String) -> String {
        let currentSettings = currentSettings.timeFormatSettings
        
        return timeFormat
    }
    
}
