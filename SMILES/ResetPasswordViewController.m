//
//  ResetPasswordViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 20/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "UIAlertView+Blocks.h"
#import "ViewController.h"
#import "JVFloatLabeledTextField.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"

@interface ResetPasswordViewController (){
    __weak IBOutlet UIView *navigationView;
    __weak IBOutlet UILabel *lblNavigationTitle;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *passwordsView;
    __weak IBOutlet UITextField *txtNewPassword;
    __weak IBOutlet UILabel *lblNewPassword;
    __weak IBOutlet UITextField *txtReEnterPassword;
    __weak IBOutlet UILabel *lblReEnterPassword;
    __weak IBOutlet UIButton *btnSave;
    __weak IBOutlet UIImageView *alertIconNewPassword;
    __weak IBOutlet UIImageView *alertImgNewPassword;
    __weak IBOutlet UILabel *alertLabelNewPassword;
    __weak IBOutlet UIImageView *alertIconReEnterPassword;
    __weak IBOutlet UILabel *alertLabelReEnterPassword;
    __weak IBOutlet UIImageView *alertImgReEnterPassword;
    __weak IBOutlet UIButton *btnNavigationBack;
    __weak IBOutlet UIImageView *yarrowBackImg;
    __weak IBOutlet UILabel *lblMobileNumber;
    __weak IBOutlet UITextField *txtOTP;
    __weak IBOutlet UIButton *btnResendOTP;
    __weak IBOutlet UIImageView *successImg;
    __weak IBOutlet UILabel *lblSuccessPhNo;
    NSString *strVerifyCode;
    
    NSString *message;
    JVFloatLabeledTextField*jv;
    __weak IBOutlet UILabel *lblWehaveSentOTP;
    __weak IBOutlet UILabel *lblNote;
    UIView *backGroundView;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation ResetPasswordViewController
@synthesize strTelCode,strMobileNo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"Reset" forKey:@"Controller"];

    
    lblNavigationTitle.text=[Language ForgotPasswordTitle];
    lblWehaveSentOTP.text=[Language sentOTPtoYourRegisteredMobileNumber];
    lblNote.text=[Language notReceivedOTPPleaseclickonResendOTPButton];
    txtOTP.placeholder=[Language EnterOTP];
    [btnResendOTP setTitle:[Language ResendOTP] forState:UIControlStateNormal];
    
    txtNewPassword.placeholder=[Language EnterNewPassword];
    txtReEnterPassword.placeholder=[Language ReEnterPassword];
    [btnSave setTitle:[Language SAVE] forState:UIControlStateNormal];
    
   
    lblMobileNumber.text=[NSString stringWithFormat:@"%@-%@",strTelCode,strMobileNo];
    [successImg setHidden:YES];
    [lblSuccessPhNo setHidden:YES];
    [passwordsView setHidden:YES];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Passwor Validation
-(BOOL)isValidPassword:(NSString *)passwordString{

    NSString *stricterFilterString = @"^(?!.*(.)\\1{3})((?=.*[\\d])(?=.*[A-Za-z])|(?=.*[^\\w\\d\\s])(?=.*[A-Za-z])).{6,25}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

#pragma TextField Deligates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField==txtOTP) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        strVerifyCode=str;
        if ([str length]== 4) {
            [self readOTP];
            [txtOTP resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

#pragma mark -Read Otp
-(void)readOTP{
    txtOTP.text=strVerifyCode;
    if (txtOTP.text.length == 0) {
     
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
                [alert showSuccess:AppName subTitle:[Language pleaseEnterOTP] closeButtonTitle:[Language ok] duration:0.0f];

        [txtOTP becomeFirstResponder];
        return;
    }
    // [Utility showLoading:self];
    
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]VerifyForgotPasswordWithTelcode:strTelCode andWithMobileNumber:strMobileNo andWithForgotPassOTP:txtOTP.text andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
                        [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

            
            [txtOTP becomeFirstResponder];
            
            
            return ;
        }
        NSString *message=[result valueForKey:@"message"];
        NSLog(@"Message is %@",message);
        NSDictionary *data = [result objectForKey:@"data"];
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        NSString *verifyStatus=[userDict valueForKey:@"mobile_verify"];
        NSInteger status = [[result objectForKey:@"status"] intValue];
        if (status==1) {
            [successImg setHidden:NO];
            successImg.image=[UIImage imageNamed:@"emailVerified"];
            lblSuccessPhNo.text=lblMobileNumber.text;
            //lblSuccessPhNo.hidden=NO;
            [btnResendOTP setHidden:YES];
            [passwordsView setHidden:NO];
        }
               else{
            [passwordsView setHidden:YES];
            // [lblSuccessPhNo setHidden:NO];
            [txtOTP setHidden:NO];
            [btnResendOTP setHidden:NO];
            [successImg setHidden:NO];
            successImg.image=[UIImage imageNamed:@"emailNotVerified"];
        }
    }];
}

