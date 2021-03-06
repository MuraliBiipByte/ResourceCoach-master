//
//  NewReviewViewController.m
//  SMILES
//
//  Created by Biipmi on 5/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "NewReviewViewController.h"
#import "DLStarView.h"
#import "DLStarRatingControl.h"
#import "REFrostedViewController.h"
#import "APIManager.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
#import "Utility.h"
#import "HomeViewController.h"
#import "NavigationViewController.h"
#import "HYCircleLoadingView.h"
#import "JVFloatLabeledTextView.h"
#import "SZTextView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "GetAllReviewViewController.h"

@interface NewReviewViewController ()<UITextViewDelegate>{
    __weak IBOutlet DLStarRatingControl *ratingView;
//    __weak IBOutlet UITextView *commentView;
    __weak IBOutlet UIButton *btnSubmitComment;
    __weak IBOutlet SZTextView *commentView;
    
    __weak IBOutlet UILabel *lblRate;
    __weak IBOutlet UILabel *lblReview;
    __weak IBOutlet UIView *bgView;
     NSString *reviewRate,*userId;
   
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation NewReviewViewController
@synthesize articleId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
    lblReview.text=[Language Review];
    lblRate.text=[Language Rate];
    [btnSubmitComment setTitle:[Language Submit] forState:UIControlStateNormal] ;
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults valueForKey:@"id"];
    bgView.layer.borderColor=[[UIColor groupTableViewBackgroundColor] CGColor];
    bgView.layer.borderWidth=0.5f;
    bgView.layer.cornerRadius=4.0f;
    //btnSubmitComment.layer.cornerRadius=4.0f;
    self.frostedViewController.panGestureEnabled=NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
   
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"])
    {
        self.title=@"评论";
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = [Language Review];
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
       
        commentView.placeholder=@"ဒီအပိုဒ်များအတွက်ပြန်လည်ဆန်းစစ်ခြင်းရေးထား";
    }
    else if ([language1 isEqualToString:@"3"])
    {
        //self.title=@"ဆန်းစစ်ခြင်း";
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"ဆန်းစစ်ခြင်း";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        
        
        commentView.placeholder=@"ဒီအပိုဒ်များအတွက်ပြန်လည်ဆန်းစစ်ခြင်းရေးထား";
    }
    else
    {
//        self.title=@"Comment";
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "custom font", size: 30)!,  NSForegroundColorAttributeName: UIColor.whiteColor()] }
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero]; //[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//        view.backgroundColor = [UIColor greenColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"Comment";
        label.textColor=[UIColor whiteColor];
//        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];

        
    commentView.placeholder=@"Write your Comment...";

    }
//    self.title=@"Review";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14],
        
     }];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
    
    
}

#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Uitextview Methods
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    [txtView resignFirstResponder];
    return NO;
}
- (void)newRating:(DLStarRatingControl *)control :(float)rating {
    reviewRate = [NSString stringWithFormat:@"%0.0f star rating",rating];
    
}

#pragma mark -Button Submit Rate Tapped
- (IBAction)btnSubmitCommentTapped:(id)sender
{
    reviewRate=[NSString stringWithFormat:@"%0.0f", ratingView.rating];
    if ([commentView.text length]==0)
    {
       // [Utility showAlert:AppName withMessage:enterComment];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
              [alert showSuccess:AppName subTitle:[Language Addyourcomment] closeButtonTitle:[Language ok] duration:0.0f];

        [commentView becomeFirstResponder];
        return;
    }
   // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]writeReviewForArticleWithUserId:userId andWithArticleId:articleId andWithRating:reviewRate andWithComment:commentView.text andCompleteBlock:^(BOOL success, id result) {
       // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
           // [alert setHorizontalButtons:YES];
            //        [alert addButton:[Language ok] actionBlock:^(void)
            //         {
            //             ResetPasswordViewController *resetPassword=[self.storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordViewController"];
            //             resetPassword.strTelCode=userTelcode;
            //             resetPassword.strMobileNo=userMobileNo;
            //             [self presentViewController:resetPassword animated:YES completion:nil];         }
            //         ];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

            return ;
        }
        GetAllReviewViewController *getAll=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllReviewViewController"];
        getAll.articleId=self.articleId;
        getAll.cameFrom = @"CommentBtn";
        [self.navigationController pushViewController:getAll animated:YES];
        
//         NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
//        HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//        navigationController.viewControllers=@[home];
//        [self.frostedViewController hideMenuViewController];
//        self.frostedViewController.contentViewController = navigationController;
    }];
}

@end
