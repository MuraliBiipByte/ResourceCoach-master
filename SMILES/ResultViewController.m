//
//  ResultViewController.m
//  DedaaBox
//
//  Created by BiipByte on 08/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "ResultViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "BankAccountViewController.h"
#import "SCLAlertView.h"
#import "ActionSheetPicker.h"
#import "Language.h"

@interface ResultViewController ()

@property (nonatomic,assign) NSInteger selectedCountryCode;

@end

@implementation ResultViewController
{
    NSMutableArray *countryWithName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scoreView.layer.cornerRadius=_scoreView.frame.size.height/2;
    _scoreView.layer.masksToBounds=YES;
    _btnDone.layer.cornerRadius=20.0f;
    _btnDone.layer.masksToBounds=YES;
    
    _viewUserDetails.layer.shadowColor = [UIColor grayColor].CGColor;
    _viewUserDetails.layer.shadowOffset = CGSizeZero;
   // _viewUserDetails.layer.masksToBounds = NO;
    _viewUserDetails.layer.shadowRadius = 4.0f;
    _viewUserDetails.layer.shadowOpacity = 1.0;
    
    _btnDone.layer.shadowColor = [UIColor grayColor].CGColor;
    _btnDone.layer.shadowOffset = CGSizeZero;
    _btnDone.layer.masksToBounds = NO;
    _btnDone.layer.shadowRadius = 4.0f;
    _btnDone.layer.shadowOpacity = 1.0;
    
    countryWithName=[[NSMutableArray alloc]init];
    countryWithName = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountryCodeWithName" ofType:@"plist"]];

    _txtCountryCode.text=@"+95";
   
    float sco=[_strPercentage floatValue];

    NSString *per=@"%";
    NSString *strVal=[NSString stringWithFormat:@"%.1f",sco];
    NSArray *array=[strVal componentsSeparatedByString:@"."];
    NSString *decimal=[array objectAtIndex:1];
    if ([decimal isEqualToString:@"0"]) {
        _lblScore.text=[NSString stringWithFormat:@"%.f%@",sco,per];
    }else{
        _lblScore.text=[NSString stringWithFormat:@"%.1f%@",sco,per];
    }
    

    
    _lblScore.layer.cornerRadius=20;
    _lblScore.layer.masksToBounds=YES;
    
//    [_txtName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtEmail setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtmobilenumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtCountryCode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self navigationConfiguration];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    
  self.title=@"Certificate";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnDoneTapped:(id)sender
{
    if ([_txtName.text isEqualToString:@""])
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];

        [alert showSuccess:AppName subTitle:@"Please EnterName" closeButtonTitle:@"OK" duration:0.0f];
      //  [Utility showAlert:AppName withMessage:@"Please EnterName"];
        return;
    }
    else if ([_txtmobilenumber.text isEqualToString:@""])
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:@"Please Enter Mobile Number" closeButtonTitle:@"OK" duration:0.0f];
        //[Utility showAlert:AppName withMessage:@"Please Email"];
        return;
    }
   else if ([_txtEmail.text isEqualToString:@""])
   {
       SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
       [alert setHorizontalButtons:YES];
       [alert showSuccess:AppName subTitle:@"Please Email" closeButtonTitle:@"OK" duration:0.0f];
        //[Utility showAlert:AppName withMessage:@"Please Email"];
        return;
    }
   else if ([_txtEmail.text length]>0)
   {
        if (![Utility validateEmail:_txtEmail.text])
        {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:@"Invalid Email" closeButtonTitle:@"OK" duration:0.0f];
           // [Utility showAlert:AppName withMessage:@"Invalid Email"];
            [_txtEmail becomeFirstResponder];
            return;
        }
    }
   
       NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
       NSString*  uID=[usercheckup valueForKey:@"id"];
        [Utility showLoading:self];
       NSString *percentage= [_lblScore.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
       
    [[APIManager sharedInstance]quizScoreUpdateWithUserId:uID andAssmentId:_strMiniCertification andName:_txtName.text andEmail:_txtEmail.text andMobileNumber:_txtmobilenumber.text andTeleCode:_txtCountryCode.text andScore:percentage andCompleteBlock:^(BOOL success, id result)
        {
            [Utility hideLoading:self];
            if (!success)
            {
                return ;
            }
            else
            {
                 NSInteger status = [[result objectForKey:@"status"] intValue];
                if (status==1)
                {
                    BankAccountViewController *account=[self.storyboard instantiateViewControllerWithIdentifier:@"BankAccountViewController"];
                    [self.navigationController pushViewController:account animated:YES];
                    
                }
                NSLog(@"%@",result);
            }
       }];
   
  
}
- (IBAction)btnCountryCodeTapped:(id)sender
{
    [self.view endEditing:YES];
    
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectCountryCode]
                                            rows:countryWithName
                                initialSelection:_selectedCountryCode
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
    {
                                           _selectedCountryCode = selectedIndex;
                                           
                                           NSString *firstWord = [[selectedValue componentsSeparatedByString:@" "] objectAtIndex:0];
                                           _txtCountryCode.text =firstWord;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker)
     {
         NSLog(@"Block Picker Canceled");
     }
                                          origin:sender];
}

@end
