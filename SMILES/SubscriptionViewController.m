//
//  SubscriptionViewController.m
//  DedaaBox
//
//  Created by BiipByte on 20/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "Language.h"
#import "Utility.h"
#import "APIManager.h"
#import "REFrostedViewController.h"
#import "HYCircleLoadingView.h"
#import "HomeViewController.h"
#import "PaymentListViewController.h"
#import "RootViewController.h"

#import "UIViewController+ENPopUp.h"
#import "UIViewController+MaryPopin.h"

#import "ArticlesViewController.h"

@interface SubscriptionViewController ()<UITextFieldDelegate>
{
    
    CGRect originalViewFraame;
    UIView *backGroundView;
    NSString *userID;
    NSString* subscribeFlag,*scratchCardFlag,*couponCodeFlag;
    UIButton *btnScratchCard;
    NSString *strSubscriptionIdentify;
    NSString *UserType;
    CGRect orginalFrame;
}
@property (weak, nonatomic) IBOutlet UIView *paymentOptionsView;
@property (weak, nonatomic) IBOutlet UIButton *btnDoyouhaveCoupon;
@property (weak, nonatomic) IBOutlet UILabel *lblOr;

@property (weak, nonatomic) IBOutlet UIButton *btnSubscribe;
@property (weak, nonatomic) IBOutlet UILabel *lblCouponValidtyDetails;
@property (weak, nonatomic) IBOutlet UIImageView *ingCoupon;


@property (weak, nonatomic) IBOutlet UILabel *lblComingSoon;


//Boolean


@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *coupunfieldsView;
@property (weak, nonatomic) IBOutlet UILabel *lblSuccessTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCouonSuccessMeg;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UIImageView *imgSuccessBackGrounImg;
@property (weak, nonatomic) IBOutlet UIView *successContentView;

@end

@implementation SubscriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    _viewPromoCode.hidden=YES;
    _viewScratchCard.hidden=YES;
    _viewSuccess.hidden=YES;
    _btnPopupHiden.hidden=YES;
    
    orginalFrame=self.view.frame;
    
    _txtCopounCode.layer.cornerRadius=4;
    _txtCopounCode.layer.masksToBounds=YES;
    _btnCouponApply.layer.cornerRadius=2;
    _btnCouponApply.layer.masksToBounds=YES;
    
    
    _txtScratchCardCode.layer.cornerRadius=4;
    _txtScratchCardCode.layer.masksToBounds=YES;
    _btnScratchCardApply.layer.cornerRadius=2;
    _btnScratchCardApply.layer.masksToBounds=YES;
    

    
    _btnSubscribe.layer.cornerRadius=2;
    _btnSubscribe.layer.masksToBounds=YES;
    _btnDoyouhaveCoupon.titleLabel.numberOfLines=4;
    
    [_btnDoyouhaveCoupon setTitle:@"Have Promo Code?Apply" forState:UIControlStateNormal];
//    _btnDoyouhaveCoupon.backgroundColor=[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1];
    
    _paymentOptionsView.layer.cornerRadius=10;
    _paymentOptionsView.layer.masksToBounds=YES;
    
    _paymentOptionsView.layer.shadowColor = [UIColor grayColor].CGColor; 
    _paymentOptionsView.layer.shadowOffset = CGSizeZero;
    _paymentOptionsView.layer.masksToBounds = NO;
    _paymentOptionsView.layer.shadowRadius = 4.0f;
    _paymentOptionsView.layer.shadowOpacity = 1.0;
    
    _coupunfieldsView.hidden=YES;
    _lblCouponValidtyDetails.hidden=YES;
    
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    
    
    
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    
    _successContentView.hidden=YES;
    //_imgSuccessBackGrounImg.hidden=YES;
    
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
    [self navigationConfiguration];
    originalViewFraame=self.view.frame;
    _lblComingSoon.hidden=YES;
   
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    self.title=@"Subscription";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    userID=[usercheckup valueForKey:@"id"];
    [self checkingSUbscriptionType] ;
    
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
-(void)checkUserType
{
    
    [[APIManager sharedInstance]checkingUserType:userID andCompleteBlock:^(BOOL success, id result)
     {
         NSLog(@"%@",result);
         if (!success)
         {
             return ;
         }
         else
         {
             NSDictionary *userdata=[result valueForKey:@"userdata"];
             NSString *type=[userdata valueForKey:@"usertype"];
             NSString *userIds=[userdata valueForKey:@"user_id"];
             NSString *userName=[userdata valueForKey:@"username"];
             
             
             if (![UserType isEqualToString:type] ) {
                 
               
                 NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:type forKey:@"usertype"];
                 RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                 [self presentViewController:homeView animated:YES completion:nil];
                 
                
             }
             
         }
     }];
}


#pragma mark - keyboard movements

