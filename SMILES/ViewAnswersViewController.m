//
//  ViewAnswersViewController.m
//  DedaaBox
//
//  Created by Biipmi on 15/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "ViewAnswersViewController.h"
#import "ViewAnswerTableViewCell.h"
#import "HYCircleLoadingView.h"
#import "APIManager.h"
#import "SCLAlertView.h"
#import "Language.h"
#import "Utility.h"
#import "ResultViewController.h"
@interface ViewAnswersViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrAssessmentQuestions;
    NSMutableArray *arrActualAnswers,*arrMarks;
    NSMutableArray *arrcorrectAnswers,*arrSates;
     __weak IBOutlet UITableView *assessmentTableviewList;
     ViewAnswerTableViewCell *assesmentCell;
    NSString *strAnswer,*submitAssessment;
    NSString *userDeptId;
    NSMutableArray *arrQuestionsId;
    NSMutableArray *option1Arry;

    __weak IBOutlet UILabel *lblPercentages;
    __weak IBOutlet UIButton *btnSubmitAssessment;
   
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
    __weak IBOutlet UIButton *btnRedeem;
    
    NSString *uID,*UserType;
    float percentage;
    NSString *strPaasStatus;
    
    
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation ViewAnswersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ViewAnswerService];
    [self navigationConfiguration];
    resultview.hidden= YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    else{
        self.title=@"View Answers";
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

-(void)ViewAnswerService{
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]viewAnswerwithUserId:self.userId andWithMinCerID:self.articleId andCompleteBlock:^(BOOL success, id result) {
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
       // NSDictionary *data = [result objectForKey:@"data"];
        arrAssessmentQuestions = [result valueForKey:@"quiz_data"];
        arrActualAnswers=[arrAssessmentQuestions valueForKey:@"answer"];
        arrcorrectAnswers=[[NSMutableArray alloc]init];
        [self arrangeArraywithCount:arrAssessmentQuestions.count];
        arrSates=[[NSMutableArray alloc] init];
        [self arrangeState:arrAssessmentQuestions.count];
        [assessmentTableviewList setHidden:NO];
        [assessmentTableviewList reloadData];
    }];
//    [[APIManager sharedInstance]getAssementDetailsWithArticleId:self.articleId andCompleteBlock:^(BOOL success, id result) {
//        // [Utility hideLoading:self];
//        [self.loadingView stopAnimation];
//        [self.loadingView setHidden:YES];
//        [self.img setHidden:YES];
//        if (!success) {
//            //[Utility showAlert:AppName withMessage:result];
//            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//            [alert setHorizontalButtons:YES];
//            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
//            
//            
//            return ;
//        }
    
   // }];
