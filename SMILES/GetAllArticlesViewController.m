//
//  GetAllArticlesViewController.m
//  SMILES
//
//  Created by Biipmi on 26/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "GetAllArticlesViewController.h"
#import "ArticleDetailsViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "ArticleCatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "ArticlesViewController.h"
#import "SequenceViewController.h"
#import "HomeViewController.h"
#import "HYCircleLoadingView.h"
#import "YTPlayerView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "SubscriptionViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import "SearchTableViewCell.h"



@interface GetAllArticlesViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>{
    UIRefreshControl *refreshController;
    NSDictionary *productData;
    NSInteger articleIndex;
    NSMutableArray *data;
    ArticleCatTableViewCell *cell;
    NSString *usrId;
    __weak IBOutlet UITableView *languageTableView;
    __weak IBOutlet UITableView *categoriesTableviewList;
     __weak IBOutlet UITableView *tblSearchHistory;
    UIRefreshControl *refreshControl;
    UISearchBar *searchBar;
    NSString *searchValue;
    UIImageView *img;
    UILabel *lblass;
    NSMutableArray *arrLinks;
   NSString *noMatchFound;
    __weak IBOutlet UIBarButtonItem *btnSelectLanguage;
    
    NSMutableArray *arrLanguages;
    NSString *selectedLanguage;
    
    UIImageView *img1;
    UILabel *lblass1;
     NSString *uID,*UserType;
    
    NSString *loginUserType;
    NSMutableArray *arrVideoType;
    NSMutableArray *arrCategory_lock;
     UIView *backGroundView;
    NSArray *recipes;
  
    NSArray *arrSearchResults;
    NSMutableArray* filteredTableData;
    Boolean isFiltered;
    
}
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;



@end

@implementation GetAllArticlesViewController

@synthesize strSubCatId,subCatBack,searchIdentify,strIdentify;

