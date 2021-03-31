//
//  ArticlesViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "ArticlesViewController.h"
#import "REFrostedViewController.h"
#import "Utility.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "UIAlertView+Blocks.h"
#import "UIImageView+WebCache.h"
#import "SubCatagoriesViewController.h"
#import "ArticleCatTableViewCell.h"
#import "GetAllArticlesViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "SequenceTableViewCell.h"
#import "Subdata.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"
//#import "GetAllArticlesVC"
 

@interface ArticlesViewController ()<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>{
    UIRefreshControl *refreshControl;
    NSMutableArray *arrSubCategories,*arrSubcategoryName;
    NSString *expanded;
    SKSTableViewCell *cell ;
    NSMutableArray *datas;
    NSString *uID,*UserType;
    UIView *backGroundView;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (weak, nonatomic) IBOutlet SKSTableView *categoriesTableView;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
    arrSubcategoryName=[[NSMutableArray alloc] init];
    [self.categoriesTableView setHidden:YES];
//    if ([self.colapse isEqualToString:@"yes"]) {
//        cell.downArrowImg.image=[UIImage imageNamed:@"catdownarrow"];
//    }
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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    //    [self.categoriesTableView reloadData];
    //cell.downArrowImg.image=[UIImage imageNamed:@"catdownarrow"];
    [self getAllCategoryArticles];
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
-(void)navigationConfiguration
{
    
    self.title=[Language Topics];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    label.text = [Language Topics];
//    [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
//    label.textColor=[UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:label];
   // self.navigationItem.titleView = view;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }



#pragma mark - Get All Category Articles
-(void)getAllCategoryArticles{
   // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllCategoriesWithUserID:uID andCompleteBlock:^(BOOL success, id result) {
        
       // [Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
           // [Utility showAlert:AppName withMessage:result];
             [self.categoriesTableView setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=[Language NoArticlecategoryavailable];
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        self.arraTotalCategories = [data valueForKey:@"categories"];
        self.arrCategories = [[NSMutableArray alloc] init];
        [self.arrCategories addObjectsFromArray:self.arraTotalCategories];
        [self.categoriesTableView setHidden:NO];
        self.categoriesTableView.SKSTableViewDelegate = self;
        self.categoriesTableView.shouldExpandOnlyOneCell = YES;
        [self.categoriesTableView reloadData];
    }];
}

#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"the count %ld",self.arrCategories.count);
    return self.arrCategories.count;
}
- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=[self.arrCategories objectAtIndex:indexPath.row];
    arrSubCategories = [[NSMutableArray alloc] init];
    if([d valueForKey:@"subcategories"])
    {
        arrSubCategories=[[d valueForKey:@"subcategories"] mutableCopy];
    }
    if ([arrSubCategories isEqual:[NSNull null]] || ![arrSubCategories count]) {
        return 0;
    }
    return arrSubCategories.count;
}
- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *strImg=[[self.arrCategories objectAtIndex:indexPath.row]valueForKey:@"photo_cat"];
    [cell.imageViewCategory sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImg]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    cell.lblCategoryName.textColor=[UIColor whiteColor];
    
    NSString *strviewCount=[NSString stringWithFormat:@"%@",[[self.arrCategories objectAtIndex:indexPath.row]valueForKey:@"view_count"]];
    NSString *strNewCount=[NSString stringWithFormat:@"NEW - %@",strviewCount];
    
    cell.lblNewArticleCount.layer.masksToBounds=YES;
    
    if ([strviewCount isEqualToString:@"0"] || [strviewCount isEqualToString:@""] || [strviewCount isEqual:[NSNull null]] || strviewCount==nil)
    {
        cell.lblNewArticleCount.hidden=YES;
    }
    else
    {
         cell.lblNewArticleCount.hidden=NO;
        cell.lblNewArticleCount.text=strNewCount;
    }
    NSString *strMainCat=[NSString stringWithFormat:@"  %@",[[self.arrCategories objectAtIndex:indexPath.row] valueForKey:@"name"]];
    if ([strMainCat isEqual:[NSNull null]]) {
        NSLog(@"Main Cat is coming NULL");
    }
    else{
        cell.lblCategoryName.text=[NSString stringWithFormat:@"  %@",[[self.arrCategories objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    
    if (!cell.imageViewCategory.image) {
        cell.imageViewCategory.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    cell.expandable=YES;
    cell.accessoryView = nil;
        
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SequenceTableViewCell";
    SequenceTableViewCell *subcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!subcell)
        subcell = [[SequenceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *strSubCat=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"name"];
    if ([strSubCat isEqual:[NSNull null]]) {
        NSLog(@"SubCat Coming NULL");
        subcell.lblArticleTitlel.text=@"";
    }
    else{
        subcell.lblArticleTitlel.text=[[arrSubCategories objectAtIndex:indexPath.subRow-1] valueForKey:@"name"];
        //subcell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        subcell.btnSelect.tag = 100+indexPath.subRow;
        [subcell.btnSelect addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return subcell;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0f;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
 }

//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
//}
- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
}
- (IBAction)btnSerchTapped:(id)sender
{
    /*
    GetAllArticlesViewController *searchController=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    searchController.searchIdentify=@"search";
    [self.navigationController pushViewController:searchController animated:YES]; */
    
    ArticleSearchVC *searchObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleSearchVCSBID"];
    [self.navigationController pushViewController:searchObj animated:YES];
}
#pragma mark _Menu button Tapped
- (IBAction)btnMenuTapped:(id)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture)
    {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

#pragma mark -Show Details Tapped
-(void)showDetailView:(id)sender{
    NSInteger rowVal = [sender tag]-100;
    NSString *subcatId=[[arrSubCategories objectAtIndex:rowVal-1] valueForKey:@"id"];
    NSString *subcatName=[[arrSubCategories objectAtIndex:rowVal-1] valueForKey:@"name"];
    NSString *childCatIdentify=[[arrSubCategories objectAtIndex:rowVal-1] valueForKey:@"child_cat"];
    if ([childCatIdentify isEqualToString:@"1"]) {
        NSLog(@"Child class");
        SubCatagoriesViewController *subSubCategorys=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCatagoriesViewController"];
        subSubCategorys.strCatId=subcatId;
        subSubCategorys.subCatName=subcatName;
        [self.navigationController pushViewController:subSubCategorys animated:YES];
    }
    else
    {
//    GetAllArticlesViewController *getAllArticles=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
//    getAllArticles.strSubCatId=subcatId;
//    [self.navigationController pushViewController:getAllArticles animated:YES];
        
        GetAllArticlesVC *getAllArticles = [self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesVCSBID"];
        getAllArticles.strSubCatId = subcatId;
        [self.navigationController pushViewController:getAllArticles animated:YES];
        

    }
}

@end
