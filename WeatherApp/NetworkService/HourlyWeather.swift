//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation
import UIKit



//"data":[48 items
//0:{32 items
//"wind_cdir":"SSE"
//"rh":80
//"pod":"d"
//"timestamp_utc":"2022-08-05T11:00:00"
//"pres":946
//"solar_rad":69.0816
//"ozone":293.8
//"weather":{...}3 items
//"wind_gust_spd":3.78
//"timestamp_local":"2022-08-05T07:00:00"
//"snow_depth":0
//"clouds":0
//"ts":1659697200
//"pop":3.05
//"pop":0
//"wind_cdir_full":"south-southeast"
//"slp":1021
//"dni":356.16
//"dewpt":16.4
//"snow":0
//"uv":1.5
//"wind_dir":158
//"clouds_hi":2
//"precip":0
//"vis":17.792
//"dhi":40.05
//"app_temp":20.1
//"datetime":"2022-08-05:11"
//"temp":20
//"ghi":72.34
//"clouds_mid":0
//"clouds_low":0
//}


struct HourlyWeatherResponse: Codable {
    var data: [HourlyWeather]
}


struct HourlyWeather: Codable {
    
    var time: String
    var currentTemperature: Float
    var feelsLikeTemperature: Float
    var probabilityOfRain: Int
    var clouds: Int
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
        case windDirection = "wind_cdir"
        case description = "weather"
      
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        time = try container.decode(String.self, forKey: .time)
        currentTemperature = try container.decode(Float.self, forKey: .currentTemperature)
        feelsLikeTemperature = try container.decode(Float.self, forKey: .feelsLikeTemperature)
        clouds = try container.decode(Int.self, forKey: .clouds)
        windSpeed = try container.decode(Float.self, forKey: .windSpeed)
        windDirection = try container.decode(String.self, forKey: .windDirection)
        probabilityOfRain = try container.decode(Int.self, forKey: .probabilityOfRain)
        description = try container.decode(Icon.self, forKey: .description)
    }
}

struct Icon: Codable {
    var icon: Int
    var verbalDesctiption: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "code"
        case verbalDesctiption = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        icon = try container.decode(Int.self, forKey: .icon)
        verbalDesctiption = try container.decode(String.self, forKey: .verbalDesctiption)
    }
}

