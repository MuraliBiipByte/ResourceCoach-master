//
//  GetAllReviewViewController.m
//  SMILES
//
//  Created by Biipmi on 7/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "GetAllReviewViewController.h"
#import "DetailTableViewCell.h"
#import "APIManager.h"
#import "Utility.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "StarRatingControl.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "ArticleDetailsViewController.h"


@interface GetAllReviewViewController ()<UITableViewDataSource,UITableViewDelegate,StarRatingDelegate>{
    __weak IBOutlet UITableView *reviewTableviewList;
    DetailTableViewCell *reviewCell;
    NSString *userId;
    UIRefreshControl *refreshControl;
    NSMutableArray *arrReviewData;
    
      NSString *uID,*UserType;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation GetAllReviewViewController
@synthesize articleId;
@synthesize cameFrom;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigation];
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];

    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    reviewTableviewList.estimatedRowHeight = 80;
    reviewTableviewList.rowHeight = UITableViewAutomaticDimension;
    [reviewTableviewList setNeedsLayout];
    [reviewTableviewList layoutIfNeeded];
    reviewTableviewList.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    reviewTableviewList.hidden=YES;
    reviewTableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    arrReviewData=[[NSMutableArray alloc] init];
    [self getAllReviewsForArticle];
    refreshControl.accessibilityLabel=@"";
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllReviewsForArticle) forControlEvents:UIControlEventValueChanged];
    [reviewTableviewList addSubview:refreshControl];
    reviewTableviewList.alwaysBounceVertical = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
}
-(void)checkUserType{
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"%@",result);
        if (!success) {
            return ;
        }
        else{
            NSDictionary *userdata=[result valueForKey:@"userdata"];
            NSString *type=[userdata valueForKey:@"usertype"];
            NSString *userIds=[userdata valueForKey:@"user_id"];
            NSString *userName=[userdata valueForKey:@"username"];
            
            
            if (![UserType isEqualToString:type] ) {
                
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

-(void)configureNavigation{
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:20]}];
//    self.title=@"Reviews";
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(selectorbacktoforgot:)];
//    [self.navigationItem setLeftBarButtonItem:barButtonItem];
//    
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        self.title=@"评论";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
        
    }
    else if ([language1 isEqualToString:@"3"]){
        // self.title=@"reviews";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"Comments";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
        
    }
    else{
        self.title=@"Comments";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
        
    }
    //self.title=@"Reviews";

    
}

#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender{
    
    // *********UnComment for Bug #4574 (count of comments not refreshing instantly) **********
    
    NSUserDefaults *uDefaults=[NSUserDefaults standardUserDefaults];
    if ([cameFrom isEqual:@"CommentBtn"]){
        NSArray *myControllers = self.navigationController.viewControllers;
        long previous = myControllers.count - 3;
        UIViewController *articlesDetailVCObj = [myControllers objectAtIndex:previous];
        
        [uDefaults setBool:YES forKey:@"NeedToReloadArticleDetails"];
        [self.navigationController popToViewController:articlesDetailVCObj animated:YES];
    }else{
        [uDefaults setBool:NO forKey:@"NeedToReloadArticleDetails"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Get All Reviews
-(void)getAllReviewsForArticle{
   // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllReviewsForParticularArticle:articleId andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
           // [Utility showAlert:AppName withMessage:result];
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
         
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            reviewTableviewList.hidden=YES;
            return ;
        }
        arrReviewData=[result valueForKey:@"review_data"];
        reviewTableviewList.hidden=NO;
        [reviewTableviewList reloadData];
    }];
}

#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrReviewData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    reviewCell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reviewcell"];
    if (reviewCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil];
       reviewCell = [nib objectAtIndex:0];
    }
    NSDictionary *reviewDictionary = [arrReviewData objectAtIndex:indexPath.row];
    reviewCell.lblComment.text=[NSString stringWithFormat:@"%@",[reviewDictionary valueForKey:@"comment"]];
    reviewCell.lblReviewPostDate.text=[NSString stringWithFormat:@"%@",[reviewDictionary valueForKey:@"created_on"]];
    NSString *strValue=[reviewDictionary valueForKey:@"rate"];
    float yourFloat = [strValue floatValue];
    long roundedFloat = lroundf(yourFloat);
    NSLog(@"%ld",roundedFloat);
    reviewCell.rateView.rating=roundedFloat;
    reviewCell.rateView.exclusiveTouch=NO;
    reviewCell.rateView.delegate=self;
    reviewCell.rateView.userInteractionEnabled=NO;
    NSDictionary *postUserData=[reviewDictionary objectForKey:@"user_data"];
    NSString *imgStr=[NSString stringWithFormat:@"%@",[postUserData valueForKey:@"user_image"]];
    [reviewCell.profileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgStr]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
    if (!reviewCell.profileImage.image) {
      reviewCell.profileImage.image=[UIImage imageNamed:@"userprofile"];
    }
    reviewCell.lblReviwerName.text=[NSString stringWithFormat:@"%@",[postUserData valueForKey:@"username"]];
    reviewCell.profileImage.layer.cornerRadius = reviewCell.profileImage.frame.size.height/2;
    reviewCell.profileImage.layer.masksToBounds = YES;
    return reviewCell;
}

@end
