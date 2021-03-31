//
//  FavoriteArticlesViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "FavoriteArticlesViewController.h"
#import "REFrostedViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "ArticleCatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "ArticleDetailsViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "SubscriptionViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import <YouTubePlayer/YouTubePlayer-umbrella.h>



@interface FavoriteArticlesViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *userId;
    __weak IBOutlet UITableView *favoriteTablevieList;
    NSMutableArray *data;
    ArticleCatTableViewCell *cell;
    UIRefreshControl *refreshControl;
     NSString *postedOn,*viewsArt,*by,*Ok,*Cancel,*removeFav,*noArticle,*noSequence,*noMatchFound;
    NSMutableArray *arrfavimg,*arrVideoType;
    
        NSString *uID,*UserType,*loginUserType;
    NSString *videoType;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation FavoriteArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    https:\/\/i.vimeocdn.com\/video\/647769497_100x75.jpg?r=pad
//    https:\/\/i.vimeocdn.com\/video\/647768958_100x75.jpg?r=pad
//    https:\/\/i.vimeocdn.com\/video\/647768309_100x75.jpg?r=pad
//    https:\/\/i.vimeocdn.com\/video\/647764406_100x75.jpg?r=pad
    arrfavimg=[[NSMutableArray alloc]initWithObjects:@"111.jpg",@"222.jpg",@"3.png",@"4.jpeg", nil];
    arrVideoType=[[NSMutableArray alloc]init];
    [self navigationConfiguration];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [favoriteTablevieList setHidden:YES];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    data=[[NSMutableArray alloc]init];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllFavoriteArticles) forControlEvents:UIControlEventValueChanged];
    [favoriteTablevieList addSubview:refreshControl];
    favoriteTablevieList.alwaysBounceVertical = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    
    
    [self getAllFavoriteArticles];
}
-(void)checkUserType{
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"%@",result);
        if (!success)
        {
            return ;
        }
        else
        {
            NSDictionary *userdata=[result valueForKey:@"userdata"];
            loginUserType=[userdata valueForKey:@"usertype"];
            NSString *userIds=[userdata valueForKey:@"user_id"];
            NSString *userName=[userdata valueForKey:@"username"];
            
            
        if (![UserType isEqualToString:loginUserType] )
            {
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Your user account type has been changed by Admin" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    [defaults setObject:userIds forKey:@"id"];
                    [defaults setObject:userName forKey:@"name"];
                    [defaults setObject:loginUserType forKey:@"usertypeid"];
                    [defaults setObject:loginUserType forKey:@"usertype"];
                    
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

#pragma mark -Get All Favourite Articles
-(void)getAllFavoriteArticles{
  //  [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllFavoriteArticlesWithUserId:userId andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success)
        {
            //[Utility showAlert:AppName withMessage:result];
            [favoriteTablevieList setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:17];
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString *language1=[defaults valueForKey:@"language"];
            NSString *strNoFavArticles;
            if ([language1 isEqualToString:@"2"]) {
                strNoFavArticles=@"မရှိနိုင်ပါအကြိုက်ဆုံးဆောင်းပါး";
            }
            else if ([language1 isEqualToString:@"3"]){
                strNoFavArticles=@"မရှိနိုင်ပါအကြိုက်ဆုံးဆောင်းပါး";
            }
            else
            {
                strNoFavArticles=@"No favorite Lessons available";
            }
            lblass.text=strNoFavArticles;
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
       
    loginUserType=[result valueForKey:@"login_usertype"];
       data=[result objectForKey:@"article_data"];
        arrVideoType=[data valueForKey:@"article_type"];
       [favoriteTablevieList setHidden:NO];
       [favoriteTablevieList reloadData];
    }];
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language isEqualToString:@"2"]) {
     //   self.title=@"ႏွစ္သက္ေသာ ေဆာင္းပါးမ်ား";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"စ္သက္ေသာ ေဆာင္းပါးမ်ား";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        
        postedOn=[Language PostedOn];
        viewsArt=[Language Views];
        by=[Language By];
        Ok=[Language ok];
        Cancel=[Language Cancel];
        removeFav=[Language removearticlefromFavouriteList];
        noArticle=[Language NoArticlesAvailable];
        noSequence=[Language NoSequenceAvailable];
        noMatchFound=@"မီးခြစ်မျှမတွေ့";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }
    else if ([language1 isEqualToString:@"3"]){
         // self.title=@"အကြှနျုပျ၏အကြိုက်ဆုံးဆောင်းပါးများ";
        postedOn=@"တွင် Posted:";
        viewsArt=@"အမြင်ချင်း";
        by=@"အားဖြင့် ";
        Ok=@"အိုကေ";
        Cancel=@"ဖျက်သိမ်း";
        removeFav=@"သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?";
        noArticle=@"ရရှိနိုင်သောပုဒ်မဘယ်သူမျှမက";
        noSequence=@"ရရှိနိုင် sequence ကိုအဘယ်သူမျှမ";
        noMatchFound=@"မီးခြစ်မျှမတွေ့";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကြှနျုပျ၏အကြိုက်ဆုံးဆောင်းပါးများ";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else{
        self.title=@"My Favorite Lessons";
        postedOn=@"Posted On";
        viewsArt=@"Views:";
        by=@"By ";
        Ok=@"ok";
        Cancel=@"cancel";
        removeFav=@"Are you sure, you want to remove this Lesson from your Favorite List?";
        noArticle=@"No Lesson Available";
        noSequence=@"No sequence available";
        noMatchFound=@"No Match Found";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }

    
   }

