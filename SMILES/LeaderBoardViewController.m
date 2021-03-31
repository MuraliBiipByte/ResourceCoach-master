//
//  LeaderBoardViewController.m
//  Resource Coach
//
//  Created by Admin on 27/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "UIImageView+WebCache.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "HYCircleLoadingView.h"
#import "SCLAlertView.h"
#import "LeaderBoardTableViewCell.h"
#import "REFrostedViewController.h"

@interface LeaderBoardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backGroundView;
    NSString *uID,*UserType;
    NSMutableArray *arrOtherToppers,*arrPositions;
    UIImageView *img;
    UILabel *lblass;

}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation LeaderBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _img1stLeader.layer.cornerRadius = _img1stLeader.frame.size.width/2;
    _img1stLeader.layer.masksToBounds=YES;
    _img1stLeader.layer.borderColor=[UIColor whiteColor].CGColor;
    _img1stLeader.layer.borderWidth=2;
    
    arrPositions=[[NSMutableArray alloc]init];
    _img2ndLeader.layer.cornerRadius = _img2ndLeader.frame.size.width/2;
    _img2ndLeader.layer.masksToBounds=YES;
    _img2ndLeader.layer.borderColor=[UIColor whiteColor].CGColor;
    _img2ndLeader.layer.borderWidth=2;
    
    _img3rdLeader.layer.cornerRadius = _img3rdLeader.frame.size.width/2;
    _img3rdLeader.layer.masksToBounds=YES;
    _img3rdLeader.layer.borderColor=[UIColor whiteColor].CGColor;
    _img3rdLeader.layer.borderWidth=2;
   _tblLeadersList.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
    
    arrOtherToppers = [[NSMutableArray alloc]init];
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    //[self.view addSubview:self.img];
    [backGroundView addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    // [self.view addSubview:self.loadingView];
    [backGroundView addSubview:self.loadingView];
    [self.view bringSubviewToFront:backGroundView];
    // Do any additional setup after loading the view.
    
    //If Data is not available we are showing data As "No data available"
    img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
    img.image=[UIImage imageNamed:@"nodataimg"];
    
    lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
    lblass.textAlignment=NSTextAlignmentCenter;
    lblass.textColor=[UIColor lightGrayColor];
    lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
    lblass.text=@"No Data Available";
    [self.view addSubview:img];
    [self.view addSubview:lblass];
    
    //No data img and lbl
    [img setHidden:YES];
    [lblass setHidden:YES];
    
    _viewLeaders.hidden=YES;
    _viewTitles.hidden=YES;
    _tblLeadersList.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self navigationConfiguration];
    [self leaderBoardDetails];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    self.title = @"Leader Board";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
    [self.navigationItem setLeftBarButtonItem:menu];
}

#pragma mark -Button Mennu Tapped
-(void)menuTapped
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
-(void)leaderBoardDetails
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]leaderBoardDetailsWithUserId:uID andCompleteBlock:^(BOOL success, id result)
     {
        backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            _viewLeaders.hidden=YES;
            _viewTitles.hidden=YES;
            _tblLeadersList.hidden=YES;
            
            //No data available img and lbl we are showing here
            [img setHidden:NO];
            [lblass setHidden:NO];
            
            return ;

        }
         
         NSMutableDictionary *leaders=[result valueForKey:@"leaders"];
         NSMutableArray *arrTopLeaders=[leaders valueForKey:@"top_lists"];
         arrOtherToppers = [leaders valueForKey:@"other_lists"];
         if (arrTopLeaders.count==3)
         {
             _viewLeaders.hidden=NO;
             _viewTitles.hidden=NO;
             _tblLeadersList.hidden=NO;
             
             //No data img and lbl
             [img setHidden:YES];
             [lblass setHidden:YES];
             
             //FirstUserData
             NSString *strLeaderName1=[[arrTopLeaders objectAtIndex:0]valueForKey:@"username"];
             NSString *strLeaderImg1=[[arrTopLeaders objectAtIndex:0]valueForKey:@"user_image"];
             NSString *strLeaderTotalScore1=[[arrTopLeaders objectAtIndex:0]valueForKey:@"total_score"];
             _lbl1stLeaderName.text =[NSString stringWithFormat:@"%@",strLeaderName1];
             _lbl1stScore.text=[NSString stringWithFormat:@"%@",strLeaderTotalScore1];
             [ _img1stLeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strLeaderImg1]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
             
             //SecondUserData
             
             NSString *strLeaderName2=[[arrTopLeaders objectAtIndex:1]valueForKey:@"username"];
             NSString *strLeaderImg2=[[arrTopLeaders objectAtIndex:1]valueForKey:@"user_image"];
             NSString *strLeaderTotalScore2=[[arrTopLeaders objectAtIndex:1]valueForKey:@"total_score"];
             _lbl2ndLeaderName.text =[NSString stringWithFormat:@"%@",strLeaderName2];
             _lbl2ndScore.text=[NSString stringWithFormat:@"%@",strLeaderTotalScore2];
             [ _img2ndLeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strLeaderImg2]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
             
             //Third UserData
             
             NSString *strLeaderName3=[[arrTopLeaders objectAtIndex:2]valueForKey:@"username"];
             NSString *strLeaderImg3=[[arrTopLeaders objectAtIndex:2]valueForKey:@"user_image"];
             NSString *strLeaderTotalScore3=[[arrTopLeaders objectAtIndex:2]valueForKey:@"total_score"];
             _lbl3rdLeaderName.text =[NSString stringWithFormat:@"%@",strLeaderName3];
             _lbl3rdScore.text=[NSString stringWithFormat:@"%@",strLeaderTotalScore3];
             [ _img3rdLeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strLeaderImg3]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
             
             [_tblLeadersList reloadData];
         }
         else
         {
             _viewLeaders.hidden=YES;
             _viewTitles.hidden=YES;
             _tblLeadersList.hidden=YES;
             
             //No data Img And lbl we are showing here 
             [img setHidden:NO];
             [lblass setHidden:NO];
         }
       
         
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"LeaderBoardTableViewCell";
    LeaderBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.imgLeader.layer.cornerRadius = cell.imgLeader.frame.size.width/2;
    cell.imgLeader.layer.masksToBounds=YES;
    cell.imgLeader.layer.borderWidth=2;
    cell.imgLeader.layer.borderColor=[UIColor colorWithRed:232.0/255.0 green:242.0/255.0 blue:252.0/255.0 alpha:1].CGColor;
    
    cell.lblName.text=[NSString stringWithFormat:@"%@",[[arrOtherToppers objectAtIndex:indexPath.row]valueForKey:@"username"]];
    cell.lblScore.text=[NSString stringWithFormat:@"%@",[[arrOtherToppers objectAtIndex:indexPath.row]valueForKey:@"total_score"]];
    NSString *strImg=[NSString stringWithFormat:@"%@",[[arrOtherToppers objectAtIndex:indexPath.row]valueForKey:@"user_image"]];
    NSInteger intPostion=indexPath.row+4;
 [arrPositions addObject:[NSString stringWithFormat:@"%ld",intPostion]];
    
    cell.lblPosition.text=[NSString stringWithFormat:@"%@ th",[arrPositions objectAtIndex:indexPath.row]];
    
     [ cell.imgLeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strImg]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
//    cell.lblPosition.text=@"10th";
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOtherToppers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
