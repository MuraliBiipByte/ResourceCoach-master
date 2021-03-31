//
//  BankAccountViewController.m
//  DedaaBox
//
//  Created by BiipByte on 10/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "BankAccountViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "HomeViewController.h"

@interface BankAccountViewController ()
{
    NSMutableDictionary *bankDetails;
}

@end

@implementation BankAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _accountView.layer.shadowColor = [UIColor grayColor].CGColor;
    _accountView.layer.shadowOffset = CGSizeZero;
    _accountView.layer.masksToBounds = NO;
    _accountView.layer.shadowRadius = 4.0f;
    _accountView.layer.shadowOpacity = 1.0;
    
    _accountNumbersView.layer.shadowColor = [UIColor grayColor].CGColor;
    _accountNumbersView.layer.shadowOffset = CGSizeZero;
    _accountNumbersView.layer.masksToBounds = NO;
    _accountNumbersView.layer.shadowRadius = 4.0f;
    _accountNumbersView.layer.shadowOpacity = 1.0;
    _btnDone.layer.cornerRadius=10;
    _btnDone.layer.masksToBounds=YES;
    [self navigationConfiguration];
    [self getBankDetails];
    
    
    
    CGSize constraintToCollect = CGSizeMake(_lblTocollectCertificate.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contextToCollect = [[NSStringDrawingContext alloc] init];
    CGSize boundingToCollect = [_lblTocollectCertificate.text boundingRectWithSize:constraintToCollect
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:_lblTocollectCertificate.font}
                                                              context:contextToCollect].size;
    
    CGSize sizelblToCollect = CGSizeMake(ceil(boundingToCollect.width), ceil(boundingToCollect.height));
    NSLog(@"sizeViews label hight is %f",sizelblToCollect.height);
   
//    _option1ViewHight.constant=option1ViewDynamicHeight;
//    _option1ViewHight.active=YES;
    
    CGSize constraintAccName = CGSizeMake(_lblAccountHolderNmae.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contextAccName = [[NSStringDrawingContext alloc] init];
    CGSize boundingAccName= [_lblAccountHolderNmae.text boundingRectWithSize:constraintAccName
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:_lblAccountHolderNmae.font}
                                                          context:contextAccName].size;
    
    CGSize sizelblAccName = CGSizeMake(ceil(boundingAccName.width), ceil(boundingAccName.height));
    NSLog(@"sizeViews label hight is %f",sizelblAccName.height);

    
    
    CGSize constraintAcc1 = CGSizeMake(_lblAccount1.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contextAcc1 = [[NSStringDrawingContext alloc] init];
    CGSize boundingAcc1 = [_lblAccount1.text boundingRectWithSize:constraintAcc1
                                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                                        attributes:@{NSFontAttributeName:_lblAccount1.font}
                                                                           context:contextAcc1].size;
    
    CGSize sizelblAcc1 = CGSizeMake(ceil(boundingAcc1.width), ceil(boundingAcc1.height));
    NSLog(@"sizeViews label hight is %f",sizelblAcc1.height);
    //    _option1ViewHight.constant=option1ViewDynamicHeight;
    //    _option1ViewHight.active=YES;
    
    
    
    
    CGSize constraintAcc2 = CGSizeMake(_lblAccount2.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contextAcc2 = [[NSStringDrawingContext alloc] init];
    CGSize boundingAcc2 = [_lblAccount2.text boundingRectWithSize:constraintAcc2
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:_lblAccount2.font}
                                                          context:contextAcc2].size;
    
    CGSize sizelblAcc2 = CGSizeMake(ceil(boundingAcc2.width), ceil(boundingAcc2.height));
    NSLog(@"sizeViews label hight is %f",sizelblAcc2.height);
    //    _option1ViewHight.constant=option1ViewDynamicHeight;
    //    _option1ViewHight.active=YES;

    CGSize constraintAcc3 = CGSizeMake(_lblAccount3.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contextAcc3 = [[NSStringDrawingContext alloc] init];
    CGSize boundingAcc3 = [_lblAccount3.text boundingRectWithSize:constraintAcc3                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:_lblAccount3.font}
                                                          context:contextAcc3].size;
    
    CGSize sizelblAcc3 = CGSizeMake(ceil(boundingAcc1.width), ceil(boundingAcc3.height));
    NSLog(@"sizeViews label hight is %f",sizelblAcc3.height);
    //    _option1ViewHight.constant=option1ViewDynamicHeight;
    //    _option1ViewHight.active=YES;
    
    
    CGSize constraintCall = CGSizeMake(_lblCallCustomer.frame.size.width, CGFLOAT_MAX);
    
    
    NSStringDrawingContext *contexCall = [[NSStringDrawingContext alloc] init];
    CGSize boundingCall = [_lblCallCustomer.text boundingRectWithSize:constraintCall
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:_lblCallCustomer.font}
                                                          context:contexCall].size;
    
    CGSize sizelblCall = CGSizeMake(ceil(boundingCall.width), ceil(boundingCall.height));
    NSLog(@"sizeViews label hight is %f",sizelblCall.height);
    
    NSInteger hightDetails=130+sizelblAcc1.height+sizelblAcc2.height+sizelblAcc3.height+sizelblAccName.height;
    
        _accountDetailsHight.constant=hightDetails;
        _accountDetailsHight.active=YES;
    
    NSInteger totalHight=hightDetails+120+sizelblToCollect.height+sizelblCall.height;
    _accountViewHight.constant=totalHight;
    _accountViewHight.active=YES;
    
    
    

    
    
    

    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getBankDetails
{
    [Utility showLoading:self];
    [[APIManager sharedInstance]bankAccDetails:^(BOOL success, id result) {
        [Utility hideLoading:self];
        if (!success)
        {
            return ;
        }
        else
        {
            bankDetails=[result valueForKey:@"bank_info"];
            NSString *acc1=[bankDetails valueForKey:@"bank1"];
             NSString *acc2=[bankDetails valueForKey:@"bank2"];
             NSString *acc3=[bankDetails valueForKey:@"bank3"];
            _lblAccount1.text=[acc1 stringByAppendingString:[NSString stringWithFormat:@" : %@",[bankDetails valueForKey:@"account1"]]];
             _lblAccount2.text=[acc2 stringByAppendingString:[NSString stringWithFormat:@" : %@",[bankDetails valueForKey:@"account2"]]];
             _lblAccount3.text=[acc3 stringByAppendingString:[NSString stringWithFormat:@" : %@",[bankDetails valueForKey:@"account3"]]];
            _lblAccountHolderNmae.text=[bankDetails valueForKey:@"account_holder_name"];
            _lblTocollectCertificate.text=[bankDetails valueForKey:@"amount"];
            [_btnCall setTitle:[bankDetails valueForKey:@"helpline"] forState:UIControlStateNormal];
            
            
        }
    }];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    self.title=@"Bank Details";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCallTapped:(id)sender {
    NSString *mobile=[bankDetails valueForKey:@"helpline"];
    NSArray* foo = [mobile componentsSeparatedByString: @" "];
    NSString *str0=[foo objectAtIndex:0];
    NSString *str1=[foo objectAtIndex:1];
    
    
    NSString *mobileSpaces = [str0 stringByAppendingString:str1];
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
- (IBAction)btnDoneTapped:(id)sender {
    HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController  pushViewController:home animated:YES];
}

@end
