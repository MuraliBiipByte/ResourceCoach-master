//
//  ArticleDetailsViewController.m
//  SMILES
//
//  Created by Biipmi on 26/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "UIImageView+WebCache.h"
#import "DetailTableViewCell.h"
#import "DLStarRatingControl.h"
#import "NewReviewViewController.h"
#import "StarRatingControl.h"
#import "APIDefineManager.h"
#import "GetAllReviewViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+Subviews.h"
#import "HYCircleLoadingView.h"
#import "YTPlayerView.h"
#import "Language.h"
#import "SCLAlertView.h"
//#import "ReportAnalyticsViewController.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "MessageViewController.h"
#import "UsersListViewController.h"
#import "ChatingViewController.h"
#import "TrainerDetailsViewController.h"

#import "RecomendedCollectionViewCell.h"
#import "SubscriptionViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import "BookMarkPopUpViewController.h"
#import "UIViewController+ENPopUp.h"
#import "UIViewController+MaryPopin.h"

@import AVKit;
@import AVFoundation;



@interface ArticleDetailsViewController ()<StarRatingDelegate,UIWebViewDelegate,UIScrollViewDelegate,YTPlayerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSString *userId;
    NSString *authorName,*strFavStatus;
    NSMutableArray *arrArticleImgs;
    NSString *videoType,*strBookMark;
    NSString *lock;
    
    int hightForWebView;
    
    UIView *QuizView;
    
    AVPlayer *player;
    AVPlayerViewController *controller;
    
    NSString *strSubTitle1,*strSubTitle2,*strSubTitle3,*strSubDesription1,*strSubDescription2,*strSubDescription3;
    NSMutableArray *arrSubArtTitles,*arrSubArtDescription;
    
    
    NSString *loginUserType;
    
    NSMutableArray *arrIdRecomended,*arrVideoTitleRecomended,*arrDurationRecomended,*arrRecomendedVideoType,*arrRecomendedVideoThumb,*arrRecomendedFileType,*arrArticlePhoto,*arrRecomendedCategoryLock;
    
    NSString * subArticleCount;
    NSString *strArticleDuration;
    
    //DynamicViews
    UIView *viewSubArticle1;
    UIView *viewSubArticle2;
    UIView *viewSubArticle3;
    
    
    UILabel *lblSubArticleTitle1;
    UILabel *lblSubArticleTitle2;
    UILabel *lblSubArticleTitle3;
    
    UILabel *lblSubArticleDescription1;
    UILabel *lblSubArticleDescription2;
    UILabel *lblSubArticleDescription3;

    
    //For Getting Dynamic Heights of quizOption View we are using this int
    int option1ViewDynamicHeight;
    int optionView2DynamicHeight;
    int optionView3DynamicHeight;
    int optionView4DynamicHeight;
    int quizViewDynamicViewHeight;
    int questionNameDynamicheight;
    int answerViewDynamicHeight;
    
    
  //  UIWebView *descriptionWbview;
    
    
    __weak IBOutlet UIView *authorView;
    __weak IBOutlet UIView *descriptionView;
    __weak IBOutlet UIView *videosView;
    __weak IBOutlet UIView *vimeVideosView;
    __weak IBOutlet UILabel *lblArticleTitle;
    __weak IBOutlet UILabel *lblAuthorName;
    __weak IBOutlet UILabel *lblPostedDate;
    __weak IBOutlet UILabel *lblViewsCount;
    __weak IBOutlet UILabel *lblRAtingCount;
    __weak IBOutlet UIImageView *authorImage;
    __weak IBOutlet UIImageView *favImg;
    __weak IBOutlet UIButton *btnRateThisArticle;
    __weak IBOutlet UIButton *btnFavourite;
    __weak IBOutlet StarRatingControl *ratingView;
    __weak IBOutlet UILabel *lblDescTitle;
    __weak IBOutlet UILabel *lblQuizTitle;
    __weak IBOutlet UILabel *lblQuestionName;
    __weak IBOutlet UILabel *lblOption1;
    __weak IBOutlet UILabel *lblOption2;
    __weak IBOutlet UILabel *lblOption3;
    __weak IBOutlet UILabel *lblOption4;
    __weak IBOutlet UILabel *lblCorrectAnswer;
    __weak IBOutlet UIButton *btnOption1;
    __weak IBOutlet UIButton *btnOption2;
    __weak IBOutlet UIButton *btnOption3;
    __weak IBOutlet UIButton *btnOption4;
    __weak IBOutlet UIButton *btnSubmit;
    __weak IBOutlet UIButton *btnViewReview;
    __weak IBOutlet UIImageView *quizAnswerImage;
    __weak IBOutlet UILabel *lblCorrect;
    
    //Recomended Articles
    __weak IBOutlet UICollectionView *collectionViewRecomendedArticles;
     __weak IBOutlet UIView *viewRecomendedArticles;
    
    //For Dynamic Heights
    __weak IBOutlet NSLayoutConstraint *viewRecomendedArticlesConstraint;
    
    
    
    NSString *question,*option1,*option2,*option3,*option4,*answer,*questionId;
    NSString *strCorectAns;
    NSString *btnIndex;
    UIPageControl *pageControl;
    UIScrollView *scroll;
    __weak IBOutlet UIScrollView *scrollview;
    NSString *strQuizStatus;
     YTPlayerView *ytPlayer;
    NSString * articleYoutubeLinks,*videoId;
    UILabel *lblImgTitle;
    NSString *articleImgTitle1,*articleImgTitle2,*articleImgTitle3;
    NSMutableArray *arrAticleImgTitles;
    UILabel *lblImgTitleBackGroundColor;
    UIImageView *image;
    
    NSString*postedOn,*viewsArt,*by;
    NSString *Ok;
    NSString *Cancel;
    NSString *removeFav,*corectAnswer;
    
    NSUserDefaults *startAndEndtimeDefaults;
    
    NSString *startTime;
    NSString *endTime;
    NSString *UserType;
    
    
  
    NSString *authoreId;
    NSString *authorImg;
    
    UIView *backGroundView;
    
    CGSize sizeTitle;
    CGSize sizeAuthore;
    CGSize sizePostedOn;
    CGSize sizeViews;
    
    NSString *articleVideoType;
    UIBarButtonItem *btnBookMark;
    UIBarButtonItem *chatButton;
    

}
@property (nonatomic,assign) NSInteger selectedCountryCode;
@property (nonatomic, retain) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (nonatomic, getter = isDismissable) BOOL dismissable;
@property (nonatomic, assign) NSInteger selectedAlignementOption;
//@property (nonatomic, strong) SRVideoPlayer *videoPlayer;
//@property (nonatomic, assign) BOOL needToReloadArticleDetails;

@end

@implementation ArticleDetailsViewController
@synthesize articleTitle,artticleVideo,artticleImage1,artticleImage2,artticleImage3,articlePosterId,articlePosterName,artclePosterTelcode,artticlePosterEmail,artcleLongDescription,artticlePosterMobileNo,articleShortDescription,articleId,articleVideoThumb,articleType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
     scrollview.hidden=YES;
    
    
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryErr];
    [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-16, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_viewWriteShow addSubview:lineView];

    
    arrSubArtTitles=[[NSMutableArray alloc]init];
    arrSubArtDescription=[[NSMutableArray alloc]init];
    arrRecomendedFileType=[[NSMutableArray alloc]init];
    arrArticlePhoto = [[NSMutableArray alloc]init];
     arrAticleImgTitles = [[NSMutableArray alloc]init];
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    
   [ _btnShare addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Loader.....
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];

    [backGroundView addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
      [backGroundView addSubview:self.loadingView];
    [self.view bringSubviewToFront:backGroundView];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults valueForKey:@"id"];
    UserType=[userDefaults valueForKey:@"usertype"];
    [self checkUserType];
    [self getArticleDetails];
    
    btnIndex=@"0";
    quizAnswerImage.hidden=YES;
    lblCorrect.hidden=YES;
    arrArticleImgs=[[NSMutableArray alloc]init];
    [self navigationConfiguration];
    
    
    [authorImage setHidden:YES];
    authorImage.layer.masksToBounds=YES;
    authorImage.layer.cornerRadius=4.0f;
    lblCorrectAnswer.hidden=YES;
    btnSubmit.layer.cornerRadius=4.0f;
    [self articleViewd];
    
    
    self.ytPlayerView.hidden=YES;
    [btnRateThisArticle setTitle:[Language WriteReview] forState:UIControlStateNormal];
    lblDescTitle.text=[Language Description];
    lblQuizTitle.text=[Language Quiz];
    [btnSubmit setTitle:[Language SubmitAnswer] forState:UIControlStateNormal];
    
    
    startAndEndtimeDefaults =[NSUserDefaults standardUserDefaults];
    [startAndEndtimeDefaults setValue:@"" forKey:@"date"];
    [startAndEndtimeDefaults setValue:@"" forKey:@"identity"];
    [startAndEndtimeDefaults setValue:@"" forKey:@"userid"];
    [startAndEndtimeDefaults setValue:@"" forKey:@"articleid"];
    
    NSString *str=[startAndEndtimeDefaults valueForKey:@"userid"];
    NSLog(@"userid is %@",str);
    // NSLog(@"defaulte %@",startAndEndtimeDefaults);
    
    //finding current date and time
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    // or Timezone with specific name like
    // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    startTime = [dateFormatter stringFromDate:currentDate];
    
    [startAndEndtimeDefaults setObject:startTime forKey:@"starttime"];
    [startAndEndtimeDefaults setValue:@"identity" forKey:@"identity"];
    [startAndEndtimeDefaults setValue:userId forKey:@"userid"];
    [startAndEndtimeDefaults setValue:articleId forKey:@"articleid"];
    
    NSString *str1=[startAndEndtimeDefaults valueForKey:@"date"];
    NSLog(@"date  is %@",str1);
