//
//  MiniCertificatesListViewController.m
//  certifications
//
//  Created by Biipmi on 12/10/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "MiniCertificatesListViewController.h"
#import "CertificateTableViewCell.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "Language.h"

@interface MiniCertificatesListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
       UIView *backGroundView;
    NSString *strUserId;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;


@end

@implementation MiniCertificatesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrCertificateID=[[NSMutableArray alloc]init];
    _arrCertificateName=[[NSMutableArray alloc]init];
    _arrEmailId=[[NSMutableArray alloc]init];
    _arrDate=[[NSMutableArray alloc]init];
    _arrPercentage=[[NSMutableArray alloc]init];
    _arrAttemptCount=[[NSMutableArray alloc]init];
    _arrMobileNumbers=[[NSMutableArray alloc]init];
    _arrTelecodes=[[NSMutableArray alloc]init];
    
    
    [self navigationConfiguration];
    _tblCertificates.separatorStyle = UITableViewCellSeparatorStyleNone;

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
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    strUserId=[userDefaults  objectForKey:@"id"];
     [self getAllCertificates];
   
    
   
    // [self checkUserType];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    
    //    [self.title sizeWithFont:[UIFont fontWithName:@"Roboto-Bold" size:14]];
    //
    //
    self.title=@"Mock Assessment";
    
   UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
}

#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)getAllCertificates
{  backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getMiniCerListWithUserId:strUserId andCompleteBlock:^(BOOL success, id result) {
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            [Utility showAlert:AppName withMessage:result];
            return ;
        }
        NSMutableDictionary *data=[result valueForKey:@"data"];
        NSMutableArray *arrCertificates=[data objectForKey:@"certificate"];
        _arrCertificateID=[arrCertificates valueForKey:@"id"];
        _arrCertificateName=[arrCertificates valueForKey:@"assessment"];
        _arrEmailId=[arrCertificates valueForKey:@"email"];
        _arrDate=[arrCertificates valueForKey:@"created_on"];
       // _arrAttemptCount=[arrCertificates valueForKey:@""];
        _arrPercentage=[arrCertificates valueForKey:@"score"];
        _arrTelecodes=[arrCertificates valueForKey:@"telcode"];
        _arrMobileNumbers=[arrCertificates valueForKey:@"mobile"];
        [_tblCertificates reloadData];
    }];
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _arrCertificateID.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  
        
      CertificateTableViewCell*  cell = (CertificateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CertificateTableViewCell"];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CertificateTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius=5;
    cell.layer.masksToBounds=YES;
    
    
    cell.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0;
    cell.lblCertificateName.text=[[_arrCertificateName objectAtIndex:indexPath.row ]uppercaseString];
    cell.lblEmail.text=[_arrEmailId objectAtIndex:indexPath.row];
    cell.lblDate.text=[_arrDate objectAtIndex:indexPath.row ];
    NSString *strTelecode=[_arrTelecodes objectAtIndex:indexPath.row];
    NSString *strMobileNumber=[_arrMobileNumbers objectAtIndex:indexPath.row];
    NSString *strMobileNumberWithTeleCode=[NSString stringWithFormat:@"%@ %@",strTelecode,strMobileNumber];
    
    if ([strMobileNumber isEqual:[NSNull null]])
    {
        cell.lblMobileNumberWithTelecode.text=[Language NotAvailable];
    }
    else
    {
       
        cell.lblMobileNumberWithTelecode.text=strMobileNumberWithTeleCode;
    }
    
    
    NSString *strScore = [_arrPercentage objectAtIndex:indexPath.row] ;
    NSString *Percentage =@"%";
    cell.lblPercentage.text=[NSString stringWithFormat:@"%@%@",strScore,Percentage];
  
    
    return cell;
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
