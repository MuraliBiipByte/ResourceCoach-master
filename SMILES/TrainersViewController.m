//
//  TrainersViewController.m
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "TrainersViewController.h"
#import "TrainersCollectionViewCell.h"
#import "TrainersTableViewCell.h"
#import "TrainerDetailsViewController.h"
#import "REFrostedViewController.h"
#import "Language.h"
#import "Utility.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "HYCircleLoadingView.h"
#import "LeaderBoardViewController.h"


@interface TrainersViewController ()
{
    TrainersCollectionViewCell *collectionCell;
    TrainersTableViewCell *tableviewCell;
    UIView *backGroundView;
    UILabel *noDataLabel ;
    UIRefreshControl *refreshControl;
    NSInteger fav_Count;
}
@property (weak, nonatomic) IBOutlet UILabel *lblMyFav;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *imgBaner;

@end

@implementation TrainersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(getAllTrainers) forControlEvents:UIControlEventValueChanged];
    [_collectionViewAuthors addSubview:refreshControl];
    _collectionViewAuthors.alwaysBounceVertical = YES;

    
    _arrFavAuthoursName=[[NSMutableArray alloc]init];
    
    _arrFavAuthoursImages=[[NSMutableArray alloc]init];
    
    _arrFavAuthorsIds=[[NSMutableArray alloc]init];
    
    _arrAuthoursName=[[NSMutableArray alloc]init];
    
    _arrAuthorsImages=[[NSMutableArray alloc]init];
    
    _arrAuthorsIds=[[NSMutableArray alloc]init];
    _arrArticleDescription=[[NSMutableArray alloc]init];
    
    //[self getAllTrainers];
    
  //  [tableViewViewAuthors reloadData];
   // [collectionViewAuthors reloadData];
    self.title=[Language Trainers];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureNavigation];
     [self getAllTrainers];
   }
