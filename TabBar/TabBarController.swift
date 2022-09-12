//
//  TabBarController.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/11.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .systemGray3
        
        let firstVC = UINavigationController(rootViewController: FirstViewController())
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "clock")
        firstVC.tabBarItem.image = UIImage(systemName: "clock")
        
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "calendar")
        secondVC.tabBarItem.image = UIImage(systemName: "calendar")
        
        let thirdVC = UINavigationController(rootViewController: ThirdViewController())
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "chart.bar.fill")
        thirdVC.tabBarItem.image = UIImage(systemName: "chart.bar.fill")
        
        let forthVC = UINavigationController(rootViewController: ForthViewController())
        forthVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        forthVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        viewControllers = [firstVC, secondVC, thirdVC, forthVC]
        
        
    }
}
