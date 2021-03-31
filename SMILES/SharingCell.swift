//
//  SharingCell.swift
//  Resource Coach
//
//  Created by Apple on 25/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

protocol SharingCellDelegate : class {
    func openSharing()
}

class SharingCell: UITableViewCell {

    var delegate : SharingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        delegate?.openSharing()
    }
    
}
