//
//  DescriptionCell.swift
//  Resource Coach
//
//  Created by Apple on 25/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

protocol DescriptionCellDelegate : class {
//        func refreshSecondCell()
}

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var delegate: DescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
