//
//  AssessmentListViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 27/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "AssessmentListViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "StartAssessmentViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SequenceTableViewCell.h"
#import "AssessmentViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface AssessmentListViewController ()<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>{
    UIRefreshControl *refreshControl;
    NSMutableArray *arrSubCategories,*arrSubcategoryName;
    NSString *expanded,*assesmentId;
    SKSTableViewCell *cell ;
    NSString *userId;
    SequenceTableViewCell *subcell;
       NSString *uID,*UserType;
}
@property (weak, nonatomic) IBOutlet SKSTableView *assesmentGroupsTableView;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation AssessmentListViewController

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
    [self.assesmentGroupsTableView setHidden:YES];
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
    [self getAssementGroupsList];
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
    if ([language isEqualToString:@"2"]) {
    //    self.title=@"အကဲဖြတ်များစာရင်း";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကဲဖြတ်များစာရင်း";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else if ([language1 isEqualToString:@"3"]){
        // self.title=@"အကဲဖြတ်များစာရင်း";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကဲဖြတ်များစာရင်း";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else{
        self.title=@"Assement List";
    }
    // self.title=@"Assement List";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    
    
}

#pragma mark -Get All Assessment Group List
-(void)getAssementGroupsList{
   // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllAssessmentsWithUserId:userId andCompleteBlock:^(BOOL success, id result) {
       // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            return ;
        }
        NSString *message = [result objectForKey:@"message"];
        NSInteger status = [[result objectForKey:@"status"] intValue];
        if (status == 1) {
            NSDictionary *data = [result objectForKey:@"data"];
            self.arraTotalGroups = [data valueForKey:@"groups"];
            self.arrAssements = [[NSMutableArray alloc] init];
            [self.arrAssements addObjectsFromArray:self.arraTotalGroups];
            [_assesmentGroupsTableView setHidden:NO];
            _assesmentGroupsTableView.SKSTableViewDelegate = self;
            _assesmentGroupsTableView.shouldExpandOnlyOneCell = YES;
            [_assesmentGroupsTableView reloadData];
        }
        else{
           // [Utility showAlert:AppName withMessage:message];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
          
            [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language ok] duration:0.0f];

            
            return;
        }
    }];
}

#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"the count %ld",self.arrAssements.count);
    return self.arrAssements.count;
}
- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=[self.arrAssements objectAtIndex:indexPath.row];
    arrSubCategories=[[NSMutableArray alloc] init];
    if([d valueForKey:@"assessment_result"]) {
    arrSubCategories=[[d valueForKey:@"assessment_result"] mutableCopy];
    }
    if ([arrSubCategories isEqual:[NSNull null]]) {
        return 0;
    }
    return arrSubCategories.count;
}
- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    CALayer *cellImageLayer = cell.assesmentGroupImg.layer;
    [cellImageLayer setCornerRadius:8.0f];
    [cellImageLayer setMasksToBounds:YES];
    cell.viewBackGround.layer.cornerRadius=8.0f;
    cell.assOpacityView.layer.cornerRadius=8.0f;
    cell.contentView.layer.cornerRadius=8.0f;
    cell.assesmentGroupImg.layer.cornerRadius=8.0f;
    NSString *strImg=[[self.arrAssements objectAtIndex:indexPath.row]valueForKey:@"photo_grp"];
    [cell.assesmentGroupImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImg]] placeholderImage:[UIImage imageNamed:@"assesmentlistbgimg"]];
    cell.lblAssGrpName.textColor=[UIColor whiteColor];
    cell.lblAssGrpName.text=[NSString stringWithFormat:@"  %@",[[self.arrAssements objectAtIndex:indexPath.row] valueForKey:@"title"]];
    if (!cell.assesmentGroupImg.image) {
        cell.assesmentGroupImg.image=[UIImage imageNamed:@"assesmentlistbgimg"];
    }
    cell.expandable=YES;
    cell.accessoryView = nil;
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    subcell = (SequenceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SequenceTableViewCell"];
    subcell.assBackgroundView.layer.cornerRadius=10.0f;
    if (subcell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceTableViewCell" owner:self options:nil];
        subcell = [nib objectAtIndex:0];
    }
    subcell.lblAssmentTitle.text=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"title"];
    subcell.lblAssesmentCreated.text=[NSString stringWithFormat:@"%@",[[arrSubCategories objectAtIndex:indexPath.subRow-1]valueForKey:@"relative_date"]];
    subcell.btnAssesment.tag = 700+indexPath.subRow;
    [subcell.btnAssesment addTarget:self action:@selector(showAssesmentDetailView:) forControlEvents:UIControlEventTouchUpInside];
    return subcell;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0f;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
//    NSString *articleid=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"id"];
//    AssessmentViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
//    getAllArticles.articleId=articleid;
//    [self.navigationController pushViewController:getAllArticles animated:YES];
    
}

#pragma mark -Show Assessment Details
-(void)showAssesmentDetailView:(id)sender{
    NSInteger rowVal = [sender tag]-700;
    NSString *articleid=[[arrSubCategories objectAtIndex:rowVal-1] valueForKey:@"id"];
    AssessmentViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
    getAllArticles.articleId=articleid;
    [self.navigationController pushViewController:getAllArticles animated:YES];
}

#pragma mark -Button Back Tapped
- (IBAction)btnBackTapped:(id)sender {
    StartAssessmentViewController*start=[self.storyboard instantiateViewControllerWithIdentifier:@"StartAssessmentViewController"];
    [self.navigationController pushViewController:start animated:YES];
}

@end
