//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation


struct HourlyWeatherResponse: Codable {
    var data: [HourlyWeather]
}


struct HourlyWeather: Codable {
    
    var time: String
    var currentTemperature: Float
    var feelsLikeTemperature: Float
    var probabilityOfRain: Float
    var clouds: Float
    var windSpeed: Float
    var windDirection: String
    var description: Icon
    
    enum CodingKeys: String, CodingKey {
        case time = "timestamp_local"
        case currentTemperature = "temp"
        case feelsLikeTemperature = "app_temp"
        case probabilityOfRain = "pop"
        case clouds
        case windSpeed = "wind_spd"
        case windDirection = "wind_cdir_full"
        case description = "weather"
      
    }

}

