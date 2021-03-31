//
//  StartAssessmentViewController.m
//  SMILES
//
//  Created by Biipmi on 13/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "StartAssessmentViewController.h"
#import "REFrostedViewController.h"
#import "AssessmentViewController.h"
#import "AssessmentListViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"


@interface StartAssessmentViewController (){
    __weak IBOutlet UILabel *lblAssessmentTitle;
    __weak IBOutlet UILabel *lblDepartmentName;
    __weak IBOutlet UIView *btnBgView;
    __weak IBOutlet UIButton *btnStart;
    NSString *userId,*departmentName,*noAssesment,*viewAss;
    NSMutableArray *results;
    
     NSString *uID,*UserType;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation StartAssessmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblAssessmentTitle.text=[Language Assessment];
    [self navigationConfiguration];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    
    results=[[NSMutableArray alloc]init];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
       userId=[defaults objectForKey:@"id"];
    lblDepartmentName.text=[NSString stringWithFormat:@"%@",[defaults valueForKey:@"deptname"]];
    [btnStart setTitle:viewAss forState:UIControlStateNormal];
    btnBgView.layer.cornerRadius=4.0f;
    btnStart.layer.cornerRadius=4.0f;
    [self getAssementGroupsList];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self checkUserType];
}

-(void)checkUserType{
    
    [[APIManager sharedInstance]checkingUserType:uID andCompleteBlock:^(BOOL success, id result) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Get Assessment Group
-(void)getAssementGroupsList{
    [Utility showLoading:self];
//    [self.loadingView startAnimation];
//    [self.loadingView setHidden:NO];
//    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllAssessmentsWithUserId:userId andCompleteBlock:^(BOOL success, id result) {
        [Utility hideLoading:self];
//        [self.loadingView stopAnimation];
//        [self.loadingView setHidden:YES];
//        [self.img setHidden:YES];       
        if (!success) {
           // [Utility showAlert:AppName withMessage:result];
            [btnStart setTitle:noAssesment forState:UIControlStateNormal];
            //[btnStart setEnabled:NO];
            return ;
        }
        // NSDictionary *response = [result objectForKey:@"response"];
        NSString *message = [result objectForKey:@"message"];
        NSInteger status = [[result objectForKey:@"status"] intValue];
        if (status == 1) {
            NSDictionary *data = [result objectForKey:@"data"];
            NSMutableArray *grpresult = [data valueForKey:@"groups"];
            results=[grpresult valueForKey:@"id"];
            if (results.count==0) {
                [btnStart setTitle:noAssesment forState:UIControlStateNormal];
                [btnStart setEnabled:NO];
            }
            else{
            }
        }
        else{
           // [Utility showAlert:AppName withMessage:message];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
           // [alert setHorizontalButtons:YES];
                        [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language ok] duration:0.0f];

            return;
        }
    }];
}

#pragma mark - Navigation Configuration

-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        //self.title=@"ကၽြႏု္ပ္၏ စီစစ္ခ်က္";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"ကၽြႏု္ပ္၏ စီစစ္ခ်က္";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        viewAss=@"အကဲၿဖတ္ခ်က္ ကိုၾကည့္ရႈပါ";
        noAssesment=@"အကဲၿဖတ္ခ်က္ မရွိေသးပါ";
    }
    else if ([language1 isEqualToString:@"3"]){
        //  self.title=@"အကဲဖြတ်";
        viewAss=@"ကြည့်ရန်အကဲဖြတ်";
        noAssesment=@"ရရှိနိုင်သောအကဲဖြတ်ခြင်းမရှိပါ";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကြှနျုပျ၏အကဲဖြတ်ခြင်း";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        
    }
    else{
        self.title=@"My Assessments";
        viewAss=@"View Assessment";
        noAssesment=@"No Assessment Available";
    }
    //self.title=@"Assessments";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    
  
}

#pragma mark -Button Start Assessment Tapped
- (IBAction)tnStartAssessmentTapped:(id)sender {
    if (results.count==0) {
        NSLog(@"No Assessment");
    }
    else{
    AssessmentListViewController *assement=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentListViewController"];
    [self.navigationController pushViewController:assement animated:YES];
    }
//    AssessmentViewController *assement=[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentViewController"];
//    [self.navigationController pushViewController:assement animated:YES];
}

#pragma mark -Button Menu Tapped
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

@end
