//
//  SettingsViewController.m
//  Resource Coach
//
//  Created by Admin on 08/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "SettingsViewController.h"
#import "MenuTableViewCell.h"
#import "REFrostedViewController.h"
#import "HYCircleLoadingView.h"
#import "Utility.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "SCLAlertView.h"
#import "PersonaliseMnmonicsViewController.h"
@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *uID,*UserType;
    UIView *backGroundView;
    NSMutableArray *arrPermissionsList;

}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblSettings.separatorStyle =UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
    
    arrPermissionsList = [[NSMutableArray alloc]init];
    
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self notificationsPermissions];
      [self navigationConfiguration];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    
    self.title=@"Settings";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
    [self.navigationItem setLeftBarButtonItem:menu];
}
-(void)notificationsPermissions
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]notificationPermissionsListWithUserId:uID andCompleteBlock:^(BOOL success, id result) {
        backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            // alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:@"OK" duration:0.0f];
            return ;
        }
        arrPermissionsList = [result valueForKey:@"settings_data"];
        [_tblSettings reloadData];
    }];
}
#pragma mark -Button Mennu Tapped
-(void)menuTapped
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture)
    {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return arrPermissionsList.count;
        
    } else if (section == 1) {
        //gastos is an array
        
        return 0;
        //return 1;
        
    }
    return 0;
    
    
    
    return 0;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    static NSString *MyIdentifier = @"MenuTableViewCell";
     static NSString *MyIdentifierCell2 = @"MenuTableView";
    
    switch (indexPath.section)
    {
        case 0:
        {
    
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }

    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblPermission.text =[NSString stringWithFormat:@"%@",[[arrPermissionsList objectAtIndex:indexPath.row]valueForKey:@"title"]];
    NSString *strStatus =[NSString stringWithFormat:@"%@",[[arrPermissionsList objectAtIndex:indexPath.row]valueForKey:@"status"]];
    if ([strStatus isEqualToString:@"1"])
    {
        
         [cell.btnSwitch setOn:YES];
    }
    else
    {
      
        [cell.btnSwitch setOn:NO];
    }
    [cell.btnSwitch setOnTintColor:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1]];
    [cell.btnSwitch addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventValueChanged];

    return cell;
        }
            case 1:
        {
            MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifierCell2];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MyIdentifier];
            }
    
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.layer.cornerRadius = 4;
            cell.layer.masksToBounds=YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lblCell2SettingsPermissions.text =@"Personalized Mnemonics";
            return cell;
        }
        default:
            break;
    }
            return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
         
    if (indexPath.section==1)
    {
        PersonaliseMnmonicsViewController *pesonalized = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonaliseMnmonicsViewController"];
        [self.navigationController pushViewController:pesonalized animated:YES];
    }

    else
    {
         NSLog(@"User Clicked Dynamic Permissions");
    }
    
    
}
-(void)changeStatus:(id)sender
{
    MenuTableViewCell *clickedCell = (MenuTableViewCell*)[[sender superview] superview];
    NSIndexPath *indexPathCell = [_tblSettings indexPathForCell:clickedCell];
    NSString *strPermissionId =[NSString stringWithFormat:@"%@",[[arrPermissionsList objectAtIndex:indexPathCell.row]valueForKey:@"id"]];
    NSString *strStatus;
    if([sender isOn])
    {
        strStatus =@"1";
    }
    else
    {
        strStatus =@"0";
    }
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]notificationUpdateStatusWithUserId:uID andWithPermissionId:strPermissionId andWithStatus:strStatus andCompleteBlock:^(BOOL success, id result)
    {
        backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            return ;
        }
        else{
            NSLog(@"SuccessFully change the Status");
            [self notificationsPermissions];
        }
    }];
}

@end
