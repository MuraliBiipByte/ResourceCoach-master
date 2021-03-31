//
//  PrivacypolicyViewController.m
//  SMILES
//
//  Created by Biipmi on 2/11/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "PrivacypolicyViewController.h"
#import "Utility.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "APIDefineManager.h"

@interface PrivacypolicyViewController ()<UIWebViewDelegate>{
    __weak IBOutlet UIWebView *privacyWebview;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation PrivacypolicyViewController
@synthesize termsConditions,privacyPolicy;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [self configureNavigation];
    [self loadingWebviewUrl];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Navigation
-(void)configureNavigation{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    if ([privacyPolicy isEqualToString:@"PrivacyPolicy"]) {
        self.title=[Language TermsConditions];
    }
    else{/////
        //  self.title=[Language TermsConditions];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *language1=[defaults valueForKey:@"language"];
        if ([language1 isEqualToString:@"2"]) {
            //self.title=[Language TermsConditions];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            label.text = [Language TermsConditions];
            [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            self.navigationItem.titleView = view;
//            [self.navigationController.navigationBar setTitleTextAttributes:
//             @{NSForegroundColorAttributeName:[UIColor whiteColor],
//               NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
        }
        else if ([language1 isEqualToString:@"3"]){
            // self.title=@"နေအိမ်";
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            label.text = [Language TermsConditions];
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
            self.title=[Language TermsConditions];
            
            
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        }
        
        //////
        
    }
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(selectorBackToAboutus:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
}

-(void)loadingWebviewUrl
{
    
if ([privacyPolicy isEqualToString:@"PrivacyPolicy"])
    {
        [privacyWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL_Service,PRIVACY_POLICY_URL]]]];
    }
    else
    {
        
    [privacyWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL_Service,PRIVACY_POLICY_URL]]]];
    }
}

#pragma mark -Button Back Tapped
-(void)selectorBackToAboutus:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UIWebview delegate methods
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [self.loadingView startAnimation];
    [self.loadingView setHidden:YES];
    [self.img setHidden:YES];
}

@end
