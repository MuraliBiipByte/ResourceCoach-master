//
//  ProfileDetailsViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 20/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "ProfileUpdateViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "ProfileUpdateViewController.h"
#import "UIImageView+WebCache.h"
#import "REFrostedViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "PromoCodeTableViewCell.h"

#import "PromoCodesViewController.h"
#import "UIViewController+ENPopUp.h"
#import "UIViewController+MaryPopin.h"
#import "MiniCertificatesListViewController.h"

@interface ProfileDetailsViewController ()
{
    __weak IBOutlet UIButton *btnSubscriptions;
    __weak IBOutlet UIView *profileView;
    __weak IBOutlet UIImageView *profileImg;
    __weak IBOutlet UITextField *txtUserName;
    __weak IBOutlet UITextField *txtMobileNumber;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtCompanyName;
    __weak IBOutlet UITextField *txtDepartment;
    __weak IBOutlet UITextField *txtEmployeeID;
    __weak IBOutlet UIButton *btnEditProfile;
    __weak IBOutlet UILabel *lblMobileVerify;
    __weak IBOutlet UILabel *lblEmailVerify;
    NSString *strUserId;
    NSString *noVerified,*verified,*notAvailable;
    __weak IBOutlet UIImageView *mobileVerifiedImg;
    __weak IBOutlet UIImageView *emailVerifiedImg;
    
    __weak IBOutlet UILabel *lblViewSubscriptions;
    __weak IBOutlet UIButton *btnClickHere;
    
    __weak IBOutlet NSLayoutConstraint *txtMobileNumberConstraints;
     __weak IBOutlet NSLayoutConstraint *txtMobileNumberLineConstraints;
    
    NSString *uID,*UserType;
    UIView *backGroundView;
    
    NSMutableArray *arrPromoCodes,*arrValidFrom,*arrValidTill;
 
    NSString *strPromoCode;
    NSString *strSubscriptions;
    NSString *strScrathCard;
    
    UIView *subBackGroundArticleView;
    UIView *subArticleView;
    NSString *strCertificatesID,*strCertificateName,*strEmail,*strDate,*strAttemptCount,*strScore,*strMobileNumber,*strTeleCode;;
    
}
@property (nonatomic, getter = isDismissable) BOOL dismissable;
@property (nonatomic, assign) NSInteger selectedAlignementOption;
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation ProfileDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    txtUserName.placeholder=[Language FullName];
    txtMobileNumber.placeholder=[Language MobileNumber];
    txtEmail.placeholder=[Language Email];
    _certificatesView.hidden=YES;
    _btnViewAllCertificates.hidden=YES;
    btnEditProfile.hidden=YES;
    arrPromoCodes=[[NSMutableArray alloc]init];
    arrValidFrom=[[NSMutableArray alloc]init];
    arrValidTill=[[NSMutableArray alloc]init];
    
    _certificatesView.layer.cornerRadius=2;
    _certificatesView.layer.masksToBounds=YES;
    
    _certificatesView.layer.shadowColor = [UIColor grayColor].CGColor;
    _certificatesView.layer.shadowOffset = CGSizeZero;
    _certificatesView.layer.masksToBounds = NO;
    _certificatesView.layer.shadowRadius = 4.0f;
    _certificatesView.layer.shadowOpacity = 1.0;
    
    [self navigationConfiguration];
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
    
    
    [mobileVerifiedImg setHidden:YES];
    [emailVerifiedImg setHidden:YES];
    
    
    _lblExpairyDate.hidden=YES;
    lblViewSubscriptions.hidden=YES;
    btnClickHere.hidden=YES;
    [txtEmail setEnabled:NO];
    [txtUserName setEnabled:NO];
    [txtMobileNumber setEnabled:NO];
    
    
    profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
    profileImg.layer.masksToBounds = YES;
    profileImg.layer.borderWidth = 3.0f;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    
    //    [self.title sizeWithFont:[UIFont fontWithName:@"Roboto-Bold" size:14]];
    //
    //
    self.title=[Language MyProfile];
    
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    strUserId=[userDefaults  objectForKey:@"id"];
    [self getTheUserProfileDetails];
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    // [self checkUserType];
}

