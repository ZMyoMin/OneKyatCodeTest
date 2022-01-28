//
//  MainTabBarController.swift
//  OneK
//
//  Created by BCMM on 26/01/2022.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let userDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        let isLogin = userDefaults.bool(forKey: "isLogin")
        if isLogin != true{
            DispatchQueue.main.async {
                self.goLogout()
            }
        }
    }
    
    func goLogout(){
        let vc = LoginViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navController.navigationBar.barTintColor = .systemGreen
        self.present(navController, animated:false, completion: nil)
    }
    
    func setupViewControllers() {
        //home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_selected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeViewController())
        homeNavController.title = "Home"
        // message
        let messageNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "messageIcon"), selectedImage: #imageLiteral(resourceName: "messageIcon"),rootViewController: MessageViewController())
        messageNavController.title = "Message"
        messageNavController.tabBarItem.badgeValue = "8"
        
        //notification
        let notiNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "notificationIcon"), selectedImage: #imageLiteral(resourceName: "notificationIcon"),rootViewController: NotificationViewController())
        notiNavController.title = "Notification"
        
        //favourite
        let favNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "favourite"), selectedImage: #imageLiteral(resourceName: "favourite"),rootViewController: FavouriteViewController())
        favNavController.title = "Favourite"
        
        //profile
        let profileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profileIcon"), selectedImage: #imageLiteral(resourceName: "profileIcon"),rootViewController: ProfileViewController())
        profileNavController.title = "Profile"
        profileNavController.tabBarItem.badgeValue = "1"

        tabBar.tintColor = .systemGreen
        viewControllers = [homeNavController,messageNavController,notiNavController,favNavController,profileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.barTintColor = .systemGreen
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
