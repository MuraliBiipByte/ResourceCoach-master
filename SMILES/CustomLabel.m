//
//  CustomLabel.m
//  FoodApp
//
//  Created by Hoang Le Huy on 7/7/15.
//  Copyright (c) 2015 Hoang Le Huy. All rights reserved.
//

#import "CustomLabel.h"
#import "Utility.h"

@implementation CustomLabel
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setFont:[UIFont fontWithName:self.font.fontName size:self.font.pointSize * [Utility scaleiPhone6Plus]]];
}
@end