#pragma mark - Reset passowrd Button Tapped
- (IBAction)btnSaveTapped:(id)sender {
    if ([txtNewPassword.text length]==0&&[txtReEnterPassword.text length]==0) {
       
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language Passwordcannotbeempty] closeButtonTitle:[Language CANCEL] duration:0.0f];
        return;
    }
    if ([txtNewPassword.text length]==0) {
       
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language Passwordcannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        
        [txtNewPassword resignFirstResponder];
        return;
    }
    else if(![self isValidPassword:txtNewPassword.text]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
       
        [alert showSuccess:AppName subTitle:[Language passwordValidate] closeButtonTitle:[Language ok] duration:0.0f];
        
        [txtNewPassword resignFirstResponder];
        return;
    }
    if ([txtReEnterPassword.text length]==0) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
               [alert showSuccess:AppName subTitle:[Language ReenterPasswordcannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        
        [txtReEnterPassword resignFirstResponder];
        return;
    }
    else if (![txtNewPassword.text isEqualToString:txtReEnterPassword.text]) {
       
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language PassandReentershouldBeSame] closeButtonTitle:[Language ok] duration:0.0f];
        
        
     
        return;
    }
    // Password Update Service
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]setNewPasswordWithTelCode:strTelCode andWithMobileNumber:strMobileNo andWithNewPassword:txtNewPassword.text andWithNewConfirmPassword:txtReEnterPassword.text andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert addButton:@"OK" actionBlock:^(void)
             {
                 ViewController *viewClass=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                 [self presentViewController:viewClass animated:YES completion:nil];
             }
             ];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            
            
            return ;
        }
        message = [result objectForKey:@"message"];
        [self SuccessCustom];
        

    }];
}

#pragma mark - Close Button Tapped
- (IBAction)btnNavigationBackTapped:(id)sender {
    ViewController *backToHome=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:backToHome animated:YES completion:nil];
}

#pragma mark - Resend OTP Button Tapped
- (IBAction)btnResendOTP:(id)sender {
    //[Utility showLoading:self];
    txtOTP.text=@"";
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]forgotPasswordWithTelCode:strTelCode andWithMobileNumber:strMobileNo andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            //[Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            return ;
        }
        NSString *resendMessage = [result objectForKey:@"message"];
        //[Utility showAlert:AppName withMessage:resendMessage];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        //        [alert addButton:@"OK" actionBlock:^(void)
        //         {
        //             ViewController *viewClass=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        //             [self presentViewController:viewClass animated:YES completion:nil];
        //         }
        //         ];
        [alert showSuccess:AppName subTitle:resendMessage closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
    }];

}
-(void)SuccessCustom
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
    [alert addButton:[Language ok] actionBlock:^(void)
     {
         ViewController *viewClass=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
         [self presentViewController:viewClass animated:YES completion:nil];
     }
     ];
    [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language Cancel] duration:0.0f];
    
    
}
@end
