//
//  ArticalViewController.swift
//  ParseTest
//
//  Created by Li Yin on 12/22/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import Parse

class ArticalViewController: UIViewController {

  @IBOutlet weak var articalTitle: UILabel!
  @IBOutlet weak var articalBody: UITextView!
  @IBOutlet weak var coverImageView: UIImageView!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      coverImageView.image = UIImage(named: "default")
      let query = PFQuery(className: "Artical")
      query.getFirstObjectInBackground { (result, error) in
        guard let result = result else {
          return
        }
        
        DispatchQueue.main.async {
          self.articalTitle.text = result["title"] as! String
          self.articalBody.text = result["body"] as! String
        }
        
        let file = result["cover"] as! PFFile
        file.getDataInBackground() { data, error in
          guard let data = data, let image = UIImage(data: data) else {
            return
          }
          DispatchQueue.main.async {
            self.coverImageView.image = image
          }
        }
        
      }
      
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
