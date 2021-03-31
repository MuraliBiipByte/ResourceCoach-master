//
//  MobileVerificationViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 15/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "MobileVerificationViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"

@interface MobileVerificationViewController ()<UITextFieldDelegate>{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *navigationBarView;
    __weak IBOutlet UIImageView *yarrowImg;
    __weak IBOutlet UIButton *btnEdit;
    __weak IBOutlet UILabel *lblMobileNumber;
    __weak IBOutlet UILabel *lbltext1;
    __weak IBOutlet UILabel *lblText2;
    __weak IBOutlet UITextField *txtVerificationCode;
    __weak IBOutlet UIButton *btnResend;
    NSString *strVerifyCode;
    __weak IBOutlet UILabel *lblHederTitle;
    __weak IBOutlet UILabel *lblNotRecievedOTP;
    UIView *backGroundView;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation MobileVerificationViewController
@synthesize strMobileNo,strCountryCode,strUserType;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"MobileNumberVerify" forKey:@"Controller"];
    
    lblHederTitle.text=[Language MobileVerification];
    txtVerificationCode.placeholder=[Language EnterVerificationCode];
    
    lblHederTitle.text=[Language MobileVerification];
    txtVerificationCode.placeholder=[Language EnterVerificationCode];
    
    
//    NSString *labelText = [Language sentSMSverificationcodetothenumberbelow];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:40];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
  // lbltext1.attributedText = attributedString ;
    
    lbltext1.text=[Language sentSMSverificationcodetothenumberbelow];
    lblText2.text=[Language FourdigitVerificationcode];
    [btnResend setTitle:[Language RESEND] forState:UIControlStateNormal];
    lblNotRecievedOTP.text=[Language NotReceivedVerificationCode];
    
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
    lblMobileNumber.text=[NSString stringWithFormat:@"%@-%@",strCountryCode,strMobileNo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
            if ([str length]== 4) {
                [self readOTP];
                [txtVerificationCode resignFirstResponder];
                return NO;
            }
        }
    return YES;
}

#pragma mark -Read Otp
-(void)readOTP{
    txtVerificationCode.text=strVerifyCode;
    if (txtVerificationCode.text.length == 0) {
        // [Utility showAlert:AppName withMessage:[Language pleaseEnterOTP]];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language pleaseEnterOTP] closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [txtVerificationCode becomeFirstResponder];
        return;
    }
    //  [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]accountActivation:strUserType andWithCountryCode:strCountryCode andWithPhoneNumber:strMobileNo andWithVerificationCode:txtVerificationCode.text andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
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
        NSString *message=[result valueForKey:@"message"];
        NSLog(@"Message is %@",message);
        NSDictionary *data = [result objectForKey:@"data"];
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        NSString *verifyStatus=[userDict valueForKey:@"mobile_verify"];
        if ([verifyStatus isEqualToString:@"YES"]){
            //[Utility showAlert:AppName withMessage:message];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language ok] duration:0.0f];
            
            ViewController *loginPage=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [self presentViewController:loginPage animated:YES completion:nil];
        }
    }];
}

#pragma mark -Button Resend Tapped
- (IBAction)btnResendTapped:(id)sender {
    txtVerificationCode.text=@"";
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]resendOTPWithTelCode:strCountryCode andWithMobileNumber:strMobileNo andCompleteBlock:^(BOOL success, id result) {
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
        NSString *resendMessage = [result objectForKey:@"message"];
        //   [Utility showAlert:AppName withMessage:resendMessage];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:resendMessage closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        
    }];
}

#pragma mark -Button Edit Tapped
- (IBAction)btnEditTapped:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    ViewController *loginPage=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:loginPage animated:YES completion:nil];
}

@end
