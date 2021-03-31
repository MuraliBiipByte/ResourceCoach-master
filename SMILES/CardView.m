//
//  CardView.m
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.frame = CGRectMake(0,25, self.frame.size.width, self.frame.size.height /2);
    [self addSubview:_imageView];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(7.0, 7.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
    
    _selectedView = [[UIView alloc]init];
    _selectedView.frame = _imageView.frame;
    _selectedView.backgroundColor = [UIColor clearColor];
    _selectedView.alpha = 0.0;
    [_imageView addSubview:_selectedView];
    
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor clearColor];
    _label.frame = CGRectMake(8, self.frame.size.height * 0.55, self.frame.size.width - 20,40);
    _label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    //[_label setBackgroundColor:[UIColor blueColor]];
    [self addSubview:_label];
    
    self.authorName = [[UILabel alloc]init];
    self.authorName.backgroundColor = [UIColor clearColor];
    self.authorName.frame = CGRectMake(8, 0, self.frame.size.width, 30);
    self.authorName.font = [UIFont fontWithName:@"Helvetica" size:12];
    [self addSubview:self.authorName];
    
    self.shortDescription = [[UITextView alloc]init];
    [self.shortDescription setScrollEnabled:NO];
    [self.shortDescription setEditable:NO];
    self.shortDescription.backgroundColor = [UIColor clearColor];
    self.shortDescription.frame = CGRectMake(8,  self.frame.size.height * 0.55 +40, self.frame.size.width - 20, 120);
    self.shortDescription.font = [UIFont fontWithName:@"Scream Real" size:17];
    //[self.shortDescription setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.shortDescription];
    
    self.Detailslbl = [[UILabel alloc]init];
      self.Detailslbl.backgroundColor = [UIColor clearColor];
      self.Detailslbl.frame = CGRectMake(self.frame.size.width-132, self.frame.size.height-38, 130,30);
      self.Detailslbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    self.Detailslbl.text=@"View Details >>";
    self.Detailslbl.textColor=[UIColor lightGrayColor];
    // [_label setBackgroundColor:[UIColor blueColor]];
    [self addSubview:  self.Detailslbl];
    


}

@end
