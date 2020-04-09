//
//  AppDelegate.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit
import VisionKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let manager = CatalogManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize TrustKit config
        TrustKitManager.start()
        
        let initialViewController = CatalogViewController()
        initialViewController.title = "Assignmentity"

        let navigationController = UINavigationController(rootViewController: initialViewController)
        configure(navigationController: navigationController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureAppearance(navigationBar: UINavigationBar) {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.backgroundColor = .systemBackground
        
        navigationBar.prefersLargeTitles = true
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func configure(navigationController: UINavigationController) {
        configureAppearance(navigationBar: navigationController.navigationBar)
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = .systemIndigo
        navigationController.visibleViewController?.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func addTapped() {
        let ocrViewController = OCRViewController()
        
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }
        navigationController.present(ocrViewController, animated: true)
    }
}
