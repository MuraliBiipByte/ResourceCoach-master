//
//  AssessmentViewController.m
//  SMILES
//
//  Created by Biipmi on 10/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "AssessmentViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "REFrostedViewController.h"
#import "SequenceTableViewCell.h"
#import "AssessmentListViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "ResultViewController.h"
#import "ResultViewController.h"
#import "CourseDetailViewController.h"
#import "MiniCertificateViewController.h"
#import "HomeViewController.h"

@interface AssessmentViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *userId,*userDeptId;
    __weak IBOutlet UITableView *assessmentTableviewList;
    __weak IBOutlet UILabel *lblPercentages;
    NSMutableArray *arrAssessmentQuestions;
    NSMutableArray *arrActualAnswers,*arrMarks;
    NSMutableArray *arrcorrectAnswers,*arrSates;
    NSString *strAnswer,*submitAssessment;
    __weak IBOutlet UIButton *btnSubmitAssessment;
    SequenceTableViewCell *assesmentCell;
    BOOL selectState;
    __weak IBOutlet UIView *resultview;
    __weak IBOutlet UIButton *resultbutton;
    __weak IBOutlet UILabel *lblMarks;
    __weak IBOutlet UILabel *lblTotalMarks;
    __weak IBOutlet UILabel *lblPercentage;
    __weak IBOutlet UIView *assementResultView;
    __weak IBOutlet UIButton *btnViewScore;
    __weak IBOutlet UILabel *lblScore;
    __weak IBOutlet UILabel *lblAssesmentResult;
    __weak IBOutlet UILabel *lblQuizFailMessage;
    NSMutableArray *arrQuestionsId;
    __weak IBOutlet UIButton *btnRedeem;

 NSString *uID,*UserType;
    float percentage;
      NSString *strPaasStatus;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation AssessmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationConfiguration];
    [btnSubmitAssessment setTitle:[Language submitAssesment] forState:UIControlStateNormal];
    lblAssesmentResult.text=[Language AssesmentResult];
    lblScore.text=[Language Score];
    lblPercentages.text=[Language Percentage];
    [btnViewScore setTitle:[Language ViewAssScore] forState:UIControlStateNormal];
    [self navigationConfiguration];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    assessmentTableviewList.estimatedRowHeight = 20;
    assessmentTableviewList.rowHeight = UITableViewAutomaticDimension;
    [assessmentTableviewList setNeedsLayout];
    [assessmentTableviewList layoutIfNeeded];
    assessmentTableviewList.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    assessmentTableviewList.hidden=YES;
    assessmentTableviewList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    selectState=NO;
    [resultview setHidden:YES];
    btnSubmitAssessment.hidden=NO;
    arrMarks=[[NSMutableArray alloc]init];
    assementResultView.layer.cornerRadius=4.0;
    [btnViewScore setHidden:YES];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    userDeptId=[userDefaults objectForKey:@"deptid"];
    arrActualAnswers=[[NSMutableArray alloc] init];
    arrQuestionsId=[[NSMutableArray alloc]init];
    [self getAllAssessment];
    btnRedeem.hidden=YES;
    lblQuizFailMessage.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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


#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
  
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Roboto-Regular" size:14],NSFontAttributeName,nil]];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
       // self.title=@"အကဲဖြတ်";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကဲဖြတ်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else if ([language1 isEqualToString:@"3"]){
        //self.title=@"အကဲဖြတ်";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အကဲဖြတ်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else
    {
        self.title=@"Assessments";
    }
    //self.title=@"Assessment";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -Get All Assessment
