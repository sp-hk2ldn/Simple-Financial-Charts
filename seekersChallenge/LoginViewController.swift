//
//  ViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 24/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    var session: TWTRSession?
    
    @IBAction func twitterLoginButtonAction(_ sender: TWTRLogInButton) {
        Twitter.sharedInstance().logIn { (session, error) in
            guard let error = error else {
                self.session = session!
                self.twitterSessionStarted(userID: session!.userID)
                return
            }
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    fileprivate func twitterSessionStarted(userID: String){
        let twitterClient = TWTRAPIClient(userID: userID)
        twitterClient.loadUser(withID: userID) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            guard let user = user else {
                return
            }
            print(user.profileImageLargeURL)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