//        [Utility showLoading:self];
//        [[APIManager sharedInstance]getAllAssessmentsWithUserId:userId andWithDepartmentId:userDeptId andCompleteBlock:^(BOOL success, id result) {
//            [Utility hideLoading:self];
//            if (!success) {
//                [Utility showAlert:AppName withMessage:result];
//                return ;
//            }
//            NSDictionary *data = [result objectForKey:@"data"];
//            arrAssessmentQuestions = [data valueForKey:@"quiz_data"];
//            arrActualAnswers=[arrAssessmentQuestions valueForKey:@"answer"];
//            arrcorrectAnswers=[[NSMutableArray alloc]init];
//            [self arrangeArraywithCount:arrAssessmentQuestions.count];
//            arrSates=[[NSMutableArray alloc] init];
//            [self arrangeState:arrAssessmentQuestions.count];
//            [assessmentTableviewList setHidden:NO];
//            [assessmentTableviewList reloadData];
//        }];
}
-(void)arrangeArraywithCount:(NSInteger)count{
    for (int j = 0; j<count; j++) {
        [arrcorrectAnswers addObject:@""];
    }
}
-(void)arrangeState:(NSInteger)count{
    for (int j = 0; j<count; j++) {
        [arrSates addObject:@"no"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrAssessmentQuestions count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    assesmentCell= (ViewAnswerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ViewAnswerTableViewCell"];
    assesmentCell.corectImg.hidden=YES;
    assesmentCell.lblAnswer.hidden=YES;
    assesmentCell.answerText.hidden=YES;
    assesmentCell.answerText.text=[Language Answer];
    if (assesmentCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewAnswerTableViewCell" owner:self options:nil];
        assesmentCell = [nib objectAtIndex:0];
    }
   
        NSDictionary *assessmentDictionary = [arrAssessmentQuestions objectAtIndex:indexPath.row];
        
        assesmentCell.lblQuestionName.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"question"]];
        assesmentCell.lblOption1.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option1"]];
        assesmentCell.lblOption2.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option2"]];
        assesmentCell.lblOption3.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option3"]];
        assesmentCell.lblOption4.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"option4"]];
        assesmentCell.lblQuestionNumber.text=[NSString stringWithFormat:@"Q.%@",[assessmentDictionary valueForKey:@"question_no"]];
        assesmentCell.lblAnswer.text=[NSString stringWithFormat:@"%@",[assessmentDictionary valueForKey:@"answer"]];
    
        NSString *answer=[assessmentDictionary valueForKey:@"answer"];
    NSString *userAnswer=[assessmentDictionary valueForKey:@"user_answer"];
    if ([userAnswer isEqual:[NSNull null]])
    {
        return assesmentCell;
    }else
    {
     if ([[assessmentDictionary valueForKey:@"option1"] isEqualToString:userAnswer]) {
        [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    }else if ([[assessmentDictionary valueForKey:@"option2"] isEqualToString:userAnswer])
    {
         [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
       
        [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    }else if ([[assessmentDictionary valueForKey:@"option3"] isEqualToString:userAnswer])
    {
        
        [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        
       [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
    }else if ([[assessmentDictionary valueForKey:@"option4"] isEqualToString:userAnswer])
    {
       
        [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        
        [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioCheck"] forState:UIControlStateNormal];
        
    }else
    {
        [assesmentCell.btnOption1 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption2 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        
        [assesmentCell.btnOption3 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        [assesmentCell.btnOption4 setImage:[UIImage imageNamed:@"radioUncheck"] forState:UIControlStateNormal];
        
    }
    
    if ([userAnswer isEqualToString:@""]) {
            assesmentCell.corectImg.hidden=YES;
            assesmentCell.lblAnswer.hidden=NO;
            assesmentCell.answerText.hidden=NO;
        }
        else if ([userAnswer isEqualToString:answer]){
            [arrMarks addObject:answer];
            assesmentCell.corectImg.hidden=NO;
            assesmentCell.corectImg.image=[UIImage imageNamed:@"correctans"];
            assesmentCell.lblAnswer.hidden=YES;
            assesmentCell.answerText.hidden=YES;
        }
        else if (![userAnswer isEqualToString:answer]){
            assesmentCell.corectImg.hidden=NO;
            assesmentCell.corectImg.image=[UIImage imageNamed:@"wrongans"];
            assesmentCell.lblAnswer.hidden=NO;
            assesmentCell.answerText.hidden=NO;
           

        }
    }
    NSMutableArray *arrAlerts=[[NSMutableArray alloc]init];
    [arrAlerts removeAllObjects];
    [arrQuestionsId removeAllObjects];
    for (int k=0; k<[arrAssessmentQuestions count]; k++) {
        NSDictionary *dictr=[arrAssessmentQuestions objectAtIndex:k];
        [arrQuestionsId addObject:[dictr valueForKey:@"id"]];
    }
    
    for (int j=0; j<[arrcorrectAnswers count]; j++) {
        NSString *strUserSelectedAnser=[arrcorrectAnswers objectAtIndex:j];
        if ([strUserSelectedAnser isEqualToString:@""])
        {
            NSLog(@"Empty");
        }
        else{
            [arrAlerts addObject:strUserSelectedAnser];
        }
    }
    
    NSLog(@"arrAlerts Count is %lu",(unsigned long)arrAlerts.count);
    
    
        
//    arrcorrectAnswers =[[NSMutableArray alloc] initWithObjects:userAnswer, nil];
//        [assessmentTableviewList reloadData];
//        NSInteger i=[arrcorrectAnswers count];
//        for (i=0; i<=[arrcorrectAnswers count]; i++) {
//            NSString *strActualAnswer=[arrActualAnswers objectAtIndex:i];
//            NSString *strSelectAnswer=[arrcorrectAnswers objectAtIndex:i];
//            if ([strActualAnswer isEqualToString:strSelectAnswer]) {
//                [arrMarks addObject:strSelectAnswer];
//            }
//        }
  //  [arrMarks addObject:userAnswer];
    
    if ([userAnswer isEqualToString:answer]) {
        arrMarks=[[NSMutableArray alloc] initWithObjects:answer, nil];
    }
    NSInteger marks=[arrMarks count];
        NSInteger totalMarks=[arrAssessmentQuestions count];
        lblMarks.text=[NSString stringWithFormat:@"%ld",(long)marks];
        lblTotalMarks.text=[NSString stringWithFormat:@"%ld",(long)totalMarks];
        NSString *per=@"%";
        if(marks==0) {
            lblPercentage.text=@"0%";
            strPaasStatus=@"fail";
            btnRedeem.hidden=YES;
            lblQuizFailMessage.hidden=NO;
            lblQuizFailMessage.textColor=[UIColor redColor];
        }
        else{
            percentage=(marks*100.0f)/totalMarks;
            NSString *strVal=[NSString stringWithFormat:@"%.1f",percentage];
            NSArray *array=[strVal componentsSeparatedByString:@"."];
            NSString *decimal=[array objectAtIndex:1];
            if ([decimal isEqualToString:@"0"]) {
                lblPercentage.text=[NSString stringWithFormat:@"%.f%@",percentage,per];
            }else
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
//        [[APIManager sharedInstance]saveQuizWithUserId:userId withassementId:self.articleId withQuestionsId:arrQuestionsId withAnswers:arrcorrectAnswers withResult:strPaasStatus andwithScore:percentageScore andCompleteBlock:^(BOOL success, id result)
//         {
//             if (!success) {
//                 return ;
//             }
//             NSLog(@"%@",result);
//         }];
        
        
        [resultview setHidden:NO];
    


   
            [assesmentCell.btnOption1 setEnabled:NO];
            [assesmentCell.btnOption2 setEnabled:NO];
            [assesmentCell.btnOption3 setEnabled:NO];
            [assesmentCell.btnOption4 setEnabled:NO];


    assesmentCell.layer.cornerRadius=4.0f;
    assesmentCell.layer.masksToBounds=YES;
    
    assessmentTableviewList.estimatedRowHeight = 80;
    assessmentTableviewList.rowHeight = UITableViewAutomaticDimension;
    [assesmentCell.contentView setNeedsLayout];
    [assesmentCell.contentView layoutIfNeeded];
    [resultview setHidden:YES];
    [btnSubmitAssessment setHidden:YES];
    [btnViewScore setHidden:NO];
    return assesmentCell;
   

}
- (IBAction)btnResultTapped:(id)sender
{
    [resultview setHidden:YES];
    [btnSubmitAssessment setHidden:YES];
    [btnViewScore setHidden:NO];
   // [arrMarks removeAllObjects];
}

#pragma mark -Button Assessment Score View Tapped
- (IBAction)btnViewScoreTapped:(id)sender
{
    [btnViewScore setHidden:NO];
    [resultview setHidden:NO];
}
- (IBAction)btnRedeemTapped:(id)sender
{
}



@end