//    _reviewimg.hidden=YES;
//    btnRateThisArticle.hidden=YES;
//    
//    _reviewview.hidden=YES;
//    lblRAtingCount.hidden=YES;
//    _writeReviewArrow.hidden=YES;
//     _viewReviewview.hidden=YES;
    _desctitle.text=[Language Description];
    [_btnViewAnalytics setTitle:[Language ViewAnalytics] forState:UIControlStateNormal];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:self.strMinicertificationId forKey:@"miniid"];
    [defaults setValue:self.articleId forKey:@"artid"];
    
    if([self.strVideoEndTime isEqual:[NSNull null]])
    {
        [defaults setValue:@"00:00:00" forKey:@"videoStart"];
    }
    else
    {
        [defaults setValue:_strVideoEndTime forKey:@"videoStart"];
    }


    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *uDefaults=[NSUserDefaults standardUserDefaults];
    if([uDefaults boolForKey:@"NeedToReloadArticleDetails"]) {
        [uDefaults setBool:NO forKey:@"NeedToReloadArticleDetails"];
        [self getArticleDetails];
    } else {
        NSLog(@"No need to reload ArticleDetails....");
    }
    
//    [self getArticleDetails];
//    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
//    uID=[usercheckup valueForKey:@"id"];
//    UserType=[usercheckup valueForKey:@"usertype"];
//    [self checkUserType];
    
}
-(void)bookMoarkPopUp
{
//    BookMarkPopUpViewController *popin = [self.storyboard instantiateViewControllerWithIdentifier:@"BookMarkPopUpViewController"];
//    popin.view.frame = CGRectMake(0, 0, 340.0f, 350.0f);
//    popin.strArticleId = articleId;
//    popin.strArticleName = lblArticleTitle.text;
//
//    [self presentPopUpViewController:popin];
//
    [player pause];
    BookMarkPopUpViewController *popin = [self.storyboard instantiateViewControllerWithIdentifier:@"BookMarkPopUpViewController"];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSlide];
    if ([self isDismissable])
    {
        [popin setPopinOptions:BKTPopinDefault];
    }
    else
    {
        [popin setPopinOptions:BKTPopinDisableAutoDismiss];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(bookMarkStatus)
     name:@"SecondViewControllerDismissed"
     object:nil];
    
    //Set popin alignement according to value in segmented control
    [popin setPopinAlignment:self.selectedAlignementOption];
    popin.strArticleId = articleId;
    popin.strArticleName = lblArticleTitle.text;
    //Create a blur parameters object to configure background blur
    BKTBlurParameters *blurParameters = [BKTBlurParameters new];
    blurParameters.alpha = 1.0f;
    blurParameters.radius = 8.0f;
    blurParameters.saturationDeltaFactor = 1.8f;
    blurParameters.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [popin setBlurParameters:blurParameters];
    
    
    //Add option for a blurry background
    [popin setPopinOptions:[popin popinOptions]|BKTPopinBlurryDimmingView];
    
    //Define a custom transition style
    if (popin.popinTransitionStyle == BKTPopinTransitionStyleCustom)
    {
        [popin setPopinCustomInAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
         
         popinController.view.frame = finalFrame;
         popinController.view.transform = CGAffineTransformMakeRotation(M_PI_4 / 2);
         
         }];
        
        [popin setPopinCustomOutAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
         
         popinController.view.frame = finalFrame;
         popinController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
         
         }];
    }
    
    [popin setPreferedPopinContentSize:CGSizeMake(340.0f, 350.0f)];
    
    //Set popin transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self.navigationController presentPopinController:popin animated:YES completion:^{
     NSLog(@"Popin presented !");
     }];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)checkUserType
{
    
    [[APIManager sharedInstance]checkingUserType:userId andCompleteBlock:^(BOOL success, id result) {
     NSLog(@"%@",result);
     if (!success) {
     return ;
     }
     else{
     NSDictionary *userdata=[result valueForKey:@"userdata"];
     NSString *type=[userdata valueForKey:@"usertype"];
     NSString *userIds=[userdata valueForKey:@"user_id"];
     NSString *userName=[userdata valueForKey:@"username"];
     
     
     if (![UserType isEqualToString:type] )
     {
     
     UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Your user account type has been changed by Admin" preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                        [defaults setObject:userIds forKey:@"id"];
                        [defaults setObject:userName forKey:@"name"];
                        [defaults setObject:type forKey:@"usertypeid"];
                        [defaults setObject:type forKey:@"usertype"];
                        
                        RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                        [self presentViewController:homeView animated:YES completion:nil];
                        
                        
                        }];
     [alert addAction:ok];
     [self presentViewController:alert animated:YES completion:nil];
     }
     
     }
     }];
}


#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        self.title=@"文章详情";
        postedOn=@"发表于:";
        viewsArt=@"视图:";
        by=@"通过 ";
        Ok=@"好";
        Cancel=@"取消";
        removeFav=@"您确定要将此文章从收藏夹列表中删除吗？";
        corectAnswer=@"正确答案:";
       
        lblCorrect.text=@"အဖြေမှန်:";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                    NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"အပိုဒ်အသေးစိတ်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }
    else if ([language1 isEqualToString:@"3"]){
        //  self.title=@"အပိုဒ်အသေးစိတ်";
        postedOn=@"တွင် Posted:";
        viewsArt=@"အမြင်ချင်း";
        by=@"အားဖြင့် ";
        Ok=@"အိုကေ";
        Cancel=@"ဖျက်သိမ်း";
        removeFav=@"သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?";
        corectAnswer=@"အဖြေမှန်:";
         lblCorrect.text=corectAnswer;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"အပိုဒ်အသေးစိတ်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
        
    }
    else
    {
        self.title=@"Lesson Details";
        postedOn=@"Posted On:";
        viewsArt=@"Views:";
        by=@"By ";
        Ok=@"ok";
        Cancel=@"cancel";
        removeFav=@"Are you sure, you want to remove this Lesson from your Favorite List?";
        corectAnswer=@"Correct Answer:";
         lblCorrect.text=corectAnswer;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                    NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }
    lblCorrectAnswer.text=corectAnswer;
    



    UIBarButtonItem *barButtonChat = [[UIBarButtonItem alloc] initWithCustomView:chatButton];
    self.navigationItem.rightBarButtonItem = barButtonChat;
     self.navigationItem.rightBarButtonItem = btnBookMark;
    
   
    
       UIBarButtonItem *btnChat = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chat"] style:UIBarButtonItemStylePlain target:self action:@selector(goToChatView)];
   
     btnBookMark = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bookmark"] style:UIBarButtonItemStylePlain target:self action:@selector(bookMoarkPopUp)];
     chatButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chat"] style:UIBarButtonItemStylePlain target:self action:@selector(goToChatView)];


    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnChat, btnBookMark, nil]];

    
}

-(void)backBtnTapped:(id)sender
{
    
    [player pause];
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);

    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
   
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Current Video Timings" message:[NSString stringWithFormat:@"%@   %@",videoDurationText,cvideoDurationText] preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:ok];
    
    //    [self presentViewController:alertController animated:YES completion:nil];
    
  
   // [playerVc.playButton addTarget:self action:@selector(didPlayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    startTime=[startAndEndtimeDefaults valueForKey:@"starttime"];
    
    if([startTime isEqualToString:@""]||[startTime isEqual:[NSNull null]])
    {
        NSLog(@"Already inserted");
         [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [startAndEndtimeDefaults setObject:@"" forKey:@"identity"];
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        
        
        endTime = [dateFormatter stringFromDate:currentDate];
        
        // NSDate *dtPostDate = [dateFormatter dateFromString:endTime];
        
        NSString *start=[startAndEndtimeDefaults valueForKey:@"starttime"];

        
        NSLog(@"date  is %@",endTime);
        
        [[APIManager sharedInstance]startAndEndTimeforArticle:start andWithEndTime:endTime withUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result) {
         
         if (!success)
         {
          [self.navigationController popViewControllerAnimated:YES];
         return ;
         
         }
         [startAndEndtimeDefaults setObject:@"" forKey:@"starttime"];
          [self.navigationController popViewControllerAnimated:YES];
         
         }];
        
        
    
    }
    
    
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
         NSString *VideoendTime=  [defaults valueForKey:@"VCT"];
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result)
         {
         if(!success)
         {
          [self.navigationController popViewControllerAnimated:YES];
         return ;
         
         }
         else
         {
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
          [defaults setValue:@"" forKey:@"miniid"];
          [defaults setValue:@"" forKey:@"artid"];
         
         NSLog(@"Success");
          [self.navigationController popViewControllerAnimated:YES];
         }
         }];
  
    }
    else{
        NSLog(@"This is normal lesson");
         [self.navigationController popViewControllerAnimated:YES];
            }
    
   
}


