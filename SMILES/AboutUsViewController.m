//
//  AboutUsViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "AboutUsViewController.h"
#import "REFrostedViewController.h"
#import "PrivacypolicyViewController.h"
#import "Language.h"
#import "ViewController.h"
#import "APIManager.h"
#import "RootViewController.h"
#import "UIViewController+MaryPopin.h"
#import "Utility.h"

@interface AboutUsViewController ()
{
    __weak IBOutlet UIView *logoBgView;
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet UILabel *lblTitle1;
    __weak IBOutlet UILabel *lblTitle2;
    __weak IBOutlet UILabel *lblSubTitle;
    __weak IBOutlet UILabel *lblEmailUs;
    __weak IBOutlet UIButton *btnTermsConditions;
    __weak IBOutlet UIButton *btnPrivacyPolicy;
    __weak IBOutlet UILabel *lblCopyRight;
    __weak IBOutlet UILabel *lblAllRights;
    __weak IBOutlet UILabel *lblSecurity;
     NSString *uID,*UserType;
    CGRect orginalFrame;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (weak, nonatomic) IBOutlet UIButton *btnSendFeedback;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
    lblSubTitle.text=[Language DedaaBox];
    lblEmailUs.text=[Language EmailusAboutUs];
    [btnTermsConditions setTitle:[Language TermsConditions] forState:UIControlStateNormal];
    lblCopyRight.text=[Language Copyrights2016xprienzSMILES];
    lblAllRights.text=[Language AllRightsReserved];
    lblSecurity.text=[Language DisclaimerDesignConceptLogoAreCopyrightOfxprienzSMILES];
    
    _queryView.layer.cornerRadius=5;
    _queryView.layer.masksToBounds=YES;

    _queryView.layer.shadowColor = [UIColor grayColor].CGColor;
    _queryView.layer.shadowOffset = CGSizeZero;
    _queryView.layer.masksToBounds = NO;
    _queryView.layer.shadowRadius = 4.0f;
    _queryView.layer.shadowOpacity = 1.0;
    _btnSubmit.layer.cornerRadius=10;
    _btnSubmit.layer.masksToBounds=YES;
    
    _txtEnterQuery.layer.cornerRadius=5;
    _txtEnterQuery.layer.masksToBounds=YES;
    
    _queryEnterView.layer.cornerRadius=20;
    _queryEnterView.layer.masksToBounds=YES;
    
    _btnNumber.layer.cornerRadius=3;
    _btnNumber.layer.masksToBounds=YES;

   
    
    
    _btnPopupHiden.hidden=YES;
    _queryView.hidden=YES;
    orginalFrame=self.view.frame;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
   // [self checkUserType];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHides:) name:UIKeyboardWillHideNotification object:nil];

    
}

#pragma mark - keyboard movements
- (void)keyboardWillShows:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height/3;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHides:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = orginalFrame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
       // self.title=[Language aboutUs];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language aboutUs];
        ;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
//        [self.navigationController.navigationBar setTitleTextAttributes:
//         @{NSForegroundColorAttributeName:[UIColor whiteColor],
//           NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    }
    else if ([language1 isEqualToString:@"3"])
    
    {
        // self.title=@"နေအိမ်";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language aboutUs];
        ;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        //        [self.navigationController.navigationBar setTitleTextAttributes:
        //         @{NSForegroundColorAttributeName:[UIColor whiteColor],
        //           NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Bold" size:12]}];
    }
    else{
        self.title=[Language aboutUs];
        ;
        
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }
    

    
    
}

#pragma mark -Button Menu Tapped
- (IBAction)btnMenuTapped:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture) {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

#pragma mark -Button TermsConditions Tapped
- (IBAction)btnTermsConditionsTapped:(id)sender {
    PrivacypolicyViewController *terms=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacypolicyViewController"];
    terms.privacyPolicy=@"TermsConditions";
    [self.navigationController pushViewController:terms animated:YES];
}

#pragma mark -Button PrivacyPolicy Tapped
- (IBAction)btnPrivacyPolicyTapped:(id)sender {
//    PrivacypolicyViewController *privacy=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacypolicyViewController"];
//     privacy.privacyPolicy=@"PrivacyPolicy";
//    [self.navigationController pushViewController:privacy animated:YES];
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
- (IBAction)btnSendFeedBack:(id)sender
{
    [self.view endEditing:YES];
    _btnPopupHiden.hidden=NO;
    _queryView.hidden=NO;
    
  
}
- (IBAction)btnCallTapped:(id)sender {
    [self.view endEditing:YES];
       NSString *mobileSpaces = @"+959970500857";
        NSString *stringWithoutSpaces = [mobileSpaces
                                     stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",stringWithoutSpaces]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else{
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:AppName message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
    

}
- (IBAction)btnPopupHidenTapped:(id)sender
{
    [self.view endEditing:YES];
    _txtEnterQuery.text=@"";
    _queryView.hidden=YES;
    _btnPopupHiden.hidden=YES;
}
- (IBAction)btnSubmitTapped:(id)sender
{
    
    [self.view endEditing:YES];
    if ([_txtEnterQuery.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:AppName message:@"Please Enter Feedback" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        [Utility showLoading:self];
        [[APIManager sharedInstance]sendQueryWithUserId:uID andwithQuey:_txtEnterQuery.text andCompleteBlock:^(BOOL success, id result) {
            [Utility hideLoading:self];
            if (!success) {
                return ;
            }
            else{
                NSInteger status=[[result valueForKey:@"status"]integerValue];
                if (status==1)
                {
                    _txtEnterQuery.text=@"";
                    _queryView.hidden=YES;
                    _btnPopupHiden.hidden=YES;
                  
                }
                else{
                    [Utility showAlert:AppName withMessage:@"Try Again"];
                }
            }
        }];
    }
}

@end
