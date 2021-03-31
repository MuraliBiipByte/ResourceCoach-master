//
//  IntroductionView.h
//  HygieneWatch
//
//  Created by Biipmi on 23/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroductionViewDelegate <NSObject>

-(void)onDoneButtonPressed;
-(void)skipPressed;

@end

@interface IntroductionView : UIView
@property id<IntroductionViewDelegate> delegate;

@end