#pragma mark -Article Viewed
-(void)articleViewd
{
    [[APIManager sharedInstance]articleViewedWithUserid:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result)
     {
        if (!success)
     {
            return ;
        }
    }];
}

#pragma mark - Get Article details
-(void)getArticleDetails
{
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getArticleDetailsWithArticleId:articleId withUserid:userId andWithAssessmentId:_strMinicertificationId andCompleteBlock:^(BOOL success, id result)
     {
     
     [self.loadingView stopAnimation];
     backGroundView.hidden=YES;
     [self.loadingView setHidden:YES];
     
     
     [scrollview setHidden:NO];
     
     if (!success)
     {
     [Utility showAlert:AppName withMessage:result];
     return ;
     }
     
     
     NSDictionary *dictionary=[result objectForKey:@"data"];
     NSMutableArray *articleData=[dictionary objectForKey:@"article_data"];
     NSMutableArray *subArticlesData=[articleData valueForKey:@"sub_article_data"];
     NSMutableDictionary *userData=[[articleData objectAtIndex:0] valueForKey:@"user_data"];
     
     articleTitle=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"title"]];
     NSString *subCount=[[articleData objectAtIndex:0]valueForKey:@"count_sub_articles"];
     NSNumber* bookMarkStatus =[[articleData objectAtIndex:0]valueForKey:@"bookmarked"];
     strBookMark = [NSString stringWithFormat:@"%@",[bookMarkStatus stringValue]];
     
     
     authorName=[userData  valueForKey:@"username"];
     authorImg=[userData valueForKey:@"user_image"];
     authoreId=[userData valueForKey:@"id"];
     loginUserType=[dictionary objectForKey:@"login_usertype"];
     
     
     [authorImage setHidden:NO];
     authorImage.layer.cornerRadius = 10.0f;
     [authorImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,authorImg]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
     
     if(!authorImage.image)
     {
     authorImage.image=[UIImage imageNamed:@"userprofile"];
     }
     
     
     //For Recomeneded Articles
     
     NSMutableArray *arrRecomenededArticlesData=[articleData valueForKey:@"recomended_article_data"];
     
     arrVideoTitleRecomended=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"title"];
     arrRecomendedCategoryLock=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"category_lock"];
     arrIdRecomended=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"id"];
     arrDurationRecomended=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"link_duration"];
     arrRecomendedVideoType=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"article_type"];
     arrRecomendedVideoThumb=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"link_thumb"];
     arrRecomendedFileType=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"file_type"];
     arrArticlePhoto=[[arrRecomenededArticlesData objectAtIndex:0]valueForKey:@"photo1"];
     if(arrVideoTitleRecomended.count>0)
     {
     
     viewRecomendedArticles.hidden=NO;
     viewRecomendedArticlesConstraint.constant=174.0f;
     viewRecomendedArticlesConstraint.active=YES;
     
     [collectionViewRecomendedArticles reloadData];
     
     }
     else
     {
     
     viewRecomendedArticles.hidden=YES;
     viewRecomendedArticlesConstraint.constant=0.0f;
     viewRecomendedArticlesConstraint.active=YES;
     
     }
     
     NSString *articleCreateDate=[[articleData objectAtIndex:0]valueForKey:@"relative_date"];
     NSString *views=[[articleData objectAtIndex:0]valueForKey:@"view_count"];
     NSNumber *reviewCount=[[articleData objectAtIndex:0]valueForKey:@"review_count"];
     NSNumber *avgrate=[[articleData objectAtIndex:0]valueForKey:@"avg_rate"];
     strFavStatus=[[articleData objectAtIndex:0]valueForKey:@"favorite"];
     articleVideoType=[[articleData objectAtIndex:0]valueForKey:@"article_type"];
     _videoStartTime=[[articleData objectAtIndex:0]valueForKey:@"end_time"];
     
     NSUserDefaults *videoStartDefaults=[NSUserDefaults standardUserDefaults];
     if([_videoStartTime isEqual:[NSNull null]])
     {
     [videoStartDefaults setValue:@"00:00:00" forKey:@"videoStart"];
     }
     else
     {
     [videoStartDefaults setValue:_videoStartTime forKey:@"videoStart"];
     }
     
     
     //Checking BookMark...
     
     if([strBookMark isEqualToString:@"0"])
     {
     [btnBookMark setImage:[UIImage imageNamed:@"bookmark"]];
     [btnBookMark setEnabled:YES];
     }
     else
     {
     [btnBookMark setImage:[UIImage imageNamed:@"bookmark"]];
     [btnBookMark setEnabled:NO];
     }
     
     lblArticleTitle.text=[NSString stringWithFormat:@"%@",[articleTitle uppercaseString]];
     
     CGSize constraint = CGSizeMake(lblArticleTitle.frame.size.width, CGFLOAT_MAX);
     
     
     NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
     CGSize boundingBox = [lblArticleTitle.text boundingRectWithSize:constraint
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName:lblArticleTitle.font}
                                                             context:context].size;
     
     sizeTitle = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
     NSLog(@"Title label hight is %f",sizeTitle.height);
     
     //Label Authore title Hight....
     NSString *byAuth=[[Language By] stringByAppendingString:authorName];
     lblAuthorName.text=[NSString stringWithFormat:@"%@",byAuth];
     CGSize constraintAuth = CGSizeMake(lblAuthorName.frame.size.width, CGFLOAT_MAX);
     
     
     NSStringDrawingContext *contextAuth = [[NSStringDrawingContext alloc] init];
     CGSize boundingBoxAuth = [lblAuthorName.text boundingRectWithSize:constraintAuth
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblAuthorName.font}
                                                               context:contextAuth].size;
     
     sizeAuthore = CGSizeMake(ceil(boundingBoxAuth.width), ceil(boundingBoxAuth.height));
     NSLog(@"sizeAuthore label hight is %f",sizeAuthore.height);
     
     
     
     
     
     
     NSString *pos=[[Language PostedOn] stringByAppendingString:articleCreateDate];
     lblPostedDate.text=[NSString stringWithFormat: @"%@",pos];
     CGSize constraintPost = CGSizeMake(lblPostedDate.frame.size.width, CGFLOAT_MAX);
     
     
     NSStringDrawingContext *contextPost = [[NSStringDrawingContext alloc] init];
     CGSize boundingBoxPost = [lblPostedDate.text boundingRectWithSize:constraintPost
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblPostedDate.font}
                                                               context:contextPost].size;
     
     sizePostedOn = CGSizeMake(ceil(boundingBoxPost.width), ceil(boundingBoxPost.height));
     NSLog(@"sizePostedOn label hight is %f",sizePostedOn.height);
     
     
     //       lblViewsCount.text=[NSString stringWithFormat:@"Views:%@",views];
     NSString *view=[[Language Views] stringByAppendingString:[NSString stringWithFormat:@"%@",views]];
     lblViewsCount.text=[NSString stringWithFormat:@"%@",view];
     
     CGSize constraintView = CGSizeMake(lblViewsCount.frame.size.width, CGFLOAT_MAX);
     
     
     NSStringDrawingContext *contextView = [[NSStringDrawingContext alloc] init];
     CGSize boundingBoxView = [lblViewsCount.text boundingRectWithSize:constraintView
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblViewsCount.font}
                                                               context:contextView].size;
     
     sizeViews = CGSizeMake(ceil(boundingBoxView.width), ceil(boundingBoxView.height));
     NSLog(@"sizeViews label hight is %f",sizeViews.height);
     
     _authorViewsHight.constant=sizeTitle.height+sizeAuthore.height+sizePostedOn.height+btnFavourite.frame.size.height+85;
     _authorViewsHight.active=YES;
     
     
     NSString *reviecount=[reviewCount stringValue];
     
     if ([reviecount isEqualToString:@"0"]) {
     _lblRatingCount.text=@"";
     // [self.reviewimg setHidden:YES];
     [btnViewReview setHidden:YES];
     // _reviewimg.hidden=YES;
     // _reviewview.hidden=YES;
     
     }
     else
     {
     // [self.reviewimg setHidden:NO];
     _lblRatingCount.text=[NSString stringWithFormat:@"(%@)",reviewCount];
     //  lblRAtingCount.hidden=NO;
     btnViewReview.hidden=NO;
     }
     
     
     NSString *strValue=[avgrate stringValue];
     if ([strValue isEqualToString:@"0"]) {
     //   [btnViewReview setEnabled:NO];
     }
     else{
     [btnViewReview setEnabled:YES];
     }
     
     float yourFloat = [strValue floatValue];
     long roundedFloat = lroundf(yourFloat);
     NSLog(@"%ld",roundedFloat);
     ratingView.rating =roundedFloat;
     ratingView.exclusiveTouch=NO;
     ratingView.delegate=self;
     ratingView.userInteractionEnabled=NO;
     
     
     if ([strFavStatus isEqualToString:@"no"]) {
     
     [btnFavourite setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
     
     favImg.image=[UIImage imageNamed:@"unfavourite"];
     }
     else{
     favImg.image=[UIImage imageNamed:@"favorite"];
     [btnFavourite setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
     }
     
     
     
     artticleImage1=[[articleData  objectAtIndex:0] valueForKey:@"photo_orig1"];
     artticleImage2=[[articleData objectAtIndex:0] valueForKey:@"photo_orig2"];
     artticleImage3=[[articleData objectAtIndex:0] valueForKey:@"photo_orig3"];
     articleImgTitle1=[[articleData objectAtIndex:0]valueForKey:@"caption_image1"];
     articleImgTitle2=[[articleData objectAtIndex:0]valueForKey:@"caption_image2"];
     articleImgTitle3=[[articleData objectAtIndex:0]valueForKey:@"caption_image3"];
     artticleVideo=[[articleData objectAtIndex:0] valueForKey:@"video"];
     articleVideoThumb=[[articleData objectAtIndex:0] valueForKey:@"video_thumb"];
     articleYoutubeLinks=[[articleData objectAtIndex:0] valueForKey:@"link"];
     strArticleDuration=[[articleData objectAtIndex:0] valueForKey:@"link_duration"];
     
     
     articleType=[[articleData objectAtIndex:0] valueForKey:@"file_type"];
     if ([articleType isEqualToString:@"2"])
     {
     ///Settingt Images Array
     [arrArticleImgs removeAllObjects];
     [arrAticleImgTitles removeAllObjects];
     if([artticleImage1 isEqual:[NSNull null]])
     {
     [arrArticleImgs addObject:@""];
     }
     else{
     [arrArticleImgs addObject:artticleImage1];
     }
     
     if([artticleImage2 isEqual:[NSNull null]])
     {
     [arrArticleImgs addObject:@""];
     }
     else{
     [arrArticleImgs addObject:artticleImage2];
     }
     if([artticleImage3 isEqual:[NSNull null]])
     {
     [arrArticleImgs addObject:@""];
     }
     else{
     [arrArticleImgs addObject:artticleImage3];
     }
     
     //Setting Titles Array
     
     if([articleImgTitle1 isEqual:[NSNull null]])
     {
     [arrAticleImgTitles addObject:@""];
     }
     else{
     [arrAticleImgTitles addObject:articleImgTitle1];
     }
     if([articleImgTitle2 isEqual:[NSNull null]])
     {
     [arrAticleImgTitles addObject:@""];
     }
     else{
     [arrAticleImgTitles addObject:articleImgTitle2];
     }
     if([articleImgTitle3 isEqual:[NSNull null]])
     {
     [arrAticleImgTitles addObject:@""];
     }
     else{
     [arrAticleImgTitles addObject:articleImgTitle3];
     }
     NSMutableArray *arrTotalImages = [[NSMutableArray alloc]init];
     [arrTotalImages removeAllObjects];
     for (int c=0;c<[arrArticleImgs count];c++)
     {
     NSString *str =[arrArticleImgs objectAtIndex:c];
     if([str isEqualToString:@""])
     {
     }
     else{
     [arrTotalImages addObject:str];
     }
     }
     NSInteger count=[arrTotalImages count];
     vimeVideosView.hidden=NO;
     if(count==0){
     UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
     [vimeVideosView addSubview:img];
     }
     // Scroll View
     scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, vimeVideosView.frame.size.width, vimeVideosView.frame.size.height)];
     scroll.backgroundColor=[UIColor whiteColor];
     scroll.delegate=self;
     //  scroll.pagingEnabled=YES;
     [scroll setContentSize:CGSizeMake(scroll.frame.size.width*count, scroll.frame.size.height)];
     // page control
     pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, vimeVideosView.frame.size.height-36, vimeVideosView.frame.size.width, 36)];
     pageControl.backgroundColor=[UIColor clearColor];
     pageControl.tintColor=[UIColor redColor];
     pageControl.numberOfPages=count;
     [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
     
     CGFloat x=0;
     for(count=0;count<[arrTotalImages count];count++)
     {
     image = [[UIImageView alloc] initWithFrame:CGRectMake(x+0, 0, scroll.frame.size.width, scroll.frame.size.height)];
     NSString *img=[arrTotalImages objectAtIndex:count];
     [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,img]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
     
     
     lblImgTitle.hidden=NO;
     lblImgTitleBackGroundColor=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, vimeVideosView.frame.size.width, 30)];
     [image addSubview:lblImgTitleBackGroundColor];
     lblImgTitleBackGroundColor.hidden=NO;
     [lblImgTitleBackGroundColor setBackgroundColor:[UIColor blackColor]];
     lblImgTitleBackGroundColor.alpha=0.3f;
     lblImgTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, vimeVideosView.frame.size.width, 30)];
     [image addSubview:lblImgTitle];
     lblImgTitle.textColor=[UIColor whiteColor];
     lblImgTitle.textAlignment=NSTextAlignmentCenter;
     lblImgTitle.font=[UIFont fontWithName:@"Roboto-Regular" size:15.0f];
     lblImgTitle.numberOfLines=0;
     if (arrAticleImgTitles.count>0){
     lblImgTitle.text=[NSString stringWithFormat:@"%@",[arrAticleImgTitles objectAtIndex:count]];
     }
     
     
     NSString *title = [NSString stringWithFormat:@"%@",lblImgTitle.text ];
     if([title isEqualToString:@""]){
     lblImgTitleBackGroundColor.hidden=YES;
     lblImgTitle.hidden=YES;
     }
     //  }
     [scroll addSubview:image];
     x+=vimeVideosView.frame.size.width;
     }
     [vimeVideosView addSubview:scroll];
     [vimeVideosView addSubview:pageControl];
     }
     
     
     
     else if([articleType isEqualToString:@"3"])
     {
     _YouTubeWebView.hidden=NO;
     
     player=[[AVPlayer alloc]init];
     controller = [[AVPlayerViewController alloc] init];
     controller.view.frame=vimeVideosView.bounds;
     [vimeVideosView addSubview:controller.view];
     
     
     NSString *vimeoUrl=[NSString stringWithFormat:@"%@",articleYoutubeLinks];
     player = [AVPlayer playerWithURL:[NSURL URLWithString:vimeoUrl]];
     controller.player = player;
     NSUserDefaults *videoTimeDefaults=[NSUserDefaults standardUserDefaults];
     NSString *videoStart=[videoTimeDefaults valueForKey:@"videoStart"];
     
     NSArray *arr = [videoStart componentsSeparatedByString:@":"];
     NSString *strHours = [arr objectAtIndex:0];
     NSString *strMin = [arr objectAtIndex:1];
     NSString *strSec = [arr objectAtIndex:2];
     int hours=[strHours intValue]*360;
     int mini=[strMin intValue]*60;
     int sec=[strSec intValue];
     int totalTime=hours+sec+mini;
     float time=[[NSNumber numberWithInt: totalTime] floatValue];
     Float64 seconds = time;
     CMTime targetTime = CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC);
     [player seekToTime:targetTime];
     controller.showsPlaybackControls = YES;
     [player pause];
     
     }
     else if([articleType isEqualToString:@"4"])
     {
     NSString *strUrl=[NSString stringWithFormat:@"%@",articleYoutubeLinks];
     [self embedVideoYoutubeWithURL:strUrl andFrame:vimeVideosView.frame];
     _YouTubeWebView.allowsInlineMediaPlayback = YES;
     _YouTubeWebView.mediaPlaybackRequiresUserAction=YES;
     [Utility hideLoading:self];
     self.ytPlayerView.hidden=NO;
     
     
     }
     
     NSLog(@"Articlew images %@",arrArticleImgs);
     articleShortDescription=[[articleData objectAtIndex:0]valueForKey:@"short_description"];
     artcleLongDescription=[[articleData objectAtIndex:0] valueForKey:@"description"];
     _descriptionWbview.scrollView.delegate = self;
     _descriptionWbview.translatesAutoresizingMaskIntoConstraints = NO;
     [_descriptionWbview loadHTMLString:artcleLongDescription baseURL:nil];
     [_descriptionWbview.scrollView setShowsHorizontalScrollIndicator:NO];
     NSMutableArray *quizData=[articleData valueForKey:@"quiz_data"];
     if([articleVideoType isEqualToString:@"mini_certification"])
     {
     btnFavourite.hidden=YES;
     }
     else{
     btnFavourite.hidden=NO;
     }
     
     strQuizStatus=[quizData objectAtIndex:0];
     if ([strQuizStatus isEqual:[NSNull null]]||[articleVideoType isEqualToString:@"mini_certification"])
     {
     
     [lblQuestionName setHidden:YES];
     _quizViewHight.constant=0.0f;
     _quizViewHight.active=YES;
     _quizView.hidden=YES;
     _option1ViewHight.constant=0.0f;
     _option1ViewHight.active=YES;
     _option2ViewHight.constant=0.0f;
     _option2ViewHight.active=YES;
     _option3ViewHight.constant=0.0f;
     _option3ViewHight.active=YES;
     _option4ViewHight.constant=0.0f;
     _option4ViewHight.active=YES;
     _answerViewHight.constant=0.0f;
     _answerViewHight.active=YES;
     btnSubmit.hidden=YES;
     btnOption1.hidden=YES;
     btnOption2.hidden=YES;
     btnOption3.hidden=YES;
     btnOption4.hidden=YES;
     lblQuestionName.hidden=YES;
     //     _
     }
     else
     
     {
     _quizView.hidden=NO;
     btnSubmit.hidden=NO;
     btnOption1.hidden=NO;
     btnOption2.hidden=NO;
     btnOption3.hidden=NO;
     btnOption4.hidden=NO;
     lblQuestionName.hidden=NO;
     
     question=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"question"]];
     option1=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"option1"]];
     option2=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"option2"]];
     option3=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"option3"]];
     option4=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"option4"]];
     answer=[NSString stringWithFormat:@"%@",[[quizData objectAtIndex:0] valueForKey:@"answer"]];
     questionId=[[quizData objectAtIndex:0] valueForKey:@"id"];
     lblQuestionName.text=question;
     
     CGSize constraintQuestion = CGSizeMake(lblQuestionName.frame.size.width, CGFLOAT_MAX);
     
     
     
     NSStringDrawingContext *contextQuestion = [[NSStringDrawingContext alloc] init];
     CGSize boundingQuestion = [lblQuestionName.text boundingRectWithSize:constraintQuestion
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:lblQuestionName.font}
                                                                  context:contextQuestion].size;
     
     CGSize sizeQuestion = CGSizeMake(ceil(boundingQuestion.width), ceil(boundingQuestion.height));
     NSLog(@"sizeViews label hight is %f",sizeQuestion.height);
     questionNameDynamicheight=sizeQuestion.height;
     
     
     lblOption1.text=option1;
     CGSize constraintlbloption1 = CGSizeMake(lblOption1.frame.size.width, CGFLOAT_MAX);
     
     
     NSStringDrawingContext *contextlblOption1 = [[NSStringDrawingContext alloc] init];
     CGSize boundinglblOption1 = [lblOption1.text boundingRectWithSize:constraintlbloption1
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblOption1.font}
                                                               context:contextlblOption1].size;
     
     CGSize sizelblOption1 = CGSizeMake(ceil(boundinglblOption1.width), ceil(boundinglblOption1.height));
     NSLog(@"sizeViews label hight is %f",sizelblOption1.height);
     option1ViewDynamicHeight=20+sizelblOption1.height;;
     _option1ViewHight.constant=option1ViewDynamicHeight;
     _option1ViewHight.active=YES;
     
     
     lblOption2.text=option2;
     
     CGSize constraintlbloption2 = CGSizeMake(lblOption2.frame.size.width, CGFLOAT_MAX);
     
     
     
     NSStringDrawingContext *contextlblOption2 = [[NSStringDrawingContext alloc] init];
     CGSize boundinglblOption2 = [lblOption2.text boundingRectWithSize:constraintlbloption2
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblOption2.font}
                                                               context:contextlblOption2].size;
     
     CGSize sizelblOption2 = CGSizeMake(ceil(boundinglblOption2.width), ceil(boundinglblOption2.height));
     NSLog(@"sizeViews label hight is %f",sizelblOption2.height);
     optionView2DynamicHeight=20+sizelblOption2.height;;
     _option2ViewHight.constant=optionView2DynamicHeight;
     _option2ViewHight.active=YES;
     
     lblOption3.text=option3;
     
     CGSize constraintlbloption3 = CGSizeMake(lblOption3.frame.size.width, CGFLOAT_MAX);
     
     
     
     NSStringDrawingContext *contextlblOption3 = [[NSStringDrawingContext alloc] init];
     CGSize boundinglblOption3 = [lblOption3.text boundingRectWithSize:constraintlbloption3
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblOption3.font}
                                                               context:contextlblOption3].size;
     
     CGSize sizelblOption3 = CGSizeMake(ceil(boundinglblOption3.width), ceil(boundinglblOption3.height));
     NSLog(@"sizeViews label hight is %f",sizelblOption3.height);
     optionView3DynamicHeight=20+sizelblOption3.height;
     _option3ViewHight.constant=optionView3DynamicHeight;
     _option3ViewHight.active=YES;
     
     
     lblOption4.text=option4;
     CGSize constraintlbloption4 = CGSizeMake(lblOption4.frame.size.width, CGFLOAT_MAX);
     
     
     
     NSStringDrawingContext *contextlblOption4 = [[NSStringDrawingContext alloc] init];
     CGSize boundinglblOption4 = [lblOption4.text boundingRectWithSize:constraintlbloption4
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:lblOption4.font}
                                                               context:contextlblOption4].size;
     
     CGSize sizelblOption4 = CGSizeMake(ceil(boundinglblOption4.width), ceil(boundinglblOption4.height));
     NSLog(@"sizeViews label hight is %f",sizelblOption4.height);
     optionView4DynamicHeight=20+sizelblOption4.height;
     _option4ViewHight.constant=optionView4DynamicHeight;
     _option4ViewHight.active=YES;
     
     
     _answerViewHight.constant=0.0f;
     _answerViewHight.active=YES;
     _answerView.hidden=YES;
     //Setting Dynamic Hights for Quiz Views
     
     quizViewDynamicViewHeight=115+questionNameDynamicheight+option1ViewDynamicHeight+optionView2DynamicHeight+optionView3DynamicHeight+optionView4DynamicHeight+btnSubmit.frame.size.height;
     
     _quizViewHight.constant=quizViewDynamicViewHeight;
     
     }
     
     }];
    CGRect contentRect = CGRectZero;
    for (UIView *view in scrollview.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    scrollview.contentSize = contentRect.size;
    
}
#pragma mark - BookMarkStatus
-(void)bookMarkStatus
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getArticleDetailsWithArticleId:articleId withUserid:userId andWithAssessmentId:_strMinicertificationId andCompleteBlock:^(BOOL success, id result)
     {
     
     [self.loadingView stopAnimation];
     [self.loadingView setHidden:YES];
     [backGroundView setHidden:YES];
     
     if (!success)
     {
       NSString *strMessage=[result valueForKey:@"message"];
       SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
       [alert setHorizontalButtons:YES];
       [alert showSuccess:AppName subTitle:strMessage closeButtonTitle:@"OK" duration:0.0f];
      return ;
     }
     else
     {
         NSDictionary *dictionary=[result objectForKey:@"data"];
         NSMutableArray *articleData=[dictionary objectForKey:@"article_data"];
         NSNumber* bookMarkStatus =[[articleData objectAtIndex:0]valueForKey:@"bookmarked"];
         strBookMark = [NSString stringWithFormat:@"%@",[bookMarkStatus stringValue]];
      if([strBookMark isEqualToString:@"0"])
      {
          [btnBookMark setImage:[UIImage imageNamed:@"bookmark"]];
          [btnBookMark setEnabled:YES];
      }
      else
     {
        [btnBookMark setImage:[UIImage imageNamed:@"bookmark"]];
        [btnBookMark setEnabled:NO];
     }
     
}

     }];
}
#pragma mark - Custom Methods
-(void)showVideo
{
    [Utility showLoading:self];
    [self playVideoWithId:videoId];
}
- (void)playVideoWithId:(NSString *)videoId
{
    NSLog(@"%f",self.view.frame.size.height);
    NSDictionary *playerVars = @{
        @"controls" : @"1",
        @"playsinline" : @"1",
        @"autohide" : @"1",
        @"showinfo" : @"1",
        @"autoplay" : @"0",
        @"fs" : @"1",
        @"rel" : @"0",
        @"loop" : @"0",
        @"enablejsapi" : @"1",
        @"modestbranding" : @"1",
    };
    self.ytPlayerView.delegate = self;
    [self.ytPlayerView loadWithVideoId:videoId playerVars:playerVars];
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:{
            break;
        }
        case kYTPlayerStateUnstarted:
            NSLog(@"kYTPlayerStateUnstarted");
            break;
        case kYTPlayerStateBuffering:
            NSLog(@"kYTPlayerStateBuffering");
            break;
        case kYTPlayerStatePaused:{
            [ytPlayer stopVideo];
            NSLog(@"kYTPlayerStatePaused");
            break;
        }
        case kYTPlayerStateEnded:
            NSLog(@"End");
        case kYTPlayerStateQueued:
            NSLog(@"Queued");
        case kYTPlayerStateUnknown:
            NSLog(@"StateUnknown");
        default:
            NSLog(@"State %ld",(long)state);
            break;
    }
}
- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    [Utility hideLoading:self];
    NSLog(@"playerViewDidBecomeReady");
}
- (void)playerView:(YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality{
    NSLog(@"YTPlayerView : didChangeToQuality");
}
- (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error{
    [Utility hideLoading:self];
    NSLog(@"receivedError");
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    CGFloat viewWidth = _scrollView.frame.size.width;
    int pageNumber = floor((_scrollView.contentOffset.x - viewWidth/50) / viewWidth) +1;
      pageControl.currentPage=pageNumber;
}
- (void)pageChanged {
    NSInteger pageNumber = pageControl.currentPage;
    CGRect frame = scroll.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    [scroll scrollRectToVisible:frame animated:YES];
}

#pragma WebViewDynamicHight

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *scrollHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"scrollHeight: %@", scrollHeight);
    NSLog(@"webview.contentSize.height %f", webView.scrollView.contentSize.height);
    _descriptionViewHight.constant=webView.scrollView.contentSize.height;
    _descriptionViewHight.active=YES;
}


