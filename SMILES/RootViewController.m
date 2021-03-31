//
//  RootViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuListViewController"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}


@end