- (void)viewDidLoad
{
    [super viewDidLoad];
    languageTableView.hidden=YES;
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    usrId=[userDefaults valueForKey:@"id"];
    NSLog(@"userid is %@",usrId);
    
    arrVideoType=[[NSMutableArray alloc]init];
    arrCategory_lock = [[NSMutableArray alloc]init];
    arrLanguages=[[NSMutableArray alloc]initWithObjects:@"English",@"Zawgyi", nil];
    
    [self navigationConfiguration];
    
   
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;

    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    
    [categoriesTableviewList setHidden:YES];
    data=[[NSMutableArray alloc]init];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    if ([strIdentify isEqualToString:@"Home"])
    {
        [refreshControl addTarget:self action:@selector(HomeCatAllArticles) forControlEvents:UIControlEventValueChanged];
        btnSelectLanguage.enabled=NO;
        btnSelectLanguage.tintColor=[UIColor clearColor];
    }
    
   else if ([strIdentify isEqualToString:@"sequenceList"])
   {
        [refreshControl addTarget:self action:@selector(getSequenceDetails) forControlEvents:UIControlEventValueChanged];
        btnSelectLanguage.enabled=NO;
        btnSelectLanguage.tintColor=[UIColor clearColor];
    }
    else if ([searchIdentify isEqualToString:@"search"])
    {
        [refreshControl addTarget:self action:@selector(search) forControlEvents:UIControlEventValueChanged];
        btnSelectLanguage.enabled=NO;
        btnSelectLanguage.tintColor=[UIColor clearColor];
        
    }
    else
    {
        btnSelectLanguage.enabled=NO;
        btnSelectLanguage.tintColor=[UIColor clearColor];
        
        [refreshControl addTarget:self action:@selector(getAllArticles) forControlEvents:UIControlEventValueChanged];
    }
    [categoriesTableviewList addSubview:refreshControl];
    categoriesTableviewList.alwaysBounceVertical = YES;
    
   
    arrLinks=[[NSMutableArray alloc]init];
    
  tblSearchHistory.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  tblSearchHistory.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];  
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];

    if ([strIdentify isEqualToString:@"sequenceList"])
          {
              
         [self getSequenceDetails];
              
         }
    else if ([searchIdentify isEqualToString:@"search"])
    {
        tblSearchHistory.hidden=NO;
         [self gettingSearchHistory];
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        [searchBar sizeToFit];
        /*UISearchDisplayController *searchDisplayController= [[UISearchDisplayController alloc] initWithSearchBar:searchBar                                                                                            contentsController:self];
        self.searchDisplayController.searchResultsDelegate = self;
        self.searchDisplayController.searchResultsDataSource = self;
        self.searchDisplayController.delegate = self; */
        
        UISearchDisplayController *searchDisplayController= [[UISearchDisplayController alloc] initWithSearchBar:searchBar                                                                                            contentsController:self];
        self.searchDisplayController.searchResultsDelegate = self;
        self.searchDisplayController.searchResultsDataSource = self;
        self.searchDisplayController.delegate = self;
        self.navigationItem.titleView = searchDisplayController.searchBar;
        
        
        searchBar.placeholder=[Language SearchArticles];
        searchBar.tintColor=[UIColor redColor];
        searchBar.delegate=self;
    }
   else if ([strIdentify isEqualToString:@"Home"])
    {
        [self HomeCatAllArticles];
    }

    else
    {
        [self getAllArticles];
    }
}
-(void)checkUserType
{
    
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result)
    {
        NSLog(@"CheckUserType  : %@",result);
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
            
            
            if (![UserType isEqualToString:type] )
            {
                
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
-(void)search
{
    // [Utility showLoading:self];
    tblSearchHistory.hidden=YES;
     backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [categoriesTableviewList setHidden:NO];
    [refreshControl endRefreshing];
    
    [[APIManager sharedInstance]search:usrId andWithKeyText:searchValue andWithUserId:usrId andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
         backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            //[Utility showAlert:AppName withMessage:result];
            img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Bold" size:14];
            lblass.text=noMatchFound;
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            [categoriesTableviewList setHidden:YES];
            [img setHidden:NO];
            [lblass setHidden:NO];
            return ;
           
        }
        [img setHidden:YES];
        [lblass setHidden:YES];
       
        data=[result objectForKey:@"article_data"];
        loginUserType=[result valueForKey:@"user_type"];
        
        [categoriesTableviewList setHidden:NO];
        [categoriesTableviewList reloadData];
    }];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(![searchBar.text isEqualToString:@""])
    {
    searchValue=searchBar.text;
    NSLog(@"%@",searchValue);
    [searchBar resignFirstResponder];
    [img setHidden:YES];
    [lblass setHidden:YES];
     [self search];
    }
    else
    {
        
        [Utility showAlert:AppName withMessage:@"Please Enter Text to search"];
    }

    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    if ([strIdentify isEqualToString:@"sequenceList"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *language1=[defaults valueForKey:@"language"];
        if ([language1 isEqualToString:@"2"])
        {
            self.title=@"mini-သင်ခန်းစာများ Lis";
          //  postedOn=@"发表于:";
           // viewsArt=@"视图:";
           // by=@"通过 ";
          //  Ok=@"好";
          //  Cancel=@"取消";
          //  removeFav=@"您确定要将此文章从收藏夹列表中删除吗？";
          ///  noArticle=@"没有文章";
           // noSequence=@"无序列可用";
            noMatchFound=@"မီးခြစ်မျှမတွေ့";
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],

               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];

        }
        else if ([language1 isEqualToString:@"3"])
        {
            //  self.title=@"အစဉ်အတိုင်းလိုက်ခြင်း";
           // postedOn=@"တွင် Posted:";
           // viewsArt=@"အမြင်ချင်း";
           // by=@"အားဖြင့် ";
            //Ok=@"အိုကေ";
            //Cancel=@"ဖျက်သိမ်း";
           // removeFav=@"သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?";
           // noArticle=@"ရရှိနိုင်သောပုဒ်မဘယ်သူမျှမက";
           // noSequence=@"ရရှိနိုင် sequence ကိုအဘယ်သူမျှမ";
            noMatchFound=@"မီးခြစ်မျှမတွေ့";
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            label.text = @"mini-သင်ခန်းစာများ Lis";
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];

            [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];

            self.navigationItem.titleView = view;
        }
        else
       {
            self.title=@"Mini-Lessons List";
            //postedOn=@"Posted On";
            //viewsArt=@"Views:";
           // by=@"By ";
           // Ok=@"ok";
           // Cancel=@"cancel";
           // removeFav=@"Are you sure, you want to remove this article from your Favorite List?";
           // noArticle=@"No Article Available";
           // noSequence=@"No sequence available";
            noMatchFound=@"No Match Found";
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],

               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];

        }
    }
    else
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *language2=[defaults valueForKey:@"language"];
        if ([language isEqualToString:@"2"])
        {
            //self.title=[Language Articles];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            label.text = [Language Articles];
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];

            [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];

            self.navigationItem.titleView = view;
            noMatchFound=@"မီးခြစ်မျှမတွေ့";
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],

               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];

    }
        else if ([language2 isEqualToString:@"3"])
        {
            // self.title=@"ဆောင်းပါးများ";
           // postedOn=@"တွင် Posted:";
           // viewsArt=@"အမြင်ချင်း";
           // by=@"အားဖြင့် ";
           // Ok=@"အိုကေ";
            //Cancel=@"ဖျက်သိမ်း";
           // removeFav=@"သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?";
           // noArticle=@"ရရှိနိုင်သောပုဒ်မဘယ်သူမျှမက";
           // noSequence=@"ရရှိနိုင် sequence ကိုအဘယ်သူမျှမ";
            noMatchFound=@"မီးခြစ်မျှမတွေ့";
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            label.text = @"ဆောင်းပါးများ";
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];

            [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];

            self.navigationItem.titleView = view;
           
            
            
        }
        
        else if ([searchIdentify isEqualToString:@"search"])
        {
           
           // postedOn=@"Posted On";
           // viewsArt=@"Views:";
           // by=@"By ";
           // Ok=@"ok";
           // Cancel=@"cancel";
           // removeFav=@"Are you sure, you want to remove this article from your Favorite List?";
            //noArticle=@"No Article Available";
           // noSequence=@"No Mini-Lessons available";
            noMatchFound=@"No matches found";
            
//            CGRect frameimg = CGRectMake(4, 4, 25, 25);
//            UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//            [someButton addTarget:self action:@selector(nextClass)
//                 forControlEvents:UIControlEventTouchUpInside];
//            [someButton setBackgroundImage:[UIImage imageNamed:@"History"] forState:UIControlStateNormal];
//            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
//            self.navigationItem.rightBarButtonItem=barButtonItem;
//            self.navigationItem.rightBarButtonItem.enabled=NO;
//
            
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        }
        else
        {
            self.title=@"Lessons";
            // postedOn=@"Posted On";
            // viewsArt=@"Views:";
            // by=@"By ";
            // Ok=@"ok";
            // Cancel=@"cancel";
            // removeFav=@"Are you sure, you want to remove this article from your Favorite List?";
            //noArticle=@"No Article Available";
            // noSequence=@"No Mini-Lessons available";
            noMatchFound=@"No matches found";
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
        }
    }
   
    
}



