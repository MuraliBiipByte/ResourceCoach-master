//
//  ReportAnalyticsViewController.m
//  SMILES
//
//  Created by BiipByte on 06/03/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "ReportAnalyticsViewController.h"
#import "ReportsTableViewCell.h"
#import "APIManager.h"
#import "HYCircleLoadingView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "Language.h"

@interface ReportAnalyticsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *arrSNO,*arrUserNames,*arrScore;
    NSMutableArray *arrScoreforgraph,*arrUsersCountforgraph,*arrColorsforgraph,*arrTextColorsforgraph;
    
    
    
    
    NSUserDefaults *startAndEndtimeDefaults;
     UIView *backGroundView;
    NSString *startTime;
    NSString *endTime;
    NSString *userId;
    NSString *articleId;
    NSString *uID,*UserType;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblScoreTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblReports;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *userDetailsView;
@property (weak, nonatomic) IBOutlet UILabel *lblSno;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblViewCount;
@property (weak, nonatomic) IBOutlet UILabel *lblDurationSpent;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreYaxis;
@property (weak, nonatomic) IBOutlet UILabel *lblUserXaxis;
@property (weak, nonatomic) IBOutlet UIView *viewTableHeader;


@end

@implementation ReportAnalyticsViewController
@synthesize barChart;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationConfiguration];
   
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    
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


    _tblReports.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    arrSNO=[[NSMutableArray alloc]init];
    arrUserNames=[[NSMutableArray alloc]init];
    arrScore=[[NSMutableArray alloc]init];
    
    arrTextColorsforgraph=[[NSMutableArray alloc]init];
     arrScoreforgraph=[[NSMutableArray alloc]init];
    arrUsersCountforgraph=[[NSMutableArray alloc]init];
    arrColorsforgraph = [[NSMutableArray alloc]init];
 
    _lblSno.text=[Language SNO];
    _lblUsername.text=[Language USERNAME];
    _lblViewCount.text=[Language VIEWCOUNT];
    
    _lblUserXaxis.hidden=YES;
    _lblScoreYaxis.hidden=YES;
    _tblReports.hidden=YES;
    barChart.hidden=YES;
    _viewTableHeader.hidden=YES;

   }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    
    [self getGraphDetails];
    [self getAllUsersList];
    
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    self.title=@"Score Details";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(dismis)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}
-(void)dismis
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getGraphDetails
{
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAnalyticsResultWithAssesmentid:_assessmentId andCompleteBlock:^(BOOL success, id result) {
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            _lblUserXaxis.hidden=YES;
            _lblScoreYaxis.hidden=YES;
             barChart.hidden=YES;
           
            
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=@"No Reports Available";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            
            return ;
        }
        else
        {
            _lblUserXaxis.hidden=NO;
            _lblScoreYaxis.hidden=NO;
            barChart.hidden=NO;
            
            NSMutableArray *arrData=[result valueForKey:@"user_results"];

            for (int i=0; i<[arrData count]; i++)
            {
                [arrScoreforgraph addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrData objectAtIndex:i]valueForKey:@"score"]]]];
                [arrUsersCountforgraph addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrData objectAtIndex:i]valueForKey:@"count"]]]];
                [arrColorsforgraph addObject:@"4170b6"];
                [arrTextColorsforgraph addObject:@"757575"];
            }
            
            [self loadBarChartUsingArray];
            
            
        }
    }];
}
//We are implementing one more service for getting all the user(Who passed exam)
-(void)getAllUsersList
{
    
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    
    [[APIManager sharedInstance]getAnalyticsResultForUserResultWithAssesmentid:_assessmentId andCompleteBlock:^(BOOL success, id result)
    {
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        
        if (!success)
        {
             _tblReports.hidden=YES;
             _viewTableHeader.hidden=YES;
        }
        else
        {
             _tblReports.hidden=NO;
            _viewTableHeader.hidden=NO;
            
            NSMutableArray *arrUserData=[result valueForKey:@"global_quiz_results"];
            for (int i=1; i<=[arrUserData count]; i++)
            {
                [arrSNO addObject:[NSString stringWithFormat:@"%d",i]];
                
            }
            for (int i=0; i<[arrUserData count]; i++)
            {
                [arrUserNames addObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrUserData objectAtIndex:i]valueForKey:@"user_name"]]]];
                [arrScore addObject: [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[arrUserData objectAtIndex:i]valueForKey:@"score"]]]];
            }
            [_tblReports reloadData];
            
        }
    }];
    
}
-(void)checkUserType
{
    
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result)
    {
        NSLog(@"%@",result);
        if (!success)
        {
            return ;
        }
        else
        {
            NSDictionary *userdata=[result valueForKey:@"userdata"];
            NSString *type=[userdata valueForKey:@"usertype"];
            NSString *userIds=[userdata valueForKey:@"user_id"];
            NSString *userName=[userdata valueForKey:@"username"];
            
            
            if (![UserType isEqualToString:type])
            {
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Your user account type has been changed by Admin" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    [defaults setObject:userIds forKey:@"id"];
                    [defaults setObject:userName forKey:@"name"];
                    [defaults setObject:type forKey:@"usertypeid"];
                    [defaults setObject:type forKey:@"usertype"];
                    
                    RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                    [self presentViewController:homeView animated:YES completion:nil];
                    
                    
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }
    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Bar Chart Setup

- (void)loadBarChartUsingArray {
    //Generate properly formatted data to give to the bar chart
    NSArray *array = [barChart createChartDataWithTitles:arrUsersCountforgraph
                                                  values:arrScoreforgraph
                                                  colors:arrColorsforgraph
                                             labelColors:arrTextColorsforgraph];
    
    //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
    [barChart setupBarViewShape:BarShapeSquared];
    
    //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
    //[barChart setupBarViewStyle:BarStyleGlossy];
    [barChart setupBarViewStyle:BarStyleFlat];
    
    //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
    //[barChart setupBarViewShadow:BarShadowLight];
    
    //Generate the bar chart using the formatted data
    [barChart setDataWithArray:array
                      showAxis:DisplayBothAxes
                     withColor:[UIColor darkGrayColor]
       shouldPlotVerticalLines:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return arrUserNames.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   ReportsTableViewCell* cell = (ReportsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReportsTableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReportsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.lblSNo.text=[arrSNO objectAtIndex:indexPath.row];
    NSString *username=[arrUserNames objectAtIndex:indexPath.row];
  
    if ([username isEqual:[NSNull null]])
    {
        NSLog(@"User Name is null in table");
        cell.lblUserName.text=@"";
    }
    else
    {
         cell.lblUserName.text=[arrUserNames objectAtIndex:indexPath.row];
    }

    cell.lblScore.text=[NSString stringWithFormat:@"%@",[arrScore objectAtIndex:indexPath.row]];

    return cell;

}


@end
