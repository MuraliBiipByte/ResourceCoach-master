//
//  MyArticlesViewController.m
//  SMILES
//
//  Created by BiipByte on 28/03/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "MyArticlesViewController.h"
#import "ArticleDetailsViewController.h"
#import "MyArticlesTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "APIManager.h"
#import "Language.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "REFrostedViewController.h"
#import "ViewController.h"
#import "JVFloatLabeledTextView.h"
#import "RPFloatingPlaceholderTextField.h"
#import "PopViewController.h"
#import "UIViewController+ENPopUp.h"
#import "RootViewController.h"
#import "UIViewController+MaryPopin.h"
@interface MyArticlesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIRefreshControl *refreshControl;
    NSString *postedOn,*viewsArt,*by,*Ok,*Cancel,*removeFav,*noArticle,*noSequence,*noMatchFound,*addSubArt;
    NSString *uID,*UserType;
    
    NSString *userId;
    NSMutableArray *data;
    MyArticlesTableViewCell*cell;
    
    UIView *subBackGroundArticleView;
    UIView *subArticleView;
    
    RPFloatingPlaceholderTextField *subArticleTitle;
    RPFloatingPlaceholderTextField *subArticleDescription;

}
@property (nonatomic, getter = isDismissable) BOOL dismissable;
@property (nonatomic, assign) NSInteger selectedAlignementOption;

@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblNoArticles;

@end

