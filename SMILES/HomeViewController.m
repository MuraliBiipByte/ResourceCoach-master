//
//  HomeViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import "HomeViewController.h"
#import "Utility.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "RandomCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ArticleDetailsViewController.h"
#import "GetAllArticlesViewController.h"
#import "HYCircleLoadingView.h"
#import "YTPlayerView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "SCLAlertView.h"
#import "MessageViewController.h"
#import "ChatingViewController.h"
#import "CatagoriesTableViewCell.h"
#import "GetAllArticlesViewController.h"
#import "SubscriptionViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import "MiniCertificateViewController.h"
#import "CourseDetailViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,YTPlayerViewDelegate>
{
    __weak IBOutlet UICollectionView *favoriteArticleCollectionView;
    __weak IBOutlet UICollectionView *mostViewdArticleCollectionView;
    __weak IBOutlet UICollectionView *randomCollectionView;
    __weak IBOutlet UITableView *catagoriesArticleTableView;
    __weak IBOutlet UIButton *btnEmail;
    UIView *backGroundView;
    
    RandomCollectionViewCell *cell;
    ArticleDetailsViewController *details;
    
    NSMutableArray *arrId,*arrArticleTitle,*arrSubCatId,*arrShortDescription,*arrLongDescription,*arrArticleImage1,*arrArticleImage2,*arrArticleImage3,*arrArticleVideo,*arrVideoThumb,*arrType,*arrYouTubeLink;
    
   
    NSMutableArray *arrFavarticleId,*arrFavArticleName,*arrFavArticleImage,*arrFavArticleVideoImage,*arrFavArticleType,*arrFavArticleYouTubeLink;
    
    NSMutableArray *arrMostViewarticleId,*arrMostViewArticleName,*arrMostViewArticleImage,*arrMostViewArticleVideoImage,*arrMostViewArticleType,*arrMostViewYouTubeLink;
    
    NSMutableArray *arrCatagoriesArticleId,*arrCatagoriesArticleName,*arrCatagoriesArticleImage,*arrCatagoriesVideoImage,*arrCatagoriesArticleType,*arrCatagoriesYouTubeLink;
    
    NSString *videoId,*videoId1,*videoId2;
     NSMutableArray *arrUserId,*arrUserName,*arrUserTelcode,*arrUserMobileNumber,*arrUserEmail;
    
    NSMutableArray *arrLatestVideosDuration,*arrMostVideosDuration,*arrFavVideosDuration,*arrLatestVideoType,*arrMostVideoType,*arrFavVideoType;
    NSString *loginUserType;
    
    __weak IBOutlet UIView *recentArticleView;
    __weak IBOutlet UIView *mostViewedArticle;
    __weak IBOutlet UIView *faverioutArticleView;
    __weak IBOutlet UIView *catgoriesArticleView;
    
     __weak IBOutlet NSLayoutConstraint *catgoriesArticleViewConstraints;
     __weak IBOutlet NSLayoutConstraint *recentArticleViewViewConstraints;
     __weak IBOutlet NSLayoutConstraint *mostViewedArticleConstraints;
     __weak IBOutlet NSLayoutConstraint *faverioutArticleViewConstraints;
    
    IBOutlet UIBarButtonItem *btnSearch;
    __weak IBOutlet UILabel *lblLatestArticles;
    __weak IBOutlet UILabel *lblMostViewed;
    __weak IBOutlet UILabel *lblFav;
    __weak IBOutlet NSLayoutConstraint *lblMostFavHight;
    
     NSString *uID,*UserType;
    NSString *chatIdentify;
    NSMutableArray *arrMiniCertificate;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
    arrMiniCertificate=[[NSMutableArray alloc]init];
    
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
    
    
    [randomCollectionView reloadData];
    [btnEmail bringSubviewToFront:mostViewdArticleCollectionView];
    [self navigationConfiguration];
    
    
        
//    //If chat Notification...Then go to chat controller.....
//    NSUserDefaults *chatDefaults=[NSUserDefaults standardUserDefaults];
//    if (![[chatDefaults valueForKey:@"othersId"] isEqualToString:@""])
//    {
//        MessageViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
//        message.authorId=@"";
//        
//        [self.navigationController pushViewController:message animated:YES];
//    }
    
  
    
    arrLatestVideoType=[[NSMutableArray alloc] init];
    arrMostVideoType=[[NSMutableArray alloc] init];
    arrFavVideoType=[[NSMutableArray alloc] init];

    arrLatestVideosDuration=[[NSMutableArray alloc] init];
    arrMostVideosDuration=[[NSMutableArray alloc] init];
    arrFavVideosDuration=[[NSMutableArray alloc] init];
    
 
    arrId=[[NSMutableArray alloc] init];
    arrArticleTitle=[[NSMutableArray alloc] init];
    arrSubCatId=[[NSMutableArray alloc] init];
    arrShortDescription=[[NSMutableArray alloc] init];
    arrLongDescription=[[NSMutableArray alloc] init];
    arrArticleImage1=[[NSMutableArray alloc] init];
    arrArticleImage2=[[NSMutableArray alloc] init];
    arrArticleImage3=[[NSMutableArray alloc] init];
    arrArticleVideo=[[NSMutableArray alloc] init];
    arrVideoThumb=[[NSMutableArray alloc] init];
    arrType=[[NSMutableArray alloc] init];
    arrYouTubeLink=[[NSMutableArray alloc]init];
    
    arrUserId=[[NSMutableArray alloc] init];
    arrUserName=[[NSMutableArray alloc] init];
    arrUserTelcode=[[NSMutableArray alloc] init];
    arrUserMobileNumber=[[NSMutableArray alloc] init];
    arrUserEmail=[[NSMutableArray alloc] init];
    arrFavarticleId=[[NSMutableArray alloc] init];
    arrFavArticleName=[[NSMutableArray alloc] init];
    arrFavArticleImage=[[NSMutableArray alloc] init];
    arrFavArticleVideoImage=[[NSMutableArray alloc] init];
    arrFavArticleType=[[NSMutableArray alloc] init];
    arrFavArticleYouTubeLink=[[NSMutableArray alloc]init];
    
    arrMostViewarticleId=[[NSMutableArray alloc] init];
    arrMostViewArticleName=[[NSMutableArray alloc] init];
    arrMostViewArticleImage=[[NSMutableArray alloc] init];
    arrMostViewArticleVideoImage=[[NSMutableArray alloc] init];
    arrMostViewArticleType=[[NSMutableArray alloc] init];
    arrMostViewYouTubeLink=[[NSMutableArray alloc]init];
    
    cell.videoImg.hidden=YES;
    cell.favVideoImg.hidden=YES;
    cell.mostViewVideoImg.hidden=YES;
    [recentArticleView setHidden:YES];
    [mostViewedArticle setHidden:YES];
    
    [faverioutArticleView setHidden:YES];
    [catgoriesArticleView setHidden:YES];
    
    lblLatestArticles.text=[Language LatestVideos];
    lblMostViewed.text=[Language TrendingVideos];
    lblFav.text=[Language ContinueReading];
    int randomNumber = [self getRandomNumberBetween:0000000000 to:9999999999];
    NSLog(@"RandomNumber is %d",randomNumber);
}
-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    
    return (int)from + arc4random() % (to-from+1);
}
- (void)appDidBecomeActive:(NSNotification *)notification {
   // [self viewWillAppear:YES];
    NSUserDefaults *chatDefaults=[NSUserDefaults standardUserDefaults];
    NSString *strCount =[NSString stringWithFormat:@"%@",[chatDefaults valueForKey:@"count"]];
    
    if ([strCount isEqualToString:@"1"]) {
         CourseDetailViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
        NSString *strAssemntId=[NSString stringWithFormat:@"%@",[chatDefaults valueForKey:@"miniid"]];
        courseDetails.miniCertificateId = strAssemntId;
        [self.navigationController pushViewController:courseDetails animated:YES];
        
    }
    
    NSInteger intcount =[strCount integerValue];
    if (intcount>1)
    {
        MiniCertificateViewController *Mini=[self.storyboard instantiateViewControllerWithIdentifier:@"MiniCertificateViewController"];
        [self.navigationController pushViewController:Mini animated:YES];
        
    }
  
    if ([chatIdentify isEqualToString:@"chat"])
    {
        NSLog(@"Already chat is there");
    }
    else
    {
    NSLog(@"did become active notification");

    NSString *othersId=[NSString stringWithFormat:@"%@",[chatDefaults valueForKey:@"othersId"]];
    
    
    BOOL firbase;
    NSString *t_st = @"(";
    NSRange rang =[othersId rangeOfString:t_st options:NSCaseInsensitiveSearch];
    
    if (rang.length == [t_st length])
    {
        firbase=YES;
    }
    else
    {
        firbase=NO;
    }
    
    
    
    if (firbase==YES||[othersId isEqualToString:@""]||[othersId isEqual:[NSNull null]])
    

    {

    }
    else
    {
        ChatingViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingViewController"];
        
//        MessageViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
        
        message.authorId=@"";
        message.self.authorName=[chatDefaults valueForKey:@"othersName"];
        message.self.authoreImage=[chatDefaults valueForKey:@"othersProfileImg"];
        
        [self.navigationController pushViewController:message animated:YES];

    }
        
    }
    

}

