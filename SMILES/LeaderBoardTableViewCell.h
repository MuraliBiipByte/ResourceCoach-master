//
//  LeaderBoardTableViewCell.h
//  LeaderBoarde
//
//  Created by Admin on 27/09/1939 Saka.
//  Copyright © 1939 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgLeader;

@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
