//
//  QuizCreationViewController.m
//  SMILES
//
//  Created by Biipmi on 12/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "QuizCreationViewController.h"
#import "UIActionSheet+Blocks.h"
#import "ActionSheetPicker.h"
#import "Utility.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SZTextView.h"
#import "SCLAlertView.h"


@interface QuizCreationViewController (){
    __weak IBOutlet UIView *questionView;
    //__weak IBOutlet UITextView *txtQuestionName;
    __weak IBOutlet UIView *optionsView;
//    __weak IBOutlet UITextView *txtOptionOne;
//    __weak IBOutlet UITextView *txtOptionTwo;
//    __weak IBOutlet UITextView *txtOptionThree;
//    __weak IBOutlet UITextView *txtOptionFour;
    __weak IBOutlet UIButton *btnSubmitQuiz;
    __weak IBOutlet UILabel *lblArticleName;
    __weak IBOutlet UIButton *btnSelectAnswer;
    __weak IBOutlet UITextField *txtSelectAnswer;
    
    __weak IBOutlet SZTextView *txtOptionOne;
    __weak IBOutlet SZTextView *txtQuestionName;
    __weak IBOutlet SZTextView *txtOptionTwo;
    __weak IBOutlet SZTextView *txtOptionThree;
    __weak IBOutlet SZTextView *txtOptionFour;
    
    __weak IBOutlet UILabel *lblQuestion;
    
    __weak IBOutlet UILabel *lblAnswer1;
    
    __weak IBOutlet UILabel *lblAnswer2;
    
