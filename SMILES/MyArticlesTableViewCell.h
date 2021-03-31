//
//  MyArticlesTableViewCell.h
//  SMILES
//
//  Created by BiipByte on 08/05/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyArticlesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthore;
@property (weak, nonatomic) IBOutlet UILabel *lblRatingCount;
@property (weak, nonatomic) IBOutlet UILabel *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *lblViewCount;
@property (weak, nonatomic) IBOutlet UIButton *btnAddSubArticle;
@property (weak, nonatomic) IBOutlet UIImageView *articleImg;
@property (weak, nonatomic) IBOutlet UIImageView *imgVideoIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblReviewCountNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblShortDescription;
@property (weak, nonatomic) IBOutlet UIImageView *viewedImg;
@end