- (void)appWillEnterForeground:(NSNotification *)notification {
    //If chat Notification...Then go to chat controller.....
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
    
    [self navigationConfiguration];
    [self getAllRandomArticles];
        //If chat Notification...Then go to chat controller.....
    
    NSUserDefaults *chatDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString *othersId=[NSString stringWithFormat:@"%@",[chatDefaults valueForKey:@"othersId"]];
    
    
    BOOL firbase;
    NSString *t_st = @"(";
    NSRange rang =[othersId rangeOfString:t_st options:NSCaseInsensitiveSearch];
    
    if (rang.length == [t_st length])
    {
        firbase=YES;
    }
    else
    {
        firbase=NO;
    }

    
    
        if (firbase==YES||[othersId isEqualToString:@""]||[othersId isEqual:[NSNull null]])
        {
//            MessageViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
//            message.authorId=@"";
//    
//            [self.navigationController pushViewController:message animated:YES];
        }
        else{
            ChatingViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingViewController"];
//            MessageViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
            message.authorId=@"";
            message.self.authorName=[usercheckup valueForKey:@"othersName"];
            message.self.authoreImage=[usercheckup valueForKey:@"othersProfileImg"];
            
            [self.navigationController pushViewController:message animated:YES];

        }
    chatIdentify=@"chat";
  

}
-(void)checkUserType
{
    
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result)
    {
        NSLog(@"%@",result);
        if (!success) {
            return ;
        }
        else
        {
            NSDictionary *userdata=[result valueForKey:@"userdata"];
            NSString *type=[userdata valueForKey:@"usertype"];
            NSString *userIds=[userdata valueForKey:@"user_id"];
            NSString *userName=[userdata valueForKey:@"username"];
            
            
            if (![UserType isEqualToString:type] ) {
                
//                UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Your user account type has been changed by Admin" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//                    [defaults setObject:userIds forKey:@"id"];
//                    [defaults setObject:userName forKey:@"name"];
//                    [defaults setObject:type forKey:@"usertypeid"];
//                    [defaults setObject:type forKey:@"usertype"];
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setObject:type forKey:@"usertype"];
                    RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                [self presentViewController:homeView animated:YES completion:nil];
                    
//                    
//                }];
//                [alert addAction:ok];
//                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }
    }];
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{

    self.title=[Language Home];
    [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    }

#pragma mark - Get Random Articles
-(void)getAllRandomArticles

{
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
      [self.loadingView setHidden:NO];
  
    [self.img setHidden:NO];
    
   
   [[APIManager sharedInstance]getAllRandomArticles:uID andCompleteBlock:^(BOOL success, id result)
    {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
         backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        
        if (!success)
        {
            //[Utility showAlert:AppName withMessage:result];
            [recentArticleView setHidden:YES];
            [mostViewedArticle setHidden:YES];
            [faverioutArticleView setHidden:YES];
            [catagoriesArticleTableView setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=[Language NoArticlesAvailable];
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        NSDictionary *data=[result objectForKey:@"data"];
        NSString *totalCount=[data objectForKey:@"articlecount"];
       loginUserType=[data objectForKey:@"login_usertype"];
        NSLog(@"Product count is %@",totalCount);
        NSDictionary *articlesData=[data objectForKey:@"article_data"];
        NSDictionary *favArticleData=[data objectForKey:@"fav_article_data"];
        

       NSDictionary *mostViedArticleData=[data objectForKey:@"viewed_article_data"];
      
        NSDictionary *categoriesData=[data objectForKey:@"categories"];
       
        if ([articlesData count]>0)
        {
            arrId=[articlesData valueForKey:@"id"];
            arrSubCatId=[articlesData valueForKey:@"subcat_id"];
            arrArticleTitle=[articlesData valueForKey:@"title"];
            arrLongDescription=[articlesData valueForKey:@"description"];
            arrArticleImage1=[articlesData valueForKey:@"photo_orig1"];
            arrArticleImage2=[articlesData valueForKey:@"photo_orig2"];
            arrArticleImage3=[articlesData valueForKey:@"photo_orig3"];
            arrArticleVideo=[articlesData valueForKey:@"video"];
            arrVideoThumb=[articlesData valueForKey:@"link_thumb"];
            arrLatestVideosDuration=[articlesData valueForKey:@"link_duration"];
            arrLatestVideoType=[articlesData valueForKey:@"article_type"];
            arrYouTubeLink=[articlesData valueForKey:@"link"];
            arrType=[articlesData valueForKey:@"file_type"];
            NSDictionary *userData=[articlesData valueForKey:@"user_data"];
            arrUserId=[userData valueForKey:@"id"];
            arrUserName=[userData valueForKey:@"username"];
            arrUserTelcode=[userData valueForKey:@"telcode"];
            arrUserMobileNumber=[userData valueForKey:@"phone"];
            arrUserEmail=[userData valueForKey:@"email"];
            [recentArticleView setHidden:NO];
            [randomCollectionView reloadData];
        }
        else
        {
            [randomCollectionView setHidden:YES];
            
        }
       
       if ([favArticleData count]>0)
        {
            arrFavarticleId=[favArticleData valueForKey:@"id"];
            arrFavArticleName=[favArticleData valueForKey:@"title"];
            arrFavArticleImage=[favArticleData valueForKey:@"photo1"];
            arrFavArticleVideoImage=[favArticleData valueForKey:@"link_thumb"];
            arrFavVideosDuration=[favArticleData valueForKey:@"link_duration"];
            arrFavVideoType=[favArticleData valueForKey:@"article_type"];
            arrFavArticleType=[favArticleData valueForKey:@"file_type"];
            arrFavArticleYouTubeLink=[favArticleData valueForKey:@"link"];
            [mostViewedArticle setHidden:NO];
            [mostViewdArticleCollectionView reloadData];
        }
        else
        {
        [mostViewdArticleCollectionView setHidden:YES];
            
           mostViewedArticleConstraints.active=YES;
            mostViewedArticleConstraints.constant=0.0f;
            
        }
       
       
       
       
        if ([mostViedArticleData count]>0)
        {
            arrMostViewarticleId=[mostViedArticleData valueForKey:@"id"];
            arrMostViewArticleName=[mostViedArticleData valueForKey:@"title"];
            arrMostViewArticleImage=[mostViedArticleData valueForKey:@"photo1"];
            arrMostViewArticleVideoImage=[mostViedArticleData valueForKey:@"link_thumb"];
            arrMostVideosDuration=[mostViedArticleData valueForKey:@"link_duration"];
            arrMostVideoType=[mostViedArticleData valueForKey:@"article_type"];
            arrMostViewArticleType=[mostViedArticleData valueForKey:@"file_type"];
            arrMostViewYouTubeLink=[mostViedArticleData valueForKey:@"link"];
            arrMiniCertificate=[mostViedArticleData valueForKey:@"assesment_id"];
            [faverioutArticleView setHidden:NO];
            [favoriteArticleCollectionView reloadData];
        }
        else
        {
        
        faverioutArticleViewConstraints.active=NO;
        faverioutArticleViewConstraints.constant=0.0f;
          //  lblFav.hidden=YES;
            lblMostFavHight.constant=0.0f;
            lblMostFavHight.active=YES;
            
        }
       
       
       if ([categoriesData count]>0)
       {
           arrCatagoriesArticleId=[categoriesData valueForKey:@"id"];
           arrCatagoriesArticleName=[categoriesData valueForKey:@"name"];
           arrCatagoriesArticleImage=[categoriesData valueForKey:@"photo_cat"];
           [catgoriesArticleView setHidden:NO];
           [catagoriesArticleTableView reloadData];
       }
       else
       {
           [catagoriesArticleTableView setHidden:YES];
       }
       
       NSString *catagoriesString=[NSString stringWithFormat:@"%lu",(unsigned long)arrCatagoriesArticleName.count];
       int catagoriesVideosHeight=[catagoriesString intValue];
       
       if (arrArticleTitle.count >0)
       {
           recentArticleView.hidden=NO;
           recentArticleViewViewConstraints.active=YES;
           recentArticleViewViewConstraints.constant=174;
           
       }
       else
       {
           recentArticleView.hidden=YES;
           recentArticleViewViewConstraints.active=YES;
           recentArticleViewViewConstraints.constant=0.0f;
       }
       
       if (arrMostViewArticleName.count >0)
       {
           faverioutArticleView.hidden=NO;
           faverioutArticleViewConstraints.active=YES;
           faverioutArticleViewConstraints.constant=174;
           
       }
       else
       {
           faverioutArticleView.hidden=YES;
           faverioutArticleViewConstraints.active=YES;
           faverioutArticleViewConstraints.constant=0.0f;
       }
       
//       if ([loginUserType isEqualToString:@"non_subscriber"])
//       {
//           NSLog(@"you are NON Subscriber");
//       }
//       else{
        
//       if ([loginUserType isEqualToString:@"subscriber"])
//       {
           faverioutArticleView.hidden=NO;
           faverioutArticleViewConstraints.active=YES;
           faverioutArticleViewConstraints.constant=174;
//
//       }
//       else
//       {
//           faverioutArticleView.hidden=YES;
//           faverioutArticleViewConstraints.active=YES;
//           faverioutArticleViewConstraints.constant=0.0f;
     //  }

       
       if (arrCatagoriesArticleName.count ==0)
       {
           catgoriesArticleView.hidden=YES;
           catgoriesArticleViewConstraints.active=YES;
           catgoriesArticleViewConstraints.constant=0.0f;
       }
       if (arrCatagoriesArticleName.count >=1)
       {
           catgoriesArticleView.hidden=NO;
           catgoriesArticleViewConstraints.active=YES;
           catgoriesArticleViewConstraints.constant=catagoriesVideosHeight*145;
           
       }
       

    }];
}

#pragma mark -Button Mennu Tapped
- (IBAction)actMenuTapped:(id)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture)
    {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}

#pragma mark - CollectionView Delegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==randomCollectionView)
    {
         return [arrArticleTitle count];
    }
   
    else if (collectionView==mostViewdArticleCollectionView)
    {
        return [arrFavArticleName count];
    }
    else if (collectionView==favoriteArticleCollectionView)
    {
        return [arrMostViewArticleName count];
        
    }
    
    return YES;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RandomCollectionViewCell";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
   
    
    if (collectionView==randomCollectionView)
    {
       
        cell.latestLockImg.hidden = YES;
        cell.lblArticleDuration.layer.cornerRadius=2.0;
        cell.lblArticleDuration.layer.masksToBounds=YES;
        cell.latestLockImg.layer.cornerRadius=2.0;
        cell.latestLockImg.layer.masksToBounds=YES;
        cell.lblArticleTitle.text = [NSString stringWithFormat:@"%@",[arrArticleTitle objectAtIndex:indexPath.row]];
        NSString *latestFileType = [NSString stringWithFormat:@"%@",[arrType objectAtIndex:indexPath.row]];
        if([latestFileType isEqualToString:@"2"])
        {
            cell.videoImg.hidden = YES;
            cell.lblArticleDuration.hidden = YES;
            [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[arrArticleImage1 objectAtIndex:indexPath.row]]]placeholderImage:[UIImage imageNamed:@"articleplaceholder"]];
        }
        else if([latestFileType isEqualToString:@"3"]){
            cell.videoImg.hidden=NO;
            cell.lblArticleDuration.hidden = NO;
                    [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrVideoThumb objectAtIndex:indexPath.row]]]
                placeholderImage:[UIImage imageNamed:@"articleplaceholder"]];
                    cell.lblArticleDuration.text =[NSString stringWithFormat:@"%@",[arrLatestVideosDuration objectAtIndex:indexPath.row]];
            
        }
        else{
       
            cell.articleImg.image = [UIImage imageNamed:@"articleplaceholder"];
            cell.lblArticleDuration.text =[NSString stringWithFormat:@"%@",[arrLatestVideosDuration objectAtIndex:indexPath.row]];
        }
        
        ///Checking User Type to lock video
        NSString *videoType=[arrLatestVideoType objectAtIndex:indexPath.row];
        if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
        {
            cell.latestLockImg.hidden=NO;
        }
        else
        {
            cell.latestLockImg.hidden=YES;
        }
        if (!cell.articleImg.image) {
             cell.articleImg.image = [UIImage imageNamed:@"articleplaceholder"];
        }

        cell.layer.cornerRadius=4.0f;
        return cell;
    }
    else if (collectionView==mostViewdArticleCollectionView)
    {
  
        cell.TrendingLockImg.hidden=YES;
        cell.lblTrendingDuration.layer.cornerRadius=2.0;
        cell.lblTrendingDuration.layer.masksToBounds=YES;
        cell.TrendingLockImg.layer.cornerRadius=2.0;
        cell.TrendingLockImg.layer.masksToBounds=YES;
        cell.mostViewdArticleLabel.text=[NSString stringWithFormat:@"%@",[arrFavArticleName objectAtIndex:indexPath.row]];
 
        NSString *articleType=[NSString stringWithFormat:@"%@",[arrFavArticleType objectAtIndex:indexPath.row]];
        if ([articleType isEqualToString:@"2"]) {
            cell.mostViewVideoImg.hidden =YES;
            cell.lblTrendingDuration.hidden =YES;
             [cell.mostViewArticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[arrFavArticleImage objectAtIndex:indexPath.row]]]];
        }
        else if ([articleType isEqualToString:@"3"])
        {
            cell.mostViewVideoImg.hidden =NO;
            cell.lblTrendingDuration.hidden =NO;
             [cell.mostViewArticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrFavArticleVideoImage objectAtIndex:indexPath.row]]]];
            cell.lblTrendingDuration.text = [NSString stringWithFormat:@"%@",[arrFavVideosDuration objectAtIndex:indexPath.row]];
        }
        else{
            cell.mostViewArticleImg.image = [UIImage imageNamed:@"articleplaceholder"];
        }
        
        NSString *videoType=[arrFavVideoType objectAtIndex:indexPath.row];
        
        if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
        {
            cell.TrendingLockImg.hidden=NO;
        }
        else
        {
            cell.TrendingLockImg.hidden=YES;
        }
        if (!cell.mostViewArticleImg.image) {
            cell.mostViewArticleImg.image = [UIImage imageNamed:@"articleplaceholder"];
        }
        cell.layer.cornerRadius=4.0f;
        return cell;
    }

    else if (collectionView==favoriteArticleCollectionView)
    {
        cell.ContinueReadingLockImg.hidden=YES;
        cell.lblTrendingDuration.layer.cornerRadius=2.0;
        cell.lblContinueArticleDuration.layer.masksToBounds=YES;
        cell.ContinueReadingLockImg.layer.cornerRadius=2.0;
        cell.ContinueReadingLockImg.layer.masksToBounds=YES;
        cell.favoriteArticleTitle.text=[NSString stringWithFormat:@"%@",[arrMostViewArticleName objectAtIndex:indexPath.row]];
        NSString *articleType=[arrMostViewArticleType objectAtIndex:indexPath.row];
        if ([articleType isEqualToString:@"2"]) {
            cell.favVideoImg.hidden=YES;
            cell.lblContinueArticleDuration.hidden=YES;
            [cell.favoriteArticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[arrMostViewArticleImage objectAtIndex:indexPath.row]]]];
        }
        
      else  if ([articleType isEqualToString:@"3"]) {
             cell.favVideoImg.hidden=NO;
          cell.lblContinueArticleDuration.hidden=YES;
              [cell.favoriteArticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrMostViewArticleVideoImage objectAtIndex:indexPath.row]]]];
            cell.lblContinueArticleDuration.text=[NSString stringWithFormat:@"%@",[arrMostVideosDuration objectAtIndex:indexPath.row]];
          
        }
        else{
            cell.favoriteArticleImg.image = [UIImage imageNamed:@"articleplaceholder"];
        }
   
        NSString *videoType=[arrMostVideoType objectAtIndex:indexPath.row];
        
        if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"]) {
            cell.ContinueReadingLockImg.hidden=NO;
        }
        else{
            cell.ContinueReadingLockImg.hidden=YES;
        }
        if (!cell.favoriteArticleImg.image) {
            cell.favoriteArticleImg.image = [UIImage imageNamed:@"articleplaceholder"];
        }
        cell.layer.cornerRadius=4.0f;
        return cell;
    }
   
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    details=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
    if (collectionView==randomCollectionView)
    {
        details.articleId=[arrId objectAtIndex:indexPath.row];
        details.strMinicertificationId=@"";
        details.articleType = [arrType objectAtIndex:indexPath.row];
        
        
        NSString *videoType=[arrLatestVideoType objectAtIndex:indexPath.row];
        
        if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
        {
            
                 SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
            [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:details animated:YES];
        }
        
    }
   else if (collectionView==favoriteArticleCollectionView)
   {
        details.articleId=[arrMostViewarticleId objectAtIndex:indexPath.row];
       NSString *videoType=[arrMostVideoType objectAtIndex:indexPath.row];
     details.strMinicertificationId=@"";
       details.articleType = [arrMostViewArticleType objectAtIndex:indexPath.row];
       
       if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
       {           SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
           [alert setHorizontalButtons:YES];
           [alert addButton:@"Subscribe Now" actionBlock:^
            {
                SubscriptionViewController *subscriptionClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionViewController"];
                [self.navigationController pushViewController:subscriptionClass animated:YES];
                
            }];

           [alert showSuccess:AppName subTitle:@"Please Subscribe to watch this video" closeButtonTitle:@"Later" duration:0.0f];

           
       }
       else
       {
           [self.navigationController pushViewController:details animated:YES];
       }

    }
