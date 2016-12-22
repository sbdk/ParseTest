//
//  CustomViews.swift
//  ParseTest
//
//  Created by Li Yin on 12/15/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import UIKit


func presentAlertView<T: UIViewController>(title: String, body: String?, host: T ) {
  let alertView = UIAlertController(title: title, message: body, preferredStyle: .alert)
  let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
  alertView.addAction(okAction)
  host.present(alertView, animated: true, completion: nil)
}


class FeedTableViewCell: UITableViewCell {
  
  var hoverView: UIView!
  var photoBackgroundView: UIImageView!
  var hoverTitleLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.backgroundColor = UIColor.clear
    
    photoBackgroundView = UIImageView()
    photoBackgroundView.contentMode = .scaleAspectFill
    photoBackgroundView.clipsToBounds = true
    photoBackgroundView.backgroundColor = UIColor.lightGray
    photoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(photoBackgroundView)
    
    hoverView = UIView()
    hoverView.backgroundColor = UIColor.white
    hoverView.alpha = 0.7
    hoverView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(hoverView)
    
    hoverTitleLabel = UILabel()
    hoverTitleLabel.numberOfLines = 0
    hoverTitleLabel.backgroundColor = UIColor.clear
    hoverTitleLabel.textAlignment = .center
    hoverTitleLabel.font = UIFont(name: "Snell Roundhand", size: 17)
    hoverTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(hoverTitleLabel)
    
    
    if #available(iOS 9.0, *) {
      NSLayoutConstraint.activate([
        photoBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        photoBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        photoBackgroundView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
        photoBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        photoBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        
        hoverView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        hoverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        hoverView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
        hoverView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
        
        hoverTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        hoverTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        hoverTitleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    } else {
      // Fallback on earlier versions
      NSLayoutConstraint.activate([
        NSLayoutConstraint(item: photoBackgroundView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: photoBackgroundView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: photoBackgroundView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.95, constant: 0),
        NSLayoutConstraint(item: photoBackgroundView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 5),
        NSLayoutConstraint(item: photoBackgroundView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -5),
        
        NSLayoutConstraint(item: hoverView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: hoverView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: hoverView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.7, constant: 0),
        NSLayoutConstraint(item: hoverView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.7, constant: 0),
        
        NSLayoutConstraint(item: hoverTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: hoverTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: hoverTitleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        ])
    }
  }
}


//MARK: Help functinon to setup views
func setupCustomTableView(tableView: UITableView, within controller: UIViewController) {
  if #available(iOS 9.0, *) {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: controller.topLayoutGuide.bottomAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: controller.bottomLayoutGuide.topAnchor, constant: 0)
      ]
    )
  } else {
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: controller.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: controller.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
      ])
  }
}




