//
//  RatingCell.swift
//  Resource Coach
//
//  Created by Apple on 23/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

protocol RatingCellDelegate : class {
    func openWriteReviewVC(articleId : String)
    func openReadReviewVC(articleId : String)
    func makeFavoriteUnfavourite(articleId : String,UserId : String,row : Int,section : Int)
}

class RatingCell: UITableViewCell {
    
    var delegate: RatingCellDelegate?
    
    @IBOutlet weak var authorView: UIView!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblPostedDate: UILabel!
    @IBOutlet weak var lblViewsCount: UILabel!
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var btnWriteReview: UIButton!
//    @IBOutlet weak var ratingView: StarRatingControl!
//    @IBOutlet weak var starRatingView: StarRatingControl!
    @IBOutlet weak var myFloatRatingView: FloatRatingView!
    @IBOutlet weak var ratingAndCommentView: UIView!
    @IBOutlet weak var btnViewComments: UIButton!
    
    
    var articleId : String?
    var userId : String?
    var index: Int = 0
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func writeCommentsBtnTapped(_ sender: UIButton) {
        delegate?.openWriteReviewVC(articleId: articleId!)
    }
    
    
    @IBAction func readCommentsBtnTapped(_ sender: UIButton) {
        delegate?.openReadReviewVC(articleId: articleId!)
    }
    
    @IBAction func favoriteBtnTapped(_ sender: UIButton) {
        delegate?.makeFavoriteUnfavourite(articleId: articleId!, UserId: userId!, row: index,section: section)
    }
    
}


