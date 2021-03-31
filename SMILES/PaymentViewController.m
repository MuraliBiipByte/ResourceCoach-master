//
//  PaymentViewController.m
//  DedaaBox
//
//  Created by BiipByte on 22/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "PaymentViewController.h"
#import "Utility.h"
#import "HYCircleLoadingView.h"
#import "APIDefineManager.h"

@interface PaymentViewController ()
{
    NSString *urlString;
    NSString *string;
    NSMutableDictionary *params;
    UIView *backGroundView;
    NSMutableString *randomString;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;


@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
   NSString * userID=[usercheckup valueForKey:@"id"];
    NSString *userName=[usercheckup valueForKey:@"name"];
    
    [self randomStringWithLength:6];
    
    NSString *refNumber=[NSString stringWithFormat:@"%@-%@",userID,randomString];
    params=[[NSMutableDictionary alloc]init];
    [params setObject:@"00959763587640" forKey:@"Destination"];
    [params setObject:self.amount forKey:@"Amount"];
    [params setObject:self.sourceNumber forKey:@"Source"];
    [params setObject:@"9DD150E602F04CDF" forKey:@"ApiKey"];
    [params setObject:userName
               forKey:@"MerchantName"];
    [params setObject:refNumber forKey:@"RefNumber"];
    [params setObject:@"ios" forKey:@"Environment"];
    [params setObject:_subscriptionId forKey:@"subscription_id"];

    
    
    NSMutableArray *keyValues = [NSMutableArray array];
    
    for (NSString *key in params)
    {
        [keyValues addObject:[NSString stringWithFormat:@"%@=%@&", key, params[key]]];
    }
    NSString *paramsString = [keyValues componentsJoinedByString:@"&"];
    paramsString = [paramsString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlString=[NSString stringWithFormat:@"%@%@",BASE_URL_Service,PaymentUrl];
    NSString *urlString1=[NSString stringWithFormat:@"%@?%@", urlString, paramsString];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString1]];
    
    [_paymentWebView loadRequest:request];
    
 
    
    //http://54.251.120.210/DedaaBox_dev/index.php/payment
    
}
-(NSString *) randomStringWithLength: (int) len
{
     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
   randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    self.title=@"Payment";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
}
#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
   
    backGroundView.hidden=YES;
    [self.loadingView stopAnimation];
    [self.loadingView setHidden:YES];
    [self.img setHidden:YES];
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];

}

@end
