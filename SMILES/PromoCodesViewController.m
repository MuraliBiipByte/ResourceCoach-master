//
//  PromoCodesViewController.m
//  DedaaBox
//
//  Created by BiipByte on 06/09/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "PromoCodesViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "PromoCodeTableViewCell.h"


@interface PromoCodesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrScratchCards,*arrScratchValidFrom,*arrScratchValidTill;
    NSMutableArray *arrPromoCodes,*arrValidFrom,*arrValidTill,*arrSubscriptionType;;
    
    NSMutableArray *arrSubscriptions,*arrSubscriptionValidFrom,*arrSubscriptionValidTill;
    
    
    NSString *strPromoCode;
    NSString *strSubscriptions;
    NSString *strScrathCard;
    
    //ForRemovingNull
    NSMutableArray *arrScratchCardswithNullValues;
    NSMutableArray *arrSubscriptionswithNullValues;
    NSMutableArray *arrpromocodeswithNullValues;
     NSString *strUserId;

}
@property (weak, nonatomic) IBOutlet UITableView *tblPromocodes;

@end

@implementation PromoCodesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrPromoCodes=[[NSMutableArray alloc]init];
    arrValidFrom=[[NSMutableArray alloc]init];
    arrValidTill=[[NSMutableArray alloc]init];
    
    arrSubscriptions=[[NSMutableArray alloc]init];
    arrSubscriptionValidFrom=[[NSMutableArray alloc]init];
    arrSubscriptionValidTill=[[NSMutableArray alloc]init];
    
    
    arrScratchCards=[[NSMutableArray alloc]init];
    arrScratchValidFrom=[[NSMutableArray alloc]init];
    arrScratchValidTill=[[NSMutableArray alloc]init];
    arrSubscriptionType=[[NSMutableArray alloc]init];
    
    arrpromocodeswithNullValues=[[NSMutableArray alloc]init];
    arrSubscriptionswithNullValues=[[NSMutableArray alloc]init];
    arrScratchCardswithNullValues=[[NSMutableArray alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    strUserId=[userDefaults  objectForKey:@"id"];
    [self getTheUserProfileDetails];
    [_tblPromocodes setSeparatorStyle:UITableViewCellSeparatorStyleNone];
 

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Get Profile Details
-(void)getTheUserProfileDetails{
    //  [Utility showLoading:self];
      [[APIManager sharedInstance]getUserProfileDetailsWithUserId:strUserId andCompleteBlock:^(BOOL success, id result)
     {
         // [Utility hideLoading:self];
        if (!success) {
            
             return ;
         }
         NSDictionary *data = [result objectForKey:@"data"];
         NSDictionary *userDict = [data objectForKey:@"userdata"];
         NSString *userId,*userName,*userTelcode,*userMobileNo,*userEmail,*userEmailVerify,*userType,*userTypeId,*userProfilePic,*userMobVerifyStatus,*userActive,*userCompanyName,*userDepartment,*userEmpId;
         userId=[userDict valueForKey:@"id"];
         userName=[userDict valueForKey:@"username"];
         userTelcode=[userDict valueForKey:@"telcode"];
         userMobileNo=[userDict valueForKey:@"phone"];
         userEmail=[userDict valueForKey:@"email"];
         userType=[userDict valueForKey:@"usertype"];
         userTypeId=[userDict valueForKey:@"usertype_id"];
         userProfilePic=[userDict valueForKey:@"photo_user"];
         userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
         userActive=[userDict valueForKey:@"active"];
         
         NSMutableDictionary *UserCode=[userDict valueForKey:@"user_subscription"];
        
         arrSubscriptionType=[UserCode valueForKey:@"type"];
         arrPromoCodes=[UserCode valueForKey:@"coupon_name"];
         arrScratchCards=[UserCode valueForKey:@"scratch_card_name"];
         arrSubscriptions=[UserCode valueForKey:@"subscription_name"];
         arrValidFrom=[UserCode valueForKey:@"start_date"];
         arrValidTill=[UserCode valueForKey:@"end_date"];
         
         [_tblPromocodes reloadData];
         
         
         
         
         
         
         
         
//         arrpromocodeswithNullValues=[UserCode valueForKey:@"coupon_name"];
//         arrValidFrom=[UserCode valueForKey:@"start_date"];
//         arrValidTill=[UserCode valueForKey:@"end_date"];
//         
//         arrSubscriptionswithNullValues=[UserCode valueForKey:@"subscription_name"];
//         arrSubscriptionValidFrom=[UserCode valueForKey:@"start_date"];
//         arrSubscriptionValidTill=[UserCode valueForKey:@"end_date"];
//         
//         arrScratchCardswithNullValues=[UserCode valueForKey:@"scratch_card_name"];
//         arrScratchValidFrom=[UserCode valueForKey:@"start_date"];
//         arrScratchValidTill=[UserCode valueForKey:@"end_date"];
//         
//         for (int i = 0; i < [arrpromocodeswithNullValues count]; i++)
//         {
//             id obj = [arrpromocodeswithNullValues objectAtIndex:i];
//             if (![obj  isEqual:[NSNull null]])
//             {
//                 [arrPromoCodes addObject:obj];
//             }
//         }
//         
//         for (int i = 0; i < [arrSubscriptionswithNullValues count]; i++)
//         {
//             id obj = [arrSubscriptionswithNullValues objectAtIndex:i];
//             if (![obj  isEqual:[NSNull null]])
//             {
//                 [arrSubscriptions addObject:obj];
//             }
//         }
//         
//         for (int i = 0; i < [arrScratchCardswithNullValues count]; i++)
//         {
//             id obj = [arrScratchCardswithNullValues objectAtIndex:i];
//             if (![obj  isEqual:[NSNull null]])
//             {
//                 [arrScratchCards addObject:obj];
//             }
//         }
//         
//         
//         if ( arrPromoCodes.count>0 || arrSubscriptions.count>0 || arrScratchCards.count>0 )
//         {
//             
//             [_tblPromocodes reloadData];
//         }
        NSString *expiry=[userDict valueForKey:@"user_expiry"];
         if (([expiry isEqual:[NSNull null]]||[expiry isEqualToString:@"<null>"]))
         {
//             _lblExpairyDate.hidden=YES;
//             _viewPromoCode.hidden=YES;
         }
         else
         {
//             _lblExpairyDate.text=[NSString stringWithFormat:@"Your subscription expires on : %@",expiry];
//             _viewPromoCode.hidden=NO;
//             _lblExpairyDate.hidden=NO;
         }
         

         [_tblPromocodes reloadData];
         
     }];
}

#pragma TableViewDeligates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrPromoCodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromoCodeTableViewCell  *cell = (PromoCodeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PromoCodeTableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PromoCodeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *strSubsType=[arrSubscriptionType objectAtIndex:indexPath.row];
    if ([strSubsType isEqualToString:@"Coupon"])
    {
        cell.lblSubscriptionName.text=[NSString stringWithFormat:@"%@",[arrPromoCodes  objectAtIndex:indexPath.row]];
    }
    else if ([strSubsType isEqualToString:@"Subscription"])
    {
        cell.lblSubscriptionName.text=[NSString stringWithFormat:@"%@",[arrSubscriptions  objectAtIndex:indexPath.row]];

    }
    else
    {
        cell.lblSubscriptionName.text=[NSString stringWithFormat:@"%@",[arrScratchCards  objectAtIndex:indexPath.row]];
    }
    cell.lblSubValidFrom.text=[NSString stringWithFormat:@"%@",[arrValidFrom objectAtIndex:indexPath.row]];
    cell.lblSUbValidTill.text=[NSString stringWithFormat:@"%@",[arrValidTill objectAtIndex:indexPath.row]];
    
       return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
