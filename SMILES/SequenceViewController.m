//
//  SequenceViewController.m
//  SMILES
//
//  Created by Biipmi on 10/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SequenceViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "SequenceDetailsViewController.h"
#import "REFrostedViewController.h"
#import "SequenceTableViewCell.h"
#import "GetAllArticlesViewController.h"
#import "HYCircleLoadingView.h"
#import "ViewController.h"
#import "RootViewController.h"


@interface SequenceViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrSequenceData;
    __weak IBOutlet UITableView *sequenceTableviewList;
    UIRefreshControl *refreshControl;
    NSString *userId,*noSequence,*posted;
      NSString *uID,*UserType;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SequenceViewController

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

    arrSequenceData=[[NSMutableArray alloc] init];
    sequenceTableviewList.estimatedRowHeight = 200;
    sequenceTableviewList.rowHeight = UITableViewAutomaticDimension;
    [sequenceTableviewList setNeedsLayout];
    [sequenceTableviewList layoutIfNeeded];
    sequenceTableviewList.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    sequenceTableviewList.hidden=YES;
    sequenceTableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    refreshControl.accessibilityLabel=@"";
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllSequences) forControlEvents:UIControlEventValueChanged];
    [sequenceTableviewList addSubview:refreshControl];
    sequenceTableviewList.alwaysBounceVertical = YES;
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
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    userId=[defaults objectForKey:@"id"];
    [self getAllSequences];
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
    NSString *language=[defaults valueForKey:@"language"];
    if ([language isEqualToString:@"2"]) {
      //  self.title=@"ကၽြႏ္ုပ္၏ သင္ခန္းစာငယ္မ်ား";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"ကၽြႏ္ုပ္၏ သင္ခန္းစာငယ္မ်ား";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        noSequence=@"No Mini-Lessons Available";
        posted=@"Posted:";
    }
    else if ([language isEqualToString:@"3"]){
        // self.title=@"Sequenced ဆောင်းပါးများ";
        noSequence=@"ရရှိနိုင်အဆက်မပြတ်ဘယ်သူမျှမက";
        posted=@"Posted:";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အဘယ်သူမျှမ Mini ကို-သင်ခန်းစာများရရှိနိုင်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:14]];
        
    }
    else{
        self.title=@"My Mini-Lessons";
        noSequence=@"No Mini-Lessons Available";
        posted=@"Posted:";
    }
    // self.title=@"Sequenced Articles";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    
  
}

#pragma mark - Get All Sequences
-(void)getAllSequences{
   // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllSequencesWithUserId:userId andCompleteBlock:^(BOOL success, id result) {
       // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"FuturaStd-Medium" size:17];
            lblass.text=noSequence;
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        arrSequenceData=[result valueForKey:@"sequence"];
        sequenceTableviewList.hidden=NO;
        [sequenceTableviewList reloadData];
    }];
}

#pragma mark -UITableview Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSequenceData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SequenceTableViewCell *sequenceCell= (SequenceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sequenceCell"];
    if (sequenceCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceTableViewCell" owner:self options:nil];
        sequenceCell = [nib objectAtIndex:0];
    }
    NSDictionary *sequenceDictionary = [arrSequenceData objectAtIndex:indexPath.row];
    sequenceCell.lblSequenceName.text=[NSString stringWithFormat:@"%@",[sequenceDictionary valueForKey:@"title"]];
    [sequenceCell.lblSequenceName setNeedsLayout];
    [sequenceCell.lblSequenceName layoutIfNeeded];
    NSString *post=[posted stringByAppendingString:[sequenceDictionary valueForKey:@"relative_date"]];
    sequenceCell.lblPostedDate.text=post;
    return sequenceCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [arrSequenceData objectAtIndex:indexPath.row];
    NSString *sequenceid=[dict valueForKey:@"id"];
    GetAllArticlesViewController *seqDetail=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    seqDetail.strSeqId=sequenceid;
    seqDetail.strIdentify=@"sequenceList";
    [self.navigationController pushViewController:seqDetail animated:YES];
//    SequenceDetailsViewController *seqDetail=[self.storyboard instantiateViewControllerWithIdentifier:@"SequenceDetailsViewController"];
//    seqDetail.strSeqId=sequenceid;
//    [self.navigationController pushViewController:seqDetail animated:YES];
}

#pragma mark - Menu Button Tapped
- (IBAction)btnMenuTapped:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture) {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

@end
