//
//  AppDelegate.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let network = NetworkLoader()
        let favourites = FavouriteStore()
        let market = Market()
        let service = QuoteListService(networkLoader: network, favouritesStore: favourites, market: market)

        let vc:QuotesListViewController = QuotesListViewController(service: service)
        let nc:UINavigationController = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureAppearance() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

}

