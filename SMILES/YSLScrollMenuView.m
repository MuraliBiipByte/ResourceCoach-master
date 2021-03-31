//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLScrollMenuView.h"
#import <UIKit/UIKit.h>

static const CGFloat kYSLScrollMenuViewWidth  = 190;
static const CGFloat kYSLScrollMenuViewMargin = 0;
static const CGFloat kYSLIndicatorHeight = 3;

@interface YSLScrollMenuView ()


@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLScrollMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default
        _viewbackgroudColor = [UIColor colorWithRed:7.0/255.0 green:146.0/255.0 blue:75.0/255.0 alpha:1];
        
        
        _itemfont = [UIFont systemFontOfSize:16];
        _itemTitleColor = [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0];
        
      //  _itemTitleColor=[UIColor redColor];
        _itemSelectedTitleColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
        _itemIndicatorColor = [UIColor colorWithRed:0.168627 green:0.498039 blue:0.839216 alpha:1.0];
        
        self.backgroundColor = _viewbackgroudColor;
        //self.backgroundColor=[UIColor redColor];
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark -- Setter

- (void)setViewbackgroudColor:(UIColor *)viewbackgroudColor
{
    if (!viewbackgroudColor) { return; }
    _viewbackgroudColor = viewbackgroudColor;
    self.backgroundColor = viewbackgroudColor;
}

- (void)setItemfont:(UIFont *)itemfont
{
    if (!itemfont) { return; }
    _itemfont = itemfont;
    for (UILabel *label in _itemTitleArray) {
        label.font = itemfont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    if (!itemTitleColor) { return; }
    _itemTitleColor = itemTitleColor;
    for (UILabel *label in _itemTitleArray) {
        label.textColor = itemTitleColor;
    }
}

- (void)setItemIndicatorColor:(UIColor *)itemIndicatorColor
{
    if (!itemIndicatorColor) { return; }
    _itemIndicatorColor = itemIndicatorColor;
    _indicatorView.backgroundColor = itemIndicatorColor;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        
        for (int i = 0; i < itemTitleArray.count; i++) {
            CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
            UILabel *itemView = [[UILabel alloc] initWithFrame:frame];
//            itemView.layer.borderColor=[UIColor whiteColor].CGColor;
//        
//           itemView.backgroundColor=[UIColor darkGrayColor];
//          itemView.layer.backgroundColor=[UIColor greenColor].CGColor;
//            itemView.layer.borderWidth=0.5;
            [self.scrollView addSubview:itemView];
            itemView.tag = i;
            itemView.text = itemTitleArray[i];
            itemView.userInteractionEnabled = YES;
           
            itemView.textAlignment = NSTextAlignmentCenter;
            itemView.font = self.itemfont;
//            itemView.font =[UIFont systemFontOfSize:17];
             itemView.font =[UIFont boldSystemFontOfSize:17];
            
            itemView.textAlignment=NSTextAlignmentCenter;
            [itemView sizeToFit];
            itemView.textColor = [UIColor whiteColor];
            [views addObject:itemView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapAction:)];
            [itemView addGestureRecognizer:tapGesture];
        }
        
        self.itemViewArray = [NSArray arrayWithArray:views];
        
        // indicator
        _indicatorView = [[UIView alloc]init];
        _indicatorView.frame = CGRectMake(0, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        _indicatorView.backgroundColor =[UIColor whiteColor];// [UIColor colorWithRed:0/255.0 green:0/255.0 blue:76/255.0 alpha:1];
//       [ _scrollView setBackgroundColor:[UIColor colorWithRed:8/255.0 green:113/255.0 blue:181/255.0 alpha:1]];
        
         [ _scrollView setBackgroundColor:[UIColor colorWithRed:8.0/255.0 green:170.0/255.0 blue:87.0/255.0 alpha:1]];
        
        
        [_scrollView addSubview:_indicatorView];
    }
}

#pragma mark -- public

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex
{
    CGFloat indicatorX = 0.0;
    if (isNextItem) {
        indicatorX = ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * ratio ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    } else {
        indicatorX =  ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * (1 - ratio) ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    }
    
    if (indicatorX < kYSLScrollMenuViewMargin || indicatorX > self.scrollView.contentSize.width - (kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth)) {
        return;
    }
    _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
    //  NSLog(@"retio : %f",_indicatorView.frame.origin.x);
}

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    if (itemTextColor) {
        _itemTitleColor = itemTextColor;
    }
    if (selectedItemTextColor) {
        _itemSelectedTitleColor = selectedItemTextColor;
    }
    
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UILabel *label = self.itemViewArray[i];
        if (i == currentIndex) {
            label.alpha = 0.1;
            [UIView animateWithDuration:0.75
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 label.backgroundColor=[UIColor clearColor];//[UIColor whiteColor];
                                 
                                 label.alpha = 1.0;
                                 label.textColor =[UIColor whiteColor];// [UIColor colorWithRed:0/255.0 green:0/255.0 blue:76/255.0 alpha:1 ];
                             } completion:^(BOOL finished) {
                             }];
        } else {
            label.textColor = [UIColor lightTextColor];//[UIColor whiteColor];
            label.backgroundColor=[UIColor clearColor];//[UIColor colorWithRed:0/255.0 green:0/255.0 blue:76/255.0 alpha:1 ];
        }
    }
}

#pragma mark -- private

// menu shadow
- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = kYSLScrollMenuViewMargin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
        CGFloat width = kYSLScrollMenuViewWidth;
        UIView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(x, 0, width, self.scrollView.frame.size.height);
        x += width + kYSLScrollMenuViewMargin;
    
    }
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    CGRect frame = self.scrollView.frame;
    if (self.frame.size.width > x) {
        frame.origin.x = (self.frame.size.width - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = self.frame.size.width;
    }
    self.scrollView.frame = frame;
}

#pragma mark -- Selector --------------------------------------- //
- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
        
    }
}

@end
