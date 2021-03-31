//
//  QuestionCell.swift
//  Resource Coach
//
//  Created by Apple on 08/01/21.
//  Copyright © 2021 Biipmi. All rights reserved.
//

import UIKit

protocol QuestionCellDelegate : class {

}

class QuestionCell: UITableViewCell {
    
    var delegate: QuestionCellDelegate?

    @IBOutlet weak var QuestionNoLbl: UILabel!
    @IBOutlet weak var answerImgView: UIImageView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option3Lbl: UILabel!
    @IBOutlet weak var option4Lbl: UILabel!
    @IBOutlet weak var correctAnswerStaticLbl: UILabel!
    @IBOutlet weak var correctAnswerLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    
    @IBOutlet weak var correctAnswerStaticLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reasonStaticLblHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
