//
//  Icon.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 16.08.2022.
//

import Foundation
import UIKit

struct Icon: Codable {
    
    var iconCode: Int
    var verbalDesctiption: String
    
    enum CodingKeys: String, CodingKey {
        case iconCode = "code"
        case verbalDesctiption = "description"
    }
}

// Тип иконки
enum WeatherIconType {
    case clearSky
    case cloudly
    case thunder
    case snow
    case rain
    case fog
    case unknown
}

extension WeatherIconType {
    
    init(code: Int) {
        let clearSky = [800]
        let cloudy = [801, 802, 803, 804]
        let thunder = [200, 201, 202, 230, 231, 232, 233]
        let snow = [600, 601, 602, 610, 611, 612, 621, 622, 623]
        let rain = [300, 301, 302, 500, 501, 502, 511, 520, 521, 522]
        let fog = [700, 711, 721, 731, 741, 751]
        
        if clearSky.contains(code) {
            self = .clearSky
        } else if cloudy.contains(code) {
            self = .cloudly
        } else if thunder.contains(code) {
            self = .thunder
        } else if snow.contains(code) {
            self = .snow
        } else if rain.contains(code) {
            self = .rain
        } else if fog.contains(code) {
            self = .fog
        } else {
            self = .unknown
        }
    }
}


class WeatherIcon {
    
    // Получаемый код иконки
    let code: Int
    // Тип иконки
    let weaterIconType: WeatherIconType
    // Изображение
    let iconImage: IconImage

    init (code: Int) {
        self.code = code
        self.weaterIconType = WeatherIconType(code: code)
        self.iconImage = WeatherIcon.getImage(for: self.weaterIconType)
    }
    
    // Функция, которая выдает изображение по типу иконки
    private static func getImage(for type: WeatherIconType) -> IconImage {
        
        switch type {
        case .clearSky:
            return IconImage(dayImage: UIImage(systemName: "sun.max.fill")!,
                             nightImage: UIImage(systemName: "moon.stars.fill")!)
        case .cloudly:
            return IconImage(dayImage: UIImage(systemName: "cloud.sun.fill")!,
                             nightImage: UIImage(systemName: "cloud.moon.fill")!)
        case .thunder:
            return IconImage(dayImage: UIImage(systemName: "cloud.bolt.rain.fill")!,
                             nightImage: UIImage(systemName: "cloud.moon.bolt.fill")!)
        case .snow:
            return IconImage(dayImage: UIImage(systemName: "cloud.snow.fill")!,
                             nightImage: UIImage(systemName: "cloud.snow")!)
        case .rain:
            return IconImage(dayImage: UIImage(systemName: "cloud.rain.fill")!,
                             nightImage: UIImage(systemName: "cloud.moon.rain.fill")!)
        case .fog:
            return IconImage(dayImage: UIImage(systemName: "cloud.fog.fill")!,
                             nightImage: UIImage(systemName: "cloud.fog")!)
        case .unknown:
            return IconImage(dayImage: UIImage(systemName: "sun.max.fill")!,
                             nightImage: UIImage(systemName: "moon.stars.fill")!)
        }
    }
}

// Структура для ночной и дневной иконки

struct IconImage {
    
    let dayImage: UIImage
    let nightImage: UIImage
    
}
