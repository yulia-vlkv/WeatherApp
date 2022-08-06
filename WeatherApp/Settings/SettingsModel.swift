//
//  SettingsModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation

final class SettingsModel {
    
    public static let shared = SettingsModel()
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys {
        
        static let tempType = "tempType"
        static let systemType = "systemType"
        static let timeType = "timeType"
        static let notifications = "notifications"
    }

    public var temperatureSettings: tempType {
        get {
            guard let rawItem = userDefaults.string(forKey: Keys.tempType),
                  let resultItem = tempType(rawValue: rawItem) else {
                return .celsius
            }
            return resultItem
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.tempType)
        }
    }
    
    public var windSpeedSettingss: systemType {
        get {
            guard let rawItem = userDefaults.string(forKey: Keys.systemType),
                  let resultItem = systemType(rawValue: rawItem) else {
                return .metric
            }
            return resultItem
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.systemType)
        }
    }
    
    public var timeFormatSettings: timeType {
        get {
            guard let rawItem = userDefaults.string(forKey: Keys.timeType),
                  let resultItem = timeType(rawValue: rawItem) else {
                return .twentyFourHourClock
            }
            return resultItem
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.timeType)
        }
    }
    
    public var notificationsSettings: notifications {
        get {
            guard let rawItem = userDefaults.string(forKey: Keys.notifications),
                  let resultItem = notifications(rawValue: rawItem) else {
                return .off
            }
            return resultItem
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.notifications)
        }
    }
    
}

enum tempType: String, CaseIterable {
    
    case celsius = "C"
    case fahrenheit = "F"

}

enum systemType: String, CaseIterable {
    
    case metric = "Km"
    case imperial = "Mi"

}

enum timeType: String, CaseIterable {
    
    case twelveHourClock = "12"
    case twentyFourHourClock = "24"

}

enum notifications: String, CaseIterable {
    
    case off = "Off"
    case on = "On"

}
