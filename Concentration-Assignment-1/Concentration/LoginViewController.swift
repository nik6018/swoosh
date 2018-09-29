//
//  LoginViewController.swift
//  Concentration
//
//  Created by Nikhil Muskur on 18/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit
/*
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
    
    private var fbAccessToken: AccessToken!
    private var myLoginButton: UIButton = UIButton(type: .roundedRect)
    private
    var myLogoutButton: UIButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(fbAccessToken)
        
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            let alert = UIAlertController(title: "Login Status", message: "The user has already logged In AT: \(accessToken)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let loginButton = LoginButton(readPermissions: [ .publicProfile ])
            loginButton.center = view.center
            
            view.addSubview(loginButton)
        }
        
        
        
        
        // Add a custom login button to your app
//        self.myLoginButton.backgroundColor = UIColor.darkGray
//        self.myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
//
//        self.myLoginButton.center = view.center;
//        self.myLoginButton.setTitle("My Login Button", for: .normal)
//
//        self.myLoginButton.addTarget(self, action: #selector(logIntoFacebook(_:)), for: .touchUpInside)
//
//        // Logout button
//        myLogoutButton.backgroundColor = UIColor.blue
//        myLogoutButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
//
//        myLogoutButton.center = view.center;
//        myLogoutButton.setTitle("My Logout Button", for: .normal)
//        myLogoutButton.isHidden = true
//
//        myLogoutButton.addTarget(self, action: #selector(logOutOfFacebook), for: .touchUpInside)
////
//        // Add the button to the view
//        view.addSubview(myLoginButton)
//        view.addSubview(myLogoutButton)
    }
    
    @IBAction func logIntoFacebook(_ sender: UIButton) {
        
        if fbAccessToken == nil {
            let loginManager = LoginManager()
            
            loginManager.logIn(readPermissions: [.publicProfile, .userFriends, .readCustomFriendlists ], viewController: self) { (loginStatus) in
                
                switch loginStatus {
                case .cancelled:
                    print("The User has cancelled the login session")
                case .failed(let error):
                    print("The Login failed due to the following reason: \(error.localizedDescription)")
                case .success(let permissionsAllowed, let permissionsDeclined, token: let accessToken):
                    print("Fuck Yes the Login Worked !! LOL")
                    print("The Following Permission Granted")
                    for permission in permissionsAllowed {
                        print(permission.name)
                    }
                    print("The Following Permission Declined")
                    for permission in permissionsDeclined {
                        print(permission.name)
                    }
                    self.fbAccessToken = accessToken
                    sender.isHidden = true
                    self.myLogoutButton.isHidden = false
                    
                }
            }
        } else {
            
          //.  let alert = UIAlertController(title: "Login To FB", message: "The User has already logged in", preferredStyle: <#T##UIAlertControllerStyle#>)
            
        }
        
        
        
    }
    
    @IBAction func logOutOfFacebook(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        myLogoutButton.isHidden = true
        myLoginButton.isHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
