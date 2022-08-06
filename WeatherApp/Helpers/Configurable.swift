//
//  Configurable.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 06.08.2022.
//

import Foundation


protocol ConfigurableView {
    
    associatedtype Model
    
    func configure(with model: Model)
    
}
