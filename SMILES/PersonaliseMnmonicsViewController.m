//
//  PersonaliseMnmonicsViewController.m
//  Resource Coach
//
//  Created by Admin on 16/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "PersonaliseMnmonicsViewController.h"
#import "MenuTableViewCell.h"
#import "APIManager.h"
#import "APIManager.h"
#import "Utility.h"
#import "HYCircleLoadingView.h"
#import "SCLAlertView.h"
#import "HomeViewController.h"


@interface PersonaliseMnmonicsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *uID,*userType,*userName;
     UIView *backGroundView;
   
    NSMutableArray *arrCategoryIDs,*arrCategoryData,*arrSelectedStatus,*arrDefaultStatus,*arrServiveStatus,*arrServiceIds;
    MenuTableViewCell *cell;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (weak, nonatomic) IBOutlet UITableView *tblInterstCat;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblSeletInfo;

@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation PersonaliseMnmonicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
     _tblInterstCat.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_btnSubmit setEnabled:NO];
    _btnSubmit.backgroundColor = [UIColor lightGrayColor];
    arrCategoryIDs=[[NSMutableArray alloc]init];
    arrCategoryData =[[NSMutableArray alloc]init];
    arrSelectedStatus=[[NSMutableArray alloc]init];
    arrDefaultStatus=[[NSMutableArray alloc]init];
    
    arrServiveStatus = [[NSMutableArray alloc]init];
    arrServiceIds=[[NSMutableArray alloc]init];
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
  
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
//    _tblInterstCat.allowsMultipleSelectionDuringEditing = YES;
//
//    [_tblInterstCat setEditing:YES animated:YES];
    _btnPopUpBackGround.hidden=YES;
    _viewThankYou.hidden=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    userType=[usercheckup valueForKey:@"usertype"];
    userName=[usercheckup valueForKey:@"name"];
    _lblUserName.text =[NSString stringWithFormat:@"Dear %@,",userName];
    _lblSeletInfo.text=@"Please select below the Modules that you are interested in, so that we can periodically recommend to you related articles";
    [self navigationConfiguration];
    [self getAllCategories];
   
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    self.title= @"Personalized Mnemonics";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

-(void)backBtnTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getAllCategories{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getCategoriesForSettingsWithUserId:uID andCompleteBlock:^(BOOL success, id result) {
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
        arrCategoryData = [result valueForKey:@"categories"];
        [arrSelectedStatus removeAllObjects];
        [arrCategoryIDs removeAllObjects];
        [arrDefaultStatus removeAllObjects];
        [arrServiceIds removeAllObjects];
        [arrServiveStatus removeAllObjects];
        
        for (int i=0; i<[arrCategoryData count]; i++) {
            [arrDefaultStatus addObject:[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:i]valueForKey:@"selected"]]];
            [arrSelectedStatus addObject:[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:i]valueForKey:@"selected"]]];
        }
        
        [_tblInterstCat reloadData];
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return arrCategoryData.count;    //count number of row from counting array hear cataGorry is An Array
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//}
//
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MenuTableViewCell";
   cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.lblCategoryName.text =[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:indexPath.row]valueForKey:@"name"]];
    NSString *strSelected =[arrSelectedStatus objectAtIndex:indexPath.row];

    [arrCategoryIDs addObject:[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:indexPath.row]valueForKey:@"id"]]];
    
  
    
    if ([strSelected isEqualToString:@"1"]) {
        [cell.btnSelect setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
    else if([strSelected isEqualToString:@"0"]){
         [cell.btnSelect setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
    
    
   [cell.btnSelect addTarget:self action:@selector(selctCheeckButton:) forControlEvents:UIControlEventTouchUpInside];
     cell.btnSelect.tag=indexPath.row;
    return cell;
}
-(void)selctCheeckButton:(id)sender
{
    UIButton *button=(UIButton *) sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    MenuTableViewCell *tappedCell = (MenuTableViewCell *)[_tblInterstCat cellForRowAtIndexPath:indexpath];
    NSString *strchek = [arrSelectedStatus objectAtIndex:indexpath.row];
    
    if ([strchek isEqualToString:@"1"])
    {
          [arrSelectedStatus replaceObjectAtIndex:indexpath.row withObject:@"0"];
        [tappedCell.btnSelect setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
    else
    {
          [arrSelectedStatus replaceObjectAtIndex:indexpath.row withObject:@"1"];
        [tappedCell.btnSelect setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
    [arrCategoryIDs removeAllObjects];
    [_tblInterstCat reloadData];
     [_btnSubmit setEnabled:YES];
    _btnSubmit.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:112.0/255.0 blue:182.0/255.0 alpha:1];

}
- (IBAction)btnSubmitTapped:(id)sender
{
    
    
 
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    
    NSMutableArray *arrFinalSelected =[[NSMutableArray alloc]init];
    NSMutableArray *arrFinalUnselect =[[NSMutableArray alloc]init];

    for (int i=0; i<arrSelectedStatus.count; i++) {
        NSString *strDefault = [NSString stringWithFormat:@"%@",[arrDefaultStatus objectAtIndex:i]];
        NSString *strSelect = [NSString stringWithFormat:@"%@",[arrSelectedStatus objectAtIndex:i]];
        if ([strDefault isEqualToString:strSelect]) {
            NSLog(@"Status is same");
        }
        else{
            [arrServiceIds addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:i]valueForKey:@"id"]]]];
            [arrServiveStatus addObject: [arrSelectedStatus objectAtIndex:i]];
            if ([strSelect isEqualToString:@"1"]) {
                [arrFinalSelected addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:i]valueForKey:@"id"]]]];
            }
            else{
                [arrFinalUnselect addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrCategoryData objectAtIndex:i]valueForKey:@"id"]]]];
            }
            
        }

    }
    NSLog(@"Selected Category IDs %@",arrServiceIds);
    NSLog(@"Selected Category status %@",arrServiveStatus);
    NSLog(@"Final Selected Category IDs %@",arrFinalSelected);
    NSLog(@"Final UnSelected Category status %@",arrFinalUnselect);
    [[APIManager sharedInstance]updateIntrestedCategoriesWithUserId:uID andWithCategoryId:arrFinalSelected andWithUnselectCatId:arrFinalUnselect andCompleteBlock:^(BOOL success, id result) {
  
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];

        if (!success) {
            return ;
        }
        _lblThankYou.text = [NSString stringWithFormat:@"%@ \r  \r %@",@"THANK YOU",@"we will update you shortly with your intrested Articles"];
        _btnPopUpBackGround.hidden=NO;
        _viewThankYou.hidden=NO;
        
    }];
}
- (IBAction)btnOkTapped:(id)sender
{
    HomeViewController  *home =[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:home animated:YES];
}
@end
