//
//  OnboardingViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 19.09.2022.
//

import Foundation
import UIKit

class OnboardingViewModel: OnboardingScreenViewOutput {
    
    private weak var view: OnboardingView!
    
    public var onSuccess: (() -> Void)?
    public var onNeedsManualLocation: (() -> Void)?
    
    public var model = LocationService.shared
    
    init(view: OnboardingView) {
        self.view = view
    }
    
    public func grantAccess(){
        self.model.checkUserLocationPermissions() { isSuccess in
            isSuccess ? self.onSuccess?() : self.onNeedsManualLocation?()
        }
    }
    
    func onManualLocationTap() {
        self.onNeedsManualLocation?()
    }
}


protocol LocationSelectorViewOutput: AnyObject {
    
    var onSuccess: ((Location) -> Void)? { get set }
    var onClose: (() -> Void)? { get set }
}

class LocationSelectorView: UIAlertController {
    
    // MARK: - Public properties
    
    public var model: LocationSelectorViewModel!
    
    // MARK: - Initialization
    
    public static func create() -> Self {
        let alert = Self(title: "Укажите вашу локацию", message: nil, preferredStyle: .alert)
        alert.configure()
        return alert
    }
    
    private func configure() {
        addTextField() { newTextField in
            newTextField.placeholder = "Мой город"
        }
        addAction(UIAlertAction(title: "Отмена", style: .cancel) { _ in
            self.model.cancel()
        })
        addAction(UIAlertAction(title: "Ок", style: .default) { _ in
            if let textFields = self.textFields,
               let tf = textFields.first,
               let text = tf.text {
                self.model.findLocation(for: text)
            } else {
                print("Can't find the location")
            }
        })
    }
}

class LocationSelectorViewModel: LocationSelectorViewOutput {
    
    // MARK: - LocationSelectorViewOutput
    
    public var onSuccess: ((Location) -> Void)?
    public var onClose: (() -> Void)?
    
    // MARK: - Private properties
    
    private let locationService = LocationService.shared
    
    // MARK: - Public methods
    
    public func cancel() {
        self.onClose?()
    }
    
    public func findLocation(for text: String) {
        locationService.getLocationFromString(from: text, completion: { location in
            guard let location = location else { return }
            // Not working
            let placeForWeather = Location(
                city: text,
                country: text,
                longitude: String(location.longitude),
                latitude: String(location.latitude)
            )

            self.onSuccess?(placeForWeather)
        })
    }
}
