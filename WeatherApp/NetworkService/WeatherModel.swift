//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 02.08.2022.
//

import Foundation

struct CurrentWeather: Codable {
    
    let temperature: Int
    let humidity: Double
    let summary: String
    let icon: String
    
    enum WeatherKeys: String, CodingKey {
        case temperature = "temperature"
        case humidity = "humidity"
        case summary = "summary"
        case icon = "icon"
    }
        
}
