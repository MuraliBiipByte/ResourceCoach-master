//
//  MenuTableViewCell.h
//  SMILES
//
//  Created by Biipmi on 16/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblMenuTitle;
//Settings Object
@property (weak, nonatomic) IBOutlet UILabel *lblPermission;
@property (weak, nonatomic) IBOutlet UISwitch *btnSwitch;
//Cell2 ...
@property (weak, nonatomic) IBOutlet UILabel *lblCell2SettingsPermissions;
@property (weak, nonatomic) IBOutlet UIImageView *lblCell2Arrow;

//Intrested categories
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;



@end