    __weak IBOutlet UILabel *lblAnswer3;
    __weak IBOutlet UILabel *lblAnswer4;
    __weak IBOutlet UILabel *lblSelectAnswer;
    NSMutableArray *arrOptions;
}
@property (nonatomic,assign) NSInteger selectedOption;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation QuizCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblAnswer1.text=[Language AnswerOption1];
    lblAnswer2.text=[Language AnswerOption2];
    lblAnswer3.text=[Language AnswerOption3];
    lblAnswer4.text=[Language AnswerOption4];
    lblQuestion.text=[Language Question];
    lblSelectAnswer.text=[Language SelectAnswer];
    txtSelectAnswer.placeholder=[Language SelectAnswer];
    [btnSubmitQuiz setTitle:[Language Submit] forState:UIControlStateNormal];
    txtOptionOne.placeholder=[Language EnterTheOptionAnswer1];
    txtOptionTwo.placeholder=[Language EnterTheOptionAnswer2];
    txtOptionThree.placeholder=[Language EnterTheOptionAnswer3];
    txtOptionFour.placeholder=[Language EnterTheOptionAnswer4];
    txtQuestionName.placeholder=[Language EnterQuestionName];
    
    
    
    [self configureNavigation];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    lblArticleName.text=self.articleName;
    questionView.layer.cornerRadius=5.0;
    optionsView.layer.cornerRadius=5.0;
    [[txtQuestionName layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[txtQuestionName layer] setBorderWidth:1];
    [[txtQuestionName layer] setCornerRadius:10];
    [[txtOptionOne layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[txtOptionOne layer] setBorderWidth:1];
    [[txtOptionOne layer] setCornerRadius:10];
    [[txtOptionTwo layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[txtOptionTwo layer] setBorderWidth:1];
    [[txtOptionTwo layer] setCornerRadius:10];
    [[txtOptionThree layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[txtOptionThree layer] setBorderWidth:1];
    [[txtOptionThree layer] setCornerRadius:10];
    [[txtOptionFour layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[txtOptionFour layer] setBorderWidth:1];
    [[txtOptionFour layer] setCornerRadius:10];
    [[btnSelectAnswer layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[btnSelectAnswer layer] setBorderWidth:1];
    [[btnSelectAnswer layer] setCornerRadius:10];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language2=[defaults valueForKey:@"language"];
    if ([language2 isEqualToString:@"2"]) {
        arrOptions=[[NSMutableArray alloc]initWithObjects:@"Option(၁)", @"Option(၂)",@"Option(၃)",@"Option(၄)",nil];
    }
    else if ([language2 isEqualToString:@"3"]){
        arrOptions=[[NSMutableArray alloc]initWithObjects:@"Option1", @"Option2",@"Option3",@"Option4",nil];
    }
    else{
        arrOptions=[[NSMutableArray alloc]initWithObjects:@"Option1", @"Option2",@"Option3",@"Option4",nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Navigation

-(void)configureNavigation{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:20]}];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        self.title=[Language CreateQuiz];
        
    }
    else if ([language1 isEqualToString:@"3"]){
        //self.title=@"ပဟေဠိ Create";
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"ပဟေဠိ Create";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:20]];
        [view addSubview:label];
        self.navigationItem.titleView = view;
    }
    else{
        self.title=@"Create Quiz";
    }
    //self.title=@"Create Quiz";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"crossMark"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];}

#pragma mark-Back Button Pressed
-(void)backBtnTapped:(id)sender
{
    NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    navigationController.viewControllers=@[home];
    [self.frostedViewController hideMenuViewController];
    self.frostedViewController.contentViewController = navigationController;
}

#pragma mark- Button Answer Tapped
- (IBAction)btnSelectAnswerTapped:(id)sender {
    [self.view endEditing:YES];
    _selectedOption=0;
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectOption]
                                            rows:arrOptions
                                initialSelection:_selectedOption
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _selectedOption = selectedIndex;
                                           txtSelectAnswer.text=selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

#pragma mark - Button Quiz Tapped
- (IBAction)btnQuizSubmitTapped:(id)sender {
    [self.view endEditing:YES];
    if ([txtQuestionName.text isEqualToString:@""]&&[txtOptionOne.text isEqualToString:@""]&&[txtOptionTwo.text isEqualToString:@""]&&[txtOptionThree.text isEqualToString:@""]&&[txtOptionFour.text isEqualToString:@""]&&[txtSelectAnswer.text isEqualToString:@""]){
      //  [Utility showAlert:AppName withMessage:[Language PleaseEnterAllTheFields]];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
       
        [alert showSuccess:AppName subTitle:[Language PleaseEnterAllTheFields] closeButtonTitle:[Language ok] duration:0.0f];

        return;
    }
    if ([txtQuestionName.text isEqualToString:@""]){
       // [Utility showAlert:AppName withMessage:[Language PleaseEnterQuestion]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language PleaseEnterQuestion] closeButtonTitle:[Language ok] duration:0.0f];

        
        [txtQuestionName resignFirstResponder];
        return;
    }
    if ([txtOptionOne.text isEqualToString:@""]){
       // [Utility showAlert:AppName withMessage:[Language EnterTheOptionAnswer1]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language EnterTheOptionAnswer1] closeButtonTitle:[Language ok] duration:0.0f];

        [txtOptionOne resignFirstResponder];
        return;
    }
    if ([txtOptionTwo.text isEqualToString:@""]){
       // [Utility showAlert:AppName withMessage:[Language EnterTheOptionAnswer2]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language EnterTheOptionAnswer2] closeButtonTitle:[Language ok] duration:0.0f];
        [txtOptionTwo resignFirstResponder];
        return;
    }
    if ([txtOptionThree.text isEqualToString:@""]){
        //[Utility showAlert:AppName withMessage:[Language EnterTheOptionAnswer3]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language EnterTheOptionAnswer3] closeButtonTitle:[Language ok] duration:0.0f];
        [txtOptionThree resignFirstResponder];
        return;
    }
    if ([txtOptionFour.text isEqualToString:@""]){
       // [Utility showAlert:AppName withMessage:[Language EnterTheOptionAnswer4]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language EnterTheOptionAnswer4] closeButtonTitle:[Language ok] duration:0.0f];
        [txtOptionFour resignFirstResponder];
        return;
    }
    if ([txtSelectAnswer.text isEqualToString:@""]) {
       // [Utility showAlert:AppName withMessage:[Language SelectOption]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language SelectOption] closeButtonTitle:[Language ok] duration:0.0f];
        return;
    }
    else{
        //[Utility showLoading:self];
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        [[APIManager sharedInstance]createQuizFortheArticleWithArticleId:self.articleId andWithQuestionName:txtQuestionName.text andWithOption1:txtOptionOne.text andWithOption2:txtOptionTwo.text andWithOption3:txtOptionThree.text andWithOption4:txtOptionFour.text andWithAnswer:txtSelectAnswer.text andCompleteBlock:^(BOOL success, id result) {
            [Utility hideLoading:self];
            if (!success) {
                // [Utility showAlert:AppName withMessage:result];
                [self.loadingView stopAnimation];
                [self.loadingView setHidden:YES];
                [self.img setHidden:YES];
                return ;
            }
            NSString *messege=[result valueForKey:@"message"];
            RIButtonItem *okItem = [RIButtonItem itemWithLabel:[Language ok] action:^{
                NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
                HomeViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                navigationController.viewControllers=@[home];
                [self.frostedViewController hideMenuViewController];
                self.frostedViewController.contentViewController = navigationController;
            }];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:AppName
                                                               message:messege cancelButtonItem:nil otherButtonItems:okItem, nil];
            [alertView show];
        }];
    }
}

@end
