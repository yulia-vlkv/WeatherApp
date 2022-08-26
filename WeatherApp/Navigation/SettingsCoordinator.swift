//
//  SettingsCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 24.08.2022.
//

import UIKit


class SettingsCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func start() {}

    func showSettings() {
        let settingsVS = SettingsView()
        settingsVS.coordinator = self
        navigationController.pushViewController(settingsVS, animated: false)
    }
}
