//
//  TableView.swift
//  ParseTest
//
//  Created by Li Yin on 12/21/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import UIKit
import Parse

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tableView: UITableView!
  var titleString: String!
  var user: PFUser = PFUser.current()!
  var collection: Collection?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor.lightText
    navigationController?.navigationBar.isTranslucent = false
    automaticallyAdjustsScrollViewInsets = false
    setupTableView()
    
    if PFUser.current()!.objectId != nil {
      let query = Collection.query()
      query?.includeKey("cars")
      query?.whereKey("owner", equalTo: user)
      query?.getFirstObjectInBackground(){ result, error in
        guard let result = result else {return}
        self.collection = result as! Collection
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnSwipe = false
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let collection = collection {
      return collection.cars.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
    let car = collection!.cars[indexPath.row]
    
    Car.fetchImage(brandName: car.brand) { (error, image) in
      if let _ = error {
        return
      } else if let image = image {
        DispatchQueue.main.async {
          cell.photoBackgroundView.image = image
        }
      }
    }
    cell.hoverTitleLabel.text = car.brand
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250.0
  }
  
  
  func setupTableView() {
    //Step 1. Create a new tableView object
    tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
    
    //Step 2. Call the custom function to setup tableView's elements and layouts
    setupCustomTableView(tableView: tableView, within: self)
  }

  
}