#pragma mark- Rate This Article Button Tapped
- (IBAction)btnRateThisArticleTapped:(id)sender
{
  // Comments Btn Tapped
    [player pause];
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
    
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
        NSString *VideoendTime=  [defaults valueForKey:@"VCT"];
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result) {
         if(!success)
         {
         return ;
         
         }
         else{
         
         NSLog(@"Success");
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
            [defaults setValue:@"" forKey:@"miniid"];
           [defaults setValue:@"" forKey:@"artid"];

         }
         }];
        
    }
    else{
        NSLog(@"This is normal lesson");
    }
    
    

    [startAndEndtimeDefaults setObject:@"" forKey:@"identity"];
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    // or Timezone with specific name like
    // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    
    endTime = [dateFormatter stringFromDate:currentDate];
    
    // NSDate *dtPostDate = [dateFormatter dateFromString:endTime];
    
    NSString *start=[startAndEndtimeDefaults valueForKey:@"starttime"];
    
    
    NSLog(@"date  is %@",endTime);
    
    [[APIManager sharedInstance]startAndEndTimeforArticle:start andWithEndTime:endTime withUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result) {
     if (!success)
     {
     return ;
     }
     
     }];
    
    
    NewReviewViewController *rateThis=[self.storyboard instantiateViewControllerWithIdentifier:@"NewReviewViewController"];
    rateThis.articleId=articleId;
    [self.navigationController pushViewController:rateThis animated:YES];
}

