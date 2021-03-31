//
//  CourseDetailViewController.h
//  DedaaBox
//
//  Created by Biipmi on 3/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *readMoreView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUpandDown;

@property (weak, nonatomic) IBOutlet UIButton *QuizButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseDescriptionConstraint;
@property (weak, nonatomic) IBOutlet NSString *miniCertificateId;
@property (weak, nonatomic) IBOutlet NSString *strAuthoreId;
@property (weak, nonatomic) IBOutlet NSString *miniCertificateName;

//@property (weak, nonatomic) IBOutlet NSInteger *sSection;
//@property (weak, nonatomic) IBOutlet NSInteger *sRow;

//@property (nonatomic, assign) NSInteger sSection;
//@property (nonatomic, assign) NSInteger sRow;
@property (weak, nonatomic) IBOutlet NSString *sSection;
@property (weak, nonatomic) IBOutlet NSString *sRow;

@property (weak, nonatomic) IBOutlet UIImageView *miniCertificationImg;
@property (weak, nonatomic) IBOutlet UILabel *lblCourseOverView;

@property (weak, nonatomic) IBOutlet UILabel *txtOverView;
@property (weak, nonatomic) IBOutlet UILabel *lblDurationTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UIView *lblLessionsTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblCourseVideos;
@property (weak, nonatomic) IBOutlet UIButton *btnQuiz;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;



@end
