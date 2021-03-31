//
//  EmailVerificationViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 21/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "EmailVerificationViewController.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "ProfileUpdateViewController.h"
#import "ProfileDetailsViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "SCLAlertView.h"

@interface EmailVerificationViewController (){
    __weak IBOutlet UILabel *lblEmail;
    __weak IBOutlet UITextField *txtVerificationCode;
    __weak IBOutlet UIButton *btnResend;
    __weak IBOutlet UIImageView *imgTick;
    __weak IBOutlet UILabel *lblVerifiedEmail;
    NSString *strVerifyCode,*userType,*verifyEmail;
    __weak IBOutlet UILabel *lbltext1;
    __weak IBOutlet UILabel *lbltext2;
    __weak IBOutlet UILabel *lbltext3;
    
    NSString *uID,*UserType;
    UIView *backGroundView;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation EmailVerificationViewController
@synthesize strEmail,editEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
    // lblVerifiedEmail.text=[Language EmailVerification];
    lbltext1.text=[Language WeHaveSentYouAnMailwithCodeToEmail];
    lbltext2.text=[Language ToCompleteYourEmailVerificationPleaseEntertThe4DigitVerificationCode];
    txtVerificationCode.placeholder=[Language EnterVerificationCode];
    lbltext3.text=[Language NotReceivedVerificationCode];
    [btnResend setTitle:[Language RESEND] forState:UIControlStateNormal ];
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

    NSUserDefaults *emailDefaults=[NSUserDefaults standardUserDefaults];
    strEmail=[emailDefaults objectForKey:@"email"];
    userType=[emailDefaults objectForKey:@"usertypeid"];
    if ([editEmail length]>0) {
        lblEmail.text=editEmail;
        verifyEmail=editEmail;
    }
    else{
        lblEmail.text=strEmail;
        verifyEmail=strEmail;
    }
    [lblVerifiedEmail setHidden:YES];
    [imgTick setHidden:YES];
    [self getOtpForEmailVerification];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
       // self.title=[Language EmailVerification];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language EmailVerification];;
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else if ([language1 isEqualToString:@"3"]){
        // self.title=@"ပရိုဖိုင်းကို";
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language EmailVerification];;
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else{
        self.title=[Language EmailVerification];;
        
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
    
}
#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Get OTP for Email
-(void)getOtpForEmailVerification{
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]resendOtpForEmail:verifyEmail andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            return;

        }
        NSString *message = [result objectForKey:@"message"];
        NSLog(@"Message is %@",message);
    }];
}

#pragma mark -Button Resend OTP Tapped
- (IBAction)btnResendTapped:(id)sender {
    [self getOtpForEmailVerification];
}

#pragma mark - UITextfield delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"The length is %lu",(unsigned long)txtVerificationCode.text.length);
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==txtVerificationCode) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        strVerifyCode=str;
        if ([str length]== 4)
        {
            [self readOTP];
            [txtVerificationCode resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

#pragma mark -Read Otp
-(void)readOTP
{
    txtVerificationCode.text=strVerifyCode;
    if (txtVerificationCode.text.length == 0)
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language pleaseEnterOTP] closeButtonTitle:[Language ok] duration:0.0f];
        [txtVerificationCode becomeFirstResponder];
        return;

    }
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]verifyRegisteredEmailWithUserType:userType andWithEmail:verifyEmail andWithEmailOTP:txtVerificationCode.text andCompleteBlock:^(BOOL success, id result)
     {
         //  [Utility hideLoading:self];
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
         if (!success)
         {
             SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
             [alert setHorizontalButtons:YES];
             [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
             
             return;
         }
         NSString *message=[result valueForKey:@"message"];
         NSLog(@"Message is %@",message);
         NSDictionary *data = [result objectForKey:@"data"];
         NSDictionary *userDict = [data objectForKey:@"userdata"];
         NSString *verifyStatus=[userDict valueForKey:@"email_verify"];
         if ([verifyStatus isEqualToString:@"YES"])
         {
             SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
             [alert setHorizontalButtons:YES];
             [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language ok] duration:0.0f];

             ProfileDetailsViewController *profileDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileDetailsViewController"];
             [self.navigationController pushViewController:profileDetails animated:YES];
         }
         else
         {
             SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
             [alert setHorizontalButtons:YES];
             [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language ok] duration:0.0f];
             
             return;
         }
     }];
}

@end
