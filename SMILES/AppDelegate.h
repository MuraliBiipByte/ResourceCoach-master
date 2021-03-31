//
//  AppDelegate.h
//  SMILES
//
//  Created by Biipmi on 6/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
-(void) tooltipFlag:(UIApplication *)application;

@end

