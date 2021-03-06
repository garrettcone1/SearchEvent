//
//  LoginVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/13/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//
import Foundation
import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        // Create authorization request to EventBrite and load the Web View
        YelpClient.sharedInstance().authenticateWithViewController(viewController: self) { (success, errorString) in

            performuUIUpdatesOnMain {
                if success {

                    self.successfulLogin()
                } else {

                    print(errorString!)
                }
            }
        }
    }
    
    // Create function to instantiate the View Controller if successfully logged in
    private func successfulLogin() {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "EventTabController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }
}
