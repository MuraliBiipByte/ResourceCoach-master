//
//  CourseDetailViewController.m
//  DedaaBox
//
//  Created by Biipmi on 3/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//
#import "Resource_Coach-Swift.h"
#import "CourseDetailViewController.h"
#import "LessonsTableViewCell.h"
#import "Language.h"
#import "HYCircleLoadingView.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "AssessmentViewController.h"
#import "ArticleDetailsViewController.h"
#import "ResultViewController.h"
#import "BankAccountViewController.h"
#import "ViewAnswersViewController.h"
#import "SCLAlertView.h"
#import "ReportAnalyticsViewController.h"
@interface CourseDetailViewController ()
{
    UIButton *lessbutton;
    UIButton *morebutton;
    UIView *backGroundView;
    NSString *userid;
NSMutableArray *arrArticleTitles,*arrArticleDuration,*arrArticleId,*arrStartTime,*arrAttemptcount,*arrVideoWatched;
    NSString *strAttemptCount,*strResultStatus,*strRedeemStatus,*strTestAssesment;
    NSString *btnType;
    NSMutableArray *arrVideoPausedTime;
    UIBarButtonItem *btnAnalytics;
    
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *readMoreContentLbl;
@property (weak, nonatomic) IBOutlet UILabel *readMoreTitleLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *explanationViewHeight;
@property (weak, nonatomic) IBOutlet UIView *TVContainerView;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *explainationView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation CourseDetailViewController
- (IBAction)okBtnTapped:(UIButton *)sender {
    [_bgView setHidden:YES];
    [_containerView setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [_bgView setHidden:YES];
    [_containerView setHidden:YES];
    [_lblDurationTitle setHidden:YES];
    
    NSLog(@"Mini id %@",_miniCertificateId);
    
    _QuizButton.layer.cornerRadius=16.0f;
    _QuizButton.layer.masksToBounds=YES;
    
    _courseDescriptionConstraint.constant=100.0f;
    _courseDescriptionConstraint.active=YES;
    
    lessbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.readMoreView.frame.size.width, self.readMoreView.frame.size.height)];
    lessbutton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:12.0f];
    morebutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.readMoreView.frame.size.width, self.readMoreView.frame.size.height)];
    morebutton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:12.0f];
    [morebutton addTarget:self action:@selector(moreconstraint) forControlEvents:UIControlEventTouchUpInside];
[morebutton setTitle:@"READ MORE" forState:UIControlStateNormal];
    
_imageViewUpandDown.image=[UIImage imageNamed:@"downArrowWhite"];
    
    [morebutton setTintColor:[UIColor whiteColor]];
    
    [self.readMoreView addSubview:morebutton];
    
   
    arrArticleTitles=[[NSMutableArray alloc]init];
    arrArticleDuration=[[NSMutableArray alloc]init];
    arrArticleId=[[NSMutableArray alloc]init];
 
    arrStartTime=[[NSMutableArray alloc]init];
    arrAttemptcount=[[NSMutableArray alloc]init];
    arrVideoWatched=[[NSMutableArray alloc]init];
    arrVideoPausedTime=[[NSMutableArray alloc]init];

    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    //[self.view addSubview:self.img];
    [backGroundView addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    // [self.view addSubview:self.loadingView];
    [backGroundView addSubview:self.loadingView];
    [self.view bringSubviewToFront:backGroundView];

    
    [morebutton setHidden:NO];
    [lessbutton setHidden:YES];
    _btnInfo.hidden=YES;
    [self configureNavigation];
    
    [_TVContainerView setHidden: YES];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    userid=[usercheckup valueForKey:@"id"];
     [self miniCertificateDetails];
   
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    userid=[usercheckup valueForKey:@"id"];
    [self miniCertificateDetails];
    
}
-(void)configureNavigation
{
    self.title=@"Mock Assessment Details";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
//   btnAnalytics = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"analytics"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoAnalytics)];
//    [self.navigationItem setRightBarButtonItem:btnAnalytics];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];

    
}
-(void)gotoAnalytics{
    ReportAnalyticsViewController *report = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportAnalyticsViewController"];
    report.assessmentId=_miniCertificateId;
    [self.navigationController pushViewController:report animated:YES];
    
}
-(void)miniCertificateDetails
{
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]miniCertificateDetailsWithId:self.miniCertificateId anduserID:userid andCompleteBlock:^(BOOL success, id result)     
     {
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
         if (!success)
         {
             return ;
         }
         else
         {
             
             
             NSMutableDictionary *response=[result valueForKey:@"mini_certification"];
             NSMutableArray *articleData=[result valueForKey:@"mini_certification"];
             
             NSString *strOverView=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"overview"]];
             _txtOverView.text=strOverView;
             NSString *miniLessionsImg=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"photo_orig"]];
             [_miniCertificationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,miniLessionsImg]]];
             
             NSMutableArray *articles=[[articleData objectAtIndex:0] valueForKey:@"article"];
             arrArticleId=[articles valueForKey:@"id"];
             arrArticleDuration=[articles valueForKey:@"url_duration"];
             