#pragma mark- Favourite Article Button Tapped
- (IBAction)btnFavouriteTapped:(id)sender {
    if ([strFavStatus isEqualToString:@"no"]) {
       // [Utility showLoading:self];
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        [[APIManager sharedInstance]addArticleToMyFavoriteArticlesWithUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result) {
          //  [Utility hideLoading:self];
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
            if (!success) {
               // [Utility showAlert:AppName withMessage:result];
         
         SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
         [alert setHorizontalButtons:YES];
         
         [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

                return ;
            }
       //  [arrArticleImgs removeAllObjects];
        // scroll.frame=CGRectZero;
            [self getFavoriteStatus];
        }];
    }
    else
    {
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert addButton:[Language ok] actionBlock:^(void)
         {
         [self.loadingView startAnimation];
         [self.loadingView setHidden:NO];
         [self.img setHidden:NO];
         [[APIManager sharedInstance]removeArticleFromMyFavoriteArticlesWithUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result) {
          // [Utility hideLoading:self];
          [backGroundView setHidden:YES];
          [self.loadingView stopAnimation];
          [self.loadingView setHidden:YES];
          [self.img setHidden:YES];
          if (!success) {
          //[Utility showAlert:AppName withMessage:result];
          
          SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
          [alert setHorizontalButtons:YES];
          
          [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
          
                   return ;
          }
       NSString* status=[NSString stringWithFormat:@"%@",[result valueForKey:@"status"]];
          if([status isEqualToString:@"1"]){
          favImg.image=[UIImage imageNamed:@""];
          
          }
          
         // [arrArticleImgs removeAllObjects];
         // scroll.frame=CGRectZero;
         
          [self getFavoriteStatus];
          }];
        
        
         }
         ];
        [alert showSuccess:AppName subTitle:[Language removearticlefromFavouriteList] closeButtonTitle:[Language Cancel] duration:0.0f];
    
    
    
    }
}

