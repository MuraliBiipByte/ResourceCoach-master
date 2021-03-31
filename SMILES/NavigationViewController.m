//
//  NavigationViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController (){
    NavigationViewController*nav;
}

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Gesture recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController panGestureRecognized:sender];
}
- (void)showMenu{
}

@end