-(void)checkingSUbscriptionType
{
    [Utility showLoading:self];
    
    [[APIManager sharedInstance]subscriptionTypeCheckingwithUserId:userID andCompleteBlock:^(BOOL success, id result)
    {
        [Utility hideLoading:self];
        if(!success)
        {
            return ;
        }
        else
        {
            subscribeFlag=[NSString stringWithFormat:@"%@",[result valueForKey:@"subscribe_flag"]];
            scratchCardFlag=[NSString stringWithFormat:@"%@",[result valueForKey:@"scratchcard_flag"]];
            couponCodeFlag=[NSString stringWithFormat:@"%@",[result valueForKey:@"coupon_flag"]];
            
            if([subscribeFlag isEqualToString:@"1"]||[scratchCardFlag isEqualToString:@"1"])
            {
                _btnDoyouhaveCoupon.enabled=NO;
                [_btnDoyouhaveCoupon setBackgroundColor:[UIColor lightGrayColor]];
            }
            else
            {
                _btnDoyouhaveCoupon.enabled=YES;
                [_btnDoyouhaveCoupon setBackgroundColor:[UIColor colorWithRed:65.0/255.0 green:112.0/255.0 blue:182.0/255.0 alpha:1]];
            }
            
        }
    }];
}
- (IBAction)btnCouponCodeTapped:(id)sender
{
    _viewPromoCode.hidden=NO;
    _btnPopupHiden.hidden=NO;
    [_btnPopupHiden setEnabled:YES];
    _viewScratchCard.hidden=YES;
    self.navigationItem.leftBarButtonItem.enabled=NO;

}
- (IBAction)btnSubscribeTapped:(id)sender
{
   PaymentListViewController *payment=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentListViewController"];
    
    [self.navigationController pushViewController:payment animated:YES];
    
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
- (IBAction)btnScratchCardTapped:(id)sender
{
    _viewPromoCode.hidden=YES;
    _viewScratchCard.hidden=NO;
    _btnPopupHiden.hidden=NO;
    [_btnPopupHiden setEnabled:YES];
    self.navigationItem.leftBarButtonItem.enabled=NO;
   
    
}
- (IBAction)btnCrossClicked:(id)sender
{
    
    [self.view endEditing:YES];
    self.navigationItem.leftBarButtonItem.enabled=YES;
    _viewScratchCard.hidden=YES;
    _viewPromoCode.hidden=YES;
    _btnPopupHiden.hidden=YES;
    _txtCopounCode.text=nil;
    _lblCouponCodeWrong.text=nil;
    _txtScratchCardCode.text=nil;
    _lblScratchCodeWrong.text=nil;
}
- (IBAction)btnCouponApplyTapped:(id)sender
{
    
    [[APIManager sharedInstance]verifyPromoCode:userID withPromocode:_txtCopounCode.text andCompleteBlock:^(BOOL success, id result)
     {
         
         if (!success)
         {
             _lblCouponCodeWrong.text=result;
             _lblCouponCodeWrong.hidden=NO;
             [_btnPopupHiden setEnabled:YES];
             _viewSuccess.hidden=YES;
             return ;
         }
         else
         {
             
            NSLog(@"Result is %@",result);
             NSMutableArray *data=[result valueForKey:@"data"];
             NSString *successMessage=[result valueForKey:@"message"];
             
             NSMutableDictionary *userData=[data valueForKey:@"userdata"];
             NSString *usertype=[userData valueForKey:@"usertype"];
             NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
             [userDefaults setObject:usertype forKey:@"usertype"];
             [_btnPopupHiden setEnabled:NO];
             _lblCouponCodeWrong.hidden=YES;
             _viewSuccess.hidden=NO;
              [_viewPromoCode setHidden:YES];
             [_btnSubscribe setEnabled:NO];
             [self.view endEditing:YES];
             _lblCouonSuccessMeg.text=successMessage;
             
         }
     }];
}

- (IBAction)btnScratchCardApplyTapped:(id)sender
{
   
        [[APIManager sharedInstance]scratchCartdValidatewithUserId:userID andwithScratchCard:_txtScratchCardCode.text andCompleteBlock:^(BOOL success, id result)
         {
             
             if (!success)
             {
                 _lblScratchCodeWrong.text=result;
                 _lblScratchCodeWrong.hidden=NO;
                 _viewSuccess.hidden=YES;
                 [_btnPopupHiden setEnabled:YES];
                 return ;
             }
             else
             {
                 
                 
                 
                 NSLog(@"Result is %@",result);
                 NSMutableArray *data=[result valueForKey:@"data"];
                 NSString *successMessage=[result valueForKey:@"message"];
                 
                 NSMutableDictionary *userData=[data valueForKey:@"userdata"];
                 NSString *usertype=[userData valueForKey:@"usertype"];
                 NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:usertype forKey:@"usertype"];
                 _viewSuccess.hidden=NO;
                 [_viewScratchCard setHidden:YES];
                 [self.view endEditing:YES];
                 [_btnPopupHiden setEnabled:NO];
                 [_btnSubscribe setEnabled:NO];
                 _lblScratchCodeWrong.hidden=YES;
                 _lblCouonSuccessMeg.text=successMessage;
             }
         }];
 
    }
        

- (IBAction)btnOkTappedAftersuccess:(id)sender
{
    
//    HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:home animated:YES];
    
    ArticlesViewController *vcObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    [self.navigationController pushViewController:vcObj animated:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==_txtCopounCode)
    {
        NSString *str=[_txtCopounCode.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([str length]>10)
        {
            
            return NO;
            
        }
    }
    if (textField==_txtScratchCardCode)
    {
    NSString *str=[_txtScratchCardCode.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([str length]>8)
        {
            
            return NO;
        }
    }

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnPopupHidenTapped:(id)sender
{
    
    [self.view endEditing:YES];
    _viewScratchCard.hidden=YES;
    _viewPromoCode.hidden=YES;
    _btnPopupHiden.hidden=YES;
    _txtCopounCode.text=nil;
    _lblCouponCodeWrong.text=nil;
    _txtScratchCardCode.text=nil;
    _lblScratchCodeWrong.text=nil;
    self.navigationItem.leftBarButtonItem.enabled=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.navigationItem.leftBarButtonItem.enabled=NO;
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
