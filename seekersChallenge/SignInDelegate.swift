//
//  SignInDelegate.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import TwitterKit
import GoogleSignIn

protocol SignInDelegate {
    func didSignInWithTwitter()
    func didSignInWithGoogle()
    func loginSessionActive(loginType: LoginType)
}

enum LoginType: String {
    case google = "google",
    twitter = "twitter"
}

extension SignInDelegate where Self: LoginViewController {
    //MARK:- Login Sessions
    var twitterSession: TWTRSession? {
        get {
            return (Twitter.sharedInstance().sessionStore.existingUserSessions() as? [TWTRSession])?.first
        }
        set {}
    }
    
    var googleSession: GIDGoogleUser? {
        get {
            return GIDSignIn.sharedInstance().currentUser
        }
        set {}
    }
    
    //MARK:- After creating new session
    func didSignInWithTwitter(){
        loginSessionActive(loginType: .twitter)
    }
    func didSignInWithGoogle(){
        loginSessionActive(loginType: .google)
    }
    
    func loginSessionActive(loginType: LoginType){
        switch loginType {
        case .google:
            guard let firstName = googleSession?.profile.givenName, let lastName = googleSession?.profile.familyName else {
                return
            }
            
            continueToAppWithName(name: "\(firstName) \(lastName)")
        case .twitter:
            guard let userName = twitterSession?.userName else {
                return
            }
            continueToAppWithName(name: userName)
        }
    }
}

extension LoginViewController {
    
    //MARK:- Google sign in delegate functions
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print("started sign in process")
    }
    
    @objc(signIn:presentViewController:) func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc(signIn:dismissViewController:) func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc(signIn:didDisconnectWithUser:withError:) func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            print("user signed out")
        }
    }
    
    @objc(signIn:didSignInForUser:withError:) func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print("cannot sign in: \(error.localizedDescription)")
        } else {
            didSignInWithGoogle()
        }
    }
}
