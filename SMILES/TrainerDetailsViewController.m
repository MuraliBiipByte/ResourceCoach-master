//
//  TrainerDetailsViewController.m
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "TrainerDetailsViewController.h"
#import "TrainerVideosCollectionViewCell.h"
#import "Utility.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "HYCircleLoadingView.h"
#import "AuthoreProfileViewController.h"
#import "SCLAlertView.h"
#import "SubscriptionViewController.h"
#import "SubScribeToDedaaBoxViewController.h"
#import "ArticleDetailsViewController.h"

@interface TrainerDetailsViewController ()
{
    TrainerVideosCollectionViewCell *collectionCell;
    NSMutableArray *arrVideosThumb,*arrArticleVideos,*arrArticleTitles,*arrArticleDuration,*arrArticleIds,*arrArticleType,*arrFileType,*arrPhoto1;
    UIView *backGroundView;
    NSString *strFav,*strLoginUserType,*typeOfarticle;
    
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation TrainerDetailsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=YES;
    arrArticleType=[[NSMutableArray alloc]init];
    
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
    
    arrVideosThumb=[[NSMutableArray alloc]init];
    arrArticleVideos=[[NSMutableArray alloc]init];
    arrArticleTitles=[[NSMutableArray alloc]init];
    arrArticleDuration=[[NSMutableArray alloc]init];
    arrArticleIds=[[NSMutableArray alloc]init];
    arrFileType=[[NSMutableArray alloc]init];
    arrPhoto1=[[NSMutableArray alloc]init];
    
    self.imgAuthour.layer.cornerRadius = self.imgAuthour.frame.size.height /2;
    self.imgAuthour.layer.masksToBounds = YES;
    self.lblAuthoursName.text=self.authorsName;
    self.lblAuthoursDescription.text=self.authorsDescription;
    
    self.title=@"Trainer Details";
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [self getAuthoreDetails];
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAuthoreDetails
{
    
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    NSString* uID=[usercheckup valueForKey:@"id"];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    NSLog(@"Author ID %@",self.authorsID);
    [[APIManager sharedInstance]GetAllArticlesBasedonAuthoreId:@"" andwithUserId:uID andWithAuthoreId:self.authorsID andCompleteBlock:^(BOOL success, id result)
    {
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        
        if (!success)
        {
//            [_authordetailsView setHidden:YES];
//            [_overlayImageView setHidden:YES];
//            [_videosLabelView setHidden:YES];
//            [_videosView setHidden:YES];
            
//            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
//            img.image=[UIImage imageNamed:@"nodataimg"];
//            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
//            lblass.textAlignment=NSTextAlignmentCenter;
//            lblass.textColor=[UIColor lightGrayColor];
//            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
//            lblass.text=@"No Data";
//            [self.view addSubview:img];
//            [self.view addSubview:lblass];
              NSMutableDictionary *userData=[result valueForKey:@"user_data"];
           
            NSString *authors=[userData valueForKey:@"username"];
            NSString *authorDescription=[userData valueForKey:@"about"];
             NSString *authoreImg=[userData valueForKey:@"photo_user"];
            
            NSString *authoreFav=[userData valueForKey:@"author_fav"];
            strFav=authoreFav;
            
            if ([strFav isEqualToString:@"yes"]) {
                [_btnFav setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
            }
            else{
                [_btnFav setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
            }
            
            
            _lblAuthoursName.text=authors;
            _lblAuthoursDescription.text=authorDescription ;
            [_imgAuthour sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,authoreImg ]]];
            if (_imgAuthour.image==nil)
            {
                _imgAuthour.image=[UIImage imageNamed:@"userprofile"];
            }
           
            UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _collectionViewAuthorVideos.bounds.size.width, _collectionViewAuthorVideos.bounds.size.height)];
            noDataLabel.text             = @"No Articles available";
            noDataLabel.textColor        = [UIColor whiteColor];
            noDataLabel.textAlignment    = NSTextAlignmentCenter;
            //yourTableView.backgroundView = noDataLabel;
            //yourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _collectionViewAuthorVideos.backgroundView = noDataLabel;
            //_collectionViewAuthorVideos.separatorStyle = UITableViewCellSeparatorStyleNone;

            return ;
        }
        else
        {
            [_authordetailsView setHidden:NO];
            [_overlayImageView setHidden:NO];
            [_videosLabelView setHidden:NO];
            [_videosView setHidden:NO];
            
            NSInteger articleCount=[[result valueForKey:@"articlecount"]integerValue];
            NSLog(@"Articles Count%ld",(long)articleCount);
            
            strLoginUserType=[result valueForKey:@"login_usertype"];
            NSMutableDictionary *articleData=[result valueForKey:@"article_data"];
            arrArticleIds=[articleData valueForKey:@"id"];
            arrArticleTitles=[articleData valueForKey:@"title"];
            arrVideosThumb=[articleData valueForKey:@"link_thumb"];
            arrArticleDuration=[articleData valueForKey:@"link_duration"];
            arrArticleType=[articleData valueForKey:@"article_type"];
            arrFileType=[articleData valueForKey:@"file_type"];
            arrPhoto1=[articleData valueForKey:@"photo1"];
            arrArticleVideos=[articleData valueForKey:@"link"];
            NSMutableDictionary *userData=[articleData valueForKey:@"user_data"];
            NSMutableArray *authors=[userData valueForKey:@"username"];
            NSMutableArray *authorDescription=[userData valueForKey:@"about"];
            NSMutableArray *authoreImg=[userData valueForKey:@"photo_user"];
            NSMutableArray *authoreFav=[userData valueForKey:@"author_fav"];
            strFav=[authoreFav objectAtIndex:0];
            
            if ([strFav isEqualToString:@"yes"])
            {
                [_btnFav setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
            }
            else{
                 [_btnFav setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
            }
        
            
            _lblAuthoursName.text=[authors objectAtIndex:0];
            _lblAuthoursDescription.text=[authorDescription objectAtIndex:0];
            [_imgAuthour sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[authoreImg objectAtIndex:0]]]];
            if (_imgAuthour.image==nil)
            {
                _imgAuthour.image=[UIImage imageNamed:@"userprofile"];
            }
            [_collectionViewAuthorVideos reloadData];
        }
    }];
}

