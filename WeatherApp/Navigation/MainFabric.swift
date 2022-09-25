//
//  MainFabric.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 23.09.2022.
//

import Foundation
import UIKit


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