#pragma mark -Button Optione One Tapped
- (IBAction)btnOptionOneTapped:(id)sender
{
    strCorectAns=lblOption1.text;
    btnIndex=@"1";
    lblCorrect.hidden=YES;
    lblCorrectAnswer.hidden=YES;
    
    _answerViewHight.constant=0.0f;
    _answerViewHight.active=YES;

    [btnOption1 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
}

#pragma mark -Button Optione Two Tapped
- (IBAction)btnOptionTwoTapped:(id)sender
{
    strCorectAns=lblOption2.text;
     btnIndex=@"2";
    lblCorrect.hidden=YES;
    lblCorrectAnswer.hidden=YES;
    _answerViewHight.constant=0.0f;
    _answerViewHight.active=YES;

    [btnOption2 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
}

#pragma mark -Button Optione Three Tapped
- (IBAction)btnOptionThreeTapped:(id)sender {
    strCorectAns=lblOption3.text;
     btnIndex=@"3";
    lblCorrect.hidden=YES;
    lblCorrectAnswer.hidden=YES;
    _answerViewHight.constant=0.0f;
    _answerViewHight.active=YES;

    [btnOption3 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
}

#pragma mark -Button Optione Four Tapped
- (IBAction)btnOptionFourTapped:(id)sender
{
    strCorectAns=lblOption4.text;
     btnIndex=@"4";
    lblCorrect.hidden=YES;
    lblCorrectAnswer.hidden=YES;
    _answerViewHight.constant=0.0f;
    _answerViewHight.active=YES;

    [btnOption4 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
}

#pragma mark -Button Answer Tapped
- (IBAction)btnQuizAnswerTapped:(id)sender
{
    if ([btnIndex isEqualToString:@"0"]||[btnIndex isEqual:[NSNull null]])
    {
     
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language PleaseSelectOption] closeButtonTitle:[Language ok] duration:0.0f];
       
        
    }
    else
    {
        if ([strCorectAns isEqualToString:answer])
        {
            quizAnswerImage.hidden=NO;
            quizAnswerImage.image=[UIImage imageNamed:@"correctans"];
        }
        else
        {
            quizAnswerImage.hidden=NO;
            quizAnswerImage.image=[UIImage imageNamed:@"wrongans"];
           
            lblCorrect.hidden=NO;
            lblCorrectAnswer.hidden=NO;
            
            
                 lblCorrectAnswer.text=answer;
                 CGSize constraintAnswer = CGSizeMake(lblCorrectAnswer.frame.size.width, CGFLOAT_MAX);
                      NSStringDrawingContext *contextAnswer = [[NSStringDrawingContext alloc] init];
                 CGSize boundingAnswer = [lblCorrectAnswer.text boundingRectWithSize:constraintAnswer
                                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                                        attributes:@{NSFontAttributeName:lblCorrectAnswer.font}
                                                                           context:contextAnswer].size;
            
                 CGSize sizeAnswer = CGSizeMake(ceil(boundingAnswer.width), ceil(boundingAnswer.height));
                 NSLog(@"sizeViews label hight is %f",sizeAnswer.height);
            
                  answerViewDynamicHeight=20+sizeAnswer.height;
                 _answerViewHight.constant=answerViewDynamicHeight;
                 _answerViewHight.active=YES;
                _answerView.hidden=NO;
            
            
           
            _quizViewHight.constant=quizViewDynamicViewHeight+answerViewDynamicHeight;
            _quizViewHight.active=YES;

            
           // CGRect newFrame1 = CGRectMake(8, 54+lblQuestionName.frame.size.height+lblOption1.frame.size.height+8+lblOption2.frame.size.height+8+lblOption3.frame.size.height+48+lblOption4.frame.size.height+8+lblCorrectAnswer.frame.size.height+8+lblCorrect.frame.size.height, self.view.frame.size.width-16, 40);
            
            //btnSubmit.frame = newFrame1;
            
        }
    }

}


#pragma mark -Button Reviews View Tapped
- (IBAction)btnViewReviewsTapped:(id)sender
{
    //Rating Btn Tapped
    [player pause];
    
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
    
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
    //Update Video pause time
    
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
        NSString *VideoendTime=  [defaults valueForKey:@"VCT"];;
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result) {
         if(!success)
         {
         return ;
         
         }
         else{
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
            [defaults setValue:@"" forKey:@"miniid"];
           [defaults setValue:@"" forKey:@"artid"];
         NSLog(@"Success");
         }
         }];
        
    }
    else{
        NSLog(@"This is normal lesson");
    }

    
        //Articles start and end time update
    
        [startAndEndtimeDefaults setObject:@"" forKey:@"identity"];
    
        NSDate *currentDate = [[NSDate alloc] init];
        NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    
        endTime = [dateFormatter stringFromDate:currentDate];
    
        // NSDate *dtPostDate = [dateFormatter dateFromString:endTime];
    
        NSString *start=[startAndEndtimeDefaults valueForKey:@"starttime"];
    
    
        NSLog(@"date  is %@",endTime);
    
        [[APIManager sharedInstance]startAndEndTimeforArticle:start andWithEndTime:endTime withUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result) {
         if (!success) {
         return ;
         }
         
         }];
   

    
    GetAllReviewViewController *allReviews=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllReviewViewController"];
    allReviews.articleId=articleId;
    allReviews.cameFrom = @"RatingBtn";
    [self.navigationController pushViewController:allReviews animated:YES];
    

}




