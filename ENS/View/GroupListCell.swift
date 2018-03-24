//
//  GroupListCell.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class GroupListCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!

    var row: Int?
    var onMessageClick: ((Int) -> ())?
    var onEmaiClick: ((Int) -> ())?
    var onCallClick: ((Int) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func actionEmail(_ sender: Any) {
        if let row = self.row {
            onEmaiClick?(row)
        }
    }

    @IBAction func actionMessage(_ sender: Any) {
        if let row = self.row {
            onMessageClick?(row)
        }
    }
    
    @IBAction func actionCall(_ sender: Any) {
        if let row = self.row {
            onCallClick?(row)
        }
    }
}
