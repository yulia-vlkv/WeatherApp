//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 03.08.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}