//             arrVideoPausedTime=[articles valueForKey:@"end_time"];
             arrArticleTitles=[articles valueForKey:@"name"];
//             arrStartTime=[articles valueForKey:@"start_time"];
//             [arrVideoWatched removeAllObjects];
             
//             NSMutableArray *arrWatch=[articles valueForKey:@"video_watched"];
//             [arrVideoWatched addObjectsFromArray:arrWatch];
//             if ([[arrWatch objectAtIndex:0] isEqualToString:@"no"]) {
//                 [arrVideoWatched replaceObjectAtIndex:0 withObject:@""];
//             }
 
             
             
          //  strTestAssesment=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"test_assessment"]];
             strAttemptCount=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"attempt_count"]];
             strResultStatus=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"result_status"]];
               strRedeemStatus=[NSString stringWithFormat:@"%@",[[articleData objectAtIndex:0] valueForKey:@"redeem_status"]];

             
             if ([strResultStatus isEqualToString:@"pass"]){
                 [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                 [_btnQuiz setEnabled:YES];
                 [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                 [_btnQuiz setTitle:@"View Result" forState:UIControlStateNormal];
                 [_explainationView setHidden:NO];
             }else{
                 [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                 [_btnQuiz setTitle:@"Take Quiz" forState:UIControlStateNormal];
                 [_btnQuiz setEnabled:YES];
                 [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                 [_TVContainerView setHidden: YES];
                 [_explainationView setHidden:YES];
             }
             
             /*
                 if ([strAttemptCount isEqual:[NSNull null] ]||[strAttemptCount isEqualToString:@"<null>"])
                 {
                     [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                     [_btnQuiz setEnabled:YES];
                     [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                     [_btnQuiz setTitle:@"Take Quiz" forState:UIControlStateNormal];
                     [_TVContainerView setHidden: YES];
                    
                 }
                 
                 else if ([strAttemptCount isEqualToString:@"1"])
                 {
                     btnType=@"1";
                    if ([strResultStatus isEqualToString:@"pass"])
                     {
                         [_TVContainerView setHidden: NO];
                         if ([strRedeemStatus isEqualToString:@"yes"])
                         {
                             [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                             [_btnQuiz setEnabled:YES];
                             [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                             [_btnQuiz setTitle:@"Collect E Certificate" forState:UIControlStateNormal];
                         }
                         else {
                             [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                             [_btnQuiz setEnabled:YES];
                             [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                             [_btnQuiz setTitle:@"Redeem Certificate" forState:UIControlStateNormal];
                         }
                         
                         
                         
                     }
                     else{
                         [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                         [_btnQuiz setEnabled:YES];
                         [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                         [_btnQuiz setTitle:@"Take Quiz" forState:UIControlStateNormal];
                         [_TVContainerView setHidden: YES];
                         
                     }

                 }
                 else if([strAttemptCount isEqualToString:@"2"])
                 {
                     btnType=@"2";

                     [_TVContainerView setHidden: NO];
                     if ([strResultStatus isEqualToString:@"pass"])
                     {
                         
                         if ([strRedeemStatus isEqualToString:@"yes"])
                         {
                             [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                             [_btnQuiz setEnabled:YES];
                             [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                             [_btnQuiz setTitle:@"Collect E Certificate" forState:UIControlStateNormal];
                         }
                         else {
                             [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                             [_btnQuiz setEnabled:YES];
                             [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                             [_btnQuiz setTitle:@"Redeem Certificate" forState:UIControlStateNormal];
                         }
                         
                         
                         
                     }
                     else{
                         [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                         [_btnQuiz setEnabled:YES];
                         [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                         [_btnQuiz setTitle:@"View Result" forState:UIControlStateNormal];
                     }
                     
                 } */
           //  }
                 
              
             
//             else{
//                 [ _btnQuiz setBackgroundColor:[UIColor darkGrayColor]];
//                 [_btnQuiz setEnabled:NO];
//                 [_btnQuiz setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                 [_btnQuiz setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
//                  [_btnQuiz setTitle:@"Take Quiz" forState:UIControlStateNormal];
//
//             }
             
         }
         
         [_tblCourseVideos reloadData];
        
        
    }];
    

    
}
-(void)backButton
{
    NSUserDefaults *notificationDefaults=[NSUserDefaults standardUserDefaults];
    [notificationDefaults setValue:@"" forKey:@"miniid"];
    [notificationDefaults setValue:@"" forKey:@"count"];
    
    [notificationDefaults setValue:_sSection forKey:@"selectedSection"];
    [notificationDefaults setValue:_sRow forKey:@"selectedRow"];
    [notificationDefaults setValue:@"backTapped" forKey:@"backTapped"];
    
//    [notificationDefaults setInteger:_sSection forKey:@"selectedSection"];
//    [notificationDefaults setInteger:_sRow forKey:@"selectedRow"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrArticleId.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LessonsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LessonsTableViewCell"];
    
    cell.imgLock.hidden=YES;
    cell.lblArticleTitle.text=[arrArticleTitles objectAtIndex:indexPath.row];
    NSString *strDuration = [NSString stringWithFormat:@"%@",[arrArticleDuration objectAtIndex:indexPath.row]];
    if ([strDuration isEqualToString:@"<null>"])
    {
        cell.lblDuration.text=@"";

    }
    else
    {
    cell.lblDuration.text=[NSString stringWithFormat:@"%@",[arrArticleDuration objectAtIndex:indexPath.row]];
    }
  //  NSString *strFirstCell=[arrVideoWatched objectAtIndex:0];

    
//    NSString *videoWatched=[arrVideoWatched objectAtIndex:indexPath.row];
//    
//    if ([videoWatched isEqualToString:@"no"])
//    {
//        cell.imgLock.image=[UIImage imageNamed:@"minilock"];
//        cell.userInteractionEnabled=NO;
//
//    }
//    else if([videoWatched isEqualToString:@"yes"])
//    {
//        cell.imgLock.image=[UIImage imageNamed:@"tick"];
//        cell.userInteractionEnabled=NO;
//        cell.imgLock.hidden=NO;
//    }
//    else{
//        cell.imgLock.hidden=YES;
//    }
    
    [cell.lblArticleTitle sizeToFit];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 45.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ArticleDetailsViewController *articleDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
    
    ArticleDetailsVC *articleDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVCSBID"];
    articleDetails.articleId=[arrArticleId objectAtIndex:indexPath.row];
    articleDetails.strMinicertificationId=self.miniCertificateId ;
//    articleDetails.videoStartTime=[arrVideoPausedTime objectAtIndex:indexPath.row];
//    articleDetails.strVideoEndTime=[arrArticleDuration objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:articleDetails animated:YES];
    
    
    
    /* let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as? ArticleDetailsVC
    
    details?.articleId = articleid!
    details?.strMinicertificationId = ""
    if let details = details {
        navigationController?.pushViewController(details, animated: true)
    } */
    
    
    
}
- (void)moreconstraint
{
    [_bgView setHidden: NO];
    [_containerView setHidden:NO];
    _readMoreContentLbl.text = _txtOverView.text;
    /*
    CGSize constraintAnswer = CGSizeMake(_txtOverView.frame.size.width, CGFLOAT_MAX);
    NSStringDrawingContext *contextAnswer = [[NSStringDrawingContext alloc] init];
    CGSize boundingtxtOverView = [_txtOverView.text boundingRectWithSize:constraintAnswer
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSFontAttributeName:_txtOverView.font}
                                                                context:contextAnswer].size;
    
    CGSize sizeAnswer = CGSizeMake(ceil(boundingtxtOverView.width), ceil(boundingtxtOverView.height));
    NSLog(@"sizeViews label hight is %f",sizeAnswer.height);
    int CorseOverviewDynamicHeight=50+sizeAnswer.height;
_courseDescriptionConstraint.constant=CorseOverviewDynamicHeight;
    _courseDescriptionConstraint.active=YES;
    [lessbutton addTarget:self action:@selector(lessconstraint) forControlEvents:UIControlEventTouchUpInside];
[lessbutton setTitle:@"READ LESS" forState:UIControlStateNormal];
_imageViewUpandDown.image=[UIImage imageNamed:@"UpArrowWhite"];
    [lessbutton setTintColor:[UIColor whiteColor]];
    
    [lessbutton setHidden:NO];
    [morebutton setHidden:YES];
    
    [self.readMoreView addSubview:lessbutton]; */
    
    
    
    
}
- (void)lessconstraint
{
    _courseDescriptionConstraint.constant=100.0f;
    _courseDescriptionConstraint.active=YES;
    
    [morebutton addTarget:self action:@selector(moreconstraint) forControlEvents:UIControlEventTouchUpInside];
[morebutton setTitle:@"READ MORE" forState:UIControlStateNormal];
_imageViewUpandDown.image=[UIImage imageNamed:@"downArrowWhite"];
    [morebutton setTintColor:[UIColor whiteColor]];
    
    [morebutton setHidden:NO];
    [lessbutton setHidden:YES];
    
}