-(void)getAllAssessment{
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAssementDetailsWithArticleId:self.articleId andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
                       [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

            
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        arrAssessmentQuestions = [data valueForKey:@"quiz_data"];
        arrActualAnswers=[arrAssessmentQuestions valueForKey:@"answer"];
        arrcorrectAnswers=[[NSMutableArray alloc]init];
        [self arrangeArraywithCount:arrAssessmentQuestions.count];
        arrSates=[[NSMutableArray alloc] init];
        [self arrangeState:arrAssessmentQuestions.count];
        [assessmentTableviewList setHidden:NO];
        [assessmentTableviewList reloadData];
    }];
    //      [Utility showLoading:self];
    //    [[APIManager sharedInstance]getAllAssessmentsWithUserId:userId andWithDepartmentId:userDeptId andCompleteBlock:^(BOOL success, id result) {
    //        [Utility hideLoading:self];
    //        if (!success) {
    //            [Utility showAlert:AppName withMessage:result];
    //            return ;
    //        }
    //        NSDictionary *data = [result objectForKey:@"data"];
    //        arrAssessmentQuestions = [data valueForKey:@"quiz_data"];
    //        arrActualAnswers=[arrAssessmentQuestions valueForKey:@"answer"];
    //        arrcorrectAnswers=[[NSMutableArray alloc]init];
    //        [self arrangeArraywithCount:arrAssessmentQuestions.count];
    //        arrSates=[[NSMutableArray alloc] init];
    //        [self arrangeState:arrAssessmentQuestions.count];
    //        [assessmentTableviewList setHidden:NO];
    //        [assessmentTableviewList reloadData];
    //    }];
}

-(void)arrangeArraywithCount:(NSInteger)count
{
    for (int j = 0; j<count; j++)
    {
        [arrcorrectAnswers addObject:@""];
    }
}
-(void)arrangeState:(NSInteger)count
{
    for (int j = 0; j<count; j++)
    {
        [arrSates addObject:@"no"];
    }
}

