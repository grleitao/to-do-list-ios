//
//  TabBarController.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 24/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1)
        
        let homeVC = HomeViewControler()
        homeVC.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Configurações"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        
        viewControllers = [UINavigationController(rootViewController: homeVC),
                           UINavigationController(rootViewController: settingsVC)]
        
        styleNavigationBar()
        styleTabBar(tabBar)
    }
    
    func styleNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }

    func styleTabBar(_ tabBar: UITabBar) {
        tabBar.backgroundColor = .systemBlue
        tabBar.barTintColor = .systemBlue
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
    }
}
