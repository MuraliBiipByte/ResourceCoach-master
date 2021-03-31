//
//  AuthoreProfileViewController.m
//  DedaaBox
//
//  Created by BiipByte on 04/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "AuthoreProfileViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "UIImageView+WebCache.h"
#import "HYCircleLoadingView.h"
#import "TrainerDetailsViewController.h"

@interface AuthoreProfileViewController ()
{
    UIView *backGroundView;

}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation AuthoreProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigation];
    _aboutAuthoreView.layer.cornerRadius=5;
    _aboutAuthoreView.layer.masksToBounds=YES;
    
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
    
    
    _imgAuthore.layer.cornerRadius=_imgAuthore.frame.size.height/2;
    _imgAuthore.layer.borderWidth=6.0;
    _imgAuthore.layer.masksToBounds = YES;
    _imgAuthore.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [self getAuthoreProfileDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureNavigation
{
    self.title=@"Trainer Details";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}
#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Get Profile Details
-(void)getAuthoreProfileDetails{
    //  [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]authoreDetailsWithAuthId:_authoreId andCompleteBlock:^(BOOL success, id result) {
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
            NSDictionary *authoreData=[result valueForKey:@"author_data"];
            NSString *authoreImg=[authoreData valueForKey:@"photo_orig"];
            NSString *authoreName=[authoreData valueForKey:@"username"];
            NSString *aboutAuthore=[authoreData valueForKey:@"about"];
            NSString *articleCount=[NSString stringWithFormat:@" VIDEOS - %@",[authoreData valueForKey:@"article_count"] ];
            
            NSString *favCount=[NSString stringWithFormat:@"  LIKES - %@",[authoreData valueForKey:@"fav_count"]];
            [_btnVideosCount setTitle:articleCount forState:UIControlStateNormal];
            [_btnLikesCount setTitle:favCount forState:UIControlStateNormal];
            _lblAuthoreName.text=authoreName;
            _lblAboutAuthore.text=aboutAuthore;
         
            
            
            
           [ _imgAuthore sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,authoreImg]]
                           placeholderImage:[UIImage imageNamed:@"userprofile"]];
            
            if (!_imgAuthore.image)
            {
                _imgAuthore.image=[UIImage imageNamed:@"userprofile"];
            }
        }
    }];
    }
- (IBAction)btnVideosTapped:(id)sender
{
    TrainerDetailsViewController *trainer=[self.storyboard instantiateViewControllerWithIdentifier:@"TrainerDetailsViewController"];
    trainer.authorsID=_authoreId;
    [self.navigationController pushViewController:trainer animated:YES];
    
    
}
- (IBAction)btnLikesTapped:(id)sender {
}

@end