#pragma mark - Get All Articles
-(void)getAllArticles
{
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllArticlesWithSubCatId:strSubCatId andWithUserid:usrId andLanguage:selectedLanguage andCompleteBlock:^(BOOL success, id result)
     
     {
         // [Utility hideLoading:self];
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
         [refreshControl endRefreshing];
         if (!success)
         {
             // [Utility showAlert:AppName withMessage:result];
             img1=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
             img1.image=[UIImage imageNamed:@"nodataimg"];
           lblass1=[[UILabel alloc] initWithFrame:CGRectMake(8, img1.frame.origin.y+108, self.view.frame.size.width-16, 21)];
             lblass1.textAlignment=NSTextAlignmentCenter;
             lblass1.textColor=[UIColor lightGrayColor];
             lblass1.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
             lblass1.text=[Language NoArticlesAvailable];
             [self.view addSubview:img1];
             [self.view addSubview:lblass1];
             categoriesTableviewList.hidden=YES;
             return ;
         }
         
         lblass1.hidden=YES;
         img1.hidden=YES;
         data=[result objectForKey:@"article_data"];
         NSLog(@"article_data = %@",data);
         loginUserType = [result valueForKey:@"user_type"];
         [categoriesTableviewList setHidden:NO];
         [categoriesTableviewList reloadData];
     }];
}
#pragma mark - Get All Articles
-(void)HomeCatAllArticles
{
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
   
  [[APIManager sharedInstance]homeCategoryArticlesListWithCatId:strSubCatId andWithUserId:usrId andCompleteBlock:^(BOOL success, id result)
     
     {
         // [Utility hideLoading:self];
         backGroundView.hidden=YES;
         [self.loadingView stopAnimation];
         [self.loadingView setHidden:YES];
         [self.img setHidden:YES];
         [refreshControl endRefreshing];
         if (!success) {
             // [Utility showAlert:AppName withMessage:result];
             img1=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
             img1.image=[UIImage imageNamed:@"nodataimg"];
             lblass1=[[UILabel alloc] initWithFrame:CGRectMake(8, img1.frame.origin.y+108, self.view.frame.size.width-16, 21)];
             lblass1.textAlignment=NSTextAlignmentCenter;
             lblass1.textColor=[UIColor lightGrayColor];
             lblass1.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
             lblass1.text=[Language NoArticlesAvailable];
             [self.view addSubview:img1];
             [self.view addSubview:lblass1];
             categoriesTableviewList.hidden=YES;
             return ;
         }
         
         lblass1.hidden=YES;
         img1.hidden=YES;
         data=[result objectForKey:@"article_data"];
         loginUserType = [result valueForKey:@"user_type"];
         [categoriesTableviewList setHidden:NO];
         [categoriesTableviewList reloadData];
     }];
}