#pragma UICollectionView Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

{
    
    return arrArticleTitles.count;
    
}
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionViewAuthorVideos.frame.size.width/2-10, 110);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 3.5,7,3.5);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    collectionCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TrainerVideosCollectionViewCell" forIndexPath:indexPath];
    collectionCell.lblTitleAuthorVideos.text=[arrArticleTitles objectAtIndex:indexPath.row];
    collectionCell.ImgLock.hidden=YES;
   
    
    
    NSString *type=[arrFileType objectAtIndex:indexPath.row];
    
    if ([type isEqual:[NSNull null]])
    {
        NSLog(@"File type missing");
    }
    
    else  if ([type isEqualToString:@"2"])
    {
        NSLog(@"type is Photo");
        collectionCell.imageViewLogoAuthorVideos.hidden=YES;
        collectionCell.lblDurationAuthorVideos.hidden=YES;
        NSString *imgStr=[NSString stringWithFormat:@"%@",[arrPhoto1 objectAtIndex:indexPath.row]];

        [collectionCell.imageViewAuthorVideos sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    }
    else if([type isEqualToString:@"3"]){
      
        collectionCell.imageViewLogoAuthorVideos.hidden=NO;
        collectionCell.lblDurationAuthorVideos.hidden=NO;
       [collectionCell.imageViewAuthorVideos sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrVideosThumb objectAtIndex:indexPath.row]]]  placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
       collectionCell.lblDurationAuthorVideos.text=[arrArticleDuration objectAtIndex:indexPath.row];
    }
   
    typeOfarticle=[arrArticleType objectAtIndex:indexPath.row];
    
    if ([strLoginUserType isEqualToString:@"non_subscriber"]&&[typeOfarticle isEqualToString:@"subscriber"])
    {
        collectionCell.ImgLock.hidden=NO;
    }
    else
    {
        collectionCell.ImgLock.hidden=YES;
    }
    
    if (collectionCell.imageViewAuthorVideos.image==nil)
    {
        collectionCell.imageViewAuthorVideos.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    collectionCell.lblDurationAuthorVideos.layer.cornerRadius=1.0f;
    collectionCell.lblDurationAuthorVideos.layer.masksToBounds=YES;
    
    return  collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    typeOfarticle=[arrArticleType objectAtIndex:indexPath.row];
   if ([strLoginUserType isEqualToString:@"non_subscriber"]&&[typeOfarticle isEqualToString:@"subscriber"])
    {
        SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
        [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
        
        
    }
    else
    {
        ArticleDetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
        details.articleId=[arrArticleIds objectAtIndex:indexPath.row];
        details.strMinicertificationId=@"";
        [self.navigationController pushViewController:details animated:YES];
    }

}
//}
- (IBAction)btnAuthoreImgTapped:(id)sender
{
    AuthoreProfileViewController *authoreProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"AuthoreProfileViewController"];
    authoreProfile.authoreId=_authorsID;
    [self.navigationController pushViewController:authoreProfile animated:YES];
}
- (IBAction)btnAuthoreNameTapped:(id)sender
{
    AuthoreProfileViewController *authoreProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"AuthoreProfileViewController"];
    authoreProfile.authoreId=_authorsID;
    [self.navigationController pushViewController:authoreProfile animated:YES];
}
- (IBAction)btnFavTapped:(id)sender
{
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    NSString* uID=[usercheckup valueForKey:@"id"];
    if ([strFav isEqualToString:@"yes"])
    {
        backGroundView.hidden=NO;
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];

        [[APIManager sharedInstance]RemoveTrainerFromFav:uID andWithTrainerId:_authorsID andCompleteBlock:^(BOOL success, id result) {
            backGroundView.hidden=YES;
            [self.loadingView stopAnimation];
            [self.loadingView setHidden:YES];
            [self.img setHidden:YES];

            if (!success)
            {
                return ;
            }
            else{
                [self getAuthoreDetails];
            }
        }];
    }
    else{
        backGroundView.hidden=NO;
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];

        [[APIManager sharedInstance]AddTrainerToFavourite:uID andWithTrainerId:_authorsID andCompleteBlock:^(BOOL success, id result)
        {
            backGroundView.hidden=YES;
            [self.loadingView stopAnimation];
            [self.loadingView setHidden:YES];
            [self.img setHidden:YES];

            if (!success)
            {
                return ;
            }
            else
            {
                [self getAuthoreDetails];

            }
        }];
    }

    
}

@end
