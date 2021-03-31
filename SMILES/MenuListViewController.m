//
//  MenuListViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "MenuListViewController.h"
#import "REFrostedViewController.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "MenuTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "ViewController.h"
#import "NavigationViewController.h"
#import "ProfileDetailsViewController.h"
#import "HomeViewController.h"
#import "CreateArticleViewController.h"
#import "ArticlesViewController.h"
#import "AboutUsViewController.h"
#import "UserGuideViewController.h"

#import "FavoriteArticlesViewController.h"
#import "TrainersViewController.h"


#import "SharegroupViewController.h"
#import "CreateGroupViewController.h"
#import "AssessmentViewController.h"
#import "SequenceViewController.h"
#import "StartAssessmentViewController.h"
#import "HYCircleLoadingView.h"
#import "MyArticlesViewController.h"
#import "SubscriptionViewController.h"
#import "Language.h"
#import "MiniCertificateViewController.h"

#import "HistoryViewController.h"
#import "SettingsViewController.h"
#import "BookMarkFolderViewController.h"
#import "LeaderBoardViewController.h"

#import "SCLAlertView.h"
@import Firebase;
//#import "Language.h"

//#import "ProductModuleName-Swift.h"


@interface MenuListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UITableView *profileMenu;
    NSString *userId,*userName,*userType,*userTypeId,*userTelCode,*userPhone,*userEmail,*userProfileImg;
    NSArray *arrSubscriberMenu,*arrContributorMenu,*arrAdminMenu,*arrFacilitatorMenu;
    NSArray *arrSubscriberMenuImages,*arrContributorMenuImages,*arrAdminMenuImages,*arrFacilitatorMenuImages;
    
    NSUserDefaults *defaults;
    NSString *language1;
    FIRDatabaseReference *ref;
}
@property (weak, nonatomic) IBOutlet UIImageView *profiloeImg;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //User defaults
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    language1=[userDefaults objectForKey:@"language"];
    userId=[userDefaults  objectForKey:@"id"];
    userName=[userDefaults  objectForKey:@"name"];
    userType=[userDefaults  objectForKey:@"usertype"];
    userTypeId=[userDefaults objectForKey:@"usertypeid"];
    userTelCode=[userDefaults objectForKey:@"telcode"];
    userPhone=[userDefaults objectForKey:@"phone"];
    userEmail=[userDefaults objectForKey:@"email"];
    userProfileImg=[userDefaults objectForKey:@"profileimage"];
   
    arrSubscriberMenu=[[NSMutableArray alloc] initWithObjects:@"Modules",@"My Favourite Lessons",@"Mock Assessment",@"Subscription List",@"My BookMarks",@"History",@"My Profile",@"User Guide",@"About Resource Coach", nil];
       
       self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-30, self.view.frame.size.height/2+15-30, 30, 30)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    
    
    arrSubscriberMenuImages=[[NSArray alloc] initWithObjects:@"Topics",@"Favourite",@"Mini",@"Subscription",@"MyBookMarks",@"History",@"MyProfile",@"UserGuide",@"AboutUs",nil];
    [_btnLogout setTitle:[Language Logout] forState:UIControlStateNormal];
    
    
    
    [profileMenu reloadData];
    
    
    profileMenu.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //User defaults
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
   
    userType=[userDefaults  objectForKey:@"usertype"];
    userTypeId=[userDefaults objectForKey:@"usertypeid"];
    userTelCode=[userDefaults objectForKey:@"telcode"];
    userPhone=[userDefaults objectForKey:@"phone"];
    userEmail=[userDefaults objectForKey:@"email"];
    
    [[APIManager sharedInstance]getUserProfileDetailsWithUserId:userId andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            return ;
        }
        else{
            NSDictionary *data = [result objectForKey:@"data"];
            NSDictionary *userDict = [data objectForKey:@"userdata"];
            NSString *userProfilePic;//username
            [userDefaults setObject:[userDict valueForKey:@"username"] forKey:@"name"];
            userProfilePic=[userDict valueForKey:@"photo_user"];
                if ([userProfilePic isEqual:[NSNull null]])
                {
                self.profiloeImg.image=[UIImage imageNamed:@"userprofile"];
                }
                else
                {
                [self.profiloeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,userProfilePic]]
                              placeholderImage:[UIImage imageNamed:@"profileimage"]];
                [userDefaults setValue:userProfilePic forKey:@""];
                if (!self.profiloeImg.image) {
                    self.profiloeImg.image=[UIImage imageNamed:@"userprofile"];
                }
            }
 
        }
    }];
     self.profiloeImg.layer.cornerRadius = self.profiloeImg.frame.size.height/2;
    self.profiloeImg.layer.masksToBounds = YES;
    self.profiloeImg.layer.shadowColor = [UIColor purpleColor].CGColor;
    self.profiloeImg.layer.shadowOffset = CGSizeMake(0, 3);
    self.profiloeImg.layer.shadowOpacity = 1;
    //self.profiloeImg.layer.shadowRadius = 1.0;
    //self.profiloeImg.clipsToBounds = NO;
    self.profiloeImg.layer.borderWidth = 3.0f;
    self.profiloeImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    userName=[userDefaults  objectForKey:@"name"];
    self.lblUserName.text=userName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableview Delegate Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.5f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return [arrSubscriberMenu count];
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell=[[MenuTableViewCell alloc]init];
     cell=(MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [cell setSelectedBackgroundView:view];
    profileMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    
       cell.lblMenuTitle.text=[arrSubscriberMenu objectAtIndex:indexPath.row];
        NSString *strimage=[arrSubscriberMenuImages objectAtIndex:indexPath.row];
        cell.menuIcon.image=[UIImage imageNamed:strimage];
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
 
        
        /* if (indexPath.row==0) {
            HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            navigationController.viewControllers=@[home];
        } */
        if (indexPath.row==0) {
            ArticlesViewController *articles=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
            navigationController.viewControllers=@[articles];
        }
        /* else if (indexPath.row==1)
        {
            TrainersViewController *favarticles=[self.storyboard instantiateViewControllerWithIdentifier:@"TrainersViewController"];
            navigationController.viewControllers=@[favarticles];
        } */
        else if (indexPath.row==1) {
            FavoriteArticlesViewController *sharegroup=[self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteArticlesViewController"];
            navigationController.viewControllers=@[sharegroup];
        }
        else if (indexPath.row==2) {
            MiniCertificateViewController *assessment=[self.storyboard instantiateViewControllerWithIdentifier:@"MiniCertificateViewController"];
            navigationController.viewControllers=@[assessment];
        }
        else if (indexPath.row==3)
        {
            SubscriptionViewController *sequences=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionViewController"];
            navigationController.viewControllers=@[sequences];
        }
        else if (indexPath.row==4)
        {
            
            BookMarkFolderViewController*bookmark=[self.storyboard instantiateViewControllerWithIdentifier:@"BookMarkFolderViewController"];
            navigationController.viewControllers=@[bookmark];
        }
    
        /* else if (indexPath.row==6)
        {
            LeaderBoardViewController *leadwerboard=[self.storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardViewController"];
            navigationController.viewControllers=@[leadwerboard];
        }*/
    
        else if (indexPath.row==5)
        {
            HistoryViewController *historyClass=[self.storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
            navigationController.viewControllers=@[historyClass];
        }
        else if (indexPath.row==6)
        {
//            ProfileDetailsViewController *profileDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileDetailsViewController"];
//            navigationController.viewControllers=@[profileDetails];
            
            ProfileVC *profileDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVCSBID"];
            navigationController.viewControllers=@[profileDetails];
        }
        else if (indexPath.row==7) {
            UserGuideViewController *userguide=[self.storyboard instantiateViewControllerWithIdentifier:@"UserGuideViewController"];
            navigationController.viewControllers=@[userguide];
        }
        else if (indexPath.row==8)
        {
            AboutUsViewController *aboutus=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            navigationController.viewControllers=@[aboutus];
        }
//        else if (indexPath.row==10)
//        {
//            SettingsViewController *settings=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
//            navigationController.viewControllers=@[settings];
//        }
    
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.contentViewController = navigationController;
  }

#pragma mark -Button Logout Tapped
- (IBAction)btnLogOuttapped:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
    [alert addButton:@"YES" target:self selector:@selector(logoutUser)];
    [alert showSuccess:AppName subTitle:@"Do you want to Logout?" closeButtonTitle:@"NO" duration:0.0f];
   
}
-(void)logoutUser
{
    NSUserDefaults *devieDefaults=[NSUserDefaults standardUserDefaults];
    NSString *deviceid=[devieDefaults objectForKey:@"token"];
    // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    
    if (deviceid==nil)
    {
        NSLog(@"Device id is not found");
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
    }
    else
    {
        [[APIManager sharedInstance]unRegisterDeviceForPushnotificationsWithUserId:userId andWithDeviceType:@"ios" andWithDeviceId:deviceid andWithregisterId:@"" andCompleteBlock:^(BOOL success, id result)
         {
             //  [Utility hideLoading:self];
             [self.loadingView stopAnimation];
             [self.loadingView setHidden:YES];
             [self.img setHidden:YES];
             if (!success)
             {
                 return ;
             }
             NSLog(@"Device is unregistered");
         }];
        
    }
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *fcmTocken=[userDefaults valueForKey:@"fcmtoken"];
    NSString *loginId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"id"]];
    
    ref = [[FIRDatabase database] reference];
    [[[ref child:@"fcm_token"]child:loginId ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableDictionary *dict = snapshot.value;
        if ([dict isEqual:[NSNull null]])
        {
            NSLog(@"%@",dict);
        }
        else{
            NSLog(@"%@",dict);
            
            NSArray *keys=dict.allKeys;
            NSArray *valuesofTimeStramp=dict.allValues;
            NSLog(@"All  keys%@",keys);
            for (int i=0; i<[dict count]; i++) {
                NSDictionary *fcmResDic=[valuesofTimeStramp objectAtIndex:i];
                NSString *fcmResponseId=[fcmResDic valueForKey:@"fcm_id"];
                NSLog(@"fcmResponseId %@",fcmResponseId);
                if ([fcmTocken isEqualToString:fcmResponseId]) {
                    NSString *timeStramp=[keys objectAtIndex:i];
                    [[[[ref child:@"fcm_token"]child:loginId]child:timeStramp]removeValue];
                    //                [[FIRMessaging messaging]sendMessage:@{@"fcm_message": @"Hi IOS"} to:@"eu56geGuGiU:APA91bE5ZB_5_qdL2obUr7H0-VMr294PfLPIPGER-8PwuI05EPXqKkmAI1GneETFJqwasm1NBWQvVW_esGbo9AY2KF2ZXGPdp--HrWJ1aHd6mINKkB1z7F3xClI3PMQ0mYA0E30ZycUC" withMessageID:@"this is is" timeToLive:4];
                    
                }
            }
        }
    } withCancelBlock:^(NSError * _Nonnull error)
     {
         NSLog(@"%@", error.localizedDescription);
     }];
    
    
    
    
    
    
    [userDefaults setObject:@"" forKey:@"id"];
    [userDefaults setObject:@"" forKey:@"name"];
    [userDefaults setObject:@"" forKey:@"usertype"];
    [userDefaults setObject:@"" forKey:@"usertypeid"];
    [userDefaults setObject:@"" forKey:@"telcode"];
    [userDefaults setObject:@"" forKey:@"phone"];
    [userDefaults setObject:@"" forKey:@"email"];
    [userDefaults setObject:@"" forKey:@"profileimage"];
    [userDefaults setObject:@"" forKey:@"deptid"];
    [userDefaults setObject:@"" forKey:@"fcmtoken"];
    
    
    
    [userDefaults setValue:@"" forKey:@"othersId"];
    [userDefaults setValue:@"" forKey:@"articleid"];
    [userDefaults setValue:@"" forKey:@"othersProfileImg"];
    [userDefaults setValue:@"" forKey:@"othersName"];
    
    [userDefaults synchronize];
    ViewController *loginView=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:loginView animated:YES completion:nil];
}
- (IBAction)btnProfileTapped:(id)sender
{
     NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
//    ProfileDetailsViewController *profileDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileDetailsViewController"];
    
    ProfileVC *profileDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVCSBID"];
    
    navigationController.viewControllers=@[profileDetails];
    [self.frostedViewController hideMenuViewController];
    self.frostedViewController.contentViewController = navigationController;
}
- (IBAction)btnSettingsTapped:(id)sender {
    NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
        SettingsViewController *settings=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        navigationController.viewControllers=@[settings];
    
    [self.frostedViewController hideMenuViewController];
    self.frostedViewController.contentViewController = navigationController;
}

@end
