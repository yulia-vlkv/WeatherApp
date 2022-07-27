//
//  OnboardingText.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 27.07.2022.
//

import Foundation

enum OnboardingText {
    
    case onBoardingTitle
    case onBoardingComment
    case onBoardingGrantAccessButton
    case onBoardingDenyButton
    
    
    static func addText (text: OnboardingText) -> String {
        switch text {
        case .onBoardingTitle:
            return "Разрешить приложению  Weather использовать данные о местоположении Вашего устройства"
        case .onBoardingComment:
            return """
Чтобы получить более точные прогнозы погоды во время движения или путешествия.

Вы можете изменить свой выбор в любое время из меню приложения.
"""
        case .onBoardingGrantAccessButton:
            return "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА"
        case .onBoardingDenyButton:
            return "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ"
        }
    }
}
