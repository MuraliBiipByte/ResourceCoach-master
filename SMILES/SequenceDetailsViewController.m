//
//  SequenceDetailsViewController.m
//  SMILES
//
//  Created by Biipmi on 10/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SequenceDetailsViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "SequenceTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "SCLAlertView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"


@interface SequenceDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *userId;
    NSMutableArray *arrSeqDetailData;
    UIRefreshControl *refreshControl;
    __weak IBOutlet UITableView *sequenceDetailTableviewList;
      NSString *uID,*UserType;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SequenceDetailsViewController
@synthesize strSeqId;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self navigationConfiguration];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    arrSeqDetailData=[[NSMutableArray alloc]init];
    sequenceDetailTableviewList.estimatedRowHeight = 80;
    sequenceDetailTableviewList.rowHeight = UITableViewAutomaticDimension;
    [sequenceDetailTableviewList setNeedsLayout];
    [sequenceDetailTableviewList layoutIfNeeded];
    sequenceDetailTableviewList.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    sequenceDetailTableviewList.hidden=YES;
    sequenceDetailTableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    refreshControl.accessibilityLabel=@"";
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getSequenceDetails) forControlEvents:UIControlEventValueChanged];
    [sequenceDetailTableviewList addSubview:refreshControl];
    sequenceDetailTableviewList.alwaysBounceVertical = YES;
    [self getSequenceDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
}
-(void)checkUserType{
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"%@",result);
        if (!success) {
            return ;
        }
        else{
            NSDictionary *userdata=[result valueForKey:@"userdata"];
            NSString *type=[userdata valueForKey:@"usertype"];
            NSString *userIds=[userdata valueForKey:@"user_id"];
            NSString *userName=[userdata valueForKey:@"username"];
            
            
            if (![UserType isEqualToString:type] ) {
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Your user account type has been changed by Admin" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
      //  self.title=@"Sequenced ဆောင်းပါးများ";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"Sequenced ဆောင်းပါးများ";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
    }
    else if ([language1 isEqualToString:@"3"]){
        self.title=@"Sequenced ဆောင်းပါးများ";
    }
    else{
        self.title=@"Sequenced Articles";
    }
    // self.title=@"Sequenced Articles";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:20]}];
    
    
   
}

#pragma mark - Get Sequence Details
-(void)getSequenceDetails{
   // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getSequenceDetailsWithUserId:userId andWithSequenceId:strSeqId andCompleteBlock:^(BOOL success, id result) {
       // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
           // [Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
                       [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

            
            return ;
        }
        arrSeqDetailData=[result valueForKey:@"sequence_data"];
        sequenceDetailTableviewList.hidden=NO;
        [sequenceDetailTableviewList reloadData];
    }];
}

#pragma mark -UITableview Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSeqDetailData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SequenceTableViewCell *sequenceDetailCell= (SequenceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sequenceDetailCell"];
    if (sequenceDetailCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceTableViewCell" owner:self options:nil];
        sequenceDetailCell = [nib objectAtIndex:0];
    }
    NSDictionary *seqDetailDictionary = [arrSeqDetailData objectAtIndex:indexPath.row];
    sequenceDetailCell.lblSequenceDetailName.text=[NSString stringWithFormat:@"%@",[seqDetailDictionary valueForKey:@"title"]];
    return sequenceDetailCell;
}

#pragma mark - Back Button Pressed
- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
