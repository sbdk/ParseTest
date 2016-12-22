//
//  PFLoginController.swift
//  ParseTest
//
//  Created by Li Yin on 12/15/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse

class PFLogInController: PFLogInViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if !PFAnonymousUtils.isLinked(with: PFUser.current()) {
      dismiss(animated: true, completion: nil)
    }
  }
}

extension PFLogInController: PFLogInViewControllerDelegate {
  func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
    print("login success")
    dismiss(animated: true, completion: nil)
  }
  
  func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: Error?) {
    print("failed to login")
    guard let error = error else {
      print("there is a unknwon error")
      return
    }
    
    presentAlertView(title: "Login Error", body: error.localizedDescription, host: self)
  }
  
  func log(_ logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
    return true
  }
}
