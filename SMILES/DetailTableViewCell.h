//
//  DetailTableViewCell.h
//  SMILES
//
//  Created by Biipmi on 6/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarView.h"
#import "DLStarRatingControl.h"
#import "StarRatingControl.h"

@interface DetailTableViewCell : UITableViewCell

//cell1
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblPostedDate;
@property (weak, nonatomic) IBOutlet UILabel *lblViewsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRateCount;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToFavourite;
@property (weak, nonatomic) IBOutlet UIButton *btnRateThisArticle;
@property (weak, nonatomic) IBOutlet UIImageView *favImage;

//cell2
@property (weak, nonatomic) IBOutlet UIImageView *artilceImageView;

// Get all Reviews for Article
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *lblReviwerName;
@property (weak, nonatomic) IBOutlet UILabel *lblReviewPostDate;
@property (weak, nonatomic) IBOutlet StarRatingControl *rateView;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