#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = (ArticleCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArticleCatTableViewCell"];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.favVideoPlayImg.hidden=YES;
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    cell.lblFavArticleName.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];;
    NSDictionary *auth=[dict objectForKey:@"user_data"];
    NSString *byAuth=[by stringByAppendingString:[auth valueForKey:@"username"]];
    cell.lblFavAuthorName.text=[NSString stringWithFormat:@"%@",byAuth];
    cell.lblFavRating.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"avg_rate"]];
    
    NSNumber *ratingValue = [dict valueForKey:@"avg_rate"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 1;
    formatter.roundingMode = NSNumberFormatterRoundUp;
    
    
    NSString *numberString = [formatter stringFromNumber:ratingValue];
    NSLog(@"Result %@",numberString);
    cell.lblFavRating.text = numberString;
    
    NSString *vie=[viewsArt stringByAppendingString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"view_count"]]];
    cell.lblViews.text=[NSString stringWithFormat:@"%@",vie];
    cell.favArticleImage.layer.masksToBounds = YES;
    cell.favArticleImage.layer.cornerRadius = 5.0;
    NSNumber *number=[dict valueForKey:@"review_count"];
    NSString *string=[number stringValue];
    if ([string isEqualToString:@"0"])
    {
        cell.lblFavRatingCount.hidden=YES;
    }
    else
    {
    cell.lblFavRatingCount.text=[NSString stringWithFormat:@"(%@)",[dict valueForKey:@"review_count"]];
    }
   cell.lblFavArticleShortDescription.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"short_description"]];
 
    NSString *type=[NSString stringWithFormat:@"%@",[dict valueForKey:@"file_type"]];
  
    cell.lblFavArticleDuration.hidden=YES;
    if ([type isEqualToString:@"2"])
    {
        NSLog(@"type is Photo");
        cell.favVideoPlayImg.hidden=YES;
        cell.lblFavArticleDuration.hidden=YES;
        [cell.favArticleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[NSString stringWithFormat:@"%@",[dict valueForKey:@"photo1"]]]]];
    }
    else if([type isEqualToString:@"3"])
    {      cell.favVideoPlayImg.hidden=NO;
         cell.lblFavArticleDuration.hidden=NO;
        NSString *videoStr=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_thumb"]]];
        
        [cell.favArticleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",videoStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
        cell.lblFavArticleDuration.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_duration"]];
    }else if ([type isEqualToString:@"4"]){
        
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
        [cell.favArticleImage sd_setImageWithURL:finalUrl placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"youtube thumnail downloaded in obj-c....");
        }];
    }

