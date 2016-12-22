//
//  PFSignUpController.swift
//  ParseTest
//
//  Created by Li Yin on 12/15/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PFSignUpController: PFSignUpViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    
    self.signUpView?.passwordField?.clearsOnBeginEditing = true
  }
}


extension PFSignUpController: PFSignUpViewControllerDelegate {
  
  //Client side sigun info validation
  func signUpViewController(_ signUpController: PFSignUpViewController, shouldBeginSignUp info: [String : String]) -> Bool {
    
    if let email = info["email"] {
      if email == "" {
        presentAlertView(title: "Sign Up Error", body: "Email can't be empty", host: self)
        return false
      }
    } else {
      return false
    }
    
    guard let password = info["password"] else {
      return false
    }
    
    if password.characters.count >= 6 {
      return true
      
    } else {
      presentAlertView(title: "Password is too short", body: "Please provide a password with at least 6 characters", host: self)
      return false
    }
  }
  
  func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
    print(user)
    dismiss(animated: true , completion: nil)
  }
  
  func signUpViewControllerDidCancelSignUp(_ signUpController: PFSignUpViewController) {
    
  }
}
