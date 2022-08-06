//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation
import UIKit

final class SettingsViewModel {
    
    private let settingsModel = SettingsModel.shared
    
    var temperatureOption: SettingsOptionView.Model!
    var windSpeedOption: SettingsOptionView.Model!
    var timeFormatOption: SettingsOptionView.Model!
    var notificationsOption: SettingsOptionView.Model!
    
    init() {
        fetchSettings()
    }
    
    private func fetchSettings() {
        
        temperatureOption = SettingsOptionView.Model(
            title: "Температура",
            values: tempType.allCases.map { $0.rawValue },
            selectedValue: settingsModel.temperatureSettings.rawValue,
            valueChanged: { newValue in
                if let newSettings = tempType(rawValue: newValue) {
                    self.settingsModel.temperatureSettings = newSettings
                }
            }
        )
        
        windSpeedOption = SettingsOptionView.Model(
            title: "Скорость ветра",
            values: systemType.allCases.map { $0.rawValue },
            selectedValue: settingsModel.windSpeedSettingss.rawValue,
            valueChanged: { newValue in
                if let newSettings = systemType(rawValue: newValue) {
                    self.settingsModel.windSpeedSettingss = newSettings
                }
            }
        )
        
        timeFormatOption = SettingsOptionView.Model(
            title: "Формат времени",
            values: timeType.allCases.map { $0.rawValue },
            selectedValue: settingsModel.timeFormatSettings.rawValue,
            valueChanged: { newValue in
                if let newSettings = timeType(rawValue: newValue) {
                    self.settingsModel.timeFormatSettings = newSettings
                }
            }
        )
        
        notificationsOption = SettingsOptionView.Model(
            title: "Уведомления",
            values: notifications.allCases.map { $0.rawValue },
            selectedValue: settingsModel.notificationsSettings.rawValue,
            valueChanged: { newValue in
                if let newSettings = notifications(rawValue: newValue) {
                    self.settingsModel.notificationsSettings = newSettings
                }
                
            }
        )
    }
    
}
