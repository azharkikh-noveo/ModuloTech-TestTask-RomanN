//
//  SceneDelegate.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 15.09.2022.
//

import UIKit


final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let router = BaseRouter(rootTransition: EmptyTransition())
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = Asset.Colors.white.color
        window?.rootViewController = router.makeRootViewController()
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
    }

}
