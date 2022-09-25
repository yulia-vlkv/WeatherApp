//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 03.08.2022.
//

import Foundation
import UIKit


enum MainInstructor {
    
    case onboarding
    case main
    
    static var destination: Self {
        if !UserDefaults.standard.bool(forKey: "LocationSelected") {
            return .onboarding
        } else {
            return .main
        }
    }
}

class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    let window: UIWindow
    
    private let fabric: MainFabric
    private var navigationController: UINavigationController?

    init(_ window: UIWindow, fabric: MainFabric) {
        self.fabric = fabric
        self.window = window
    }
    
    func start() {
        switch MainInstructor.destination {
        case .main:
            showMainScreen()
        case .onboarding:
            showOnboardingScreen()
        }
    }
    
    private func showMainScreen(location: Location? = nil) {
        let (controller, screen) = fabric.makeMainScreen(location: location)
        
        screen.onOpenHourlyWeather = { [weak self] model in
            self?.showHourlyWeatherScreen(model: model)
        }
        
        screen.onOpenDailyWeather = { [weak self] model, selectedModel in
            self?.showDailyWeatherScreen(model: model, selectedModel: selectedModel)
        }
        
        screen.onOpenSettings = { [weak self] in
            self?.showSettings()
        }
        
        screen.onOpenLocationSelection = { [weak self] in
            self?.showManualLocationScreen()
        }
        
        let navigationController = fabric.makeNavigationController(rootViewController: controller)
        
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        UserDefaults.standard.set(true, forKey: "LocationSelected")
    }
    
    private func showOnboardingScreen(){
        let (controller, model) = fabric.makeOnboardingScreen()

        model.onSuccess = { [weak self] in
            self?.showMainScreen()
        }

        model.onNeedsManualLocation = { [weak self] in
            self?.showManualLocationScreen()

        }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    private func showManualLocationScreen() {
        
        let (controller, model) = fabric.makeLocationSelectorScreen()
        
        model.onClose = { [weak self] in

        }
        
        model.onSuccess = { [weak self] location in
            self?.showMainScreen(location: location)
        }
        
        window.rootViewController?.present(controller, animated: true)
    }
    
    private func showHourlyWeatherScreen(model: [HourlyWeather]) {
        let (controller, _) = fabric.makeHourlyWeatherScreen(with: model)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showDailyWeatherScreen(model: [DailyWeather], selectedModel: DailyWeather?) {
        let (controller, _) = fabric.makeDailyWeatherScreen(with: model, selectedModel: selectedModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showSettings(){
        let settings = fabric.makeSettingsScreen()
        self.navigationController?.pushViewController(settings, animated: true)
    }
                
}
