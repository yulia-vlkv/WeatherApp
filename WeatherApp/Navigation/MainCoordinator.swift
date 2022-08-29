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
    
    var onOpenDailyWeather: (([DailyWeather]) -> Void)? { get set }
    
    var onOpenSettings: (() -> Void)? { get set }
    
}

protocol OnboardingScreenViewOutput: AnyObject {
    
    var onPermitAccess: (() -> Void)? { get set }
    
    var onDenyAccess: (() -> Void)? { get set }
    
}

protocol HourlyWeatherScreenViewOutput: AnyObject {
    
}

protocol DailyWeatherScreenViewOutput: AnyObject {
    
}

class MainFabric {
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: rootViewController)
    }
    
    func makeMainScreen() -> (UIViewController, MainScreenViewOutput) {
        let view = MainScreenView()
        let model = MainScreenViewModel(view: view)
        view.model = model
        return (view, model)
    }

//    func makeOnboardingScreen() -> (UIViewController, OnboardingScreenViewOutput) {
//        let view = OnboardingView()
//        return view
//    }
//
    func makeHourlyWeatherScreen(with model: [HourlyWeather]) ->  (UIViewController, HourlyWeatherScreenViewOutput) {
        let view = HourlyWeatherView()
        let model = HourlyWeatherViewModel(view: view, model: model)
        view.model = model
        return (view, model)
    }
    
    func makeDailyWeatherScreen(with model: [DailyWeather]) ->  (UIViewController, DailyWeatherScreenViewOutput) {
        let view = DailyWeatherView()
        let model = DailyWeatherViewModel(view: view, model: model)
        view.model = model
        return (view, model)
    }
    
    func makeSettingsScreen() -> UIViewController {
        let view = SettingsView()
        return view
    }
}

enum MainInstructor {
    
    case onboarding
    case main
    
    static var destination: Self {
        return .main
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
            showMainScreen()
//            showOnboardingScreen()
        }
    }
    
    private func showMainScreen() {
        let (controller, screen) = fabric.makeMainScreen()
        
        screen.onOpenHourlyWeather = { [weak self] model in
            self?.showHourlyWeatherScreen(model: model)
        }
        
        screen.onOpenDailyWeather = { [weak self] model in
            self?.showDailyWeatherScreen(model: model)
        }
        
        screen.onOpenSettings = { [weak self] in
            self?.showSettings()
        }
        
        let navigationController = fabric.makeNavigationController(rootViewController: controller)
        
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
//    private func showOnboardingScreen(){
//        let controller = fabric.makeOnboardingScreen()
//
//        controller.onPermitAccess = { [weak self] in
//            self?.showMainScreen()
//        }
//
//        controller.onDenyAccess = { [weak self] in
//            // Show alert to add location
//            // Show MainScreen
//
//        }
//    }
    
    private func showHourlyWeatherScreen(model: [HourlyWeather]) {
        let (controller, _) = fabric.makeHourlyWeatherScreen(with: model)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showDailyWeatherScreen(model: [DailyWeather]) {
        let (controller, _) = fabric.makeDailyWeatherScreen(with: model)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func showSettings(){
        
    }
                
}
