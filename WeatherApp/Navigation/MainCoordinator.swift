//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 03.08.2022.
//

import Foundation
import UIKit

protocol MainScreenViewOutput: AnyObject {
    
    var onOpenHourlyWeather: (([HourlyWeather]) -> Void)? { get set }
    
    var onOpenDailyWeather: (([DailyWeather], DailyWeather) -> Void)? { get set }
    
    var onOpenSettings: (() -> Void)? { get set }
    
    var onOpenLocationSelection: (() -> Void)? { get set }
    
}

protocol OnboardingScreenViewOutput: AnyObject {
    
    var onSuccess: (() -> Void)? { get set }
    
    var onNeedsManualLocation: (() -> Void)? { get set }
    
}

protocol HourlyWeatherScreenViewOutput: AnyObject {
    
}

protocol DailyWeatherScreenViewOutput: AnyObject {
    
}

class MainFabric {
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: rootViewController)
    }
    
    func makeMainScreen(location: Location?) -> (UIViewController, MainScreenViewOutput) {
        let view = MainScreenView()
        let model = MainScreenViewModel(view: view, location: location)
        view.model = model
        return (view, model)
    }

    func makeOnboardingScreen() -> (UIViewController, OnboardingScreenViewOutput) {
        let view = OnboardingView()
        let model = OnboardingViewModel(view: view)
        view.model = model
        return (view, model)
    }

    func makeHourlyWeatherScreen(with model: [HourlyWeather]) ->  (UIViewController, HourlyWeatherScreenViewOutput) {
        let view = HourlyWeatherView()
        let model = HourlyWeatherViewModel(view: view, model: model)
        view.model = model
        return (view, model)
    }
    
    func makeDailyWeatherScreen(with model: [DailyWeather], selectedModel: DailyWeather?) ->  (UIViewController, DailyWeatherScreenViewOutput) {
        let view = DailyWeatherView()
        let model = DailyWeatherViewModel(view: view, model: model, selectedModel: selectedModel)
        view.model = model
        return (view, model)
    }
    
    func makeLocationSelectorScreen() ->  (UIViewController, LocationSelectorViewOutput) {
        let view = LocationSelectorView.create()
        let model = LocationSelectorViewModel()
        view.model = model
        return (view, model)
    }
    
    func makeSettingsScreen() -> UIViewController {
        let view = SettingsView()
        let model = SettingsViewModel()
        view.configure(with: model)
        return view
    }
}

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
//        self.navigationController?.pushViewController(controller, animated: true)
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    private func showManualLocationScreen() {
        // To do
        
        let (controller, model) = fabric.makeLocationSelectorScreen()
        
        model.onClose = { [weak self] in
//            controller.dismiss(animated: true)
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
