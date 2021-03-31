//
//  ArticleCatTableViewCell.h
//  SMILES
//
//  Created by BiipByte Technologies on 22/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCatTableViewCell : UITableViewCell

//Category
@property (weak, nonatomic) IBOutlet UIImageView *imgViewCat;
@property (weak, nonatomic) IBOutlet UILabel *lblCategorieName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubCategoriesCount;
@property (weak, nonatomic) IBOutlet UIView *categoriesView;

//Sub category
@property (weak, nonatomic) IBOutlet UILabel *lblSubCatName;

//Sub Sub Category

@property (weak, nonatomic) IBOutlet UILabel *lbl3SubCategory;
@property (weak, nonatomic) IBOutlet UIImageView *img3SubArrow;


//Articles
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblViewsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblShortDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (weak, nonatomic) IBOutlet UILabel *lblRateCount;
@property (weak, nonatomic) IBOutlet UILabel *lblReviedCount;
@property (weak, nonatomic) IBOutlet UIImageView *rateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favPressedImg;
@property (weak, nonatomic) IBOutlet UIImageView *articleVideoPlayImg;
@property (weak, nonatomic) IBOutlet UILabel *lblBgRate;
@property (weak, nonatomic) IBOutlet UIImageView *viewedImage;
@property (weak, nonatomic) IBOutlet UILabel *lblArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgArticleLock;
@property (weak, nonatomic) IBOutlet UIImageView *imgNew;

//Favorite Articles
@property (weak, nonatomic) IBOutlet UIImageView *favArticleImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFavAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblFavArticleName;
@property (weak, nonatomic) IBOutlet UILabel *lblFavArticleShortDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblFavRating;
@property (weak, nonatomic) IBOutlet UILabel *lblFavRatingCount;
@property (weak, nonatomic) IBOutlet UIImageView *favStarImg;
@property (weak, nonatomic) IBOutlet UIImageView *favVideoPlayImg;
@property (weak, nonatomic) IBOutlet UIButton *btnUnFavourite;
@property (weak, nonatomic) IBOutlet UILabel *lblFavBgRate;
@property (weak, nonatomic) IBOutlet UILabel *lblViews;
@property (weak, nonatomic) IBOutlet UILabel *lblFavArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgFavLock;
//Book Mark Folders

@property (weak, nonatomic) IBOutlet UIImageView *articleBookMarkImage;
@property (weak, nonatomic) IBOutlet UILabel *lblBookmarkArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBookmarkAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblBookmarkViewsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblBookmarkShortDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnBookMarkFavorite;
@property (weak, nonatomic) IBOutlet UIButton *btnBookMarkDelete;
@property (weak, nonatomic) IBOutlet UILabel *lblBookMarkRateCount;
@property (weak, nonatomic) IBOutlet UILabel *lblBookMarkReviedCount;
@property (weak, nonatomic) IBOutlet UIImageView *rateBookMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favBookMarkPressedImg;
@property (weak, nonatomic) IBOutlet UIImageView *articleBookMarkVideoPlayImg;
@property (weak, nonatomic) IBOutlet UILabel *lblBookMarkBgRate;
@property (weak, nonatomic) IBOutlet UIImageView *viewedBookMarkImage;
@property (weak, nonatomic) IBOutlet UILabel *lblBookMarkArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgBookMarkArticleLock;
@property (weak, nonatomic) IBOutlet UIButton *btnBookMark;

@end
