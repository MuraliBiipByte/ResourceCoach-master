//
//  SettingsViewController.h
//  Resource Coach
//
//  Created by Admin on 08/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (nonatomic,assign) BOOL disablePanGesture;
@property (weak, nonatomic) IBOutlet UITableView *tblSettings;

@end