#pragma mark -Get Article Details Tapped
-(void)getSequenceDetails
{
       // [Utility showLoading:self];
    backGroundView.hidden=NO;

    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getSequenceDetailsWithUserId:usrId andWithSequenceId:self.strSeqId andCompleteBlock:^(BOOL success, id result)
    {
        // [Utility hideLoading:self];
        backGroundView.hidden=YES;

        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        
        if (!success) {
            // [Utility showAlert:AppName withMessage:result];
            UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img1.image=[UIImage imageNamed:@"nodataimg"];
            lblass1=[[UILabel alloc] initWithFrame:CGRectMake(8, img1.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass1.textAlignment=NSTextAlignmentCenter;
            lblass1.textColor=[UIColor lightGrayColor];
            lblass1.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass1.text=[Language NoSequenceAvailable];
            [self.view addSubview:img1];
            [self.view addSubview:lblass1];
            return ;
        }
        img1.hidden=YES;
        data=[result objectForKey:@"sequence_data"];
        loginUserType = [result valueForKey:@"user_type"];
        [categoriesTableviewList setHidden:NO];
        [categoriesTableviewList reloadData];
    }];
}

#pragma mark - TableViewDeligates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==categoriesTableviewList)
    {
        return 190.0f;
    }
    else if(tableView==languageTableView)
    {
        return 45.0f;
    }
    else if(tableView==tblSearchHistory)
    {
        return 45.0f;
    }
    return 0;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==categoriesTableviewList)
    {
        return [data count];
    }
    else if(tableView==languageTableView)
    {
        return [arrLanguages count];
    }
    else if(tableView==tblSearchHistory)
    {
        int rowCount;
        if(isFiltered)
        {
            rowCount = filteredTableData.count;
        }
        else
        {
            rowCount = arrSearchResults.count;
        }
        
        
        return rowCount;
        
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
  //  [arrVideoType removeAllObjects];
    if (tableView==categoriesTableviewList)
    {
        
        cell = (ArticleCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArticleCatTableViewCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCatTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSDictionary *dict = [data objectAtIndex:indexPath.row];
        [arrVideoType addObject:[dict valueForKey:@"article_type"]];
        [arrCategory_lock addObject: [dict valueForKey:@"category_lock"]];
        
        NSString *title=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];
        cell.lblArticleTitle.text=[title uppercaseString];
        NSString *type=[dict valueForKey:@"file_type"];
        if ([type isEqual:[NSNull null]])
        {
            
            NSLog(@"Article list is coming null");
            
        }
        else if ([type isEqualToString:@"2"])
        {
            NSLog(@"type is Photo");
            cell.articleVideoPlayImg.hidden=YES;
            NSString *imgStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"photo1"]];
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
            [cell.lblArticleDuration setHidden:YES];
        }
        else if([type isEqualToString:@"3"])
        {
            NSString *imgStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_thumb"]];
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
            cell.articleVideoPlayImg.hidden=NO;
            [cell.lblArticleDuration setHidden:NO];
            cell.lblArticleDuration.text=[dict valueForKey:@"link_duration"];

        }
        
        else
        {

            NSString *UrlStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_thumb"]];
            
            [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",UrlStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
        }
        
    
        if (!cell.articleImage.image)
        {
            cell.articleImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
        }
        NSDictionary *auth=[dict objectForKey:@"user_data"];
        NSString *byAuth=[[Language By] stringByAppendingString:[auth valueForKey:@"username"]];
        cell.lblAuthorName.text=[NSString stringWithFormat:@"%@", byAuth];
        NSString *str=[NSString stringWithFormat:@"%@",[dict valueForKey:@"avg_rate"]];
        if ([str isEqualToString:@"0"])
        {
            cell.lblRateCount.text=[NSString stringWithFormat:@"%@",str];
        }
        else
        {
            float rat=[str floatValue];
            cell.lblRateCount.text=[NSString stringWithFormat:@"%.1f",rat];
        }
        
        NSNumber *number=[dict valueForKey:@"review_count"];
        NSString *string=[number stringValue];
        if ([string isEqualToString:@"0"])
        {
            cell.lblReviedCount.text=@"";
        }
        else
        {
            cell.lblReviedCount.text=[NSString stringWithFormat:@"(%@)",string];
        }
        NSString *vie=[[Language Views] stringByAppendingString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"view_count"]]];
        cell.lblViewsCount.text=[NSString stringWithFormat:@"%@",vie];
        NSString *shortDes=[dict valueForKey:@"short_description"];
        if ([shortDes isEqual:[NSNull null]])
             {
            NSLog(@"Null Data");
        }
        else
        {
            cell.lblShortDescription.text=[dict valueForKey:@"short_description"];
        }
        cell.articleImage.layer.masksToBounds = YES;
        cell.articleImage.layer.cornerRadius = 5.0;
        NSString *watch=[dict valueForKey:@"watched"];
        if ([watch isEqualToString:@"yes"])
        {
            cell.imgNew.hidden=YES;
            cell.viewedImage.hidden=NO;
        }
        else
        {
            cell.imgNew.hidden=NO;
            cell.viewedImage.hidden=YES;
        }
        NSString * favStatu = [dict objectForKey:@"favorite"] ;
        if ([favStatu isEqualToString:@"no"]) {
            [cell.favPressedImg setImage:[UIImage imageNamed:@"unfavorite"]];
        }
        else{
            [cell.favPressedImg setImage:[UIImage imageNamed:@"favorite"]];
        }
        [cell.btnFavorite addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        CALayer *layer=cell.layer;
        layer.masksToBounds=NO;
        layer.cornerRadius = 4.0f;
        cell.layer.cornerRadius=5.0;
        cell.contentView.layer.cornerRadius=5.0;
        cell.lblBgRate.layer.masksToBounds=YES;
        cell.lblBgRate.layer.cornerRadius=4.0;
        
        
        NSString *artType=[arrVideoType objectAtIndex:indexPath.row];
        if ([loginUserType isEqualToString:@"non_subscriber"]&&[artType isEqualToString:@"subscriber"])
        {
            cell.btnFavorite.enabled=NO;
            //cell.imgArticleLock.hidden = NO;
        }
        else
        {
            cell.btnFavorite.enabled=YES;
            //cell.imgArticleLock.hidden = YES;
        }
        
        NSString *catLock = [arrCategory_lock objectAtIndex:indexPath.row];
        if ([catLock isEqual:@"1"])
        {
            cell.imgArticleLock.hidden = NO;
            cell.btnFavorite.hidden = YES;
            cell.favPressedImg.hidden = YES;
        }else{
            cell.imgArticleLock.hidden = YES;
            cell.btnFavorite.hidden = NO;
            cell.favPressedImg.hidden = NO;
        }
        
            if (cell) {
                CGFloat direction = cell ? -1 : 1;
                cell.transform = CGAffineTransformMakeTranslation(cell.bounds.size.width * direction, 0);
                [UIView animateWithDuration:0.25 animations:^{
                    cell.transform = CGAffineTransformIdentity;
                }];
            }
        
        return cell;
        
    }
    else if(tableView==languageTableView)
    {
        
        static NSString *simpleTableIdentifier = @"LanguagesTableView";
        
        UITableViewCell*cell1 = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            
        }
        cell1.backgroundColor=[UIColor grayColor];
        cell1.textLabel.text = [arrLanguages objectAtIndex:indexPath.row];
        return cell1;
    }
    
    else if(tableView==tblSearchHistory)
    {
        static NSString *simpleTableIdentifier = @"SearchTableViewCell";
        
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell.imgSearch.image =[UIImage imageNamed:@"SearchHistory"];
        if(isFiltered)
        {
            cell.lblHistoryName.text=[filteredTableData objectAtIndex:indexPath.row];
        }
       
        else
        {
            cell.lblHistoryName.text=[arrSearchResults objectAtIndex:indexPath.row];
        }
     
        return cell;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==categoriesTableviewList)
    {
        
        
        NSString *artType=[arrVideoType objectAtIndex:indexPath.row];
        /* if ([loginUserType isEqualToString:@"non_subscriber"]&&[artType isEqualToString:@"subscriber"])
        {
            SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
            [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
        }*/
        NSString *catLock = [arrCategory_lock objectAtIndex:indexPath.row];
        if([catLock isEqualToString:@"1"]){
            SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
            [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
        }
        else
        {
            NSDictionary *dict = [data objectAtIndex:indexPath.row];
            NSString *articleid=[dict valueForKey:@"id"];
            ArticleDetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
            details.articleId=articleid;
            details.strMinicertificationId=@"";
            [self.navigationController pushViewController:details animated:YES];
        }

        
//        if (cell.imgFavLock.hidden==NO) {
//            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//            [alert setHorizontalButtons:YES];
//            
//            [alert showSuccess:AppName subTitle:@"Please Subscribe With us to watch this video" closeButtonTitle:[Language ok] duration:0.0f];
//        }
//        else{
//            ArticleDetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
//            details.articleId=articleid;
//            [self.navigationController pushViewController:details animated:YES];
//        }
    }
    else if (tableView==languageTableView)
    {
        
        
        NSLog(@"clicked on language");
        NSString *langua=[arrLanguages objectAtIndex:indexPath.row];
        if ([langua isEqualToString:@"English"]) {
            selectedLanguage=@"en";
        }
        else if ([langua isEqualToString:@"Chinese"]) {
            selectedLanguage=@"zh";
        }
        else   if ([langua isEqualToString:@"Zawgyi"]) {
            selectedLanguage=@"my";
        }
        languageTableView.hidden=YES;
        lblass1.hidden=YES;
        img1.hidden=YES;
        [self getAllArticles];
    }
    else if (tableView==tblSearchHistory)
    {
        if(isFiltered)
        {
            searchBar.text=[filteredTableData objectAtIndex:indexPath.row];
            tblSearchHistory.hidden=YES;
            [self searchBarSearchButtonClicked:searchBar];
        }
        else
        {
            searchBar.text=[arrSearchResults objectAtIndex:indexPath.row];
            tblSearchHistory.hidden=YES;
            [self searchBarSearchButtonClicked:searchBar];
        }
       
       
    }
    
    
}

