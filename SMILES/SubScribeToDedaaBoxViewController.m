//
//  SubScribeToDedaaBoxViewController.m
//  DedaaBox
//
//  Created by BiipByte on 9/11/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "SubScribeToDedaaBoxViewController.h"



@interface SubScribeToDedaaBoxViewController ()

@end

@implementation SubScribeToDedaaBoxViewController

- (void)viewDidLoad
{
    [self navigationConfiguration];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)navigationConfiguration
{
    self.title=@"Subscription";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackClicked)];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
}
-(void)btnBackClicked
{
     [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnSubscribeToDedaaBoxClicked:(id)sender
{
    SubscriptionViewController *subScriptionClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionViewController"];
    [self.navigationController pushViewController:subScriptionClass animated:YES];
    
}
@end
