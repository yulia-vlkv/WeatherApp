//
//  LocationService.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 05.08.2022.
//

import Foundation
import CoreLocation

struct Location {
    let city: String
    let country: String
    let longitude: String
    let latitude: String
}

class LocationService: NSObject {
    
//    private weak var view: OnboardingView!
//    
//    init(view: OnboardingView) {
//        self.view = view
//    }
    
    static var shared = LocationService()
    
    public var currentLocation: CLLocation? {
        didSet {
            if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
                self.getPlace(for: currentLocation!) { placemark in
                    
                    guard let placemark = placemark else { return }
                    
                    let placeForWeather = Location(
                        city: placemark.locality ?? "Неизвестно",
                        country: placemark.country ?? "Неизвестно",
                        longitude: String(self.currentLocation!.coordinate.longitude),
                        latitude: String(self.currentLocation!.coordinate.latitude)
                    )
                    
                    self.locations?.append(placeForWeather)
                }
            }
        }
    }
    
    public var locations: [Location]? 
    
    private lazy var locationManager = CLLocationManager()
    
    func checkUserLocationPermissions() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                self.currentLocation = location
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
    
//    func getCityFromCoordinates(currentCoordinates: CLLocationCoordinate2D) -> Location {
//    https://rapidapi.com/wirefreethought/api/geodb-cities/
    //    }
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }

}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location {
            self.currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("Failed to find user's location: \(error.localizedDescription)")
          manager.stopUpdatingLocation()
    }
    
}
