//
//  ViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 24/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit
import TwitterKit
import ChameleonFramework
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate, SignInDelegate {
    
    @IBAction func twitterLoginButtonAction(_ sender: TWTRLogInButton) {
        Twitter.sharedInstance().logIn(withMethods: .webBased, completion: { (session, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            self.didSignInWithTwitter()
        })
    }

    @IBAction func googleLoginButtonAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGoogleSignIn()
        configureUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if twitterSession != nil {
            didSignInWithTwitter()
        }
    }
    
    fileprivate func configureUI(){
//        self.view.backgroundColor = FlatSkyBlue()
        self.navigationController?.hidesNavigationBarHairline = true
        self.setThemeUsingPrimaryColor(FlatSkyBlue(), with: .contrast)
        
    }
    
    fileprivate func configureGoogleSignIn(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func continueToAppWithName(name: String){
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = homeStoryboard.instantiateInitialViewController()!
        if let homeVC = vc.childViewControllers.first as? HomeScreenViewController {
            homeVC.displayName = name
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

