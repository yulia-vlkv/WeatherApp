//
//  LocationSelectorView.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 23.09.2022.
//

import Foundation
import UIKit


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

