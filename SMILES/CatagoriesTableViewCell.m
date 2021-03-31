//
//  CatagoriesTableViewCell.m
//  DedaaBox
//
//  Created by BiipByte on 01/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "CatagoriesTableViewCell.h"

@implementation CatagoriesTableViewCell

- (void)awakeFromNib
{
    _catagoriesArticleImg.layer.cornerRadius=4.0f;
    _catagoriesArticleImg.layer.masksToBounds=YES;
    _lblcatagoriesOverlay.layer.cornerRadius=4.0f;
    _lblcatagoriesOverlay.layer.masksToBounds=YES;
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
