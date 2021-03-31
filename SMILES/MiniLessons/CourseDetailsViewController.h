//
//  CourseDetailsViewController.h
//  MiniLessons
//
//  Created by BiipByte on 8/3/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *readMoreView;

@property (weak, nonatomic) IBOutlet UIButton *QuizButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseDescriptionConstraint;

@end
