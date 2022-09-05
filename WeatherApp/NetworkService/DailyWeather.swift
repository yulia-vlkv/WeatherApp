//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 16.08.2022.
//

import Foundation


struct DailyWeatherResponse: Codable {
    var data: [DailyWeather]
}


struct DailyWeather: Codable {
    
    var time: String
    var lowestTemperature: Float
    var highestTemperature: Float
    var feelsLikeMaxTemperature: Float
    var feelsLikeMinTemperature: Float
    var dayTemperature: Float
    var nightTemperature: Float
    var probabilityOfRain: Float
    var clouds: Float
    var windSpeed: Float
    var windDirection: String
    var description: Icon
    var uvIndex: Float
    var moonPhase: Float
    var moonrise: Int
    var moonset: Int
    var sunrise: Int
    var sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case time = "valid_date"
        case lowestTemperature = "min_temp"
        case highestTemperature = "max_temp"
        case feelsLikeMaxTemperature = "app_max_temp"
        case feelsLikeMinTemperature = "app_min_temp"
        case dayTemperature = "high_temp"
        case nightTemperature = "low_temp"
        case probabilityOfRain = "pop"
        case clouds
        case windSpeed = "wind_spd"
        case windDirection = "wind_cdir"
        case description = "weather"
        case uvIndex = "uv"
        case moonPhase = "moon_phase_lunation"
        case moonrise = "moonrise_ts"
        case moonset = "moonset_ts"
        case sunrise = "sunrise_ts"
        case sunset = "sunset_ts"
      
    }
}
