//
//  AppDelegate.swift
//  VKPosts
//
//  Created by MacBook on 17/05/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
    

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        self.authService = AuthService()
        authService.delegate = self
        let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
            }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //    Реализуем AuthServiceDelegate
    
    func authServiceNeAvtorizirovan(_ vievController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(vievController, animated: true, completion: nil
        )
    }
    
    func authServiceAvtorizirovan() {
        print(#function)
        let feedVC = UIStoryboard(name: "NewsfeedViewController", bundle: nil).instantiateInitialViewController() as! NewsfeedViewController
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceOshibka() {
        print(#function)
    }
}

