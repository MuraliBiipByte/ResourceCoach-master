//
//  PaymentListViewController.m
//  DedaaBox
//
//  Created by BiipByte on 21/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "PaymentListViewController.h"
#import "PaymentListTableViewCell.h"
#import "PaymentViewController.h"
#import "HYCircleLoadingView.h"
#import "REFrostedViewController.h"
#import "Language.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "UIViewController+ENPopUp.h"
#import "UIViewController+MaryPopin.h"
#import "StripePaymentViewController.h"

@interface PaymentListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *arrSubscriptionName,*arrSubscriptionDuration,*arrAmount,*arrDescription,*arrIds;
    PaymentListTableViewCell *paymentListCell;
    UIView *backGroundView;
    UIRefreshControl *refreshControl;
    NSString *strMobileNumber;
    NSString *strSubscriptionId;
    NSString *strAmount;
    CGRect orginalFrame;
    StripePaymentViewController *stripePaymentClass;
    
  
}
@property (weak, nonatomic) IBOutlet UITableView *tblPaymentList;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
//Boolean
@property (nonatomic,assign) BOOL disablePanGesture;

@end

@implementation PaymentListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _viewMobilenumber.hidden=YES;
    _btnPopupHiden.hidden=YES;
    orginalFrame=self.view.frame;
    
    arrSubscriptionName=[[NSMutableArray alloc]init];
    arrSubscriptionDuration=[[NSMutableArray alloc]init];
    arrAmount=[[NSMutableArray alloc]init];
    
    arrDescription=[[NSMutableArray alloc]init];
    arrIds=[[NSMutableArray alloc]init];
    _tblPaymentList.separatorStyle=UISemanticContentAttributeUnspecified;
    _tblPaymentList.layer.cornerRadius=5;
    _tblPaymentList.layer.masksToBounds=YES;
    _tblPaymentList.backgroundColor=[UIColor whiteColor];
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(subscriptionList) forControlEvents:UIControlEventValueChanged];[_tblPaymentList addSubview:refreshControl];
    
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
    
    stripePaymentClass=[[StripePaymentViewController alloc]init];
    stripePaymentClass=[self.storyboard instantiateViewControllerWithIdentifier:@"StripePaymentViewController"];


    [self navigationConfiguration];
    [self subscriptionList];
    
    
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    self.title=[Language Subscribe];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma subscription list
-(void)subscriptionList
{
    [Utility showLoading:self];
    [[APIManager sharedInstance]subscrptionList:^(BOOL success, id result)
    {
        [Utility hideLoading:self];
           [refreshControl endRefreshing];
        if (!success)
        {
        NSString *strMessage=[result objectForKey:@"message"];
        [Utility showAlert:AppName withMessage:strMessage];
            return ;
        }
        else
        {
            NSMutableArray *arrSubscription=[result valueForKey:@"subscription_list"];
            arrIds=[arrSubscription valueForKey:@"id"];
            arrAmount=[arrSubscription valueForKey:@"price"];
            arrDescription=[arrSubscription valueForKey:@"description"];
            arrSubscriptionDuration=[arrSubscription valueForKey:@"validity"];
            arrSubscriptionName=[arrSubscription valueForKey:@"name"];
            [_tblPaymentList reloadData];
            
            
        }
    }];
    
}
#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSubscriptionName count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    paymentListCell = (PaymentListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentListTableViewCell"];
    paymentListCell.payListView.layer.cornerRadius=5;
    paymentListCell.payListView.layer.masksToBounds=YES;
    
    
    paymentListCell.payListView.layer.shadowColor = [UIColor grayColor].CGColor;
    paymentListCell.payListView.layer.shadowOffset = CGSizeZero;
    paymentListCell.payListView.layer.masksToBounds = NO;
    paymentListCell.payListView.layer.shadowRadius = 4.0f;
    paymentListCell.payListView.layer.shadowOpacity = 1.0;
    if (paymentListCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PaymentListTableViewCell" owner:self options:nil];
        paymentListCell = [nib objectAtIndex:0];
    }
    paymentListCell.contentView.layer.cornerRadius=5;
    paymentListCell.contentView.layer.masksToBounds=YES;
    
    NSString *strSubscriptionName=[arrSubscriptionName objectAtIndex:indexPath.row];
    
    if ([strSubscriptionName isEqual:[NSNull null]])
    {
        NSLog(@"No subscriptions Available");
    }
    else
    {
        paymentListCell.lblSubscriptionName.text=[arrSubscriptionName objectAtIndex:indexPath.row];
        paymentListCell.lblSubscriptionDuration.text=[arrSubscriptionDuration objectAtIndex:indexPath.row];
        paymentListCell.lblPrice.text=[arrAmount objectAtIndex:indexPath.row];
        [paymentListCell.btnPay setTitle:@"Pay" forState:UIControlStateNormal];
    }
    return paymentListCell;
   }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _viewMobilenumber.hidden=YES;
    _txtMobileNumber.text=nil;
    _btnPopupHiden.hidden=YES;
    strSubscriptionId=[arrIds objectAtIndex:indexPath.row];
    strAmount=[arrAmount objectAtIndex:indexPath.row];
    
    stripePaymentClass.totalAmount=strAmount;
    stripePaymentClass.subscriptionID=strSubscriptionId;
    
    [self.navigationController pushViewController:stripePaymentClass animated:YES];
    
    self.navigationItem.leftBarButtonItem.enabled=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    _viewMobilenumber.hidden=YES;
    _btnPopupHiden.hidden=YES;
    self.navigationItem.leftBarButtonItem.enabled=YES;
    [super viewWillAppear:animated];
}