#pragma mark -Button Add To Favourite Tapped
-(void)addToFavorite:(id)sender
{
    ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
    NSIndexPath *indexPathCell = [categoriesTableviewList indexPathForCell:clickedCell];
    NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
    NSString* strArticleId=[dict valueForKey:@"id"];
    NSString * favStatu = [dict objectForKey:@"favorite"] ;
    if ([favStatu isEqualToString:@"no"])
    {
        // [Utility showLoading:self];
        backGroundView.hidden=NO;
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        [[APIManager sharedInstance]addArticleToMyFavoriteArticlesWithUserId:usrId andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
            // [Utility hideLoading:self];
              backGroundView.hidden=YES;
            [self.loadingView stopAnimation];
            [self.loadingView setHidden:YES];
            [self.img setHidden:YES];
            if (!success) {
               // [Utility showAlert:AppName withMessage:result];
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                
                [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
                return;

                
                return ;
            }
            if ([strIdentify isEqualToString:@"sequenceList"])
            {
                [self getSequenceDetails];
            }
            else if ([searchIdentify isEqualToString:@"search"])
            {
                [self search];
            }
            else
            {
                [self getAllArticles];
            }
            //            [self getAllArticles];
        }];
    }
    else{
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
                [alert addButton:[Language ok] actionBlock:^(void)
                 {
                     ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
                     NSIndexPath *indexPathCell = [categoriesTableviewList indexPathForCell:clickedCell];
                     NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
                     NSString* strArticleId=[dict valueForKey:@"id"];
                     // [Utility showLoading:self];
                      backGroundView.hidden=NO;
                     [self.loadingView startAnimation];
                     [self.loadingView setHidden:NO];
                     [self.img setHidden:NO];
                     [[APIManager sharedInstance]removeArticleFromMyFavoriteArticlesWithUserId:usrId andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
                         // [Utility hideLoading:self];
                          backGroundView.hidden=YES;
                         [self.loadingView stopAnimation];
                         [self.loadingView setHidden:YES];
                         [self.img setHidden:YES];
                         if (!success) {
                             [Utility showAlert:AppName withMessage:result];
                             return ;
                         }
                         if ([strIdentify isEqualToString:@"sequenceList"]) {
                             [self getSequenceDetails];
                         }
                         else if ([searchIdentify isEqualToString:@"search"]){
                             [self search];
                         }
                         else{
                             [self getAllArticles];
                         }
                         
                     }];

                 }
                 ];
        [alert showSuccess:AppName subTitle:[Language removearticlefromFavouriteList] closeButtonTitle:[Language Cancel] duration:0.0f];
        
       

    }
}

