//
//  BookMarksDetailsViewController.m
//  Resource Coach
//
//  Created by Admin on 10/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "BookMarksDetailsViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "HYCircleLoadingView.h"
#import "SCLAlertView.h"
#import "ArticleCatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ArticleDetailsViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import "Language.h"


@interface BookMarksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *backGroundView;
    NSString *uID;
    NSString *userType;
    NSMutableArray *data;
     NSString *loginUserType;
    ArticleCatTableViewCell *cell;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end

@implementation BookMarksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
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
    
    data = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    userType=[usercheckup valueForKey:@"usertype"];
   
    [self navigationConfiguration];
     [self getBookMarkArticles];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    self.title= @"Book Marked Articles";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

-(void)backBtnTapped:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}
-(void)getBookMarkArticles
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getBookMarkedArticlesWithUserId:uID andwithBookMarkId:_strFolderId andCompleteBlock:^(BOOL success, id result) {
        _tblBookMarkArticles.hidden=YES;
        [self.loadingView stopAnimation];
        backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=@"No BookMarks Found";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        else
        {
            _tblBookMarkArticles.hidden=NO;
            NSDictionary *dicionary = [result objectForKey:@"data"];
            data=[dicionary objectForKey:@"article_data"];
            loginUserType = [dicionary valueForKey:@"login_usertype"];
            [_tblBookMarkArticles reloadData];
        }
    }];
}
#pragma mark - TableViewDeligates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190.0f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Dataa count %lu",(unsigned long)data.count);
    return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = (ArticleCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArticleCatTableViewCell"];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.imgBookMarkArticleLock.hidden = YES;
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    NSDictionary *auth=[dict objectForKey:@"user_data"];
    cell.lblBookmarkAuthorName.text = [NSString stringWithFormat:@"By %@",[auth valueForKey:@"username"]];
    NSString *str=[NSString stringWithFormat:@"%@",[dict valueForKey:@"avg_rate"]];
    if ([str isEqualToString:@"0"])
    {
        cell.lblBookMarkRateCount.text=[NSString stringWithFormat:@"%@",str];
    }
    else{
        float rat=[str floatValue];
        cell.lblBookMarkRateCount.text=[NSString stringWithFormat:@"%.1f",rat];
    }
    NSNumber *number=[dict valueForKey:@"review_count"];
    NSString *string=[number stringValue];
    if ([string isEqualToString:@"0"]) {
        
 
        cell.lblBookMarkReviedCount.text=@"";
    }
    else{
        cell.lblBookMarkReviedCount.text=[NSString stringWithFormat:@"(%@)",string];
    }
    NSString *vie=[NSString stringWithFormat:@"Views: %@",[dict valueForKey:@"view_count"]];
    cell.lblBookmarkViewsCount.text=[NSString stringWithFormat:@"%@",vie];
    
    cell.lblBookmarkArticleTitle.text =[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];
    cell.lblBookmarkShortDescription.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"short_description"]];
    
    NSString *fileType = [NSString stringWithFormat:@"%@",[dict valueForKey:@"file_type"]];
    if ([fileType isEqualToString:@"2"]) {
        cell.lblBookMarkArticleDuration.hidden=YES;
        cell.articleBookMarkVideoPlayImg.hidden=YES;
        NSString *strImageUrl =[dict valueForKey:@"photo1"];
        [cell.articleBookMarkImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImageUrl]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    }
    else if ([fileType isEqualToString:@"3"])
    {
        cell.articleBookMarkVideoPlayImg.hidden=NO;
        cell.lblBookMarkArticleDuration.hidden=YES;
        NSString *imgStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_thumb"]];
        
        if (([imgStr isEqual:[NSNull null]]) || [imgStr isEqualToString:@"<null>"]) {
            NSString *vID = nil;
            NSString *url = [NSString stringWithFormat:@"%@",[dict valueForKey:@"link"]];
            NSString *query = [url componentsSeparatedByString:@"?"][1];
            NSArray *pairs = [query componentsSeparatedByString:@"&"];
            for (NSString *pair in pairs) {
                NSArray *kv = [pair componentsSeparatedByString:@"="];
                if ([kv[0] isEqualToString:@"v"]) {
                    vID = kv[1];
                    break;
                }
            }

            NSLog(@"%@", vID);
            NSString *tmp1 = @"https://img.youtube.com/vi/";
            NSString *tmp2 = @"/1.jpg";
            
            NSString *youtubeImgStr = [NSString stringWithFormat:@"%@%@%@",tmp1,vID,tmp2];
            NSLog(@"%@",youtubeImgStr);
            
            NSURL *finalUrl = [NSURL URLWithString:youtubeImgStr];
            [cell.articleBookMarkImage sd_setImageWithURL:finalUrl placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"youtube thumnail downloaded in obj-c....");
            }];
            
            cell.lblBookMarkArticleDuration.text = @"00:00";
            cell.lblBookMarkArticleDuration.hidden=YES;
        }else{
            [cell.articleBookMarkImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
            cell.lblBookMarkArticleDuration.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_duration"]];
            cell.lblBookMarkArticleDuration.hidden=YES;
        }
        
        
   
    }else if ([fileType isEqualToString:@"4"]){
        cell.articleBookMarkVideoPlayImg.hidden=NO;
        cell.lblBookMarkArticleDuration.hidden=YES;
        
        
        NSString *vID = nil;
        NSString *url = [NSString stringWithFormat:@"%@",[dict valueForKey:@"link"]];
        NSString *query = [url componentsSeparatedByString:@"?"][1];
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *kv = [pair componentsSeparatedByString:@"="];
            if ([kv[0] isEqualToString:@"v"]) {
                vID = kv[1];
                break;
            }
        }

        NSLog(@"%@", vID);
        NSString *tmp1 = @"https://img.youtube.com/vi/";
        NSString *tmp2 = @"/1.jpg";
        
        NSString *youtubeImgStr = [NSString stringWithFormat:@"%@%@%@",tmp1,vID,tmp2];
        NSLog(@"%@",youtubeImgStr);
        
        NSURL *finalUrl = [NSURL URLWithString:youtubeImgStr];
        [cell.articleBookMarkImage sd_setImageWithURL:finalUrl placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"youtube thumnail downloaded in obj-c....");
        }];
        
        cell.lblBookMarkArticleDuration.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_duration"]];
        cell.lblBookMarkArticleDuration.hidden=YES;
        
        
    }
    else{
        cell.lblBookMarkArticleDuration.hidden=YES;
        cell.articleBookMarkVideoPlayImg.hidden=YES;
        cell.articleBookMarkImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    if (!cell.articleBookMarkImage.image)
    {
        cell.articleBookMarkImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    
    cell.articleBookMarkImage.layer.masksToBounds = YES;
    cell.articleBookMarkImage.layer.cornerRadius = 5.0;

    [cell.btnBookMarkDelete addTarget:self action:@selector(bookMarkDeleteArticle:) forControlEvents:UIControlEventTouchUpInside];
    CALayer *layer=cell.layer;
    layer.masksToBounds=NO;
    layer.cornerRadius = 4.0f;
    cell.layer.cornerRadius=5.0;
    cell.contentView.layer.cornerRadius=5.0;
    cell.lblBookMarkBgRate.layer.masksToBounds=YES;
    cell.lblBookMarkBgRate.layer.cornerRadius=4.0;
    
    
    NSString *artType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"article_type"]];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[artType isEqualToString:@"subscriber"])
    {
        cell.btnBookMarkFavorite.enabled=NO;
        cell.imgBookMarkArticleLock.hidden = NO;
    }
    else
    {
        cell.btnBookMarkFavorite.enabled=YES;
        cell.imgBookMarkArticleLock.hidden = YES;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // franklabes ,hawared university
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    NSString *artType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"article_type"]];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[artType isEqualToString:@"subscriber"])
    {
        SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
        [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
    }
    else
    {
        NSString *articleid=[dict valueForKey:@"id"];
//        ArticleDetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
        ArticleDetailsVC *details = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVCSBID"];
        
        details.articleId=articleid;
        details.strMinicertificationId=@"";
        [self.navigationController pushViewController:details animated:YES];
    }

   
    
    
}
-(void)bookMarkDeleteArticle:(id)sender
{
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
            [alert addButton:[Language ok] actionBlock:^(void)
             {
                /* ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
                 NSIndexPath *indexPathCell = [favoriteTablevieList indexPathForCell:clickedCell];
                 NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
                 NSString* strArticleId=[dict valueForKey:@"id"];
                 // [Utility showLoading:self];
                 [self.loadingView startAnimation];
                 [self.loadingView setHidden:NO];
                 [self.img setHidden:NO];
                 [[APIManager sharedInstance]removeArticleFromMyFavoriteArticlesWithUserId:userId andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
                     //[Utility hideLoading:self];
                     [self.loadingView stopAnimation];
                     [self.loadingView setHidden:YES];
                     [self.img setHidden:YES];
                     if (!success)
                     {
                         [Utility showAlert:AppName withMessage:result];
                         return ;
                     }
                     [self getAllFavoriteArticles];
                 }]; */
                ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
                NSIndexPath *indexPathCell = [_tblBookMarkArticles indexPathForCell:clickedCell];
                
                NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
                NSString* strArticleId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
                backGroundView.hidden=NO;
                [self.loadingView startAnimation];
                [self.loadingView setHidden:NO];
                [self.img setHidden:NO];
                [[APIManager sharedInstance]deleteBookMarkDetailsWithUserId:uID andwithBookMarkId:strArticleId andCompleteBlock:^(BOOL success, id result) {

                    backGroundView.hidden=YES;
                    [self.loadingView stopAnimation];
                    [self.loadingView setHidden:YES];
                    [self.img setHidden:YES];
                    if (!success) {
                        // [Utility showAlert:AppName withMessage:result];
                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                        [alert setHorizontalButtons:YES];
                        
                        [alert showSuccess:AppName subTitle:result closeButtonTitle:@"Ok" duration:0.0f];
                        return;
                        
                        
                        return ;
                    }
                    
                    [self getBookMarkArticles];
                    
                }];
     }
             ];
    [alert showSuccess:AppName subTitle:@"Are you sure, you want to remove this article from your Bookmark?" closeButtonTitle:[Language Cancel] duration:0.0f];
    
    
    
    
}
#pragma mark -Button Add To Favourite Tapped
-(void)addToFavorite:(id)sender
{
    ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
    NSIndexPath *indexPathCell = [_tblBookMarkArticles indexPathForCell:clickedCell];
    
    NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
    NSString* strArticleId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    NSString * favStatu = [dict objectForKey:@"favorite"] ;
    if ([favStatu isEqualToString:@"no"])
    {
        // [Utility showLoading:self];
        backGroundView.hidden=NO;
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        [[APIManager sharedInstance]addArticleToMyFavoriteArticlesWithUserId:uID andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
            // [Utility hideLoading:self];
            backGroundView.hidden=YES;
            [self.loadingView stopAnimation];
            [self.loadingView setHidden:YES];
            [self.img setHidden:YES];
            if (!success) {
                // [Utility showAlert:AppName withMessage:result];
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                
                [alert showSuccess:AppName subTitle:result closeButtonTitle:@"Ok" duration:0.0f];
                return;
                
                
                return ;
            }
          
                [self getBookMarkArticles];
          
        }];
    }
    else{
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert addButton:@"Ok" actionBlock:^(void)
         {
             ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
             NSIndexPath *indexPathCell = [_tblBookMarkArticles indexPathForCell:clickedCell];
             NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
             NSString* strArticleId=[dict valueForKey:@"id"];
             // [Utility showLoading:self];
             backGroundView.hidden=NO;
             [self.loadingView startAnimation];
             [self.loadingView setHidden:NO];
             [self.img setHidden:NO];
             [[APIManager sharedInstance]removeArticleFromMyFavoriteArticlesWithUserId:uID andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
                 // [Utility hideLoading:self];
                 backGroundView.hidden=YES;
                 [self.loadingView stopAnimation];
                 [self.loadingView setHidden:YES];
                 [self.img setHidden:YES];
                 if (!success) {
                     [Utility showAlert:AppName withMessage:result];
                     return ;
                 }
                    [self getBookMarkArticles];
             }];
             
         }
         ];
        [alert showSuccess:AppName subTitle:[Language removearticlefromFavouriteList] closeButtonTitle:[Language Cancel] duration:0.0f];
        
        
        
    }
}
- (IBAction)btnDelete:(id)sender
{
}


@end
