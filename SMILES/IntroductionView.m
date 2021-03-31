//
//  IntroductionView.m
//  HygieneWatch
//
//  Created by Biipmi on 23/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "IntroductionView.h"

@interface IntroductionView () <UIScrollViewDelegate>
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
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIImageView *splashBg;

@end

@implementation IntroductionView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        [self addSubview:self.splashBg];
        [self addSubview:self.scrollView];
        //[self addSubview:self.pageControl];
        [self.scrollView addSubview:self.viewOne];
        [self.scrollView addSubview:self.viewTwo];
        [self.scrollView addSubview:self.viewThree];
        [self.scrollView addSubview:self.viewFour];
        [self.scrollView addSubview:self.viewFive];
        [self.scrollView addSubview:self.viewSix];
        //[self addSubview:self.doneButton];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.doneButton];
        [self.bottomView addSubview:self.skipButton];
        [self.bottomView addSubview:self.pageControl];
        [self.doneButton setHidden:YES];
        [_bottomView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1]];
//       [_bottomView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:51/255.0 alpha:1]];
//        
//          [_bottomView setBackgroundColor:[UIColor darkGrayColor]];
    }
    return self;
}


-(UIImageView *)splashBg {
    if (!_splashBg) {
        _splashBg = [[UIImageView alloc] initWithFrame:self.frame];
        [_splashBg setImage:[UIImage imageNamed:@"splashbg.png"]];
    }
    return _splashBg;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView)
    {
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
    
     [_bottomView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1]];
    
    if (vall == 0)
    {
        self.doneButton.hidden=YES;
        
    }
    if (vall == 1)
    {
        self.doneButton.hidden=YES;
    }
    else if (vall == 2)
    {
        self.doneButton.hidden=YES;
    }
    
    else if (vall == 3)
    {
        self.doneButton.hidden=YES;
    }
    else if (vall == 4)
    {
        self.doneButton.hidden=YES;
    }

    else if (vall == 5)
    {
        self.doneButton.hidden=NO;
    }


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
    //    if (!_doneButton) {
    //        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 60)];
    //        [_doneButton setTintColor:[UIColor whiteColor]];
    //        [_doneButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
    //        [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    //        [_doneButton setBackgroundColor:[UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1.000]];
    //        [_doneButton addTarget:self.delegate action:@selector(onDoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //    }
    //    return _doneButton;
    
    
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(_bottomView.frame.size.width-100, _bottomView.frame.size.height-45, 100, 30)];
        [_doneButton setTintColor:[UIColor whiteColor]];
        [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
       // [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_doneButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:15.0f]];
        //        [_doneButton setBackgroundColor:[UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1.000]];
        [_doneButton addTarget:self.delegate action:@selector(onDoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

-(UIButton *)skipButton
{
    
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithFrame:CGRectMake(8, _bottomView.frame.size.height-45, 50, 30)];
        [_skipButton setTintColor:[UIColor whiteColor]];
        [_skipButton setTitle:@"SKIP" forState:UIControlStateNormal];
     //   [_skipButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_skipButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:15.0f]];
        
        //        [_skipButton setBackgroundColor:[UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1.000]];
        [_skipButton addTarget:self.delegate action:@selector(skipPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}


-(UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_bottomView.frame.size.width/2-25, _bottomView.frame.size.height-45, 50, 30)];
        //[_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:65.0/255.0 green:112.0/255.0 blue:182.0/255.0 alpha:1]];
       [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        [_pageControl setNumberOfPages:6];
    }
    return _pageControl;
}



-(UIView *)viewOne
{
    if (!_viewOne) {
        _viewOne = [[UIView alloc] initWithFrame:self.frame];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewOne.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"u1.jpg"];
        [_viewOne addSubview:imageview];
        
        
//        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, _viewOne.frame.size.width, _scrollView.frame.size.height-60)];
//        imageview1.contentMode = UIViewContentModeScaleToFill;
//        imageview1.image = [UIImage imageNamed:@"placeholder_gradient.1467085018.png"];
//        [_viewOne addSubview:imageview1];
//
//         UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, _viewOne.frame.size.width, 40)];
//        titleLabel.text = [NSString stringWithFormat:@"GrabFlowers"];
//        titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.textAlignment =  NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 0;
//        [_viewOne addSubview:titleLabel];
//
//        
//        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, _viewOne.frame.size.width, 60)];
//        descLabel.text = [NSString stringWithFormat:@"The ONE flowers app for both Buyers and Sellers"];
//        descLabel.font = [UIFont boldSystemFontOfSize:20.0];
//        descLabel.textColor = [UIColor whiteColor];
//        descLabel.textAlignment =  NSTextAlignmentCenter;
//        descLabel.numberOfLines = 0;
//        [_viewOne addSubview:descLabel];
        
    }
    return _viewOne;
    
}

-(UIView *)viewTwo {
    if (!_viewTwo) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        
        _viewTwo = [[UIView alloc] initWithFrame:CGRectMake(originWidth*1, 0, originWidth, originHeight)];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewTwo.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"u2.jpg"];
        [_viewTwo addSubview:imageview];
        
       
        
//        
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, _viewTwo.frame.size.width, 40)];
//        titleLabel.text = [NSString stringWithFormat:@"Simple and Fast"];
//        titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.textAlignment =  NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 0;
//        [_viewTwo addSubview:titleLabel];
//        
//        
//        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, _viewTwo.frame.size.width, 60)];
//        descLabel.text = [NSString stringWithFormat:@"Grab Today or Grab Advance, it only takes seconds"];
//        descLabel.font = [UIFont boldSystemFontOfSize:20.0];
//        descLabel.textColor = [UIColor whiteColor];
//        descLabel.textAlignment =  NSTextAlignmentCenter;
//        descLabel.numberOfLines = 0;
//        [_viewTwo addSubview:descLabel];

        
    }
    return _viewTwo;
    
}

