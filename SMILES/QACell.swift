//
//  QACell.swift
//  Resource Coach
//
//  Created by Apple on 25/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

protocol QADelegate : class {
    
}
class QACell: UITableViewCell {

    var delegate: QADelegate?
    @IBOutlet weak var quizQandAContainer: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var answerImgView: UIImageView!
    
    
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option3Lbl: UILabel!
    @IBOutlet weak var option4Lbl: UILabel!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var correctAnswerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
