//
//  ArticleDetailsViewController.h
//  SMILES
//
//  Created by Biipmi on 26/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface ArticleDetailsViewController : UIViewController
@property(nonatomic,retain)NSString *articleId,*assessmentId,*articleTitle,*articleShortDescription,*artcleLongDescription,*artticleImage1,*artticleImage2,*artticleImage3,*artticleVideo,*articleVideoThumb,*articleType,*strMinicertificationId,*strVideoEndTime;
@property(nonatomic,retain)NSString *articlePosterId,*articlePosterName,*artclePosterTelcode,*artticlePosterMobileNo,*artticlePosterEmail;

@property (weak, nonatomic) IBOutlet UILabel *lblh1;
@property (weak, nonatomic) IBOutlet UILabel *lblh2;
@property (weak, nonatomic) IBOutlet UIImageView *reviewimg;
//@property (weak, nonatomic) IBOutlet UIWebView *descriptionWbview;
@property (weak, nonatomic) IBOutlet UIView *reviewview;
@property (weak, nonatomic) IBOutlet UIView *viewReviewview;
@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *desctitle;
@property (weak, nonatomic) IBOutlet UILabel *quiztitle;

@property (weak, nonatomic) IBOutlet UIButton *btnAuthor;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthor1;

@property (weak, nonatomic) IBOutlet YTPlayerView *ytPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAnalytics;
@property (weak, nonatomic) IBOutlet UIImageView *imgAnalyticsArrow;
@property (weak, nonatomic) IBOutlet UIView *viewWriteShow;
@property (weak, nonatomic) IBOutlet UIView *viewDescription;
@property (weak, nonatomic) IBOutlet UIView *viewQuiz;
@property (weak, nonatomic) IBOutlet UIImageView *writeReviewArrow;
@property (weak, nonatomic) IBOutlet UIWebView *YouTubeWebView;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWbview;


@property (weak,nonatomic) IBOutlet NSLayoutConstraint *authorViewsHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionViewHight;

//Quiz View Objects
@property (weak, nonatomic) IBOutlet UIView *quizView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quizViewHight;
@property (weak, nonatomic) IBOutlet UIView *option1View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *option1ViewHight;

@property (weak, nonatomic) IBOutlet UIView *option2View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *option2ViewHight;

@property (weak, nonatomic) IBOutlet UIView *option3View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *option3ViewHight;

@property (weak, nonatomic) IBOutlet UIView *option4View;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *option4ViewHight;

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerViewHight;
@property (weak, nonatomic) IBOutlet UIView *viewShare;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UILabel *lblRatingCount;
@property(nonatomic,retain)NSString *videoStartTime;
@property (nonatomic, assign) BOOL needToReloadArticleDetails;

@end
