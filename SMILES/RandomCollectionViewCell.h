//
//  RandomCollectionViewCell.h
//  SMILES
//
//  Created by BiipByte Technologies on 26/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomCollectionViewCell : UICollectionViewCell

//Recent Article
@property (weak, nonatomic) IBOutlet UIImageView *articleImg;
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *latestLockImg;

///Favorite Articles
@property (weak, nonatomic) IBOutlet UIImageView *favoriteArticleImg;
@property (weak, nonatomic) IBOutlet UILabel *favoriteArticleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *favVideoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblTrendingDuration;
@property (weak, nonatomic) IBOutlet UIImageView *TrendingLockImg;

//MostViewedArticle
@property (weak, nonatomic) IBOutlet UIImageView *mostViewArticleImg;
@property (weak, nonatomic) IBOutlet UILabel *mostViewdArticleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mostViewVideoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblContinueArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *ContinueReadingLockImg;



@end
