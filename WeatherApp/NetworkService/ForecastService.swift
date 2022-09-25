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
    
    func getCommonParameters(parameters: ForecastWeatherReqObj) -> [String: Any] {
        let parameters = [  "lon" : String(parameters.longitude),
                            "lat" : String(parameters.latitude),
                          "units" : parameters.units.rawValue,
                           "lang" : parameters.lang,
                            "hours": parameters.hours]
        return parameters
    }
    
    func getWeatherItems<T: Codable>(
        with parameters: [String: Any],
        path: String,
        completion: @escaping (Result<T, ForecastServiceError>) -> Void
    ) {
        let url: String = "\(baseURL)\(path)"
        let header: HTTPHeaders = ["X-RapidAPI-Key" : apiKey]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: header
        ).responseDecodable(of: GenericWeatherResponse<T>.self){ (response) in
            switch response.result {
            case .success(let weather):
                completion(.success(weather.data))
            case .failure(let error):
                print("Probably ran out of free api requests")
                completion(.failure(ForecastServiceError.unknown(error)))
            }
        }
    }
    
    func getWeatherItem<T: Codable>(
        with parameters: [String: Any],
        path: String,
        completion: @escaping (Result<T, ForecastServiceError>) -> Void
    ) {
        getWeatherItems(
            with: parameters,
            path: path,
            completion: { (result: Result<[T], ForecastServiceError>) in
                switch result {
                case .success(let items):
                    guard let firstItem = items.first else {
                        completion(.failure(ForecastServiceError.noData))
                        return
                    }
                    completion(.success(firstItem))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    func getCurrentWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<CurrentWeather, ForecastServiceError>) -> Void
    ) {
        getWeatherItem(
            with: getCommonParameters(parameters: parameters),
            path: "/current/",
            completion: completion
        )
    }
    
    func getHourlyWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<[HourlyWeather], ForecastServiceError>) -> Void
    ) {
        getWeatherItems(
            with: getCommonParameters(parameters: parameters),
            path: "/forecast/hourly/",
            completion: completion
        )
    }
    
    func getDailyWeather(
        with parameters: ForecastWeatherReqObj,
        completion: @escaping (Result<[DailyWeather], ForecastServiceError>) -> Void
    ) {
        getWeatherItems(
            with: getCommonParameters(parameters: parameters),
            path: "/forecast/daily/",
            completion: completion
        )
    }

}
