//
//  ReportsTableViewCell.h
//  SMILES
//
//  Created by BiipByte on 06/03/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblSNo;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblManyTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeSpent;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

@end
