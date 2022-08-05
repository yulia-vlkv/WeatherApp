//
//  Weather.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 02.08.2022.
//

import Foundation
import UIKit

struct WeatherResponse: Codable {
    var data: [CurrentWeather]
}

struct CurrentWeather: Codable {
    
    var currentTemperature: Float
//    var feelsLikeTemperature: Int
//    var lowTemperature: Int?
//    var highTemperature: Int?
//    var verbalDescription: String
    var clouds: Int
    var windSpeed: Float
//    var windDirection: String
    var humidity: Int
    var sunrise: String
    var sunset: String
    var date: String
//    // Время указывает не текущее время, а время прогноза. Нужно для отражения погоды каждые 3 часа
//    var time: String
//    var icon: String
//
//    var dayTemperature: Int
//    var dayVerbalDescription: String
//    var dayWindSpeed: Int
//    var dayWindDirection: String
//    var dayHumidity: Int
//
//    var nightTemperature: Int
//    var nightVerbalDescription: String
//    var nightWindSpeed: Int
//    var nightWindDirection: String
//    var nightHumidity: Int
//
//    var indexUV: Int
//    var airQuality: Int
////uv: UV Index (0-11+).
////aqi: Air Quality Index [US - EPA standard 0 - +500]
//
//    var moonrise: String
//    var moonset: String
////moonrise_ts: Moonrise time unix timestamp (UTC)
////moonset_ts: Moonset time unix timestamp (UTC)
    
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case clouds
        case windSpeed = "wind_spd"
        case humidity = "rh"
        case sunrise
        case sunset 
        case date = "datetime"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        currentTemperature = try container.decode(Float.self, forKey: .currentTemperature)
        clouds = try container.decode(Int.self, forKey: .clouds)
        windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        humidity = try container.decode(Int.self, forKey: .humidity)
        sunrise = try container.decode(String.self, forKey: .sunrise)
        sunset = try container.decode(String.self, forKey: .sunset)
        date = try container.decode(String.self, forKey: .date)
    }
}

