//
//  CustomTableViewCell.swift
//  PersistenceStorageAssignment1
//
//  Created by Macmini-13 on 21/09/2022.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
static let identifier: String = "tableViewCell"

    
//MARKS:- Outlets
    
  @IBOutlet  weak var nameLabel: UILabel!
  @IBOutlet  weak var dateLabel: UILabel!
    
    
}
