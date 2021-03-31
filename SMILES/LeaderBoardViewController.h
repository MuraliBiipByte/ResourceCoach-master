//
//  LeaderBoardViewController.h
//  Resource Coach
//
//  Created by Admin on 27/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewLeaders;
@property (weak, nonatomic) IBOutlet UIImageView *img2ndLeader;
@property (weak, nonatomic) IBOutlet UIImageView *img3rdLeader;
@property (weak, nonatomic) IBOutlet UIImageView *img1stLeader;
@property (weak, nonatomic) IBOutlet UILabel *lbl2ndLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *lbl3rdLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *lbl1stLeaderName;
@property (weak, nonatomic) IBOutlet UILabel *lbl1st;
@property (weak, nonatomic) IBOutlet UILabel *lbl2nd;
@property (weak, nonatomic) IBOutlet UILabel *lbl2ndScore;
@property (weak, nonatomic) IBOutlet UILabel *lbl1stScore;
@property (weak, nonatomic) IBOutlet UILabel *lbl3rd;
@property (weak, nonatomic) IBOutlet UILabel *lbl3rdScore;
@property (weak, nonatomic) IBOutlet UITableView *tblLeadersList;
@property (weak, nonatomic) IBOutlet UIView *viewTitles;

@end
