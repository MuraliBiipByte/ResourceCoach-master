//
//  SharegroupViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SharegroupViewController.h"
#import "REFrostedViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SequenceTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface SharegroupViewController ()<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>{
    NSString *userId;
    __weak IBOutlet SKSTableView *groupsTableView;
    SKSTableViewCell *cell ;
     NSMutableArray *arrSubCategories,*arrSubcategoryName;
     NSString*noGroups;
     NSString *uID,*UserType;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation SharegroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [groupsTableView setHidden:YES];
    [self navigationConfiguration];
}
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    userId=[defaults objectForKey:@"id"];
    [groupsTableView refreshData];
    [self getAllDepartmens];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language=[defaults valueForKey:@"language"];
    if ([language isEqualToString:@"2"]) {
      //  self.title=@"ကၽြႏု္ပ္၏ Learning Group";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"ကၽြႏု္ပ္၏ Learning Group";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        
        noGroups=@"No Groups Available";
    }
    else if ([language isEqualToString:@"3"]){
        // self.title=@"အကြှနျုပျ၏သင်ယူအဖွဲ့များ";
        noGroups=@"ရရှိနိုင်သောအဘယ်သူမျှမအဖွဲ့များ";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကြှနျုပျ၏သင်ယူအဖွဲ့များ";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
    }
    else{
       // self.title=@"My Learning Groups";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"My Learning Groups";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        
        
        noGroups=@"No Groups Available";
    }
    //self.title=@"My Learning Groups";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];

   }

#pragma mark -Get All Departments
-(void)getAllDepartmens{
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getGroupNameDetails:@"" andWithUserId:userId andCompleteBlock:^(BOOL success, id result){
       // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
//            [Utility showAlert:AppName withMessage:result];
//            return ;
            
            [groupsTableView setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"FuturaStd-Medium" size:17];
            lblass.text=@"No Groups Available";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return;

        }
        NSDictionary *response = [result objectForKey:@"response"];
        NSString *message = [response objectForKey:@"message"];
        NSLog(@"Msg is %@",message);
        NSInteger status = [[response objectForKey:@"status"] intValue];
        if (status == 1) {
            NSDictionary *data = [response objectForKey:@"data"];
            self.arraTotalGroups = [data valueForKey:@"groups"];
            self.arrGroups = [[NSMutableArray alloc] init];
            [self.arrGroups addObjectsFromArray:self.arraTotalGroups];
            [groupsTableView setHidden:NO];
            groupsTableView.SKSTableViewDelegate = self;
            groupsTableView.shouldExpandOnlyOneCell = YES;
            [groupsTableView reloadData];
        }
        else{
            //[Utility showAlert:AppName withMessage:message];
            [groupsTableView setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"FuturaStd-Medium" size:17];
            lblass.text=@"No Groups Available";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
             return;
        }
    }];
}

#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"the count %ld",self.arrGroups.count);
    return self.arrGroups.count;
}
- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=[self.arrGroups objectAtIndex:indexPath.row];
    arrSubCategories=[[NSMutableArray alloc] init];
    if([d valueForKey:@"user_result"]) {
        arrSubCategories=[[d valueForKey:@"user_result"] mutableCopy];
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
    static NSString *CellIdentifier = @"SKSTableViewCellGroup";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSString *strImg=[[self.arrGroups objectAtIndex:indexPath.row]valueForKey:@"photo_grp"];
    CALayer *cellImageLayer = cell.groupImage.layer;
    [cellImageLayer setCornerRadius:10.0f];
    [cellImageLayer setMasksToBounds:YES];
    cell.groupImage.layer.cornerRadius=10.0f;
    cell.opacityView.layer.cornerRadius=10.0f;
    cell.btnGroupTitle.enabled=NO;
    [cell.groupImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImg]] placeholderImage:[UIImage imageNamed:@"groupPlaceholder"]];
    [cell.btnGroupTitle setTitle:[NSString stringWithFormat:@"  %@",[[self.arrGroups objectAtIndex:indexPath.row] valueForKey:@"title"]] forState:UIControlStateNormal];
    if (!cell.groupImage.image) {
        cell.groupImage.image=[UIImage imageNamed:@"groupPlaceholder"];
    }
    cell.expandable=YES;
    cell.accessoryView = nil;
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
      static NSString *CellIdentifier = @"SequenceTableViewCell";
     SequenceTableViewCell *subcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    subcell.subUserImg.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    subcell.subUserImg.layer.borderWidth=1.0f;
    if (!subcell)
        subcell = [[SequenceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    subcell.bkgView.layer.cornerRadius=8.0f;
    subcell.subUserImg.layer.cornerRadius=subcell.subUserImg.frame.size.height/2;
    subcell.subUserImg.layer.masksToBounds=YES;
    subcell.bkgView.layer.masksToBounds=YES;
    NSString *usrImg=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"photo_user"];
      subcell.subUserName.text=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"username"];
    if ([usrImg isEqual:[NSNull null]]) {
        subcell.subUserImg.image=[UIImage imageNamed:@"userprofile"];
    }
    else{
    [subcell.subUserImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,usrImg]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
    }
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
//    NSString *subcatId=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"id"];
//    GetAllArticlesViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
//    getAllArticles.strSubCatId=subcatId;
//    [self.navigationController pushViewController:getAllArticles animated:YES];
}

#pragma mark -Button Menu Tapped
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
