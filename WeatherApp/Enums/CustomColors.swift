//
//  Colors.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation
import UIKit

enum CustomColors {
    
    case brightOrange
    case brightYellow
    case deepBlue
    case dustyOrange
    case lightBlue
    
    static func setColor (style: CustomColors) -> UIColor {
        switch style {
        case .brightOrange:
            return UIColor(named: "brightOrange")!
        case .brightYellow:
            return UIColor(named: "brightYellow")!
        case .deepBlue:
            return UIColor(named: "deepBlue")!
        case .dustyOrange:
            return UIColor(named: "dustyOrange")!
        case .lightBlue:
            return UIColor(named: "lightBlue")!
        }
    }
}