//    if (!cell.favArticleImage.image) {
//        cell.favArticleImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
//    }
    videoType=[NSString stringWithFormat:@"%@",[dict valueForKey:@"article_type"]];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
    {
        cell.btnUnFavourite.enabled=NO;
        cell.imgFavLock.hidden = NO;
    }
    else
    {
        cell.btnUnFavourite.enabled=YES;
        cell.imgFavLock.hidden = YES;
    }

    CALayer *layer=cell.layer;
    layer.masksToBounds=NO;
    layer.cornerRadius = 4.0f;
    [cell.btnUnFavourite addTarget:self action:@selector(removeFromFav:) forControlEvents:UIControlEventTouchUpInside];
    cell.lblFavBgRate.layer.masksToBounds=YES;
    cell.lblFavBgRate.layer.cornerRadius=4.0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSDictionary *dict = [data objectAtIndex:indexPath.row];
        videoType=[NSString stringWithFormat:@"%@",[dict valueForKey:@"article_type"]];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
    {
        SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
        [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];    }
    else
    {

        NSString* strArticleId=[dict valueForKey:@"id"];
//        ArticleDetailsViewController *articleDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
        ArticleDetailsVC *articleDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVCSBID"];
        
        articleDetails.articleId=strArticleId;
        articleDetails.strMinicertificationId=@"";
        [self.navigationController pushViewController:articleDetails animated:YES];
    }
    


}

#pragma mark -Menu Button Tapped
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

#pragma mark -Remove From Favourite Tapped
-(void)removeFromFav:(id)sender
{
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
            [alert addButton:[Language ok] actionBlock:^(void)
             {
                 ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
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
                 }];
     }
             ];
    [alert showSuccess:AppName subTitle:removeFav closeButtonTitle:[Language Cancel] duration:0.0f];
    
    
//    UIAlertController *alertController = [UIAlertController
//                                          alertControllerWithTitle:AppName
//                                          message:removeFav
//                                          preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okayAction = [UIAlertAction
//                                 actionWithTitle:Ok
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * _Nonnull action) {
//                                     [alertController dismissViewControllerAnimated:YES completion:nil];
//                                     ArticleCatTableViewCell *clickedCell = (ArticleCatTableViewCell*)[[sender superview] superview];
//                                     NSIndexPath *indexPathCell = [favoriteTablevieList indexPathForCell:clickedCell];
//                                     NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
//                                     NSString* strArticleId=[dict valueForKey:@"id"];
//                                    // [Utility showLoading:self];
//                                     [self.loadingView startAnimation];
//                                     [self.loadingView setHidden:NO];
//                                     [self.img setHidden:NO];
//                                     [[APIManager sharedInstance]removeArticleFromMyFavoriteArticlesWithUserId:userId andWithArticleId:strArticleId andCompleteBlock:^(BOOL success, id result) {
//                                         //[Utility hideLoading:self];
//                                         [self.loadingView stopAnimation];
//                                         [self.loadingView setHidden:YES];
//                                         [self.img setHidden:YES];
//                                         if (!success) {
//                                             [Utility showAlert:AppName withMessage:result];
//                                             return ;
//                                         }
//                                         [self getAllFavoriteArticles];
//                                          }];
//                                 }];
//    UIAlertAction *cancelaction=[UIAlertAction
//                                 actionWithTitle:Cancel
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * _Nonnull action) {
//                                 }];
//    [alertController addAction:okayAction];
//    [alertController addAction:cancelaction];
//    [self presentViewController:alertController animated:YES completion:nil];
}

@end
