//
//  DateScrollCellModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.08.2022.
//

import Foundation


struct DateScrollCellModel {
    
    let date: String
    
}

extension DateScrollCellModel  {
    
    init(with dailyWeather: DailyWeather) {
        
        self.date = {
            let stringToFormat = dailyWeather.time
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: stringToFormat)
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date!)
        }()
        
    }
}
