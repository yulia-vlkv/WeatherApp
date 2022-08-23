//
//  Weather.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 02.08.2022.
//

import Foundation


struct CurrentWeatherResponse: Codable {
    var data: [CurrentWeather]
}


struct CurrentWeather: Codable {
    
    var currentTemperature: Float
    var clouds: Float
    var windSpeed: Float
    var humidity: Float
    var sunrise: String
    var sunset: String
    var date: String
    var description: Icon
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case clouds
        case windSpeed = "wind_spd"
        case humidity = "rh"
        case sunrise
        case sunset
        case date = "datetime"
        case description = "weather"
    }

}





