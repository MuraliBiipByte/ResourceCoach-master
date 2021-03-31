//
//  MiniCertificateViewController.m
//  DedaaBox
//
//  Created by Biipmi on 3/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "MiniCertificateViewController.h"
#import "CourseDetailViewController.h"
#import "SKSTableViewCell.h"
#import "SequenceTableViewCell.h"
#import "MiniCertificatesTableViewCell.h"
#import "REFrostedViewController.h"
#import "Language.h"
#import "HYCircleLoadingView.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "AuthoreProfileViewController.h"
#import "SCLAlertView.h"
#import "SubscriptionViewController.h"
@interface MiniCertificateViewController ()
{
    NSMutableArray *arrAuthoreImage,*arrAuthoreName,*arrAuthoreId,*arrCount,*arrAboutAuthore,*arrMiniCertNames,*arrMiniCertificatesIds;
    
    NSMutableArray *miniCertificatesTotal,*miniCertificates,*arrSubMiniCer;
    UIView *backGroundView;
    SKSTableViewCell *cell;
    NSString *userid;
    NSString *loginUserType;
    UILabel *lblass1;
    int subcellHight;
    NSString *strAuthoreId;
    
    NSString *selectedSection;
    NSString *selectedRow;
    
    NSString *strSubCat;
    NSString *strSubCat1;
    
//    int selectedSection;
//    int selectedRow;
   
}

@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation MiniCertificateViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
  
    arrAuthoreImage=[[NSMutableArray alloc]init];
    arrAuthoreName=[[NSMutableArray alloc]init];
    arrAuthoreId=[[NSMutableArray alloc]init];
    arrCount=[[NSMutableArray alloc]init];
    arrAboutAuthore=[[NSMutableArray alloc]init];
    arrMiniCertNames=[[NSMutableArray alloc]init];
    arrMiniCertificatesIds=[[NSMutableArray alloc]init];
    
   
    miniCertificatesTotal=[[NSMutableArray alloc]init];
    miniCertificates=[[NSMutableArray alloc]init];
     arrSubMiniCer=[[NSMutableArray alloc]init];

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

    
    
    
    self.miniLessonsTable.shouldExpandOnlyOneCell = YES;
    self.miniLessonsTable.SKSTableViewDelegate = self;
    [self navigationConfiguration];
    [_miniLessonsTable setShowsVerticalScrollIndicator:NO];
    
    

  
    
    // Do any additional setup after loading the view.
}
-(void)navigationConfiguration{
    self.title=[Language MiniCertifications];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    userid=[usercheckup valueForKey:@"id"];
      [self GetallminiCerticatesList];
  
    
}
-(void)tapDetected:(id)sender

{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.miniLessonsTable];
    NSIndexPath *indexPath = [self.miniLessonsTable indexPathForRowAtPoint:buttonPosition];

     NSString *strAuthoreid=[NSString stringWithFormat:@"%@",[[miniCertificates objectAtIndex:indexPath.row] valueForKey:@"id"]];
    
    AuthoreProfileViewController *authoreProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"AuthoreProfileViewController"];
    
    authoreProfile.authoreId=strAuthoreid;
    
    [self.navigationController pushViewController:authoreProfile animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)GetallminiCerticatesList
{
    
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllMiniCertificatesListWithUserId:userid andCompleteBlock:^(BOOL success, id result)
    {
        backGroundView.hidden=YES;
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:NO];
        if (!success)
        {
            self.miniLessonsTable.hidden=YES;
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            //lblass.text=@"No Mini Certifications Available";
            lblass.text=@"No Mock assessments Available";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            
            return ;
        }
        else
        {
            
            self.miniLessonsTable.hidden=NO;
            
            NSMutableDictionary *data=[result valueForKey:@"data"];
            loginUserType=[result valueForKey:@"user_type"];
            
            
//            NSMutableArray *categoryArr = [data valueForKey:@"category"];
            
            if ([loginUserType isEqualToString:@"non_subscriber"]) {
                UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
                img1.image=[UIImage imageNamed:@"nodataimg"];
                lblass1=[[UILabel alloc] initWithFrame:CGRectMake(8, img1.frame.origin.y+108, self.view.frame.size.width-16, 40)];
                lblass1.textAlignment=NSTextAlignmentCenter;
                lblass1.textColor=[UIColor lightGrayColor];
                lblass1.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
                lblass1.text=@"Sorry,this content is locked.Please subscribe to continue.";
                lblass1.numberOfLines=0;
                UIButton *btnSubscribe=[[UIButton alloc]initWithFrame:CGRectMake(100, img1.frame.origin.y+154, self.view.frame.size.width-200, 40)];
               [btnSubscribe setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:40.0/255.0 blue:46.0/255.0 alpha:1]];
                [btnSubscribe setTitle:@"Subscribe" forState:UIControlStateNormal];
                [btnSubscribe addTarget:self action:@selector(goToSubscriber) forControlEvents:UIControlEventTouchUpInside];
                btnSubscribe.layer.cornerRadius=20;
                btnSubscribe.layer.masksToBounds=YES;
                
                
                [self.view addSubview:img1];
                [self.view addSubview:lblass1];
                [self.view addSubview:btnSubscribe];
            }
            else{
            NSMutableDictionary *authoreData=[data valueForKey:@"author"];
            //miniCertificatesTotal=[data valueForKey:@"author"];
            miniCertificatesTotal=[data valueForKey:@"category"];
            [miniCertificates addObjectsFromArray:miniCertificatesTotal];
            
      
                
//            miniCertificatesTotal = categoryArr;
                
            [self.miniLessonsTable refreshData];
            }
            
            
        }
    }];
    

    
}