-(void)configureNavigation
{
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"badge"] style:UIBarButtonItemStylePlain target:self action:@selector(clickOnBadge:)];
//    [self.navigationItem setRightBarButtonItem:barButtonItem];
}
-(void)clickOnBadge:(id)sender
{
    LeaderBoardViewController *leaderBoard = [self.storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardViewController"];
    [self.navigationController pushViewController:leaderBoard animated:YES];
}

-(void)getAllTrainers
{
    
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
     [refreshControl endRefreshing];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
  NSString* uID=[usercheckup valueForKey:@"id"];
    [[APIManager sharedInstance]TrainersIncludingFav:uID andCompleteBlock:^(BOOL success, id result) {
        
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if(!success)
        {
            _viewFav.hidden=YES;
            _viewTrainers.hidden=YES;
            _viewFavTrainer.hidden=YES;
            _imgBaner.hidden=YES;
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=@"No Trainers Available";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        else
        {
            _viewFav.hidden=NO;
            _viewTrainers.hidden=NO;
            _viewFavTrainer.hidden=NO;
            _imgBaner.hidden=NO;
            
            NSDictionary *data=[result valueForKey:@"data"];
            NSDictionary *dictAuthors=[data valueForKey:@"all_authors"];
            
            _arrAuthoursName=[dictAuthors valueForKey:@"username"];
            _arrAuthorsDescription=[dictAuthors valueForKey:@"about"];
            _arrAuthorsImages=[dictAuthors valueForKey:@"photo_user"];
            _arrAuthorsIds=[dictAuthors valueForKey:@"id"];
            
           fav_Count=[[data valueForKey:@"fav_count"]integerValue];
            
            if (fav_Count==0)
            {
                noDataLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.collectionViewAuthors.bounds.size.width, _collectionViewAuthors.bounds.size.height)];
                noDataLabel.text             = @"No data available";
                noDataLabel.textColor        = [UIColor whiteColor];
                noDataLabel.textAlignment    = NSTextAlignmentCenter;

//          
                _collectionViewAuthors.backgroundView = noDataLabel;
                [_collectionViewAuthors reloadData];
                
                
              //  _collectionViewAuthors.hidden=YES;
           
            }
            else
            {
                noDataLabel.hidden=YES;
                _collectionViewAuthors.hidden=NO;
                
                NSDictionary *dictFavAuthors=[data valueForKey:@"fav_authors"];
                _arrFavAuthoursImages=[dictFavAuthors valueForKey:@"photo_user"];
                _arrFavAuthorsDescription=[dictFavAuthors valueForKey:@"about"];
                _arrFavAuthoursName=[dictFavAuthors valueForKey:@"username"];
                _arrFavAuthorsIds=[dictFavAuthors valueForKey:@"id"];
                [_collectionViewAuthors reloadData];
                
            }
            [_tableViewViewAuthors reloadData];
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
    if(fav_Count==0){
        return 0;
    }
    else{
        return _arrFavAuthoursName.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
        collectionCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TrainersCollectionViewCell" forIndexPath:indexPath];
        collectionCell.lblBigAuthorName.text=[_arrFavAuthoursName objectAtIndex:indexPath.row];
    [collectionCell.imgBigProfile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[_arrFavAuthoursImages objectAtIndex:indexPath.row]]]  placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    
    if (collectionCell.imgBigProfile.image==nil)
    {
        collectionCell.imgBigProfile.image=[UIImage imageNamed:@"userprofile"];
    }
collectionCell.imgBigProfile.layer.cornerRadius=collectionCell.imgBigProfile.frame.size.height/2;
    collectionCell.imgBigProfile.layer.masksToBounds=YES;
    collectionCell.imgBigProfile.layer.shadowColor = [UIColor whiteColor].CGColor;
    collectionCell.imgBigProfile.layer.shadowOffset = CGSizeZero;
   // collectionCell.imgBigProfile.layer.masksToBounds = NO;
    collectionCell.imgBigProfile.layer.shadowRadius = 4.0f;
    collectionCell.imgBigProfile.layer.shadowOpacity = 1.0;
    return  collectionCell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TrainerDetailsViewController *trainerDetailClass=[[TrainerDetailsViewController alloc]init];
trainerDetailClass=[self.storyboard instantiateViewControllerWithIdentifier:@"TrainerDetailsViewController"];
    trainerDetailClass.authorsID=[_arrFavAuthorsIds objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:trainerDetailClass animated:YES];
}

#pragma  UITableview Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _arrAuthorsImages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    tableviewCell=[tableView dequeueReusableCellWithIdentifier:@"TrainersTableViewCell" forIndexPath:indexPath];
    
    NSString *authorName=[_arrAuthoursName objectAtIndex:indexPath.row];
    
    if ([authorName isEqual:[NSNull null]])
    {
        NSLog(@"Author Name Unavailable");
        
    }
    else
    {
        tableviewCell.lblSmallAuthorName.text=[_arrAuthoursName objectAtIndex:indexPath.row];
    }
      NSString *authorDescription=[_arrAuthorsDescription objectAtIndex:indexPath.row];
    
    if ([authorDescription isEqual:[NSNull null]])
    {
        NSLog(@"Author Description Unavailable");
        
    }
    else
    {
    tableviewCell.lblArticleDescription.text=[_arrAuthorsDescription objectAtIndex:indexPath.row];
    }
    NSString *authorImage=[_arrAuthorsImages objectAtIndex:indexPath.row];
    
    if ([authorImage isEqual:[NSNull null]])
    {
        tableviewCell.imgSmallProfile.image=[UIImage imageNamed:@"userprofile"];

    }
    else
    {
    [tableviewCell.imgSmallProfile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,authorImage]] placeholderImage:[UIImage imageNamed:@"ic_placeholder_articles_item.png"]];
    }
    
    

    [tableviewCell.btnFav addTarget:self action:@selector(AddToFav:) forControlEvents:UIControlEventTouchUpInside];
    
    
        if (tableviewCell) {
            CGFloat direction = tableviewCell ? -1 : 1;
            tableviewCell.transform = CGAffineTransformMakeTranslation(tableviewCell.bounds.size.width * direction, 0);
            [UIView animateWithDuration:0.25 animations:^{
                tableviewCell.transform = CGAffineTransformIdentity;
            }];
        }
    
    
    return tableviewCell;
        
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainerDetailsViewController *trainerDetailClass=[[TrainerDetailsViewController alloc]init];
    trainerDetailClass=[self.storyboard instantiateViewControllerWithIdentifier:@"TrainerDetailsViewController"];
    trainerDetailClass.authorsID=[_arrAuthorsIds objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:trainerDetailClass animated:YES];
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
-(void)AddToFav:(id)sender
{
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    NSString* uID=[usercheckup valueForKey:@"id"];
    TrainersTableViewCell *clickedCell = (TrainersTableViewCell*)[[sender superview] superview];
    NSIndexPath *indexPathCell = [_tableViewViewAuthors indexPathForCell:clickedCell];
    NSString *TrainerId = [_arrAuthorsIds objectAtIndex:indexPathCell.row];
 //   NSString* strArticleId=[dict valueForKey:@"id"];

  //  [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]AddTrainerToFavourite:uID andWithTrainerId:TrainerId andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            return ;
        }
        else{
            NSLog(@"Fav Result is %@",result);
            NSInteger statue=[[result valueForKey:@"status"]integerValue];
            if (statue ==1) {
//                [tableviewCell.btnFav setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
                 [self getAllTrainers];
            }
        }
    }];
}




@end