#pragma mark - Get Fav Status
-(void)getFavoriteStatus
{
    /*
    // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getArticleDetailsWithArticleId:articleId withUserid:userId andWithAssessmentId:_strMinicertificationId andCompleteBlock:^(BOOL success, id result)
     {
    
     //[Utility hideLoading:self];
     [self.loadingView stopAnimation];
     [self.loadingView setHidden:YES];
     [backGroundView setHidden:YES];
     
     [scrollview setHidden:NO];
     
     self.btnViewAnalytics.hidden=NO;
     self.imgAnalyticsArrow.hidden=NO;
     [self.img setHidden:YES];
     btnRateThisArticle.hidden=NO;
     _reviewimg.hidden=NO;
     
     if (!success) {
     [Utility showAlert:AppName withMessage:result];
     return ;
     }
     NSDictionary *dictionary=[result objectForKey:@"data"];
     NSMutableArray *articleData=[dictionary objectForKey:@"article_data"];
     NSMutableArray *subArticlesData=[articleData valueForKey:@"sub_article_data"];
     NSMutableDictionary *userData=[[articleData objectAtIndex:0] valueForKey:@"user_data"];
     
     articleTitle=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"title"]];
     NSString *subCount=[[articleData objectAtIndex:0]valueForKey:@"count_sub_articles"];
     if([subCount isEqual:[NSNull null]]||[subCount isEqualToString:@"0"]){
     subArticleCount=@"0";
     }
     else{
     //subArticleCount=subCount;
     subArticleCount=@"0";
     //arrSubArtTitles=[[subArticlesData objectAtIndex:0] valueForKey:@"title"];
     //arrSubArtDescription=[[subArticlesData objectAtIndex:0] valueForKey:@"description"];
     
     if([arrSubArtTitles count]==1){
     strSubTitle1=[arrSubArtTitles objectAtIndex:0];
     }
     else if ([arrSubArtTitles count]==2){
     strSubTitle1=[arrSubArtTitles objectAtIndex:0];
     strSubTitle2=[arrSubArtTitles objectAtIndex:1];
     }
     else if ([arrSubArtTitles count]==3){
     strSubTitle1=[arrSubArtTitles objectAtIndex:0];
     strSubTitle2=[arrSubArtTitles objectAtIndex:1];
     strSubTitle3=[arrSubArtTitles objectAtIndex:2];
     }
     else{
     
     }
     ///////////////
     
     if([arrSubArtDescription count]==1){
     strSubDesription1=[arrSubArtDescription objectAtIndex:0];
     }
     else if ([arrSubArtDescription count]==2){
     strSubDesription1=[arrSubArtDescription objectAtIndex:0];
     strSubDescription2=[arrSubArtDescription objectAtIndex:1];
     }
     else if ([arrSubArtDescription count]==3){
     strSubDesription1=[arrSubArtDescription objectAtIndex:0];
     strSubDescription2=[arrSubArtDescription objectAtIndex:1];
     strSubDescription3=[arrSubArtDescription objectAtIndex:2];
     }
     
     }
     authorName=[userData  valueForKey:@"username"];
     NSString *authorImg=[userData valueForKey:@"user_image"];
     [authorImage setHidden:NO];
     [self.viewReviewview setHidden:NO];
     [self.reviewview setHidden:NO];
     [self.line1 setHidden:NO];
     [self.lblh1 setHidden:NO];
     [self.lblh2 setHidden:NO];
     [self.desctitle setHidden:NO];
     [self.quiztitle setHidden:NO];
     [btnOption1 setHidden:NO];
     [btnOption2 setHidden:NO];
     [btnOption3 setHidden:NO];
     [btnOption4 setHidden:NO];
     authorImage.layer.cornerRadius = 10.0f;
     [authorImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,authorImg]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
     if(!authorImage.image){
     authorImage.image=[UIImage imageNamed:@"userprofile"];
     }
     NSString *articleCreateDate=[[articleData objectAtIndex:0]valueForKey:@"relative_date"];
     NSString *views=[[articleData objectAtIndex:0]valueForKey:@"view_count"];
     NSNumber *reviewCount=[[articleData objectAtIndex:0]valueForKey:@"review_count"];
     NSNumber *avgrate=[[articleData objectAtIndex:0]valueForKey:@"avg_rate"];
     strFavStatus=[[articleData objectAtIndex:0]valueForKey:@"favorite"];
     lblArticleTitle.text=[NSString stringWithFormat:@"%@",[articleTitle uppercaseString]];
     lblArticleTitle.lineBreakMode = NSLineBreakByWordWrapping;
     CGSize labelSize = [lblArticleTitle.text sizeWithFont:lblArticleTitle.font
                                         constrainedToSize:lblArticleTitle.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping];
     CGFloat labelHeight = labelSize.height;
     
     int lines = [lblArticleTitle.text sizeWithFont:lblArticleTitle.font
                                  constrainedToSize:lblArticleTitle.frame.size
                                      lineBreakMode:NSLineBreakByWordWrapping].height/2;
     NSString *byAuth=[[Language By] stringByAppendingString:authorName];
     lblAuthorName.text=[NSString stringWithFormat:@"%@",byAuth];
     //       lblAuthorName.text=[NSString stringWithFormat:@"By %@",authorName];
     //       lblPostedDate.text=[NSString stringWithFormat:@"Posted on:%@",articleCreateDate];
     NSString *pos=[[Language PostedOn] stringByAppendingString:articleCreateDate];
     lblPostedDate.text=[NSString stringWithFormat: @"%@",pos];
     //       lblViewsCount.text=[NSString stringWithFormat:@"Views:%@",views];
     NSString *view=[[Language Views] stringByAppendingString:[NSString stringWithFormat:@"%@",views]];
     lblViewsCount.text=[NSString stringWithFormat:@"%@",view];
     NSString *reviecount=[reviewCount stringValue];
//     if ([reviecount isEqualToString:@"0"]) {
//     _lblRatingCount.text=@"";
//     [self.reviewimg setHidden:YES];
//     [btnViewReview setHidden:YES];
//     
//     }
//     else{
//     [self.reviewimg setHidden:NO];
//     //_lblRatingCount.text=[NSString stringWithFormat:@"(%@)",reviewCount];
//     btnViewReview.hidden=NO;
//     }
     NSString *strValue=[avgrate stringValue];
     if ([strValue isEqualToString:@"0"]) {
        [btnViewReview setEnabled:NO];
     }
     else{
     [btnViewReview setEnabled:YES];
     }
     float yourFloat = [strValue floatValue];
     long roundedFloat = lroundf(yourFloat);
     NSLog(@"%ld",roundedFloat);
     ratingView.rating =roundedFloat;
     ratingView.exclusiveTouch=NO;
     ratingView.delegate=self;
     ratingView.userInteractionEnabled=NO;
     if ([strFavStatus isEqualToString:@"no"])
     {
     
     [btnFavourite setImage:[UIImage imageNamed:@"unfavorite"] forState:UIControlStateNormal];
     
     favImg.image=[UIImage imageNamed:@"unfavorite"];
     }
     else
     {
     favImg.image=[UIImage imageNamed:@"favorite"];
     [btnFavourite setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
     }
  
     
     
         }]; */
}

#pragma mark - Embed Video

- (UIWebView *)embedVideoYoutubeWithURL:(NSString *)urlString andFrame:(CGRect)frame {
    
    [Utility showLoading:self];
    //urlString=@"https://www.youtube.com/watch?v=G62HrubdD6o";
    
    NSString *videoID = [self extractYoutubeVideoID:urlString];
    
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"http://www.youtube.com/v/%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString *html = [NSString stringWithFormat:embedHTML, videoID, frame.size.width, frame.size.height];
    // UIWebView *videoWebView = [[UIWebView alloc] initWithFrame:frame];
    [_YouTubeWebView loadHTMLString:html baseURL:nil];
    _YouTubeWebView.scrollView.scrollEnabled = NO;
    _YouTubeWebView.scrollView.bounces = NO;
    
    return _YouTubeWebView;
}



