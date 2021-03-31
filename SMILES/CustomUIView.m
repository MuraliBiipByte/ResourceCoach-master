//
//  CustomUIView.m
//  FoodApp
//
//  Created by Hoang Le Huy on 7/7/15.
//  Copyright (c) 2015 Hoang Le Huy. All rights reserved.
//

#import "CustomUIView.h"
#import "Utility.h"

@implementation CustomUIView

- (void)awakeFromNib
{
    [super awakeFromNib];
    CGRect rect = self.bounds;
    NSLog(@"a : %f",[Utility scaleiPhone6Plus]);
    rect.origin.x *= [Utility scaleiPhone6Plus];
    rect.origin.y *= [Utility scaleiPhone6Plus];
    rect.size.width *= [Utility scaleiPhone6Plus];
    rect.size.height *= [Utility scaleiPhone6Plus];
    self.bounds = rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
