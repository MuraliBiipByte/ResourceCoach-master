//
//  UserGuideViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "UserGuideViewController.h"
#import "ABCIntroView.h"
#import "REFrostedViewController.h"
#import "Language.h"

#import "APIManager.h"
#import "ViewController.h"
#import "RootViewController.h"
@interface UserGuideViewController ()<ABCIntroViewDelegate>
{
      NSString *uID,*UserType;
}
@property ABCIntroView *introView;
@property (nonatomic,assign) BOOL disablePanGesture;


@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
    self.introView.delegate = self;
    self.introView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.introView];
    
    [self navigationConfiguration];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
   // [self checkUserType];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Configuration

-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
      //  self.title=[Language UserGuide];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language UserGuide];
        ;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }
    else if ([language1 isEqualToString:@"3"]){
        // self.title=@"နေအိမ်";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language UserGuide];
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
    else
    {
    self.title=[Language UserGuide];
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }
    

  
}


#pragma mark - ABCIntroViewDelegate Methods

-(void)onDoneButtonPressed{
}

-(void)skipPressed{
}
- (IBAction)btnTapped:(id)sender {
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

@end