- (NSString *)extractYoutubeVideoID:(NSString *)urlYoutube {
    
    
    
    NSString *regexString = @"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:urlYoutube options:0 range:NSMakeRange(0, [urlYoutube length])];
    
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *substringForFirstMatch = [urlYoutube substringWithRange:rangeOfFirstMatch];
        
        
        return substringForFirstMatch;
    }
    
    return nil;
}

-(void)goToChatView
{
    [player pause];
    
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
    
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
    //Update Video pause time
    
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
    NSString *VideoendTime=  [defaults valueForKey:@"VCT"];;
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result)
         {
         if(!success)
         {
         return ;
         
         }
         else{
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
            [defaults setValue:@"" forKey:@"miniid"];
           [defaults setValue:@"" forKey:@"artid"];
         NSLog(@"Success");
         }
         }];
        
    }
    else{
        NSLog(@"This is normal lesson");
    }
    

    //Update Article time for Analytics
    
    startTime=[startAndEndtimeDefaults valueForKey:@"starttime"];
    
    if([startTime isEqualToString:@""]||[startTime isEqual:[NSNull null]]){
        NSLog(@"Already inserted");
    }
    else
    {
        [startAndEndtimeDefaults setObject:@"" forKey:@"identity"];
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        
        
        endTime = [dateFormatter stringFromDate:currentDate];
        
        // NSDate *dtPostDate = [dateFormatter dateFromString:endTime];
        
        NSString *start=[startAndEndtimeDefaults valueForKey:@"starttime"];
        
        
        NSLog(@"date  is %@",endTime);
        
        [[APIManager sharedInstance]startAndEndTimeforArticle:start andWithEndTime:endTime withUserId:userId andWithArticleId:articleId andCompleteBlock:^(BOOL success, id result)
         {
         if (!success)
         {
         return ;
         }
         [startAndEndtimeDefaults setObject:@"" forKey:@"starttime"];
         
         }];
        
        
        
    }
    
    NSUserDefaults *defaul=[NSUserDefaults standardUserDefaults];
    NSString *mainAuthore=[NSString stringWithFormat:@"-%@",authoreId];
    [defaul setValue:mainAuthore forKey:@"mainAuthoreId"];
    
    NSString *loginUserId=[defaul valueForKey:@"id"];
    if([loginUserId isEqualToString:authoreId])
    {
        UsersListViewController*userList=[self.storyboard instantiateViewControllerWithIdentifier:@"UsersListViewController"];
        userList.articleId=articleId;
        [self.navigationController pushViewController:userList animated:YES];
    }
    else
    {
    ChatingViewController *messageView=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingViewController"];
        
       // ChatJSQViewController*messageView=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatJSQViewController"];
   // MessageViewController *messageView=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    messageView.authorId=authoreId;
    messageView.articleId=articleId;
    messageView.authorName=authorName;
    messageView.authoreImage=authorImg;
        
   
    [self.navigationController pushViewController:messageView animated:YES];
        
    }
    
}

-(IBAction)authorButtonClicking:(id)sender
{
    //Update Video pause time
    [player pause];
   
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
    
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
        NSString *VideoendTime=  [defaults valueForKey:@"VCT"];
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result) {
         if(!success)
         {
         return ;
         
         }
         else{
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
            [defaults setValue:@"" forKey:@"miniid"];
           [defaults setValue:@"" forKey:@"artid"];
         NSLog(@"Success");
         }
         }];
        
    }
    else
    {
        NSLog(@"This is normal lesson");
    }
    

    
    TrainerDetailsViewController *trainersDetailsClass=[self.storyboard instantiateViewControllerWithIdentifier:@"TrainerDetailsViewController"];
    trainersDetailsClass.authorsID=authoreId;
    [self.navigationController pushViewController:trainersDetailsClass animated:YES];
}

#pragma UITableViewDelegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return arrVideoTitleRecomended.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RecomendedCollectionViewCell";
   RecomendedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (collectionView==collectionViewRecomendedArticles)
    {
        
        
        lock = [NSString stringWithFormat:@"%@",[arrRecomendedCategoryLock objectAtIndex:indexPath.row]];
        if ([lock isEqual:[NSNull null]]){
            NSLog(@"Category lock is coming null....");
        }else{
            if ([lock isEqualToString:@"0"]){
                cell.recomendedlatestLockImg.hidden=YES;
            }else{
                cell.recomendedlatestLockImg.hidden=NO;
            }
        }
        
        
        cell.recomendedlblArticleTitle.text=[NSString stringWithFormat:@"%@",[arrVideoTitleRecomended objectAtIndex:indexPath.row]];
        videoType=[arrRecomendedVideoType objectAtIndex:indexPath.row];
        
        if ([videoType isEqual:[NSNull null]])
        {
            NSLog(@"Type is coming null in random articles");
        }
        
        else
        {
            
            NSString *strFileType = [NSString stringWithFormat:@"%@",[arrRecomendedFileType objectAtIndex:indexPath.row]];
            if([strFileType isEqualToString:@"2"])
            {
                 cell.recomendedvideoImg.hidden=YES;
                cell.recomendedlblArticleDuration.hidden=YES;
                [cell.recomendedarticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[arrArticlePhoto objectAtIndex:indexPath.row]]]];
            }
            else if ([strFileType isEqualToString:@"3"])
            {
            cell.recomendedlblArticleDuration.hidden=NO;
            cell.recomendedvideoImg.hidden=NO;
            [cell.recomendedarticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrRecomendedVideoThumb objectAtIndex:indexPath.row]]]
                               placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
                
        }
    
            cell.recomendedlblArticleDuration.text=[NSString stringWithFormat:@"%@",[arrDurationRecomended objectAtIndex:indexPath.row]];
         
            cell.recomendedlblArticleDuration.layer.cornerRadius=2.0;
            cell.recomendedlblArticleDuration.layer.masksToBounds=YES;
            cell.recomendedlatestLockImg.layer.cornerRadius=2.0;
            cell.recomendedlatestLockImg.layer.masksToBounds=YES;
            videoType=[arrRecomendedVideoType objectAtIndex:indexPath.row];
            
            if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
            {
                cell.recomendedlatestLockImg.hidden=NO;
            }
            else
            
            {
                cell.recomendedlatestLockImg.hidden=YES;
            }
            
        }
        
        if (!cell.recomendedarticleImg.image)
        {
            cell.recomendedarticleImg.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
        }
        cell.layer.cornerRadius=4.0f;
    }
        return cell;
    }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [player pause];
    
    CMTime duration = player.currentItem.duration; //total time
    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
    
    NSUInteger cHours = floor(cTotalSeconds / 3600);
    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
    NSLog(@"time :%@",videoDurationText);
    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
    CMTime currentTime =player.currentTime; //playing time
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"time :%@",cvideoDurationText);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:cvideoDurationText forKey:@"VCT"];
    
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
    if([articleVideoType isEqualToString:@"mini_certification"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *VideostartTime=@"00:00:00";
        NSString *VideoendTime=  [defaults valueForKey:@"VCT"];
        
        
        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userId andWithAssementId:_strMinicertificationId withArticleId:articleId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result)
         {
         if(!success)
         {
         return ;
         
         }
         else
         {
         NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
         [defaults setValue:@"" forKey:@"VCT"];
         [defaults setValue:@"" forKey:@"miniid"];
         [defaults setValue:@"" forKey:@"artid"];
         NSLog(@"Success");
         }
         }];
        
    }
    else
    {
        NSLog(@"This is normal lesson");
    }
    
    
    
   articleId=[arrIdRecomended objectAtIndex:indexPath.row];
    
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
    {
        SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
        [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
    }
    else
    {
        
        [self viewDidLoad];
        [scrollview setContentOffset:
         CGPointMake(0, -scrollview.contentInset.top) animated:YES];
    }
    
    
}

#pragma mark -Share Button
-(void)share
{
    
    
    
    NSString * startingMessage= @"Resource Coach App";
    NSString * secondMessage = @"Hey! I came across a very good Lesson";
    NSString *followMessage = @"Please download the Resource Coach app from Google Play Store and App Store now!";
    //NSString * message = @"www.facebook.com";
    //NSString *mess=[AppName stringByAppendingString:@"-Total Learning App"];
    NSString *titleName=@"Title";
    NSString *descr=@"Description";
    NSString *title=articleTitle;
    NSString *desc=articleShortDescription;
    
    NSString *totalString=[NSString stringWithFormat:@"%@\n\n%@\n\n%@ :%@\n\n%@ :%@\n\n%@",startingMessage,secondMessage,titleName,title,descr,desc,followMessage];
    
    
    
    //UIImage * image = [UIImage imageNamed:@"88311178.jpg"];
    // NSLog(@"%@\n%@",appName,desc);
    NSArray * shareItems = @[totalString];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
    
}

@end
