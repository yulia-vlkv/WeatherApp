//
//  Location.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation
import CoreLocation
import UIKit

class Location: UIViewController {
    
    static var currentLocation: CLLocationCoordinate2D?
    
    private lazy var locationManager = CLLocationManager()
    
    func checkUserLocationPermissions() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy
        locationManager.startUpdatingLocation()
    
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                Location.currentLocation = location.coordinate
                print(Location.currentLocation?.latitude)
                print(Location.currentLocation?.longitude)
            }
            
        case .denied, .restricted:
            // Пользователь выбирает место сам
            // Чистый экран с +
            // Алерт с полем для введения города
            print("DENIED")
            
        @unknown default:
            fatalError("Не обрабатываемый статус")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationPermissions()
    }
    
}

extension Location: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location {
            Location.currentLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
              print("Failed to find user's location: \(error.localizedDescription)")
              manager.stopUpdatingLocation()
    }
    
}
