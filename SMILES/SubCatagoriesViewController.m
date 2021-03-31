//
//  SubCatagoriesViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 21/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "SubCatagoriesViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "UIAlertView+Blocks.h"
#import "UIImageView+WebCache.h"
#import "GetAllArticlesViewController.h"
#import "ArticleCatTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "SubSubCategoryViewController.h"
#import "SCLAlertView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface SubCatagoriesViewController ()<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UITableView *subCategoriesTableView;
    //Array Declaration
    NSMutableArray *arrSubCatId,*arrSubCatName,*arrSubParentId,*arrSubCatChild;
    UIRefreshControl *refreshControl;
    NSString *strSubCatIdentifier;
         NSString *uID,*UserType;
}

@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SubCatagoriesViewController
@synthesize strCatId,subCatName;

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
    [subCategoriesTableView setHidden:YES];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllSubCategories) forControlEvents:UIControlEventValueChanged];
    [subCategoriesTableView addSubview:refreshControl];
    subCategoriesTableView.alwaysBounceVertical = YES;
     subCategoriesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAllSubCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            //[Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            return;

            
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSArray *occationType = [data objectForKey:@"subcategories"];
        arrSubCatChild=[occationType valueForKey:@"child_cat"];
        arrSubCatId=[occationType valueForKey:@"id"];
        arrSubCatName=[occationType valueForKey:@"name"];
        arrSubParentId=[occationType valueForKey:@"parent_id"];
        [subCategoriesTableView setHidden:NO];
        [subCategoriesTableView reloadData];
    }];
}

#pragma mark -Button Menu Tapped
- (IBAction)btnMenuTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TableViewDeligates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSubCatName count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleCatTableViewCell  *cell = (ArticleCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"subcategorycell"];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.lblSubCatName.text=[arrSubCatName objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    strSubCatIdentifier=[arrSubCatChild objectAtIndex:indexPath.row];
    if ([strSubCatIdentifier isEqualToString:@"1"]) {
        SubSubCategoryViewController *subsubsublist=[self.storyboard instantiateViewControllerWithIdentifier:@"SubSubCategoryViewController"];
        subsubsublist.strCatId=[arrSubCatId objectAtIndex:indexPath.row];
        subsubsublist.subCatName=[arrSubCatName objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:subsubsublist animated:YES];
    }
    else
    {
    /*GetAllArticlesViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    getAllArticles.strSubCatId=[arrSubCatId objectAtIndex:indexPath.row];
    getAllArticles.subCatBack=@"Back";
    [self.navigationController pushViewController:getAllArticles animated:YES]; */
        
        GetAllArticlesVC *getAllArticles = [self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesVCSBID"];
        getAllArticles.strSubCatId=[arrSubCatId objectAtIndex:indexPath.row];
        getAllArticles.subCatBack=@"Back";
        [self.navigationController pushViewController:getAllArticles animated:YES];
    }
    
    
}

@end
