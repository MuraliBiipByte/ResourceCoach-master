//
//  CreateGroupViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "REFrostedViewController.h"

@interface CreateGroupViewController ()
@property (nonatomic,assign) BOOL disablePanGesture;

@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    self.title=@"Create Group";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:20]}];
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

@end
