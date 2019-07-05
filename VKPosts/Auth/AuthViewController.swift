//
//  AuthViewController.swift
//  VKPosts
//
//  Created by MacBook on 18/05/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        authService = AuthService()
       authService = AppDelegate.shared().authService
    }
    

    @IBAction func button() {
        authService.wakeUpSession()
    }
    
    

}
