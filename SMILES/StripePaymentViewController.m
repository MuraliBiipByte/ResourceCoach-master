//
//  StripePaymentViewController.m
//  Bakester
//
//  Created by BiipByte Technologies on 10/04/17.
//  Copyright © 2017 BiipByte. All rights reserved.
//

#import <Stripe/Stripe.h>
#import "StripePaymentViewController.h"
#import "Constants.h"
#import "APIManager.h"
#import "SCLAlertView.h"
#import "RootViewController.h"
#import "HYCircleLoadingView.h"


@interface StripePaymentViewController () <STPPaymentCardTextFieldDelegate>


//Strings
@property (nonatomic) NSString *strCardNumber;
@property (nonatomic) NSString *strExprMonth;
@property (nonatomic) NSString *strExpYear;
@property (nonatomic) NSString *strCvv;
@property (nonatomic) NSString *strStripeToken;

@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain) UIImageView *img;
@property(nonatomic,retain) UIView *backGroundView;


//Extra used
@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;
@end

@implementation StripePaymentViewController
{
    NSString *userID;
}
@synthesize totalAmount,strCardNumber,strExprMonth,strExpYear,strCvv,subscriptionID,strStripeToken,backGroundView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [backGroundView addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [backGroundView addSubview:self.loadingView];
    [self.view bringSubviewToFront:backGroundView];
    

    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] init];
    paymentTextField.delegate = self;
    paymentTextField.cursorColor = [UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1];
    self.paymentTextField = paymentTextField;
    self.paymentTextField.frame = CGRectMake(self.view.frame.origin.x+8, self.view.frame.origin.y+16, self.view.frame.size.width-16, 35);
    [self.view addSubview:paymentTextField];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self navigationConfiguration];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    userID=[usercheckup valueForKey:@"id"];
    
    [self.paymentTextField clear];
}
-(void)navigationConfiguration
{
   
     self.title=@" Payment";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];

    NSString *stringPayMoney=[NSString stringWithFormat:@"Pay %@$",totalAmount];
    UIBarButtonItem *buyButton = [[UIBarButtonItem alloc] initWithTitle:stringPayMoney style:UIBarButtonItemStyleDone target:self action:@selector(pay)];
    buyButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = buyButton;
   
}
-(void)backBtnTapped
{
    
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.paymentTextField becomeFirstResponder];
}

- (void)paymentCardTextFieldDidChange:(nonnull STPPaymentCardTextField *)textField
{
    self.navigationItem.rightBarButtonItem.enabled = textField.isValid;
    
     strCardNumber=textField.cardParams.number;
     strExprMonth=[NSString stringWithFormat:@"%lu",(unsigned long)textField.cardParams.expMonth];
     strExpYear=[NSString stringWithFormat:@"%lu",(unsigned long)textField.cardParams.expYear];
    
}

- (void)pay
{
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [self.view endEditing:YES];
    
    if (![self.paymentTextField isValid])
    {
        return;
    }
    else
    {
        [[STPAPIClient sharedClient] createTokenWithCard:self.paymentTextField.cardParams
                                              completion:^(STPToken *token, NSError *error)
         {
             backGroundView.hidden=YES;
             [self.loadingView stopAnimation];
             [self.loadingView setHidden:YES];
             [self.img setHidden:YES];
             
             if (error)
             {
                 NSString *strErrorMessage=[NSString stringWithFormat:@"%@",error.localizedDescription];
                 SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                 [alert setHorizontalButtons:YES];
                 [alert showSuccess:AppName subTitle:strErrorMessage closeButtonTitle:@"OK" duration:0.0f];
             }
             else
             {
                 strStripeToken=[NSString stringWithFormat:@"%@",token.tokenId];
                 [[APIManager sharedInstance]stripePaymentWithUserId:userID andEnvironMent:@"ios" andStripetoken:strStripeToken andCardNumber:strCardNumber andexpyear:strExpYear andexpmonth:strExprMonth andsubscriptionId:subscriptionID andCompleteBlock:^(BOOL success, id result)
                  {
                      
                     if (!success)
                     {
                         //If issue with the Backend Then we are showing that message
                      //   NSString *strMessage=[result valueForKey:@"message"];
                         if ([result isEqual:[NSNull null]])
                         {
                              SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                             [alert addButton:@"Please Try Again" target:self selector:@selector(pay)];
                             [alert addButton:@"Cancel" actionBlock:^(void)
                              {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }];
                             
                             [alert showCustom:self image:[UIImage imageNamed:@"logo2_witheyes_face.png"] color:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1] title:AppName subTitle:@"Payment failed" closeButtonTitle:nil duration:0.0f];
                         }
                         //If issue with the backend though data coming null we can show this default message
                         else
                         {
                             SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                             [alert addButton:@"Please Try Again" target:self selector:@selector(pay)];
                             [alert addButton:@"Cancel" actionBlock:^(void)
                              {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }];
                             
                             [alert showCustom:self image:[UIImage imageNamed:@"logo2_witheyes_face.png"] color:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1] title:AppName subTitle:result closeButtonTitle:nil duration:0.0f];
                         }
                        
                         
                         return ;
                     }
                     else
                     {
                         
                         SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                         [alert addButton:@"Ok" actionBlock:^(void)
                          {
                              RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                              [self presentViewController:homeView animated:YES completion:nil];
                          }];
                         
                         [alert showCustom:self image:[UIImage imageNamed:@"logo2_witheyes_face.png"] color:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1] title:AppName subTitle:@"payment successful" closeButtonTitle:nil duration:0.0f];
                         
                         return ;
                         
                     }
                     
                 }];
             }
             
         }];
    }

    
}


@end
