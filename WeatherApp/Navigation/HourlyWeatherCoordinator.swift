//
//  HourlyWeatherCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 15.08.2022.
//

import Foundation
import UIKit

class HourlyWeatherCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func start() {}

    func startPush() -> UINavigationController {
        
        let hourlyWeatherController = HourlyWeatherView()

        navigationController.setViewControllers([hourlyWeatherController], animated: false)

        return navigationController
    }
}

