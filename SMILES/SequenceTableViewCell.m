//
//  SequenceTableViewCell.m
//  SMILES
//
//  Created by Biipmi on 10/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SequenceTableViewCell.h"

@implementation SequenceTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)prepareForReuse
{
    [super prepareForReuse];

}
@end
