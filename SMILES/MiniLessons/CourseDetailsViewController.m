//
//  CourseDetailsViewController.m
//  MiniLessons
//
//  Created by BiipByte on 8/3/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "CourseDetailsViewController.h"
#import "LessonsTableViewCell.h"

@interface CourseDetailsViewController ()
{
    UIButton *lessbutton;
    UIButton *morebutton;
}

@end

@implementation CourseDetailsViewController

- (void)viewDidLoad
{
    _QuizButton.layer.cornerRadius=16.0f;
    _QuizButton.layer.masksToBounds=YES;
    
    lessbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.readMoreView.frame.size.width, self.readMoreView.frame.size.height)];
    lessbutton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0f];
     morebutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.readMoreView.frame.size.width, self.readMoreView.frame.size.height)];
    morebutton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0f];
    [morebutton addTarget:self action:@selector(moreconstraint) forControlEvents:UIControlEventTouchUpInside];
[morebutton setTitle:@"READ MORE" forState:UIControlStateNormal];
    [morebutton setTintColor:[UIColor whiteColor]];
    
    [self.readMoreView addSubview:morebutton];
    
    [morebutton setHidden:NO];
    [lessbutton setHidden:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LessonsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LessonsTableViewCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 45.0f;
}

- (void)moreconstraint
{
    _courseDescriptionConstraint.constant=160.0f;
    _courseDescriptionConstraint.active=YES;
    [lessbutton addTarget:self action:@selector(lessconstraint) forControlEvents:UIControlEventTouchUpInside];
    [lessbutton setTitle:@"Less" forState:UIControlStateNormal];
    [lessbutton setTintColor:[UIColor whiteColor]];
    
    [lessbutton setHidden:NO];
    [morebutton setHidden:YES];
    
    [self.readMoreView addSubview:lessbutton];
    
    
}
- (void)lessconstraint
{
    _courseDescriptionConstraint.constant=114.0f;
    _courseDescriptionConstraint.active=YES;
    
    [morebutton addTarget:self action:@selector(moreconstraint) forControlEvents:UIControlEventTouchUpInside];
    [morebutton setTitle:@"READ MORE" forState:UIControlStateNormal];
    [morebutton setTintColor:[UIColor whiteColor]];

    [morebutton setHidden:NO];
    [lessbutton setHidden:YES];

}
@end
