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
}

protocol HourlyWeatherScreenViewOutput: AnyObject {
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
    
    func makeHourlyWeatherScreen(with model: [HourlyWeather]) ->  (UIViewController, HourlyWeatherScreenViewOutput) {
        let view = HourlyWeatherView()
        let model = HourlyWeatherViewModel(view: view, model: model)
        view.model = model
        return (view, model)
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
        }
    }
    
    private func showMainScreen() {
        let (controller, screen) = fabric.makeMainScreen()
        
        screen.onOpenHourlyWeather = { [weak self] model in
            self?.showHourlyWeatherScreen(model: model)
        }
        
        let navigationController = fabric.makeNavigationController(rootViewController: controller)
        
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showHourlyWeatherScreen(model: [HourlyWeather]) {
        let (controller, _) = fabric.makeHourlyWeatherScreen(with: model)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc private func showSettings(){
        
    }
                
}
