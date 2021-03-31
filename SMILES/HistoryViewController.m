//
//  HistoryViewController.m
//  DedaaBox
//
//  Created by BiipByte on 16/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "Resource_Coach-Swift.h"
#import "HistoryViewController.h"
#import "REFrostedViewController.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "HistoryTableViewCell.h"
#import "Language.h"
#import "UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "SubscriptionViewController.h"
#import "ArticleDetailsViewController.h"
#import "HYCircleLoadingView.h"
#import "SubScribeToDedaaBoxViewController.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView *historyTableview;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation HistoryViewController
{
    NSString *loginUserType;
    NSString *videoType;
    NSString *postedOn,*viewsArt,*by,*Ok,*Cancel;
    NSMutableArray *data;
    NSMutableArray *arrVideoType;
    UIRefreshControl *refreshControl;
    HistoryTableViewCell *cell;
}


- (void)viewDidLoad
{
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [_historyTableview setHidden:YES];
    data=[[NSMutableArray alloc]init];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllHsitory) forControlEvents:UIControlEventValueChanged];
    [_historyTableview addSubview:refreshControl];
    _historyTableview.alwaysBounceVertical = YES;
    data=[[NSMutableArray alloc]init];
    postedOn=[Language PostedOn];
    viewsArt=[Language Views];
    by=[Language By];
    Ok=[Language ok];
    Cancel=[Language Cancel];
    
    self.title=@"History";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllHsitory];
}

-(void)getAllHsitory
{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];

    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    NSString* userID=[usercheckup valueForKey:@"id"];
    [[APIManager sharedInstance]historywithUserId:userID andCompleteBlock:^(BOOL success, id result)
    {
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        
        if (!success)
        {
            [_historyTableview setHidden:YES];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:17];
            NSString *strNoFavArticles;
            strNoFavArticles=@"No History Found";
            lblass.text=strNoFavArticles;
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return;
        }
       else
       {
        loginUserType=[result valueForKey:@"login_usertype"];
           data=[result objectForKey:@"article_data"];
        arrVideoType=[data valueForKey:@"article_type"];
           [_historyTableview setHidden:NO];
           [_historyTableview reloadData];
           
       }
    }];
    
}
#pragma mark - TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HistoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.imglockHistory.hidden=YES;
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    cell.lblVideoName.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];;
    NSDictionary *auth=[dict objectForKey:@"user_data"];
//    NSString *byAuth=[by stringByAppendingString:[auth valueForKey:@"username"]];
    NSString *byAuth=[NSString stringWithFormat:@"By %@",[auth valueForKey:@"username"]];

    cell.lblAuthorName.text=[NSString stringWithFormat:@"%@",byAuth];
    cell.lblRating.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"avg_rate"]];
    NSString *vie=[viewsArt stringByAppendingString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"view_count"]]];
    cell.lblViews.text=[NSString stringWithFormat:@"%@",vie];
   
    NSNumber *number=[dict valueForKey:@"review_count"];
    NSString *string=[number stringValue];
    
    if ([string isEqualToString:@"0"])
    {
        cell.lblRatingCount.hidden=YES;
    }
    else
    {
        cell.lblRatingCount.text=[NSString stringWithFormat:@"(%@)",[dict valueForKey:@"review_count"]];
    }
    cell.lblShortDescription.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"short_description"]];
    NSString *imgStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"photo1"]];
    cell.videoImage.layer.masksToBounds = YES;
    cell.videoImage.layer.cornerRadius = 5.0;
    NSString *type=[dict valueForKey:@"file_type"];
    
    if ([type isEqual:[NSNull null]])
    {
        NSLog(@"File type missing");
    }
    
    else  if ([type isEqualToString:@"2"])
    {
        NSLog(@"type is Photo");
        cell.VideoPlayImg.hidden=YES;
        cell.lblDuration.hidden=YES;
        [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    }
    else if([type isEqualToString:@"3"] || [type isEqualToString:@"4"]){
        cell.VideoPlayImg.hidden=NO;
         cell.lblDuration.hidden=NO;
        
        NSString *videoStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_thumb"]];
        if (([videoStr isEqual:[NSNull null]]) || [videoStr isEqualToString:@"<null>"]) {
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
            [cell.videoImage sd_setImageWithURL:finalUrl placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"youtube thumnail downloaded in obj-c....");
            }];
            
            cell.lblDuration.text = @"00:00";
            [cell.lblDuration setHidden: YES];
        }else{
            [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",videoStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
            cell.lblDuration.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"link_duration"]];
            [cell.lblDuration setHidden: YES];
        }
        
         
    }
    else
    {

        cell.videoImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    if (!cell.videoImage.image)
    {
        cell.videoImage.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
    videoType=[arrVideoType objectAtIndex:indexPath.row];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
    {
        cell.imglockHistory.hidden = NO;
    }
   else if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"mini_certification"])
    {
        cell.imglockHistory.hidden = NO;
    }
    else
    {
        cell.imglockHistory.hidden = YES;
    }
    
    CALayer *layer=cell.layer;
    layer.masksToBounds=NO;
    layer.cornerRadius = 4.0f;
    cell.lblBgRate.layer.masksToBounds=YES;
    cell.lblBgRate.layer.cornerRadius=4.0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    videoType=[arrVideoType objectAtIndex:indexPath.row];
    if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"subscriber"])
    {
        SubScribeToDedaaBoxViewController *subscriptionDedaaBoxClass=[self.storyboard instantiateViewControllerWithIdentifier:@"SubScribeToDedaaBoxViewController"];
        [self.navigationController pushViewController:subscriptionDedaaBoxClass animated:YES];
    }
    else if ([loginUserType isEqualToString:@"non_subscriber"]&&[videoType isEqualToString:@"mini_certification"])
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
        NSDictionary *dict = [data objectAtIndex:indexPath.row];
        NSString* strArticleId=[dict valueForKey:@"id"];
//        ArticleDetailsViewController *articleDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
        ArticleDetailsVC *articleDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVCSBID"];
        
        articleDetails.articleId=strArticleId;
        articleDetails.strMinicertificationId=@"";
        [self.navigationController pushViewController:articleDetails animated:YES];
    }
    
    
    
}
#pragma mark -Button Menu Tapped
- (IBAction)btnMenuTapped:(id)sender
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



@end