- (IBAction)btnQuizTapped:(id)sender
{
 
//    if ([strResultStatus isEqualToString:@"pass"]){
//
//    }else{
//
//    }
    
    
    /*[ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
    [_btnQuiz setEnabled:YES];
    [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_btnQuiz setTitle:@"TAKE THE QUIZ" forState:UIControlStateNormal]; */
    
//    AssessmentViewController *assessViewControll=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
    
    AssessmentVC *assessViewControll=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentVCSBID"];
    
    if ([strResultStatus isEqualToString:@"pass"]){
        assessViewControll.quizOrResult = @"result";
    }else{
        assessViewControll.quizOrResult = @"quiz";
    }
    
    
    assessViewControll.articleId=self.miniCertificateId;
    assessViewControll.strAuthoreId=_strAuthoreId;

    
    
    
    [self.navigationController pushViewController:assessViewControll animated:YES];
    
    
    
    
    
    
    /*
        if ([strAttemptCount isEqual:[NSNull null]]||[strAttemptCount isEqualToString:@"<null>"])
        {
            [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
            [_btnQuiz setEnabled:YES];
            [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_btnQuiz setTitle:@"Take Quiz" forState:UIControlStateNormal];

            AssessmentViewController *assessViewControll=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
            assessViewControll.articleId=self.miniCertificateId;
            assessViewControll.strAttemptcount=strAttemptCount;
             assessViewControll.strAuthoreId=_strAuthoreId;
            [self.navigationController pushViewController:assessViewControll animated:YES];
            
        }
        
        else if ([strAttemptCount isEqualToString:@"1"])
        {
            btnType=@"1";
            if ([strResultStatus isEqualToString:@"pass"])
            {
                
                if ([strRedeemStatus isEqualToString:@"yes"])
                {
                    [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                    [_btnQuiz setEnabled:YES];
                    [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [_btnQuiz setTitle:@"Collect E Certificate" forState:UIControlStateNormal];
                    
                    BankAccountViewController *bankAccount=[self.storyboard instantiateViewControllerWithIdentifier:@"BankAccountViewController"];
                    [self.navigationController pushViewController:bankAccount animated:YES];
                    
                    
                    
                }
                else {
                    [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                    [_btnQuiz setEnabled:YES];
                    [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [_btnQuiz setTitle:@"Redeem Certificate" forState:UIControlStateNormal];
                    
                    backGroundView.hidden=NO;
                    [self.loadingView startAnimation];
                    [self.loadingView setHidden:NO];
                    [self.img setHidden:NO];
                    [[APIManager sharedInstance]getingRecordedScoreWithUserId:userid andwithMinCerId:self.miniCertificateId ndCompleteBlock:^(BOOL success, id result) {
                        backGroundView.hidden=YES;
                        [self.loadingView stopAnimation];
                        [self.loadingView setHidden:YES];
                        [self.img setHidden:YES];
                        if (!success) {
                            return ;
                        }
                        else{
                            NSDictionary *score=[result valueForKey:@"score"];
                            NSString *strScore=[score valueForKey:@"score"];
                            ResultViewController *result=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
                            result.strPercentage=[NSString stringWithFormat:@"%@", strScore];
                            result.strMiniCertification=self.miniCertificateId;
                            [self.navigationController pushViewController:result animated:YES];
                        }
                    }];
                }
                
                
                
            }
            else{
                [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                [_btnQuiz setEnabled:YES];
                [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_btnQuiz setTitle:@"TAKE THE QUIZ" forState:UIControlStateNormal];
                AssessmentViewController *assessViewControll=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
                assessViewControll.articleId=self.miniCertificateId;
                assessViewControll.strAttemptcount=strAttemptCount;
                    assessViewControll.strAuthoreId=_strAuthoreId;
                [self.navigationController pushViewController:assessViewControll animated:YES];
            }
            
        }
        else if([strAttemptCount isEqualToString:@"2"])
        {
            btnType=@"2";
            
            if ([strResultStatus isEqualToString:@"pass"])
            {
                
                if ([strRedeemStatus isEqualToString:@"yes"])
                {
                    [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                    [_btnQuiz setEnabled:YES];
                    [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [_btnQuiz setTitle:@"Collect E Certificate" forState:UIControlStateNormal];
                    BankAccountViewController *bankAccount=[self.storyboard instantiateViewControllerWithIdentifier:@"BankAccountViewController"];
                    [self.navigationController pushViewController:bankAccount animated:YES];

                }
                else {
                    [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                    [_btnQuiz setEnabled:YES];
                    [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [_btnQuiz setTitle:@"Redeem Certificate" forState:UIControlStateNormal];
                    backGroundView.hidden=NO;
                    [self.loadingView startAnimation];
                    [self.loadingView setHidden:NO];
                    [self.img setHidden:NO];
                    [[APIManager sharedInstance]getingRecordedScoreWithUserId:userid andwithMinCerId:self.miniCertificateId ndCompleteBlock:^(BOOL success, id result) {
                        backGroundView.hidden=YES;
                        [self.loadingView stopAnimation];
                        [self.loadingView setHidden:YES];
                        [self.img setHidden:YES];
                        if (!success) {
                            return ;
                        }
                        else{
                            NSDictionary *score=[result valueForKey:@"score"];
                            NSString *strScore=[score valueForKey:@"score"];
                            ResultViewController *result=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
                            result.strPercentage=strScore;
                            result.strMiniCertification=self.miniCertificateId;
                            [self.navigationController pushViewController:result animated:YES];
                        }
                    }];

                }
   
            }
            else{
                [ _btnQuiz setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:76.0/255.0 blue:131.0/255.0 alpha:1]];
                [_btnQuiz setEnabled:YES];
                [_btnQuiz setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_btnQuiz setTitle:@"View Result" forState:UIControlStateNormal];


                [self ViewAnswer];

            }
            
        //}
        
        
        
    } */
    
    
    
    
    
    
    
    
    
    
    
//     if ([btnType isEqualToString:@"2"]) {
//        backGroundView.hidden=NO;
//        [self.loadingView startAnimation];
//        [self.loadingView setHidden:NO];
//        [self.img setHidden:NO];
//        [[APIManager sharedInstance]getingRecordedScoreWithUserId:userid andwithMinCerId:self.miniCertificateId ndCompleteBlock:^(BOOL success, id result) {
//            backGroundView.hidden=YES;
//            [self.loadingView stopAnimation];
//            [self.loadingView setHidden:YES];
//            [self.img setHidden:YES];
//            if (!success) {
//                return ;
//            }
//            else{
//                NSDictionary *score=[result valueForKey:@"score"];
//                NSString *strScore=[score valueForKey:@"score"];
//                ResultViewController *result=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
//                result.strPercentage=strScore;
//                result.strMiniCertification=self.miniCertificateId;
//                [self.navigationController pushViewController:result animated:YES];
//            }
//        }];
//
//    }
//    else{
//    
//    AssessmentViewController *assessViewControll=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
//    assessViewControll.articleId=self.miniCertificateId;
//    [self.navigationController pushViewController:assessViewControll animated:YES];
//    }
}
-(void)ViewAnswer
{
    ViewAnswersViewController *viewAnswVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewAnswersViewController"];
    viewAnswVC.articleId=self.miniCertificateId;
    viewAnswVC.userId=userid;
    [self.navigationController pushViewController:viewAnswVC animated:YES];
}
- (IBAction)btnInfoTapped:(id)sender {
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
    [alert showSuccess:AppName subTitle:@"You need to complete watching all the videos lessons and take the quiz. Once you have completed one video you cannot re-watch the same video again." closeButtonTitle:[Language ok] duration:0.0f];

}
- (IBAction)btnAnalyticsTapped:(id)sender {
    [self gotoAnalytics];
}
@end
