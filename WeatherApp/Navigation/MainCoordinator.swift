//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Iuliia Volkova on 03.08.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?

//    private var onboaringViewController: UIViewController!
//    private var settingsViewController: UIViewController!

    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func start() {
        let navigationController = self.setNavigationController()
        self.window?.rootViewController = navigationController
    }
    
    func setNavigationController() -> UINavigationController {
        let navController = UINavigationController()
//        
//        navController.navigationBar.isHidden = false
//        navController.navigationBar.backgroundColor = .white
//        navController.title = "Город, страна"
//        navController.navigationBar.tintColor = .black
//        navController.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle"),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action:  #selector(toOnboarding))
//        
//        navController.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action:  #selector(toSettings))
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        navController.navigationBar.scrollEdgeAppearance  = appearance
//        navController.navigationBar.standardAppearance  = appearance
//        
        return navController
    }
                
}
