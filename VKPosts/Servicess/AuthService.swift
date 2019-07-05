//
//  AuthSevece.swift
//  VKPosts
//
//  Created by MacBook on 18/05/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceNeAvtorizirovan(_ vievController: UIViewController)
    func authServiceAvtorizirovan()
    func authServiceOshibka()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
   
   weak var delegate: AuthServiceDelegate?
    
    var token:String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    private let appId = "6987872"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("okk")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        
      let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                delegate?.authServiceAvtorizirovan()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state \(state), error \(String(describing: error))")
                delegate?.authServiceOshibka()
            }
        }
    }
    
//    VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceAvtorizirovan()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
         print(#function)
    }
    
//    VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
         print(#function)
        delegate?.authServiceNeAvtorizirovan(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
         print(#function)
    }
}
