//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"

@interface ABCIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *doneButton;
@property(strong,nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIView *viewOne;
@property (strong, nonatomic) UIView *viewTwo;
@property (strong, nonatomic) UIView *viewThree;
@property (strong, nonatomic) UIView *viewFour;
@property (strong, nonatomic) UIView *viewFive;
@property (strong, nonatomic) UIView *viewSix;
@property (strong, nonatomic) UIView *viewSeven;
@property (strong, nonatomic) UIView *viewEight;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIImageView *splashBg;

@end

@implementation ABCIntroView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.splashBg];
        [self addSubview:self.scrollView];
       // [self addSubview:self.pageControl];
        [self.scrollView addSubview:self.viewOne];
        [self.scrollView addSubview:self.viewTwo];
        [self.scrollView addSubview:self.viewThree];
        [self.scrollView addSubview:self.viewFour];
        [self.scrollView addSubview:self.viewFive];
        [self.scrollView addSubview:self.viewSix];
//        [self.scrollView addSubview:self.viewSeven];
//        [self.scrollView addSubview:self.viewEight];
        
        //[self addSubview:self.doneButton];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.doneButton];
        [self.bottomView addSubview:self.skipButton];
        [self.bottomView addSubview:self.pageControl];
        [self.doneButton setHidden:YES];
       // _bottomView.backgroundColor=[UIColor clearColor];
        //[_bottomView setBackgroundColor:[UIColor redColor]];
    }
    return self;
}


-(UIImageView *)splashBg
{
    if (!_splashBg) {
        _splashBg = [[UIImageView alloc] initWithFrame:self.frame];
        [_splashBg setImage:[UIImage imageNamed:@"splashbg.png"]];
    }
    return _splashBg;
}
-(UIScrollView *)scrollView {
    if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(self.frame.size.width*6, self.scrollView.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
    NSInteger vall = self.pageControl.currentPage;
    if (vall == 0) {
        self.doneButton.hidden=YES;
         self.skipButton.hidden=YES;
        //[_bottomView setBackgroundColor:[UIColor redColor]];
    }
    if (vall == 1) {
        self.doneButton.hidden=YES;
        self.skipButton.hidden=YES;
        //[_bottomView setBackgroundColor:[UIColor blueColor]];
    }
    else if (vall == 2) {
        self.doneButton.hidden=YES;
        self.skipButton.hidden=YES;
        //[_bottomView setBackgroundColor:[UIColor grayColor]];
    }
    else if (vall == 3)
    {
        self.doneButton.hidden=YES;
        self.skipButton.hidden=YES;
       // [_bottomView setBackgroundColor:[UIColor grayColor]];
    }

    else if (vall == 4)
    {
        self.doneButton.hidden=YES;
        self.skipButton.hidden=YES;
       // [_bottomView setBackgroundColor:[UIColor grayColor]];
    }
    else if (vall == 5)
    {
        self.doneButton.hidden=YES;
        self.skipButton.hidden=YES;
        // [_bottomView setBackgroundColor:[UIColor grayColor]];
    }
//    else if (vall == 6)
//    {
//        self.doneButton.hidden=YES;
//        self.skipButton.hidden=YES;
//        // [_bottomView setBackgroundColor:[UIColor grayColor]];
//    }
//    else if (vall == 7)
//    {
//        self.doneButton.hidden=YES;
//        self.skipButton.hidden=YES;
//        // [_bottomView setBackgroundColor:[UIColor grayColor]];
//    }
    
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 60)];
        //[_bottomView setBackgroundColor:[UIColor colorWithRed:8/255.0 green:113/255.0 blue:181/255.0 alpha:1]];
    }
    return _bottomView;
}

-(UIButton *)doneButton {
        return _doneButton;
}

-(UIButton *)skipButton {
    return _skipButton;
}


-(UIPageControl *)pageControl {
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_bottomView.frame.size.width/2-25, _bottomView.frame.size.height-105, 50, 30)];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:65.0/255.0 green:112.0/255.0 blue:182.0/255.0 alpha:1]];

        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        [_pageControl setNumberOfPages:6];
    }
    return _pageControl;
}

-(UIView *)viewOne {
    if (!_viewOne) {
        _viewOne = [[UIView alloc] initWithFrame:self.frame];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewOne.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u1.jpg"];
        [_viewOne addSubview:imageview];
    }
    return _viewOne;
    
}

-(UIView *)viewTwo {
    if (!_viewTwo) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewTwo = [[UIView alloc] initWithFrame:CGRectMake(originWidth*1, 0, originWidth, originHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewTwo.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u2.jpg"];
        [_viewTwo addSubview:imageview];
        }
    return _viewTwo;
    
}

-(UIView *)viewThree{
    
    if (!_viewThree)
    {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewThree = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewThree.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u3.jpg"];
        [_viewThree addSubview:imageview];
        }
    return _viewThree;
}


-(UIView *)viewFour{
    
    if (!_viewFour) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewFour = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewFour.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u4.jpg"];
        [_viewFour addSubview:imageview];
    }
    return _viewFour;
    
}

-(UIView *)viewFive{
    
    if (!_viewFive) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewFive = [[UIView alloc] initWithFrame:CGRectMake(originWidth*4, 0, originWidth, originHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewFive.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u5.jpg"];
        [_viewFive addSubview:imageview];
    }
    return _viewFive;
    
}
-(UIView *)viewSix
{

    if (!_viewSix)
    {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewSix = [[UIView alloc] initWithFrame:CGRectMake(originWidth*5, 0, originWidth, originHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewSix.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"u6.jpg"];
        [_viewSix addSubview:imageview];
    }
    return _viewSix;

}
//
//-(UIView *)viewSeven
//{
//
//    if (!_viewSeven)
//    {
//        CGFloat originWidth = self.frame.size.width;
//        CGFloat originHeight = self.frame.size.height;
//        _viewSeven = [[UIView alloc] initWithFrame:CGRectMake(originWidth*6, 0, originWidth, originHeight)];
//        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewSeven.frame.size.width, _scrollView.frame.size.height-60)];
//        imageview.contentMode = UIViewContentModeScaleToFill;
//        imageview.image = [UIImage imageNamed:@"S2"];
//        [_viewSeven addSubview:imageview];
//    }
//    return _viewSeven;
//
//}
//-(UIView *)viewEight
//{
//
//    if (!_viewEight)
//    {
//        CGFloat originWidth = self.frame.size.width;
//        CGFloat originHeight = self.frame.size.height;
//        _viewEight = [[UIView alloc] initWithFrame:CGRectMake(originWidth*7, 0, originWidth, originHeight)];
//        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewEight.frame.size.width, _scrollView.frame.size.height-60)];
//        imageview.contentMode = UIViewContentModeScaleToFill;
//        imageview.image = [UIImage imageNamed:@"S3"];
//        [_viewEight addSubview:imageview];
//    }
//    return _viewEight;
//
//}


@end
