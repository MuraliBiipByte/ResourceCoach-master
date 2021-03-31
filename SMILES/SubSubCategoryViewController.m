//
//  SubSubCategoryViewController.m
//  SMILES
//
//  Created by Biipmi on 25/11/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "SubSubCategoryViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "UIAlertView+Blocks.h"
#import "UIImageView+WebCache.h"
#import "GetAllArticlesViewController.h"
#import "ArticleCatTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface SubSubCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *subSubSubTableviewList;
    NSMutableArray *arrSubCatId,*arrSubCatName,*arrSubParentId,*arrSubCatChild;
    UIRefreshControl *refreshControl;
    NSString *strSubCatIdentifier;
     NSString *uID,*UserType;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SubSubCategoryViewController
@synthesize strSubCatId,subCatName;
@synthesize strCatId;

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
    arrSubCatId=[[NSMutableArray alloc] init];
    arrSubCatName=[[NSMutableArray alloc] init];
    arrSubParentId=[[NSMutableArray alloc] init];
    arrSubCatChild=[[NSMutableArray alloc] init];
    [subSubSubTableviewList setHidden:YES];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllSubCategories) forControlEvents:UIControlEventValueChanged];
    [subSubSubTableviewList addSubview:refreshControl];
    subSubSubTableviewList.alwaysBounceVertical = YES;
    
    subSubSubTableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    
    [self getAllSubCategories];
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
    
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    self.title=subCatName;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
}

#pragma mark - Get All Sub Categories
-(void)getAllSubCategories{
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllSucbcategoriesWithCatId:strCatId andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
          //  [Utility showAlert:AppName withMessage:result];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            return;

            
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSArray *subSubSubcategory = [data objectForKey:@"subcategories"];
        arrSubCatChild=[subSubSubcategory valueForKey:@"child_cat"];
        arrSubCatId=[subSubSubcategory valueForKey:@"id"];
        arrSubCatName=[subSubSubcategory valueForKey:@"name"];
        arrSubParentId=[subSubSubcategory valueForKey:@"parent_id"];
        [subSubSubTableviewList setHidden:NO];
        [subSubSubTableviewList reloadData];
    }];
}

#pragma TableViewDeligates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSubCatName count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ArticleCatTableViewCell  *cell = (ArticleCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"subsubcell"];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.lbl3SubCategory.text=[arrSubCatName objectAtIndex:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*GetAllArticlesViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    getAllArticles.strSubCatId=[arrSubCatId objectAtIndex:indexPath.row];
    getAllArticles.subCatBack=@"Back";
    [self.navigationController pushViewController:getAllArticles animated:YES]; */
    
    GetAllArticlesVC *getAllArticles = [self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesVCSBID"];
    getAllArticles.strSubCatId=[arrSubCatId objectAtIndex:indexPath.row];
    getAllArticles.subCatBack=@"Back";
    [self.navigationController pushViewController:getAllArticles animated:YES];
}

- (IBAction)btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
