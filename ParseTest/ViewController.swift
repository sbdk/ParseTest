//
//  ViewController.swift
//  ParseTest
//
//  Created by Li Yin on 12/12/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {
  
  @IBOutlet weak var logInAOutButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  var objectID: String? = nil
  var newCar: Car!

  override func viewDidLoad() {
    super.viewDidLoad()
    let image = UIImage(named: "Mazda")
    let data = UIImagePNGRepresentation(image!)!
    print(PFUser.current())
    if PFAnonymousUtils.isLinked(with: PFUser.current()) {
      print("Current user is Anonymous")
    }
    
    guard let carFile = PFFile(data: data) else {
      print("create PFFile from image data failed")
      return
    }
    newCar = Car(brand: "马自达", image: carFile)
    
    newCar.saveInBackground { (success, error) in
      if success {
        print("save image data success")
      } else {
        print(error?.localizedDescription)
      }
    }
    
    //Creat a new parse object
//    let testObject = PFObject(className: "game")
//    testObject["score"] = 999
//    testObject["playerName"] = "wuwu"
//    testObject["cheatMode"] = false
    
    //When called this method, data will stored locally when there is no network connection, and uploaded onto cloud when connection back.
//    testObject.saveEventually()
    
    //MARK: Save object to cloud
//    testObject.saveInBackground(){(success: Bool, error: Error?) -> Void in
//      if success {
//        self.objectID = testObject.objectId
//        print("save new Object success")
//      } else {
//        print("\(error?.localizedDescription)")
//      }
//    }
    
    //MARK: Save object to localDataStore (when store in local, no objectId generated)
//    testObject.pinInBackground { (success: Bool, error: Error?) in
//      if success {
//
//      }
//    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateLogButton()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "collection" {
      let controller = segue.destination as! TableView
      controller.titleString = "这是个实验"
    }
  }
  
  @IBAction func SaveButtonTouched(_ sender: Any) {
    
    let query = Collection.query()
    //Do some fine query condition here...
    query?.getFirstObjectInBackground(block: { (result, error) in
      if error != nil {
        let errorCode = (error as! NSError).code
        switch errorCode {
        //No object found, creat a default collection to save data
        case 101:
          let defaultCollection = Collection(collectionName: "Default", owner: PFUser.current()!)
          defaultCollection.cars.append(self.newCar)
          defaultCollection.saveInBackground(block: { (success, error) in
            if success {
              print("Create a default collection and save data successfully")
            }
          })
        default: break
        }
      } else {
          let collection = result as! Collection
          collection.cars.append(self.newCar)
          collection.saveInBackground(block: { (success, error) in
          if success {
            print("Find a collection and save data successfully")
          }
        })
      }
    })
  }


  @IBAction func ButtonTouched(_ sender: Any) {
    
    if !PFAnonymousUtils.isLinked(with: PFUser.current()) {
      PFUser.logOut()
      updateLogButton()
      print("logOut success")
    } else {
      //No user exist, present login view
      //MARK: ParseUI default loginViewController
      let logInController = PFLogInController()
      let signUpController = PFSignUpController()
      logInController.emailAsUsername = true
      signUpController.emailAsUsername = true
      logInController.signUpController = signUpController
      logInController.fields = [
        PFLogInFields.usernameAndPassword,
        PFLogInFields.logInButton,
        PFLogInFields.signUpButton,
        PFLogInFields.passwordForgotten,
        PFLogInFields.dismissButton,
        PFLogInFields.facebook
      ]
      logInController.facebookPermissions = ["friends_about_me"]
      present(logInController, animated: true, completion: nil)

    }
    
    //MARK: Fetch image from cloud
//    Car.fetchImage(brandName: "Mazda") { (error, image) in
//      
//      if let _ = error {
//        return
//      } else if let image = image {
//        DispatchQueue.main.async {
//          self.imageView.image = image
//        }
//      }
//    }
    
//    let object = PFObject(className: "game")
//    object.remove(forKey: "userName")
    
    //MARK: Update a object in cloud
//    let query = PFQuery(className: "game")
//    query.getObjectInBackground(withId: "lIHcm0UFqg") { (result: PFObject?, error: Error?) in
//      guard let result = result else {
//        return
//      }
//      result["score"] = 666
//      result["userName"] = "Sabrina"
//      result.saveInBackground()
//    }
    
    //MARK: query from cloud
//    query.whereKey("playerName", equalTo: "dongdong")
//    query.findObjectsInBackground(){(results: [PFObject]?, error: Error?) -> Void in
//      if error == nil {
//        let userName = results?[0]["playerName"] as! String
//        let score = results?[0]["score"] as! Int
//        print("\(userName) get a score of \(score)")
//      } else {
//      }
//    }
    
    //This metod can only be used when query from cloud, since only data stored at cloud generate the objectId
//    query.getObjectInBackground(withId: <#T##String#>) { (<#PFObject?#>, <#Error?#>) in
//      <#code#>
//    }
    
    //MARK: Query from local Datastore
//    query.fromLocalDatastore()
//    query.whereKey("userName", equalTo: "dongdong")
//    query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
//      guard let results = results else {
//        print(error.debugDescription)
//        return
//      }
//      let name = results[0]["userName"] as! String
//      print(name)
//    }
  }
}

extension ViewController {
  enum logButtonStatus: String {
    case toLogOut = "Log Out"
    case toLogIn = "Log In"
  }
  
  func updateLogButton() {
    if PFAnonymousUtils.isLinked(with: PFUser.current()) {
      logInAOutButton.setTitle(logButtonStatus.toLogIn.rawValue, for: .normal)
    } else {
      logInAOutButton.setTitle(logButtonStatus.toLogOut.rawValue, for: .normal)
    }
  }
}


