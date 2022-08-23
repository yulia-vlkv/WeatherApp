//
//  OnboardingCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 15.08.2022.
//

import Foundation
import UIKit

class OnboardingCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func start() {}

//    func startPush() -> UINavigationController {
//        let onboardingController = OnboardingView()
//        navigationController.setViewControllers([onboardingController], animated: false)
//        return navigationController
//    }
}