-(IBAction)payButtonClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblPaymentList];
     NSIndexPath *indexPath = [self.tblPaymentList indexPathForRowAtPoint:buttonPosition];
    strSubscriptionId=[arrIds objectAtIndex:indexPath.row];
    strAmount=[arrAmount objectAtIndex:indexPath.row];
    
    stripePaymentClass.totalAmount=strAmount;
    stripePaymentClass.subscriptionID=strSubscriptionId;
    [self.navigationController pushViewController:stripePaymentClass animated:YES];
    self.navigationItem.leftBarButtonItem.enabled=NO;
    _txtMobileNumber.text=nil;
    _viewMobilenumber.hidden=YES;
    _btnPopupHiden.hidden=YES;
}
-(IBAction)btnSubmitClicked:(id)sender
{
    if (_txtMobileNumber.text.length==0)
    {
       _lblMobilenumberWrong.text=[Language MobileNumbercannotbeempty];
        [_lblMobilenumberWrong setHidden:NO];
    }
    else
    {
        strMobileNumber=_txtMobileNumber.text;
        PaymentViewController *paymnet=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        paymnet.subscriptionId=strSubscriptionId;
        paymnet.amount=strAmount;
        strMobileNumber=_txtMobileNumber.text;
        paymnet.sourceNumber=strMobileNumber;
        [self.navigationController pushViewController:paymnet animated:YES];
        [_lblMobilenumberWrong setHidden:YES];
        [self.view endEditing:YES];
    }
    
}
- (IBAction)btnCrossClicked:(id)sender
{
    _txtMobileNumber.text=nil;
    _viewMobilenumber.hidden=YES;
    _btnPopupHiden.hidden=YES;
    self.navigationItem.leftBarButtonItem.enabled=YES;
    [self.view endEditing:YES];
}

- (IBAction)btnPopupHidenTapped:(id)sender
{
    [self.view endEditing:YES];
    _txtMobileNumber.text=nil;
    _viewMobilenumber.hidden=YES;
    _btnPopupHiden.hidden=YES;
    self.navigationItem.leftBarButtonItem.enabled=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
