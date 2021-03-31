//
//  ViewController.m
//  MiniLessons
//
//  Created by Biipmi on 2/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "ViewController.h"
#import "CourseDetailsViewController.h"
#import "SKSTableViewCell.h"
#import "SequenceTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.miniLessonsTable.shouldExpandOnlyOneCell = YES;
    self.miniLessonsTable.SKSTableViewDelegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 SKSTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SKSTableViewCell"];
    cell.expandable=YES;
    cell.accessoryView = nil;
    return cell;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SequenceTableViewCell";
    
    SequenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        
    cell = [[SequenceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    return cell;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250.0f;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    
    CourseDetailsViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
    [self.navigationController pushViewController:courseDetails animated:YES];
    
}



@end
