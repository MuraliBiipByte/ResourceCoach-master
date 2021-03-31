//
//  MessageTableViewCell.h

//
//  Created by BiipByte on 14/06/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *useImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIView *contemtBackgroundView;

@end