-(void)goToSubscriber{
    SubscriptionViewController *subscribe=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionViewController"];
    [self.navigationController pushViewController:subscribe animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"the count %ld",miniCertificates.count);
    return miniCertificatesTotal.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  cell=[tableView dequeueReusableCellWithIdentifier:@"SKSTableViewCell"];
   cell.imgMiniLock.hidden=YES;
    
    
    cell.imgAuthore.layer.cornerRadius=cell.imgAuthore.frame.size.height/2;
    cell.imgAuthore.layer.masksToBounds=YES;
    if ([loginUserType isEqualToString:@"non_subscriber"]) {
        cell.imgMiniLock.hidden=NO;
          cell.expandable=NO;
    }
    else{
        cell.imgMiniLock.hidden=YES;
           cell.expandable=YES;
 
    }
    cell.imgMiniLock.layer.cornerRadius=3;
    cell.imgMiniLock.layer.masksToBounds=YES;
    
      [cell.btnAuthoreNameTapped addTarget:self action:@selector(tapDetected:) forControlEvents:UIControlEventTouchUpInside];
     [cell.btnAuthoreImageTapped addTarget:self action:@selector(tapDetected:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnReadMoreAboutAuthore addTarget:self action:@selector(tapDetected:) forControlEvents:UIControlEventTouchUpInside];
 

    
    
     NSString *strImg=[[miniCertificates objectAtIndex:indexPath.row]valueForKey:@"photo_orig"];
    /*[cell.imgAuthore sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImg]]];
    
    if (!cell.imgAuthore.image) {
        cell.imgAuthore.image=[UIImage imageNamed:@"userprofile"];
    } */
    
    
    [cell.backgroundImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strImg]]];
    if (!cell.backgroundImgView.image){
        cell.backgroundImgView.image = [UIImage imageNamed:@"userprofile"];
    }
    NSString *name=[[miniCertificates objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.lblAuthoreName.text = name;
    
    /*
    NSString *strAuthoreName=[NSString stringWithFormat:@"%@",[[miniCertificates objectAtIndex:indexPath.row] valueForKey:@"username"]];

    cell.lblAuthoreName.text=strAuthoreName;
    
    NSString *strAaboutAuthore=[NSString stringWithFormat:@"%@",[[miniCertificates objectAtIndex:indexPath.row] valueForKey:@"about"]];
    
    
    cell.lblAboutAuthore.text=strAaboutAuthore; */
    
    
 
    cell.accessoryView = nil;
    
    
    
    return cell;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MiniCertificatesTableViewCell";
    
    MiniCertificatesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (!cell)
        
        cell = [[MiniCertificatesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
//    strSubCat=[[arrSubMiniCer objectAtIndex:indexPath.subRow-1] valueForKey:@"title"];
//    NSLog(@"strSubCat = %@ ",strSubCat);
    
    NSDictionary *d=[miniCertificates objectAtIndex:indexPath.row];
   if([d valueForKey:@"mini_certification_data"])
   {
       arrSubMiniCer=[[d valueForKey:@"mini_certification_data"] mutableCopy];
   }
 
    if ([strSubCat isEqual:[NSNull null]]) {
        NSLog(@"SubCat Coming NULL");
        cell.lblMiniCertificationTitle.text=@"";
    }
    else{
        cell.lblMiniCertificationTitle.text=[[arrSubMiniCer objectAtIndex:indexPath.subRow-1] valueForKey:@"title"];
       
        CGSize constraintAnswer = CGSizeMake(cell.lblMiniCertificationTitle.frame.size.width, CGFLOAT_MAX);
        NSStringDrawingContext *contextAnswer = [[NSStringDrawingContext alloc] init];
        CGSize boundingAnswer = [cell.lblMiniCertificationTitle.text boundingRectWithSize:constraintAnswer
                                                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                attributes:@{NSFontAttributeName:cell.lblMiniCertificationTitle.font}
                                                                                                   context:contextAnswer].size;
        
        CGSize sizeAnswer = CGSizeMake(ceil(boundingAnswer.width), ceil(boundingAnswer.height));
        NSLog(@"sizeViews label hight is %f",sizeAnswer.height);
        subcellHight=sizeAnswer.height+20;
        [cell.btnSelect setFrame:CGRectMake(cell.btnSelect.frame.origin.x, cell.btnSelect.frame.origin.y, cell.btnSelect.frame.size.width, subcellHight)];
        

        
        cell.btnSelect.tag = 100+indexPath.subRow;
        [cell.btnSelect addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchUpInside];
        

    }

    
    //cell.lblMiniCertificationTitle.text=strSubCat;
    return cell;
}
- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *notificationDefaults=[NSUserDefaults standardUserDefaults];
    NSString *isBackTapped = [notificationDefaults valueForKey:@"backTapped"];
    NSString *selSection = [notificationDefaults valueForKey:@"selectedSection"];
    NSString *selRow = [notificationDefaults valueForKey:@"selectedRow"];

    NSString *strSection=[NSString stringWithFormat:@"%d",indexPath.section];
    NSString *strRow=[NSString stringWithFormat:@"%d",indexPath.row];
//    NSInteger secInt = [selSection integerValue];
//    NSInteger rowInt = [selRow integerValue];
    
//    NSLog(@"Murali....");
//    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
//    NSLog(@"secInt: %d, rowInt:%d", secInt, rowInt);
    if ([isBackTapped isEqualToString:@"backTapped"]){
        
        if(indexPath.row == ((miniCertificatesTotal.count)-1)){
            [notificationDefaults removeObjectForKey:@"backTapped"];
//            [notificationDefaults removeObjectForKey:@"selectedSection"];
//            [notificationDefaults removeObjectForKey:@"selectedRow"];
            [notificationDefaults synchronize];
            if([strSection isEqualToString:selSection] && [strRow isEqualToString:selRow]) {
                return YES;
            }else{
                return NO;
            }
        }else{
            if([strSection isEqualToString:selSection] && [strRow isEqualToString:selRow]) {
                return YES;
            }else{
                return NO;
            }
        }
        
        
        
    }else{
        return NO;
    }
    
    //return NO;
//    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//    f.numberStyle = NSNumberFormatterNoStyle;
//    NSNumber *secInt = [f numberFromString:selSection];
//    NSNumber *rowInt = [f numberFromString:selRow];
    
    
    
    
    //return NO;
    
    
    
    
    
    
    
}


- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *d=[miniCertificates objectAtIndex:indexPath.row];
    if([d valueForKey:@"mini_certification_data"])
    {
        arrSubMiniCer=[[d valueForKey:@"mini_certification_data"] mutableCopy];
    }
    if ([arrSubMiniCer isEqual:[NSNull null]] || ![arrSubMiniCer count]) {
        return 0;
    }
    return arrSubMiniCer.count;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //return 250.0f;
    return  150.0f;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
   return subcellHight;
}


- (void)setExpanded:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"setExpanded from SKSTV called...");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strAuthoreId = [NSString stringWithFormat:@"%@",[[miniCertificates objectAtIndex:indexPath.row] valueForKey:@"id"]];
    if ([loginUserType isEqualToString:@"non_subscriber"]) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:@"Please Subscribe With us to Get the Certification From DedaaBox" closeButtonTitle:[Language ok] duration:0.0f];
        
    }
    else{
        

    }
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    selectedSection=[NSString stringWithFormat:@"%d",indexPath.section];
    selectedRow=[NSString stringWithFormat:@"%d",indexPath.row];
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, :%d", indexPath.section, indexPath.row, indexPath.subRow);
    selectedSection=[NSString stringWithFormat:@"%d",indexPath.section];
    selectedRow=[NSString stringWithFormat:@"%d",indexPath.row];
//    CourseDetailViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
//    [self.navigationController pushViewController:courseDetails animated:YES];
    
}

- (IBAction)btnMenuTapped:(id)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
#pragma mark -Show Details Tapped
-(void)showDetailView:(id)sender{

    NSInteger rowVal = [sender tag]-100;
    NSString *miniCertificateId=[[arrSubMiniCer objectAtIndex:rowVal-1] valueForKey:@"id"];
      NSString *miniCertificateName=[[arrSubMiniCer objectAtIndex:rowVal-1] valueForKey:@"title"];
//    NSString *subcatName=[[arrSubMiniCer objectAtIndex:rowVal-1] valueForKey:@"title"];
//   
            CourseDetailViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
        courseDetails.miniCertificateId=miniCertificateId;
       courseDetails.miniCertificateName=miniCertificateName;
    courseDetails.strAuthoreId = strAuthoreId;
    
    courseDetails.sSection = selectedSection;
    courseDetails.sRow = selectedRow;
        [self.navigationController pushViewController:courseDetails animated:YES];
    
}


@end