-(UIView *)viewThree{
    
    if (!_viewThree) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewThree = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewThree.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"u3.jpg"];
        [_viewThree addSubview:imageview];
        
        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, _viewThree.frame.size.width, 40)];
//        titleLabel.text = [NSString stringWithFormat:@"Flowers Delivery"];
//        titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.textAlignment =  NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 0;
//        [_viewThree addSubview:titleLabel];
//        
//        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, _viewThree.frame.size.width, 90)];
//        descLabel.text = [NSString stringWithFormat:@"Need for delivery?  We can take care of that"];
//        descLabel.font = [UIFont boldSystemFontOfSize:20.0];
//        descLabel.textColor = [UIColor whiteColor];
//        descLabel.textAlignment =  NSTextAlignmentCenter;
//        descLabel.numberOfLines = 0;
//        [_viewThree addSubview:descLabel];
//
        
    }
    return _viewThree;
    
}

-(UIView *)viewFour {
    if (!_viewFour) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        _viewFour = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewFour.frame.size.width, _scrollView.frame.size.height-60)];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"u4.jpg"];
        [_viewFour addSubview:imageview];
        
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-200, _viewFour.frame.size.width, 40)];
//        titleLabel.text = [NSString stringWithFormat:@"Special Dates"];
//        titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.textAlignment =  NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 0;
//        [_viewFour addSubview:titleLabel];
//        
//        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, _viewFour.frame.size.width, 90)];
//        descLabel.text = [NSString stringWithFormat:@"Forget-no-more...we make your important dates special"];
//        descLabel.font = [UIFont boldSystemFontOfSize:20.0];
//        descLabel.textColor = [UIColor whiteColor];
//        descLabel.textAlignment =  NSTextAlignmentCenter;
//        descLabel.numberOfLines = 0;
//        [_viewFour addSubview:descLabel];

        
        
    }
    
    
    return _viewFour;
    
}

-(UIView *)viewFive
{
    
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

@end