else if (collectionView==mostViewdArticleCollectionView)
   {
      
        details.articleId=[arrFavarticleId objectAtIndex:indexPath.row];
       NSString *videoType=[arrFavVideoType objectAtIndex:indexPath.row];
       details.strMinicertificationId=@"";
        details.articleType = [arrFavArticleType objectAtIndex:indexPath.row];
       
       if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
       {
           SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
           [alert setHorizontalButtons:YES];
           [alert addButton:@"Subscribe Now" actionBlock:^
            {
                SubscriptionViewController *subscriptionClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionViewController"];
                [self.navigationController pushViewController:subscriptionClass animated:YES];
                
            }];

           [alert showSuccess:AppName subTitle:@"Please Subscribe to watch this video" closeButtonTitle:@"Later" duration:0.0f];

           
       }
       else
       {
           [self.navigationController pushViewController:details animated:YES];
       }
       

   }
    
}

#pragma UITableview Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrCatagoriesArticleName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
       CatagoriesTableViewCell *catagoriesCell=[tableView dequeueReusableCellWithIdentifier:@"CatagoriesTableViewCell"];
    
        catagoriesCell.catagoriesArticleLabel.text=[arrCatagoriesArticleName objectAtIndex:indexPath.row];
    NSString *catagoryarticleImage=[arrCatagoriesArticleImage objectAtIndex:indexPath.row];
    
    if ([catagoryarticleImage isEqual:[NSNull null]])
    {
        catagoriesCell.catagoriesArticleImg.image=[UIImage imageNamed:@"articleplaceholder"];
    }
    else
    {
        [catagoriesCell.catagoriesArticleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,catagoryarticleImage]] placeholderImage:[UIImage imageNamed:@"articleplaceholder"]];
    }
    if (! catagoriesCell.catagoriesArticleImg.image) {
        catagoriesCell.catagoriesArticleImg.image=[UIImage imageNamed:@"articleplaceholder"];
    }
    
 
    
    if (catagoriesCell) {
        CGFloat direction = catagoriesCell ? 1 : -1;
        catagoriesCell.transform = CGAffineTransformMakeTranslation(catagoriesCell.bounds.size.width * direction, 0);
        [UIView animateWithDuration:0.25 animations:^{
            catagoriesCell.transform = CGAffineTransformIdentity;
        }];
    }

    
          return catagoriesCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 140.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
   GetAllArticlesViewController *getAll=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    getAll.strIdentify=@"Home";
    getAll.strSubCatId=[arrCatagoriesArticleId objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:getAll animated:YES];
}



#pragma mark -Compose Emil Delegate

- (IBAction)btnEmailTapped:(id)sender
{
    if ([MFMailComposeViewController canSendMail]){
    MFMailComposeViewController *mailCompose=[[MFMailComposeViewController alloc]init];
    mailCompose.mailComposeDelegate=self;
    [mailCompose setSubject:@"PrinceSELF"];
    [mailCompose setMessageBody:@"Good Morning" isHTML:YES];
    [mailCompose setEditing:YES];
    [self presentViewController:mailCompose animated:YES completion:nil];
    }
    else
    {
    [Utility showAlert:AppName withMessage:@"Your device doesn't support the composer sheet"];
        return;
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MFMailComposeResultSent:
            [Utility showAlert:AppName withMessage:@"Your mail has been sent Successfull"];
           [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MFMailComposeResultFailed:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MFMailComposeResultSaved:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

#pragma mark -Button Search Tapped
- (IBAction)btnSerchTapped:(id)sender
{
    GetAllArticlesViewController *searchController=[self.storyboard instantiateViewControllerWithIdentifier:@"GetAllArticlesViewController"];
    searchController.searchIdentify=@"search";
    [self.navigationController pushViewController:searchController animated:YES];
}

@end
