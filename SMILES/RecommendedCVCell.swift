//
//  RecommendedCVCell.swift
//  Resource Coach
//
//  Created by Apple on 28/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

class RecommendedCVCell: UICollectionViewCell {

    @IBOutlet weak var lockImgView: UIImageView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var playImgView: UIImageView!
    @IBOutlet weak var recommendedArticleImg: UIImageView!
    @IBOutlet weak var recommendedArticleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
