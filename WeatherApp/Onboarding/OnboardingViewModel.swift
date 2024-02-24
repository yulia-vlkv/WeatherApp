//
//  OnboardingViewModel.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 19.09.2022.
//

import Foundation
import UIKit


protocol OnboardingScreenViewOutput: AnyObject {
    
    var onSuccess: (() -> Void)? { get set }
    
    var onNeedsManualLocation: (() -> Void)? { get set }
    
}


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