#pragma mark - Back Button Tapped
- (IBAction)btnBackTapped:(id)sender {
    if ([strIdentify isEqualToString:@"sequenceList"]) {
        SequenceViewController *article=[self.storyboard instantiateViewControllerWithIdentifier:@"SequenceViewController"];
        [self.navigationController pushViewController:article animated:YES];
    }
    else if ([searchIdentify isEqualToString:@"search"]){
        //searchBar.hidden=YES;
        RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
        [self presentViewController:homeView animated:YES completion:nil];
//        HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//        [self.navigationController pushViewController:home animated:YES];
    }
    else if ([subCatBack isEqualToString:@"Back"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
//        ArticlesViewController *article=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
//        article.colapse=@"yes";
//        [self.navigationController pushViewController:article animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)btnSelectLanguageTapped:(id)sender {
    
    languageTableView.hidden=NO;
    
    [self.view bringSubviewToFront:languageTableView];
    [languageTableView reloadData];
    
}
-(void)gettingSearchHistory
{
    arrSearchResults=[[NSArray alloc]init];
    //Need to start tableHERE
    [[APIManager sharedInstance]getSearchHistoryWithUserId:usrId andCompleteBlock:^(BOOL success, id result) {
        if (!success)
        {
            
            [tblSearchHistory setHidden:YES];
            self.navigationItem.rightBarButtonItem.enabled=NO;
            return ;
            
        }
        else
        {
            NSMutableArray *arrHistory=[result objectForKey:@"history"];
            arrSearchResults=[arrHistory valueForKey:@"name"];
            if (arrSearchResults.count>=1)
            {
                self.navigationItem.rightBarButtonItem.enabled=YES;
            }
            else
            {
                self.navigationItem.rightBarButtonItem.enabled=NO;
            }
            [tblSearchHistory reloadData];
            [tblSearchHistory setHidden:NO];
        }
    }];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    categoriesTableviewList.hidden=YES;
    [img setHidden:YES];
    [lblass setHidden:YES];
    
    return YES;
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
  
      tblSearchHistory.hidden=NO;

  
    return YES;
} // called before text changes
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}                        // return NO to not resign first responder

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
  
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = TRUE;
        filteredTableData = [[NSMutableArray alloc] init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
        NSArray *predicateResult =  [arrSearchResults filteredArrayUsingPredicate:predicate];
        [filteredTableData addObjectsFromArray:predicateResult];
    
    }
    
    [tblSearchHistory reloadData];
}

    






@end
