//
//  TrainersCollectionViewCell.m
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "TrainersCollectionViewCell.h"

@implementation TrainersCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imgBigProfile.layer.cornerRadius = self.imgBigProfile.frame.size.height /2;
    self.imgBigProfile.layer.masksToBounds = YES;

}

@end