#pragma mark - Get Profile Details
-(void)getTheUserProfileDetails
{
    //  [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getUserProfileDetailsWithUserId:strUserId andCompleteBlock:^(BOOL success, id result)
     {
         // [Utility hideLoading:self];
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
         if (!success)
         {
             _certificatesView.hidden=YES;
             _btnViewAllCertificates.hidden=YES;
             [Utility showAlert:AppName withMessage:result];
             return ;
         }
         
         NSDictionary *data = [result objectForKey:@"data"];
         NSDictionary *userDict = [data objectForKey:@"userdata"];
         NSMutableDictionary *UserCode=[userDict valueForKey:@"user_subscription"];
         arrPromoCodes=[UserCode valueForKey:@"coupon_name"];
         NSArray *certificates=[data objectForKey:@"certificate"];
         NSString *strCerCount=[[certificates objectAtIndex:0]valueForKey:@"certificate_count"];
         
         if ([strCerCount isEqualToString:@"0"])
         {
             _certificatesView.hidden=YES;
             _btnViewAllCertificates.hidden=YES;
            
         }
         else
         {
             strCertificatesID=[[certificates objectAtIndex:0] valueForKey:@"id"];
             strCertificateName=[[certificates objectAtIndex:0] valueForKey:@"assessment"];
             NSLog(@"str ca %@",strCertificateName);
             strEmail=[[certificates objectAtIndex:0] valueForKey:@"email"];
             strDate=[[certificates objectAtIndex:0] valueForKey:@"created_on"];
             strMobileNumber=[[certificates objectAtIndex:0] valueForKey:@"mobile"];
             strTeleCode=[[certificates objectAtIndex:0] valueForKey:@"telcode"];
             NSString *strMobileNumberWithTeleCode=[NSString stringWithFormat:@"%@ %@",strTeleCode,strMobileNumber];
             strScore=[[certificates objectAtIndex:0] valueForKey:@"score"];
             int countCert=[strCerCount intValue];
             if (countCert==1)
             {
                  _certificatesView.hidden=NO;
                 _btnViewAllCertificates.hidden=YES;

             }
             else if (countCert>1)
             {
                 _certificatesView.hidden=NO;
                 _btnViewAllCertificates.hidden=NO;
             }
            
             _lblCertificationName.text=[strCertificateName uppercaseString];
             
             _lblEmai.text=strEmail;
             _lbldate.text=strDate;
             _lblCount.text=strAttemptCount;
             if ([strMobileNumber isEqual:[NSNull null]])
             {
                 _lblCertificateMobileNumber.text=[Language NotAvailable];
             }
             else
             {
                 _lblCertificateMobileNumber.text=strMobileNumberWithTeleCode;
             }
             NSString *Percentage =@"%";
             _lblScore.text=[NSString stringWithFormat:@"%@%@",strScore,Percentage];
             
            
         }
         
         NSString *userId,*userName,*userTelcode,*userMobileNo,*userEmail,*userEmailVerify,*userType,*userTypeId,*userProfilePic,*userMobVerifyStatus,*userActive,*userCompanyName,*userDepartment,*userEmpId,*loginType;
         loginType=[userDict valueForKey:@"login_type"];
         userId=[userDict valueForKey:@"id"];
         userName=[userDict valueForKey:@"username"];
         userTelcode=[userDict valueForKey:@"telcode"];
         userMobileNo=[userDict valueForKey:@"phone"];
         userEmail=[userDict valueForKey:@"email"];
         userType=[userDict valueForKey:@"usertype"];
         userTypeId=[userDict valueForKey:@"usertype_id"];
         userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
         userActive=[userDict valueForKey:@"active"];
         if ([loginType isEqualToString:@"fb_login"])
         {
              userProfilePic=[userDict valueForKey:@"photo_user_fb"];
             
         }
         else
         {
              userProfilePic=[userDict valueForKey:@"photo_user"];
         }
         
        NSString *expiry=[userDict valueForKey:@"user_expiry"];
         if (([expiry isEqual:[NSNull null]]||[expiry isEqualToString:@"<null>"]))
         {
             _lblExpairyDate.hidden=YES;
             lblViewSubscriptions.hidden=YES;
            
         }
         else
         {
             _lblExpairyDate.hidden=NO;
             lblViewSubscriptions.hidden=NO;
             _lblExpairyDate.text=[NSString stringWithFormat:@"Your subscription expires on : %@",expiry];
             
             
         }
         if (arrPromoCodes.count>0)
         {
             btnClickHere.hidden=NO;
         }
         else
         {
             btnClickHere.hidden=YES;
         }
         
         userEmailVerify=[userDict valueForKey:@"email_verify"];
         
         if ([loginType isEqualToString:@"fb_login"])
         {
             btnEditProfile.hidden=YES;
             if ([userProfilePic isEqual:[NSNull null]])
             {
                 profileImg.image=[UIImage imageNamed:@"userprofile"];
             }
             else
             {
                 [profileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userProfilePic]]
                               placeholderImage:[UIImage imageNamed:@"userprofile"]];
                 if (!profileImg.image)
                 {
                     profileImg.image=[UIImage imageNamed:@"userprofile"];
                 }
             }
         }
         
         else
         {
              btnEditProfile.hidden=NO;
             if ([userProfilePic isEqual:[NSNull null]])
             {
                 profileImg.image=[UIImage imageNamed:@"userprofile"];
             }
             else
             {
                 [profileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,userProfilePic]]
                               placeholderImage:[UIImage imageNamed:@"userprofile"]];
                 if (!profileImg.image)
                 {
                     profileImg.image=[UIImage imageNamed:@"userprofile"];
                 }
             }
         }
         profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
         profileImg.layer.masksToBounds = YES;
         profileImg.layer.borderWidth = 3.0f;
         profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
         txtUserName.text=userName;
         
         if ([userMobileNo isEqualToString:@""])
         {
        
             txtMobileNumber.text=[Language NotAvailable];
         }
         else
         {
             
             txtMobileNumber.text=[NSString stringWithFormat:@"%@ %@",userTelcode,userMobileNo];
             
         }
        
         if ([userMobVerifyStatus isEqualToString:@"NO"])
         {
             //lblMobileVerify.text=@"Not Verify";
             [mobileVerifiedImg setHidden:YES];
         }
         else
         {
             // lblMobileVerify.text=@"Verified";
             // [mobileVerifiedImg setHidden:NO];
             // mobileVerifiedImg.image=[UIImage imageNamed:@"emailVerified"];
         }
         if ([userEmail isEqual:[NSNull null]] || [userEmail isEqualToString:@""])
         {
             txtEmail.text=[Language NotAvailable];
             [lblEmailVerify setHidden:YES];
         }
         else
         {
             txtEmail.text=userEmail;
             [lblEmailVerify setHidden:NO];
             //[emailVerifiedImg setHidden:NO];
             if ([userEmailVerify isEqualToString:@"NO"]||[userEmailVerify isEqual:[NSNull null]])
             {
                 lblEmailVerify.text=[Language NotVerified];
                 //emailVerifiedImg.image=[UIImage imageNamed:@"emailNotVerified"];
             }
             else
             {
                 lblEmailVerify.text=@"Verified";
                 //emailVerifiedImg.image=[UIImage imageNamed:@"emailVerified"];
             }
         }
         
         
     }];
}

#pragma mark -Button Menu Tapped
- (IBAction)btnMenuTapped:(id)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture)
    {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

#pragma mark - Edit Profile Button Tapped
- (IBAction)btnEditProfileTapped:(id)sender
{
    ProfileUpdateViewController *updateProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileUpdateViewController"];
    [self.navigationController pushViewController:updateProfile animated:YES];
}

- (IBAction)btnSubscriptionsList:(id)sender
{
    
   PromoCodesViewController *popin = [self.storyboard instantiateViewControllerWithIdentifier:@"PromoCodesViewController"];
    popin.view.frame = CGRectMake(0, 0, 300.0f, 260.0f);
    [self presentPopUpViewController:popin];

    

}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    subBackGroundArticleView.hidden=YES;
    subArticleView.hidden=YES;
    
}
- (IBAction)btnViewAllCertificatesTapped:(id)sender
{
    MiniCertificatesListViewController *minCerList=[self.storyboard instantiateViewControllerWithIdentifier:@"MiniCertificatesListViewController"];
    minCerList.usrId=strUserId;
    [self.navigationController pushViewController:minCerList animated:YES];
    
}
@end

