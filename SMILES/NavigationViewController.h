//
//  NavigationViewController.h
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface NavigationViewController : UINavigationController
@property (nonatomic,assign) BOOL disablePanGesture;
- (void)showMenu;
@end
