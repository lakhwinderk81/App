//
//  BalanceTblCell.swift
//  app
//
//  Created by apple on 19/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BalanceTblCell: UITableViewCell {

    @IBOutlet var lblDate:UILabel?
    @IBOutlet var lblDescription:UILabel?
    @IBOutlet var lblCredit:UILabel?
    @IBOutlet var lblDebit:UILabel?
    @IBOutlet var lblBalance:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