@implementation MyArticlesViewController

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
    [_tblMyArticles setHidden:YES];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    UserType=[userDefaults objectForKey:@"usertype"];
    data=[[NSMutableArray alloc]init];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(getAllMyArticles) forControlEvents:UIControlEventValueChanged];
    [_tblMyArticles addSubview:refreshControl];
    _tblMyArticles.alwaysBounceVertical = YES;
   _tblMyArticles.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     [self checkUserType];
    [self getAllMyArticles];
    

  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)checkUserType
{
    [[APIManager sharedInstance]checkingUserType:userId andCompleteBlock:^(BOOL success, id result) {
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


#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        //self.title=[Language MyArticles];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language MyArticles];
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
        addSubArt=[Language AddSubArticleMy];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    }
    else if ([language1 isEqualToString:@"3"]){
        //  self.title=@"အကြှနျုပျ၏ဆောင်းပါးများ";
        postedOn=@"တွင် Posted:";
        viewsArt=@"အမြင်ချင်း";
        by=@"အားဖြင့် ";
        Ok=@"အိုကေ";
        Cancel=@"ဖျက်သိမ်း";
        removeFav=@"သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?";
        noArticle=@"ရရှိနိုင်သောပုဒ်မဘယ်သူမျှမက";
        noSequence=@"ရရှိနိုင် sequence ကိုအဘယ်သူမျှမ";
        noMatchFound=@"မီးခြစ်မျှမတွေ့";
        addSubArt=@"Sub ဆောင်းပါးများ Add";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကြှနျုပျ၏ Created ဆောင်းပါးများ";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
    }
    else{
        self.title=@"My Created Articles";
        postedOn=@"Posted On";
        viewsArt=@"Views:";
        by=@"By ";
        Ok=@"ok";
        Cancel=@"cancel";
        removeFav=@"Are you sure, you want to remove this article from your Favorite List?";
        noArticle=@"No Article Available";
        noSequence=@"No sequence available";
        noMatchFound=@"No Match Found";
         addSubArt=@"Add Sub Articles";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    }
    
}

#pragma mark -Get All Favourite Articles
-(void)getAllMyArticles{
    //  [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllMyArticles:userId andCompleteBlock:^(BOOL success, id result) {
     
        //[Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        [refreshControl endRefreshing];
        if (!success) {
            [_tblMyArticles setHidden:YES];
            
            
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"FuturaStd-Medium" size:17];
        
            lblass.text=[Language NoArticlesAvailable];
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            
                       return ;
        }
        data=[result objectForKey:@"article_data"];
        [_tblMyArticles setHidden:NO];
        [_tblMyArticles reloadData];
    }];
}
#pragma mark - TableViewDeligates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        return 190.0f;
    
      
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = (MyArticlesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyArticlesTableViewCell"];
    cell.contentView.layer.cornerRadius=2.0f;
     cell.contentView.layer.masksToBounds=YES;
    CALayer *layer=cell.layer;
    layer=cell.ratingView.layer;
    
    layer.masksToBounds=NO;
    layer.cornerRadius = 4.0f;
   
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyArticlesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    NSLog(@"%@",dict);
    cell.lblArticleTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];;
    NSDictionary *auth=[dict objectForKey:@"user_data"];
    NSString *byAuth=[by stringByAppendingString:[auth valueForKey:@"username"]];
    cell.lblAuthore.text=[NSString stringWithFormat:@"%@",byAuth];
    NSString *rate=[NSString stringWithFormat:@"%@",[dict valueForKey:@"avg_rate"]];
    if ([rate isEqualToString:@"0"]) {
         cell.lblRatingCount.text=@"0";
    }
    else{
    float rating=[[dict valueForKey:@"avg_rate"] floatValue];
    cell.lblRatingCount.text=[NSString stringWithFormat:@"%.1f",rating];
    }
    NSString *watch=[dict valueForKey:@"watched"];
    if ([watch isEqualToString:@"yes"]) {
        cell.viewedImg.hidden=NO;
    }
    else{
        cell.viewedImg.hidden=YES;
    }

    NSString *vie=[viewsArt stringByAppendingString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"view_count"]]];
    cell.lblViewCount.text=[NSString stringWithFormat:@"%@",vie];
    NSNumber *number=[dict valueForKey:@"review_count"];
    NSString *string=[number stringValue];
    
    if ([string isEqualToString:@"0"]) {
        cell.lblReviewCountNumber.hidden=YES;
    }
    else{
        cell.lblReviewCountNumber.text=[NSString stringWithFormat:@"(%@)",[dict valueForKey:@"review_count"]];
    }
     NSNumber *numberSub=[dict valueForKey:@"count_sub_articles"];
    NSString *subArticleCount=[numberSub stringValue];
    NSInteger subCount=[subArticleCount integerValue];
    NSString *addSub;
    
    
    if (subCount >=3) {
        cell.btnAddSubArticle.hidden=YES;
    }
    else{
        cell.btnAddSubArticle.hidden=NO;
        if (subCount==0) {
            addSub=@"3";
        }
        if (subCount==1) {
            addSub=@"2";
        }
        if (subCount==2) {
            addSub=@"1";
        }
        if ([addSub isEqualToString:@"3"]) {
            
            NSString *add=[Language Add];
            NSString *subArticle=[Language MoreSubArticles];
             [cell.btnAddSubArticle setTitle:[NSString stringWithFormat:@"%@ %@ %@",add,addSub,subArticle] forState:UIControlStateNormal];
        }
        else{
            
            NSString *add=[Language Add];
            NSString *moreSub=[Language MoreSubArticles];
        [cell.btnAddSubArticle setTitle:[NSString stringWithFormat:@"%@ %@ %@",add,addSub,moreSub] forState:UIControlStateNormal];
        }
//       CGRect newframe=CGRectMake(x, y, width, hight);
//        cell.btnAddSubArticle.frame=newframe;
        cell.btnAddSubArticle.titleLabel.numberOfLines=2;
    }
    cell.lblShortDescription.text=[dict valueForKey:@"short_description"];
    NSString *imgStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"photo1"]];
    cell.articleImg.layer.masksToBounds = YES;
    cell.articleImg.layer.cornerRadius = 5.0;
    NSString *type=[dict valueForKey:@"file_type"];
    if ([type isEqualToString:@"2"]) {
        NSLog(@"type is Photo");
        cell.imgVideoIcon.hidden=YES;
        [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,imgStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
        
        
    }
    else if([type isEqualToString:@"3"]){
        NSString *videoStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"video_thumb"]];
        cell.imgVideoIcon.hidden=NO;
        [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,videoStr]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    }
    else{
        NSString *  videoId;
        NSString *youtubeImg=[dict valueForKey:@"link"];
        NSArray* foo = [youtubeImg componentsSeparatedByString: @".be/"];
        NSString* firstBit = [foo objectAtIndex: 0];
        if ([firstBit isEqualToString:@"https://youtu"]) {
            videoId= [foo objectAtIndex:1];
            NSString *youtubeImg=@"http://img.youtube.com/vi/";
            NSString *url=[NSString stringWithFormat:@"%@%@/0.jpg",youtubeImg,videoId];
            cell.imgVideoIcon.hidden=NO;
            [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
        }
        else{
            NSString *youtubeImg=[dict valueForKey:@"link"];
            NSURL *url1=[NSURL URLWithString:youtubeImg];
            NSString *urlStr = [url1 absoluteString];
            NSString * videoId = [urlStr substringFromIndex:[urlStr rangeOfString:@"="].location + 1];
            NSString *youImg=@"http://img.youtube.com/vi/";
            NSString *url=[NSString stringWithFormat:@"%@%@/0.jpg",youImg,videoId];
            cell.imgVideoIcon.hidden=NO;
            [cell.articleImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", url]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
        }
    }
    if (!cell.articleImg.image) {
        cell.articleImg.image=[UIImage imageNamed:@"ic_placeholder_articles_item.png"];
    }
//    CALayer *layer=cell.layer;
//    layer.masksToBounds=NO;
//    layer.cornerRadius = 4.0f;
    
    cell.btnAddSubArticle.layer.cornerRadius=5.0f;
    cell.btnAddSubArticle.layer.masksToBounds=YES;
    
    
    [cell.btnAddSubArticle addTarget:self action:@selector(subArticlePopUp:) forControlEvents:UIControlEventTouchUpInside];
    cell.ratingView.layer.masksToBounds=YES;
    cell.ratingView.layer.cornerRadius=4.0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    NSString* strArticleId=[dict valueForKey:@"id"];
    ArticleDetailsViewController *articleDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsViewController"];
    articleDetails.articleId=strArticleId;
    [self.navigationController pushViewController:articleDetails animated:YES];
    
}
-(void)subArticlePopUp:(id)sender{
    MyArticlesTableViewCell *clickedCell = (MyArticlesTableViewCell*)[[sender superview] superview];
    NSIndexPath *indexPathCell = [_tblMyArticles indexPathForCell:clickedCell];
    NSDictionary *dict = [data objectAtIndex:indexPathCell.row];
    NSString* strArticleId=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:strArticleId forKey:@"artId"];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:AppName
                                          message:strArticleId
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:[Language Cancel]
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:[Language ok]
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    NSUserDefaults *userdef=[NSUserDefaults standardUserDefaults];
    [userdef setObject:@"sub" forKey:@"subarticle"];
    PopViewController *popin = [self.storyboard instantiateViewControllerWithIdentifier:@"PopViewController"];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSlide];
    if ([self isDismissable]) {
        [popin setPopinOptions:BKTPopinDefault];
    } else {
        [popin setPopinOptions:BKTPopinDisableAutoDismiss];
    }
    
    //Set popin alignement according to value in segmented control
    [popin setPopinAlignment:self.selectedAlignementOption];
    
    //Create a blur parameters object to configure background blur
    BKTBlurParameters *blurParameters = [BKTBlurParameters new];
    blurParameters.alpha = 1.0f;
    blurParameters.radius = 8.0f;
    blurParameters.saturationDeltaFactor = 1.8f;
    blurParameters.tintColor = [UIColor colorWithRed:0.966 green:0.851 blue:0.038 alpha:0.2];
    [popin setBlurParameters:blurParameters];
    
    //Add option for a blurry background
    [popin setPopinOptions:[popin popinOptions]|BKTPopinBlurryDimmingView];
    
    //Define a custom transition style
    if (popin.popinTransitionStyle == BKTPopinTransitionStyleCustom)
    {
        [popin setPopinCustomInAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
            
            popinController.view.frame = finalFrame;
            popinController.view.transform = CGAffineTransformMakeRotation(M_PI_4 / 2);
            
        }];
        
        [popin setPopinCustomOutAnimation:^(UIViewController *popinController, CGRect initialFrame, CGRect finalFrame) {
            
            popinController.view.frame = finalFrame;
            popinController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            
        }];
    }
    
    [popin setPreferedPopinContentSize:CGSizeMake(280.0, 300.0)];
    
    //Set popin transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self.navigationController presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];

    


}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    subBackGroundArticleView.hidden=YES;
    subArticleView.hidden=YES;
    
}
- (IBAction)btnMenuTapped:(id)sender {
    [self.view endEditing:YES];
    
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];

}


@end
