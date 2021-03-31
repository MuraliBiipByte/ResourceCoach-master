//
//  TrainersTableViewCell.m
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "TrainersTableViewCell.h"

@implementation TrainersTableViewCell

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.imgSmallProfile.layer.cornerRadius = self.imgSmallProfile.frame.size.height /2;
    self.imgSmallProfile.layer.masksToBounds = YES;
    
    self.lblBackground.layer.cornerRadius=5.0f;
    self.lblBackground.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
