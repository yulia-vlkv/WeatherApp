//
//  OnboardingCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 15.08.2022.
//

import UIKit


class OnboardingCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func start() {}

}