#pragma mark -UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrAssessmentQuestions count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    assesmentCell=[[SequenceTableViewCell alloc]init];
    NSString *assesmentCellIdentifier=@"SequenceTableViewCell";
    assesmentCell= [tableView dequeueReusableCellWithIdentifier:assesmentCellIdentifier];
    assesmentCell.corectImg.hidden=YES;
    assesmentCell.lblAnswer.hidden=YES;
    assesmentCell.answerText.hidden=YES;
    assesmentCell.answerText.text=[Language Answer];
    if (assesmentCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceTableViewCell" owner:self options:nil];
        assesmentCell = [nib objectAtIndex:0];
    }
    [assesmentCell.btnOption1 setHidden:NO];
    [assesmentCell.btnOption2 setHidden:NO];
    [assesmentCell.btnOption3 setHidden:NO];
    [assesmentCell.btnOption4 setHidden:NO];
    
    if ([submitAssessment isEqualToString:@"submit"])
    {
        NSDictionary *assessmentDictionary = [arrAssessmentQuestions objectAtIndex:indexPath.row];
        assesmentCell.lblQuestionName.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"question"]];
        assesmentCell.lblOption1.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option1"]];
        assesmentCell.lblOption2.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option2"]];
        assesmentCell.lblOption3.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option3"]];
        assesmentCell.lblOption4.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option4"]];
        assesmentCell.lblQuestionNumber.text=[NSString stringWithFormat:@"Q.%@",[assessmentDictionary valueForKey:@"question_no"]];
       assesmentCell.lblAnswer.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"answer"]];
        NSString *answer=[assessmentDictionary valueForKey:@"answer"];
        NSString *selectAnswer=[arrcorrectAnswers objectAtIndex:indexPath.row];
        if ([selectAnswer isEqualToString:@""])
        {
            assesmentCell.corectImg.hidden=YES;
            assesmentCell.lblAnswer.hidden=NO;
            assesmentCell.answerText.hidden=NO;
        }
        else if ([selectAnswer isEqualToString:answer])
        {
            //[arrMarks addObject:answer];
            assesmentCell.corectImg.hidden=NO;
            assesmentCell.corectImg.image=[UIImage imageNamed:@"correctans"];
            assesmentCell.lblAnswer.hidden=YES;
            assesmentCell.answerText.hidden=YES;
        }
        else if (![selectAnswer isEqualToString:answer])
        {
            assesmentCell.corectImg.hidden=NO;
            assesmentCell.corectImg.image=[UIImage imageNamed:@"wrongans"];
            assesmentCell.lblAnswer.hidden=NO;
            assesmentCell.answerText.hidden=NO;
        }
        NSString *strState=[arrSates objectAtIndex:indexPath.row];
        if ([strState isEqualToString:@"no"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"1"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"2"]){
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"3"]){
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"4"]){
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
        }
        [assesmentCell.btnOption1 setEnabled:NO];
        [assesmentCell.btnOption2 setEnabled:NO];
        [assesmentCell.btnOption3 setEnabled:NO];
        [assesmentCell.btnOption4 setEnabled:NO];
        
       
        //        NSInteger marks=[arrMarks count];
        //        NSInteger totalMarks=[arrAssessmentQuestions count];
        //        lblMarks.text=[NSString stringWithFormat:@"%ld",(long)marks];
        //        lblTotalMarks.text=[NSString stringWithFormat:@"%ld",(long)totalMarks];
        //        NSString *per=@"%";
        //        if(marks==0) {
        //            lblPercentage.text=@"0%";
        //        }
        //        else{
        //        float percentage=(marks*100)/totalMarks;
        //        lblPercentage.text=[NSString stringWithFormat:@"%.2ld%@",(long)percentage,per];
        //        }
    }
    else
    {
        
        NSDictionary *assessmentDictionary = [arrAssessmentQuestions objectAtIndex:indexPath.row];
//        [arrQuestionsId addObject:[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"id"]]];
        
        assesmentCell.lblQuestionName.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"question"]];
        assesmentCell.lblOption1.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option1"]];
        assesmentCell.lblOption2.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option2"]];
        assesmentCell.lblOption3.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option3"]];
        assesmentCell.lblOption4.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option4"]];
        assesmentCell.lblQuestionNumber.text=[NSString stringWithFormat:@"Q.%@",[assessmentDictionary valueForKey:@"question_no"]];
       // assesmentCell.lblAnswer.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"answer"]];
        assesmentCell.btnOption1.tag = indexPath.row;
        assesmentCell.btnOption2.tag = indexPath.row;
        assesmentCell.btnOption3.tag = indexPath.row;
        assesmentCell.btnOption4.tag = indexPath.row;
        [assesmentCell.btnOption1 addTarget:self action:@selector(optionOnePressed:) forControlEvents:UIControlEventTouchUpInside];
        [assesmentCell.btnOption2 addTarget:self action:@selector(optionTwoPressed:) forControlEvents:UIControlEventTouchUpInside];
        [assesmentCell.btnOption3 addTarget:self action:@selector(optionThreePressed:) forControlEvents:UIControlEventTouchUpInside];
        [assesmentCell.btnOption4 addTarget:self action:@selector(optionFourPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *strState=[arrSates objectAtIndex:indexPath.row];
        if ([strState isEqualToString:@"no"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"1"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"2"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"3"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        }
        else if ([strState isEqualToString:@"4"])
        {
            [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
            [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
        }
        
    
    }
    
     assesmentCell.lblAnswer.hidden=YES;
    assesmentCell.layer.cornerRadius=4.0f;
    assesmentCell.layer.masksToBounds=YES;
    [assesmentCell.contentView setNeedsLayout];
    [assesmentCell.contentView layoutIfNeeded];
    
    return assesmentCell;
}

-(void)optionOnePressed:(id)sender1
{
    assesmentCell = (SequenceTableViewCell*)[[sender1 superview] superview];
    NSIndexPath *indexPathCell = [assessmentTableviewList indexPathForCell:assesmentCell];
    NSDictionary *dict = [arrAssessmentQuestions objectAtIndex:indexPathCell.row];
    NSString *option1=[dict valueForKey:@"option1"];
    NSLog(@"Selected Tag %ld",(long)[sender1 tag]);
    int selectedVal = (int)[sender1 tag];
    int unitDigit = selectedVal;
    NSLog(@" The Val is %d",unitDigit);
    [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [arrcorrectAnswers replaceObjectAtIndex:unitDigit withObject:option1];
    NSLog(@"The val %@",arrcorrectAnswers);
    [arrSates replaceObjectAtIndex:unitDigit withObject:@"1"];
    NSLog(@"The val %@",arrcorrectAnswers);
   // btnSubmitAssessment.hidden=NO;
}

-(void)optionTwoPressed:(id)sender2{
    assesmentCell = (SequenceTableViewCell*)[[sender2 superview] superview];
    NSIndexPath *indexPathCell = [assessmentTableviewList indexPathForCell:assesmentCell];
    NSDictionary *dict = [arrAssessmentQuestions objectAtIndex:indexPathCell.row];
    NSString *option2=[dict valueForKey:@"option2"];
    strAnswer=[dict valueForKey:@"answer"];
    NSLog(@"Selected Tag %ld",(long)[sender2 tag]);
    int selectedVal = (int)[sender2 tag];
    int unitDigit = selectedVal;
    NSLog(@" The Val is %d",unitDigit);
    [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [arrcorrectAnswers replaceObjectAtIndex:unitDigit withObject:option2];
    NSLog(@"The val %@",arrcorrectAnswers);
    [arrSates replaceObjectAtIndex:unitDigit withObject:@"2"];
    //btnSubmitAssessment.hidden=NO;
}

-(void)optionThreePressed:(id)sender3
{
    assesmentCell = (SequenceTableViewCell*)[[sender3 superview] superview];
    NSIndexPath *indexPathCell = [assessmentTableviewList indexPathForCell:assesmentCell];
    NSDictionary *dict = [arrAssessmentQuestions objectAtIndex:indexPathCell.row];
    NSString *option3=[dict valueForKey:@"option3"];
    strAnswer=[dict valueForKey:@"answer"];
    NSLog(@"Selected Tag %ld",(long)[sender3 tag]);
    int selectedVal = (int)[sender3 tag];
    int unitDigit = selectedVal;
    NSLog(@" The Val is %d",unitDigit);
    [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [arrcorrectAnswers replaceObjectAtIndex:unitDigit withObject:option3];
    NSLog(@"The val %@",arrcorrectAnswers);
    [arrSates replaceObjectAtIndex:unitDigit withObject:@"3"];
    
   /// btnSubmitAssessment.hidden=NO;
}

-(void)optionFourPressed:(id)sender4
{
    assesmentCell = (SequenceTableViewCell*)[[sender4 superview] superview];
    NSIndexPath *indexPathCell = [assessmentTableviewList indexPathForCell:assesmentCell];
    NSDictionary *dict = [arrAssessmentQuestions objectAtIndex:indexPathCell.row];
    NSString *option4=[dict valueForKey:@"option4"];
    strAnswer=[dict valueForKey:@"answer"];
    NSLog(@"Selected Tag %ld",(long)[sender4 tag]);
    int selectedVal = (int)[sender4 tag];
    int unitDigit = selectedVal;
    NSLog(@" The Val is %d",unitDigit);
    [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
    [arrcorrectAnswers replaceObjectAtIndex:unitDigit withObject:option4];
    NSLog(@"The val %@",arrcorrectAnswers);
    [arrSates replaceObjectAtIndex:unitDigit withObject:@"4"];
   // btnSubmitAssessment.hidden=NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark -Button Menu Tapped
- (IBAction)btnMenuTapped:(id)sender
{
    [self.view endEditing:YES];
    AssessmentListViewController*ass=[self.storyboard  instantiateViewControllerWithIdentifier:@"AssessmentListViewController"];
    [self.navigationController pushViewController:ass animated:YES];
}

#pragma mark -Button Assessment Submit Tapped
- (IBAction)btnSubmitAssessmentTapped:(id)sender
{
    NSMutableArray *arrAlerts=[[NSMutableArray alloc]init];
    [arrAlerts removeAllObjects];
    [arrQuestionsId removeAllObjects];
    for (int k=0; k<[arrAssessmentQuestions count]; k++)
    {
        NSDictionary *dictr=[arrAssessmentQuestions objectAtIndex:k];
        [arrQuestionsId addObject:[dictr valueForKey:@"id"]];
    }
    
    for (int j=0; j<[arrcorrectAnswers count]; j++)
    {
        NSString *strUserSelectedAnser=[arrcorrectAnswers objectAtIndex:j];
        if ([strUserSelectedAnser isEqualToString:@""])
        {
            NSLog(@"Empty");
        }
        else
        {
            [arrAlerts addObject:strUserSelectedAnser];
        }
    }
    
    NSLog(@"arrAlerts Count is %lu",(unsigned long)arrAlerts.count);
    
    if (arrAlerts.count==arrQuestionsId.count)
    {
     
    submitAssessment=@"submit";
    [assessmentTableviewList reloadData];
    NSInteger i=[arrcorrectAnswers count];
    for (i=0; i<[arrcorrectAnswers count]; i++)
    {
        NSString *strActualAnswer=[arrActualAnswers objectAtIndex:i];
        NSString *strSelectAnswer=[arrcorrectAnswers objectAtIndex:i];
        if ([strActualAnswer isEqualToString:strSelectAnswer])
        {
            [arrMarks addObject:strSelectAnswer];
        }
    }
    NSInteger marks=[arrMarks count];
    NSInteger totalMarks=[arrAssessmentQuestions count];
    lblMarks.text=[NSString stringWithFormat:@"%ld",(long)marks];
    lblTotalMarks.text=[NSString stringWithFormat:@"%ld",(long)totalMarks];
    NSString *per=@"%";
    if(marks==0)
    {
        lblPercentage.text=@"0%";
        strPaasStatus=@"fail";
        btnRedeem.hidden=YES;
        lblQuizFailMessage.hidden=NO;
        lblQuizFailMessage.textColor=[UIColor redColor];
    }
    else
    {
        percentage=(marks*100.0f)/totalMarks;
        NSString *strVal=[NSString stringWithFormat:@"%.1f",percentage];
        NSArray *array=[strVal componentsSeparatedByString:@"."];
        NSString *decimal=[array objectAtIndex:1];
        if ([decimal isEqualToString:@"0"])
        {
            lblPercentage.text=[NSString stringWithFormat:@"%.f%@",percentage,per];
        }
        else
        {
            lblPercentage.text=[NSString stringWithFormat:@"%.1f%@",percentage,per];
        }
      
       
        if (percentage>=80)
        {
            strPaasStatus=@"pass";
            btnRedeem.hidden=NO;
            lblQuizFailMessage.hidden=YES;

        }
        else
        {
            strPaasStatus=@"fail";
            btnRedeem.hidden=YES;
            lblQuizFailMessage.hidden=NO;
            lblQuizFailMessage.textColor=[UIColor redColor];
        }
           }
        NSString *percentageScore=[NSString stringWithFormat:@"%.1f",percentage];
        [[APIManager sharedInstance]saveQuizWithUserId:userId withassementId:self.articleId withQuestionsId:arrQuestionsId withAnswers:arrcorrectAnswers withResult:strPaasStatus andwithScore:percentageScore andCompleteBlock:^(BOOL success, id result)
         {
             if (!success)
             {
                 return ;
             }
             NSDictionary *data = [result valueForKey:@"data"];
             NSMutableArray *arrMiniCert = [data valueForKey:@"mini_certification"];
             NSMutableDictionary *dictValue =[arrMiniCert objectAtIndex:0];
             strPaasStatus = [NSString stringWithFormat:@"%@",[dictValue valueForKey:@"result_status"]];
             
             NSString *atCount = [NSString stringWithFormat:@"%@",[dictValue valueForKey:@"attempt_count"]];
             NSString *similarAssesmentId = [NSString stringWithFormat:@"%@",[dictValue valueForKey:@"similar_assesment_id"]];
             NSInteger similarCount = [[dictValue valueForKey:@"similar_assesment_count"]integerValue];
             
             if ([atCount isEqualToString:@"2"] &&[strPaasStatus isEqualToString:@"fail"]&&similarCount>=1)
             {
                 UIAlertController * alert=[UIAlertController alertControllerWithTitle:AppName
                                                                               message:@"This Authore has similar type of assessments Would you like to take the quizzes now?"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action)
                 {
               
                     
                     if (similarCount == 1 )
                     {
                         CourseDetailViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
                         courseDetails.miniCertificateId= similarAssesmentId;
                         [self.navigationController pushViewController:courseDetails animated:YES];
                     }
                     else if (similarCount >1)
                     {
                         MiniCertificateViewController *miniCer=[self.storyboard instantiateViewControllerWithIdentifier:@"MiniCertificateViewController"];
                       
                         [self.navigationController pushViewController:miniCer animated:YES];
                         
                     }
                     
                 }];
                 
                 UIAlertAction* Remind= [UIAlertAction actionWithTitle:@"REMAINED ME LATER"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action)
                 {
                     [Utility showLoading:self];
                     [[APIManager sharedInstance]remainedMeLaterWithUserId:uID andWithAssessmentId:self.articleId andWithAuthorId:_strAuthoreId andCompleteBlock:^(BOOL success, id result)
                     {
                         [Utility hideLoading:self];
                         if (!success)
                         {
                             return ;
                         }
                         else
                         {
//                             HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//                             [self.navigationController  pushViewController:home animated:YES];
                         }
                     }];
                  
                 }];
                 UIAlertAction* skip= [UIAlertAction actionWithTitle:@"SKIP"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action)
                                         {
                                             /** What we write here???????? **/
                                             NSLog(@"you pressed No, thanks button");
                                             // call method whatever u need
                                         }];
                 
                 [alert addAction:ok];
                 [alert addAction:Remind];
                [alert addAction:skip];
                 
                 [self presentViewController:alert animated:YES completion:nil];
             }
           else  if ([atCount isEqualToString:@"2"] &&[strPaasStatus isEqualToString:@"fail"]&&similarCount==0)
             {
                 UIAlertController * alert=[UIAlertController alertControllerWithTitle:AppName
                                                                               message:@"Would you like us to remind you for Newly added Mini-Certification"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action)
                                      {
                                          
                                          
                                          if (similarCount == 1 )
                                          {
                                              CourseDetailViewController *courseDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"CourseDetailsViewController"];
                                              courseDetails.miniCertificateId= similarAssesmentId;
                                              [self.navigationController pushViewController:courseDetails animated:YES];
                                          }
                                          else if (similarCount >1)
                                          {
                                              MiniCertificateViewController *miniCer=[self.storyboard instantiateViewControllerWithIdentifier:@"MiniCertificateViewController"];
                                              
                                              [self.navigationController pushViewController:miniCer animated:YES];
                                              
                                          }
                                          
                                      }];
                 
                 UIAlertAction* Remind= [UIAlertAction actionWithTitle:@"REMAINED ME LATER"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action)
                                         {
                                             [Utility showLoading:self];
                                             [[APIManager sharedInstance]remainedMeLaterWithUserId:uID andWithAssessmentId:self.articleId andWithAuthorId:_strAuthoreId andCompleteBlock:^(BOOL success, id result) {
                                                 [Utility hideLoading:self];
                                                 if (!success) {
                                                     return ;
                                                 }
                                                 else{
//                                                     HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//                                                     [self.navigationController  pushViewController:home animated:YES];
                                                 }
                                             }];
                                             
                                         }];
                 UIAlertAction* skip= [UIAlertAction actionWithTitle:@"SKIP"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action)
                                       {
                                           /** What we write here???????? **/
                                           NSLog(@"you pressed No, thanks button");
                                           // call method whatever u need
                                       }];
                 
               //  [alert addAction:ok];
                 [alert addAction:Remind];
                 [alert addAction:skip];
                 
                 [self presentViewController:alert animated:YES completion:nil];
             }
             
             NSLog(@"%@%@",result,self.strAttemptcount);
         }];
        

    [resultview setHidden:NO];
    }
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:@"Please Attempt all the Questions"  closeButtonTitle:@"OK" duration:0.0f];        
     }
    
}

#pragma mark -Button Assessment Result Tapped
- (IBAction)btnResultTapped:(id)sender
{
    [resultview setHidden:YES];
    [btnSubmitAssessment setHidden:YES];
    [btnViewScore setHidden:NO];
    [arrMarks removeAllObjects];
}

#pragma mark -Button Assessment Score View Tapped
- (IBAction)btnViewScoreTapped:(id)sender
{
    [btnViewScore setHidden:NO];
    [resultview setHidden:NO];
}
- (IBAction)btnRedeemTapped:(id)sender
{
    ResultViewController *result=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
       result.strPercentage=lblPercentage.text;
    result.strMiniCertification=self.articleId;
    [self.navigationController pushViewController:result animated:YES];
    
}
@end
