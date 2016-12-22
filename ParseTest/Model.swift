//
//  Model.swift
//  ParseTest
//
//  Created by Li Yin on 12/13/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import Parse

class Car : PFObject {
  
  @NSManaged var brand: String
  @NSManaged var image: PFFile?
  
  override init() {
    super.init()
  }
  
  convenience init(brand: String, image: PFFile) {
    self.init()
    self.brand = brand
    self.image = image
  }
  
}

extension Car: PFSubclassing {
  
  static func parseClassName() -> String {
    return "Car"
  }
}

extension Car {
  static func fetchImage(brandName: String, completion: @escaping (_ error: Error?, _ image: UIImage?) -> Void) {
    let query = Car.query()
    query?.whereKey("brand", equalTo: brandName)
    query?.getFirstObjectInBackground(){(object, error) in
      if let error = error {
        completion(error, nil)
      } else if let object = object as? Car, let image = object.image {
        image.getDataInBackground {(data, error) in
          if let error = error {
            completion(error, nil)
          } else if let data = data, let image = UIImage(data: data) {
            completion(nil, image)
          }
        }
      } else {
        completion(QueryError.wrongType, nil)
      }
    }
  }
}


class Collection: PFObject {
  
  @NSManaged var createTime: NSDate
  @NSManaged var collectionName: String
  @NSManaged var owner: PFUser
  @NSManaged var cars: [Car]
  
  override init() {
    super.init()
  }
  
  convenience init(collectionName: String, owner: PFUser) {
    self.init()
    createTime = NSDate()
    self.collectionName = collectionName
    self.owner = owner
    self.cars = []
  }
}

extension Collection: PFSubclassing {
  static func parseClassName() -> String {
    return "Collection"
  }
}


//class User: PFUser {
//  
//}
//
//extension User: PFSubclassing {
//  static func parseClassName() -> String {
//    return "User"
//  }
//}

public func configParse() {
  
  Car.registerSubclass()
  Collection.registerSubclass()
  let configuration = ParseClientConfiguration {
    $0.applicationId = "appID"
    $0.server = "http://localhost:1337/parse"
    $0.isLocalDatastoreEnabled = true
  }
  Parse.initialize(with: configuration)
  PFUser.enableAutomaticUser()
  PFUser.current()?.incrementKey("RunCount")
  PFUser.current()?.saveInBackground()
}

enum QueryError: Error {
  case wrongType
}
