//
//  SplashScreenViewController.m
//  HygieneWatch
//
//  Created by Biipmi on 23/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "AppDelegate.h"
#import "IntroductionView.h"
#import <stdlib.h>

@interface SplashScreenViewController () <IntroductionViewDelegate>
{
    AppDelegate* appD;
}
@property IntroductionView *introView;

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"])
        {
    self.introView = [[IntroductionView alloc] initWithFrame:self.view.frame];
    self.introView.delegate = self;
    //self.introView.backgroundColor = [UIColor colorWithWhite:0.149 alpha:1.000];
    self.introView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.introView];
   
        }
    
    int r = arc4random_uniform(74);
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    [def setObject:[NSString stringWithFormat:@"%d",r] forKey:@"randomnumber"];
    
}

#pragma mark - ABCIntroViewDelegate Methods

-(void)onDoneButtonPressed{
    
    UIApplication *application = [UIApplication sharedApplication];
    [appD tooltipFlag:application];
}

-(void)skipPressed{
    UIApplication *application = [UIApplication sharedApplication];
    [appD tooltipFlag:application];
    
}


@end
