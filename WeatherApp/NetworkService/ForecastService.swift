//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 02.08.2022.
//

import Foundation
import Alamofire

class ForecastService {
        
    let forecastAPIKey = "0000000"

    let forecastBaseURL: String = "https://api.openweathermap.org/data/3.0/onecall?"
    let latitude: Double = 44.8125
    let longitude: Double = 20.4612
    let exclude: String = "hourly,daily"
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseURL)/lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&appid=\(forecastAPIKey)") {
            
            AF.request(forecastURL).responseJSON(completionHandler: { (response) in
                print(response)
            }
                                                 
            )
        }
    }
}
