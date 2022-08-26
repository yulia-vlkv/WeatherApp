//
//  HourlyWeatherCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 24.08.2022.
//

import UIKit


class HourlyWeatherCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func start() {}

}

