//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 02.08.2022.
//

import Foundation
import MapKit
import Alamofire

enum ForecastServiceError: Error {
    
    case noData
    case unknown(Error)
}

struct ForecastWeatherReqObj {
    
    enum Units: String {
        
        case metric
    }
    
    let longitude: String
    let latitude: String
    let units: Units
    let lang: String = "ru"
    let hours: String = "24"
}

class ForecastService {
    
//    public var currentWeather: CurrentWeather?
//    public var hourlyWeather: [HourlyWeather]?
//    public var dailyWeather: [DailyWeather]?
    
//    lazy var coordinates = LocationService().currentLocation
//    lazy var lon = coordinates?.longitude
//    lazy var lat = coordinates?.latitude
    
    private let baseURL = "https://weatherbit-v1-mashape.p.rapidapi.com"
    
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
          fatalError("Couldn't find file 'Keys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "weatherApiKey") as? String else {
          fatalError("Couldn't find key 'weatherApiKey' in 'Keys.plist'.")
        }
        return value
      }
    }
    
    func getCurrentWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<CurrentWeather, ForecastServiceError>) -> Void
    ) {
        let url: String = "\(baseURL)/current/"
        let header: HTTPHeaders = ["X-RapidAPI-Key" : apiKey]
        let parameters = [  "lon" : String(parameters.longitude),
                            "lat" : String(parameters.latitude),
                          "units" : parameters.units.rawValue,
                           "lang" : parameters.lang ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: header
        ).responseDecodable(of: CurrentWeatherResponse.self){ (response) in
            switch response.result {
            case .success(let weather):
                guard let currentWeather = weather.data.first else {
                    completion(.failure(ForecastServiceError.noData))
                    return
                }
                completion(.success(currentWeather))
            case .failure(let error):
                print("Probably ran out of free api requests")
                completion(.failure(ForecastServiceError.unknown(error)))
            }
        }
    }
    
    func getHourlyWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<[HourlyWeather], ForecastServiceError>) -> Void
    ) {
        let url: String = "\(baseURL)/forecast/hourly/"
        let header: HTTPHeaders = ["X-RapidAPI-Key" : apiKey]
        let parameters = [  "lon" : String(parameters.longitude),
                            "lat" : String(parameters.latitude),
                          "units" : parameters.units.rawValue,
                           "lang" : parameters.lang,
                           "hours": parameters.hours ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: header
        ).responseDecodable(of: HourlyWeatherResponse.self){ (response) in
            switch response.result {
            case .success(let weather):
                let hourlyWeather = weather.data
                guard hourlyWeather != nil else {
                    completion(.failure(ForecastServiceError.noData))
                    return
                }
                completion(.success(hourlyWeather))
            case .failure(let error):
                completion(.failure(ForecastServiceError.unknown(error)))
            }
        }
    }

    
    func getDailyWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<[DailyWeather], ForecastServiceError>) -> Void
    ) {
        let url: String = "\(baseURL)/forecast/daily/"
        let header: HTTPHeaders = ["X-RapidAPI-Key" : apiKey]
        let parameters = [  "lon" : String(parameters.longitude),
                            "lat" : String(parameters.latitude),
                          "units" : parameters.units.rawValue,
                           "lang" : parameters.lang ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: header
        ).responseDecodable(of: DailyWeatherResponse.self){ (response) in
            switch response.result {
            case .success(let weather):
                let dailyWeather = weather.data
                guard dailyWeather != nil else {
                    completion(.failure(ForecastServiceError.noData))
                    return
                }
                completion(.success(dailyWeather))
            case .failure(let error):
                completion(.failure(ForecastServiceError.unknown(error)))
            }
        }
    }

}
