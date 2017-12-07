//
//  TaskTableViewCell.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var isCompletedOval: UIImageView!
    
    @IBOutlet weak var lblOwner: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblExpDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
