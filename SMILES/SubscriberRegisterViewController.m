//
//  SubscriberRegisterViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 07/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "SubscriberRegisterViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ViewController.h"
#import "APIManager.h"
#import "TOCropViewController.h"
#import "MobileVerificationViewController.h"
#import "APIManager.h"
#import "User.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"
#import "ActionSheetPicker.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
@import Firebase;

@interface SubscriberRegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,UIActionSheetDelegate>{
    UIImage *chosenImage;
    NSMutableArray *countryWithName;
    NSString *countryCode;
    NSMutableArray *arrCompanyNames;
    NSMutableArray *arrCompanyIDs;
    NSMutableArray *arrDepartments;
    NSMutableArray *arrDepartmentIDs;
    NSString *companyID,*departmentID;
    NSString *verifyCode;
   NSInteger verifyStatus;
    UIView *backGroundView;
    
    //  NSString *language;
    NSString *header,*Ok,*Cancel,*Gallery,*Camera,*selectCompany,*selectDepartment;
}
@property (weak, nonatomic) IBOutlet UIImageView *alertIconUserName;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelUserName;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgUserName;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconMobileNumber;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgMobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelMobileNumber;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconEmail;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgEmail;
@property (weak, nonatomic) IBOutlet UILabel *alertLableEmail;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconPassword;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgPassword;
@property (weak, nonatomic) IBOutlet UILabel *alerLabelPassword;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconCNPassword;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgCNPassword;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelCNPassword;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconCompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelCompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconDepartment;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelDepartment;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgDepartment;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *suView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserNameLine;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumberLine;
@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryCodeLine;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailLine;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblPasswordLine;
@property (weak, nonatomic) IBOutlet UITextField *txtConformPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblConformPasswordLine;
@property (weak, nonatomic) IBOutlet UITextField *txtCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyNameLine;
@property (weak, nonatomic) IBOutlet UITextField *txtDepartment;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartmentLine;
@property (weak, nonatomic) IBOutlet UITextField *txtEmployID;
@property (weak, nonatomic) IBOutlet UILabel *lblEmployIDLine;
@property (weak, nonatomic) IBOutlet UITextField *txtCompanyCode;
@property (weak, nonatomic) IBOutlet UIImageView *alertIconCompanyCode;
@property (weak, nonatomic) IBOutlet UIImageView *alertImgCompanyCode;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelCompanyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnDepartment;
@property (nonatomic,assign) NSInteger selectedCountryCode;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle;
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblUserDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblLineCompanyDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblLine2;

@property (weak, nonatomic) IBOutlet UIView *registerView;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation SubscriberRegisterViewController
@synthesize strUserModel,strHeaderTitle,strUserType;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"SignUp" forKey:@"Controller"];

//    if ([strUserModel isEqualToString:@"2"])
//    {
//        _lblHeaderTitle.text=[Language ContributorSignUp];
//    }
//    else{
        _lblHeaderTitle.text=[Language SignUp];
   // }
    _lblCompanyDetails.text=[Language COMPANYDETAILS];
    _lblUserDetails.text=[Language USERDETAILS];
    _txtCompanyName.placeholder=[Language SelectCompanyName];
    _txtDepartment.placeholder=[Language SelectDepartment];
    _txtEmployID.placeholder=[Language LearnerIDOp];
    _txtUserName.placeholder=[Language FullName];
    _txtMobileNumber.placeholder=[Language MobileNumber];
    _txtEmail.placeholder=[Language EmailOptional];
    _txtPassword.placeholder=[Language Password];
    _txtConformPassword.placeholder=[Language ReEnterPassword];
    [_registerBtn setTitle:[Language REGISTER] forState:UIControlStateNormal];
    
    
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
    
    
    [_registerView.layer setCornerRadius:10.0f];
    [_registerView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_registerView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_registerView.layer setShadowOpacity:0.5];
    [_registerView.layer setShadowRadius:10.0f];
    [_registerView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    _registerBtn.layer.cornerRadius=5.0f;
    _registerBtn.layer.masksToBounds=YES;
    
    
    
    //Hiding Alerts
    _alertIconUserName.hidden=YES;
    _alertImgUserName.hidden=YES;
    _alertLabelUserName.hidden=YES;
    _alertIconMobileNumber.hidden=YES;
    _alertImgMobileNumber.hidden=YES;
    _alertLabelMobileNumber.hidden=YES;
    _alertIconEmail.hidden=YES;
    _alertImgEmail.hidden=YES;
    _alertLableEmail.hidden=YES;
    _alertIconPassword.hidden=YES;
    _alertImgPassword.hidden=YES;
    _alerLabelPassword.hidden=YES;
    _alertIconCNPassword.hidden=YES;
    _alertImgCNPassword.hidden=YES;
    _alertLabelCNPassword.hidden=YES;
    _alertIconCompanyName.hidden=YES;
    _alertImgCompanyName.hidden=YES;
    _alertLabelCompanyName.hidden=YES;
    _alertIconDepartment.hidden=YES;
    _alertImgDepartment.hidden=YES;
    _alertLabelDepartment.hidden=YES;
    _alertIconCompanyCode.hidden=YES;
    _alertImgCompanyCode.hidden=YES;
    _alertLabelCompanyCode.hidden=YES;
    _lblHeaderTitle.shadowColor = [UIColor whiteColor];
    _lblHeaderTitle.shadowOffset = CGSizeMake(0,1);
   
    NSLog(@"User Type is %@",strUserModel);
    countryWithName=[[NSMutableArray alloc]init];
    countryWithName = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountryCodeWithName" ofType:@"plist"]];
    //Get Country Code
    NSLocale *locale = [NSLocale currentLocale];
    countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSString *country = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    NSLog(@"Current Country is- %@",country);
    NSDictionary *dict=[self dictCountryCodes];
    NSString *strCode=[dict objectForKey:countryCode];
    _txtCountryCode.text=[NSString stringWithFormat:@"+%@",strCode];
    countryWithName=[[NSMutableArray alloc]init];
    countryWithName = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountryCodeWithName" ofType:@"plist"]];
    [[_btnCompanyName layer] setBorderWidth:1.0f];
    [[_btnCompanyName layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    _btnCompanyName.layer.cornerRadius=5;
    [[_btnDepartment layer] setBorderWidth:1.0f];
    [[_btnDepartment layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    _btnDepartment.layer.cornerRadius=5;
    arrCompanyNames=[[NSMutableArray alloc]init];
    arrCompanyIDs=[[NSMutableArray alloc]init];
    arrDepartments=[[NSMutableArray alloc]init];
    arrDepartmentIDs=[[NSMutableArray alloc]init];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
//    self.profileImageView.layer.borderWidth = 3.0f;
//    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _alertLabelUserName.text=[Language FullNamecannotbeempty];
    _alertLabelMobileNumber.text=[Language MobileNumbercannotbeempty];
    _alertLabelCNPassword.text=[Language ReenterPasswordcannotbeempty];
    
    //Here we are not using any company for registration
   // [self getAllCompanies];
    _txtCountryCode.text=@"+95";
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *lang=[defaults valueForKey:@"language"];
    if ([lang isEqualToString:@"1"]) {
        _lblLine2.hidden=YES;
        _lblLineCompanyDetails.hidden=NO;
    }
     else if([lang isEqualToString:@"2"]) {
         _lblLine2.hidden=YES;
         _lblLineCompanyDetails.hidden=NO;
    }
     else{
       //  _lblLine2.hidden=NO;
        // _lblLineCompanyDetails.hidden=YES;
     }
}
#pragma mark - Get Country Codes
-(NSDictionary *)dictCountryCodes{
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"93", @"AF",@"20",@"EG", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    return dictCodes;
}

#pragma TextField Deligates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ((textField=_txtPassword)) {
        if ([_txtPassword.text length]>0&&![self isValidPassword:_txtPassword.text]) {
            //            _alertIconPassword.hidden=NO;
            //            _alertImgPassword.hidden=NO;
            //            _alerLabelPassword.text=[Language passwordValidate];
            //            _alerLabelPassword.hidden=NO;
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:[Language passwordValidate] closeButtonTitle:[Language ok] duration:0.0f];
            [_txtPassword resignFirstResponder];
        }
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==_txtUserName) {
        if ([_txtUserName.text length]==0&&_alertIconUserName.hidden==NO) {
            
            
            
            
        }
        else{
            
        }
    }
    if (textField==_txtMobileNumber) {
        if ([_txtMobileNumber.text length]==0 &&_alertIconMobileNumber.hidden==NO) {
        }
        else{
            
        }
    }
    if (textField==_txtEmail) {
    }
    if (textField==_txtPassword) {
        if ([_txtPassword.text length]==0&& _alertIconPassword.hidden==NO) {
            //  _alerLabelPassword.text=[Language Passwordcannotbeempty];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:[Language Passwordcannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
            [_txtPassword resignFirstResponder];
        }
        else{
            //            _alertImgPassword.hidden=YES;
            //            _alerLabelPassword.hidden=YES;
        }
    }
    if (textField==_txtConformPassword) {
        if ([_txtPassword.text length]==0) {
            // [Utility showAlert:AppName withMessage:@"Please enter Password"];
            [_txtPassword becomeFirstResponder];
            return;
        }
        else
            if ([_txtConformPassword.text length]==0&&_alertIconCNPassword.hidden==NO) {
                
            }
            else{
                
            }
    }
    if (textField==_txtCompanyName) {
        if ([_txtCompanyName.text length]==0&&_alertIconCompanyName.hidden==NO) {
            
        }
        else{
            
        }
    }
    if (textField==_txtDepartment) {
        if ([_txtDepartment.text length]==0 && _alertIconDepartment.hidden==NO) {
            
        }
        else{
        }
    }
    if (textField==_txtCompanyCode) {
        if ([_txtCompanyCode.text length]==0&&_alertIconCompanyCode.hidden==NO) {
            
        }
        else{
            
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_txtUserName) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            
        }
    }
    if (textField==_txtMobileNumber) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
        }
    }
    if (textField==_txtEmail) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            
        }
    }
    if (textField==_txtPassword) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            
        }
    }
    if (textField==_txtConformPassword) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if (_alertImgPassword.hidden==NO) {
        }
        if ([str length]>0) {
            
        }
    }
    if (textField==_txtCompanyName) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            
        }
    }
    //    if (textField==_txtDepartment) {
    //         NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
    //        if ([str length]>0) {
    //            _alertIconDepartment.hidden=YES;
    //            _alertImgDepartment.hidden=YES;
    //            _alertLabelDepartment.hidden=YES;
    //        }
    //    }
    if (textField==_txtCompanyCode) {
        NSString *str=[_txtCompanyCode.text stringByReplacingCharactersInRange:range withString:string];
        verifyCode=str;
        if ([str length]>0) {
            _alertIconCompanyCode.hidden=YES;
            _alertImgCompanyCode.hidden=YES;
            _alertLabelCompanyCode.hidden=YES;
            if ([str length]>0&&[_txtCompanyName.text isEqualToString:@""]&&[_txtDepartment.text isEqualToString:@""]) {
                // [Utility showAlert:AppName withMessage:@"Please select Company Name before entering Registration Code"];
                return NO;
            }
            else if ([str length]>0&&[_txtDepartment.text isEqualToString:@""]) {
                [Utility showAlert:AppName withMessage:[Language PleaseSelectDepartment]];
                return NO;
            }
            else if ([str length]==7) {
                [_txtCompanyCode resignFirstResponder];
                [self verifyCompanycode];
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - Profile Image Button Tapped
-(void)cameraClick{
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
    profilePicker.modalPresentationStyle = UIModalPresentationPopover;
    profilePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    profilePicker.allowsEditing = NO;
    profilePicker.delegate = self;
   // profilePicker.preferredContentSize = CGSizeMake(512,512);
    profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:profilePicker animated:YES completion:nil];
}
-(void)galleryClick{
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
    profilePicker.modalPresentationStyle = UIModalPresentationPopover;
    profilePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    profilePicker.allowsEditing = NO;
    profilePicker.delegate = self;
  //  profilePicker.preferredContentSize = CGSizeMake(512,512);
    profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:profilePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.imageCropFrame=CGRectMake(0, 0, _profileImageView.frame.size.width, _profileImageView.frame.size.height);
    cropController.aspectRatioLockEnabled = YES;
    cropController.resetAspectRatioEnabled = NO;
    cropController.toolbarPosition = TOCropViewControllerToolbarPositionTop;
    cropController.delegate = self;

    self.image = image;
    if (self.croppingStyle == TOCropViewCroppingStyleCircular) {
        [picker pushViewController:cropController animated:YES];
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:cropController animated:YES completion:nil];
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image Cropper Delegate
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController{
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
       _profileImageView.image = image;
    chosenImage=image;
    [self layoutImageView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (cropViewController.croppingStyle != TOCropViewCroppingStyleCircular) {
        self.imageView.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self
                                                   withCroppedImage:image
                                                             toView:self.imageView
                                                            toFrame:CGRectZero
                                                              setup:^{ [self layoutImageView]; }
                                                         completion:
         ^{
             self.imageView.hidden = NO;
         }];
    }
    else {
        self.imageView.hidden = NO;
        [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Image Layout
- (void)layoutImageView{
    if (self.imageView.image == nil)
        return;
    CGFloat padding = 20.0f;
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= ((padding * 2.0f));
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.imageView.image.size;
    if (self.imageView.image.size.width > viewFrame.size.width ||
        self.imageView.image.size.height > viewFrame.size.height){
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= scale;
        imageFrame.size.height *= scale;
        imageFrame.origin.x = (CGRectGetWidth(self.view.bounds) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.view.bounds) - imageFrame.size.height) * 0.5f;
        self.imageView.frame = imageFrame;
    }
    else {
        self.imageView.frame = imageFrame;
        self.imageView.center = (CGPoint){CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)};
    }
}

#pragma mark- User Profile Image Tapped
- (IBAction)profileBtnTapped:(id)sender {
    [self.view endEditing:YES];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        UIAlertController* alert = [UIAlertController
                alertControllerWithTitle:nil message:nil
        preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* button0 = [UIAlertAction
                actionWithTitle:[Language Cancel]
        style:UIAlertActionStyleCancel
            handler:^(UIAlertAction * action){
            
                                  }];
        UIAlertAction* button1 = [UIAlertAction
                                  actionWithTitle:[Language camera]
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self cameraClick];
                                  }];
        UIAlertAction* button2 = [UIAlertAction
                                  actionWithTitle:[Language gallary]
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self galleryClick];
                                  }];
        [alert addAction:button0];
        [alert addAction:button1];
        [alert addAction:button2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(status == AVAuthorizationStatusDenied)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:[Language appSettings] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:[Language ok] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:[Language Cancel] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(status == AVAuthorizationStatusRestricted){
    }
    else if(status == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                UIAlertController* alert = [UIAlertController
                                            alertControllerWithTitle:nil
                                            message:nil
                                            preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction* button0 = [UIAlertAction
                                          actionWithTitle:[Language Cancel]
                                          style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction * action){
                                          }];
                UIAlertAction* button1 = [UIAlertAction
                                          actionWithTitle:[Language camera]
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [self cameraClick];
                                          }];
                UIAlertAction* button2 = [UIAlertAction
                                          actionWithTitle:[Language gallary]
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [self galleryClick];
                                          }];
                [alert addAction:button0];
                [alert addAction:button1];
                [alert addAction:button2];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
            }
        }];
    }
}

#pragma mark - Button country Code Tapped
- (IBAction)btnCountryCodeTapped:(id)sender {
    [self.view endEditing:YES];
    _selectedCountryCode=0;
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectCountryCode]
            rows:countryWithName initialSelection:_selectedCountryCode
    doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        _selectedCountryCode = selectedIndex;
        NSString *firstWord = [[selectedValue componentsSeparatedByString:@" "] objectAtIndex:0];
        _txtCountryCode.text =firstWord;
            }
        cancelBlock:^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
        }
    origin:sender];
}

#pragma mark - Passwor Validation
-(BOOL)isValidPassword:(NSString *)passwordString{
//    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}";
     NSString *stricterFilterString = @"^(?!.*(.)\\1{3})((?=.*[\\d])(?=.*[A-Za-z])|(?=.*[^\\w\\d\\s])(?=.*[A-Za-z])).{6,25}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

#pragma mark- User Register tapped
- (IBAction)registerBtnTapped:(id)sender {
    [self.view endEditing:YES];
    if ([_txtUserName.text length]==0&&[_txtMobileNumber.text length]==0&& [_txtPassword.text length]==0&&[_txtConformPassword.text length]==0) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language FullNamecannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        
        return;
    }
    if ([_txtUserName.text length]==0) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language FullNamecannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        [_txtUserName becomeFirstResponder];
        return;
    }
    if ([_txtMobileNumber.text length]==0) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language MobileNumbercannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        [_txtMobileNumber becomeFirstResponder];
        return;
    }
    if ([_txtEmail.text length]>0) {
        if (![Utility validateEmail:_txtEmail.text]) {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:[Language InvalidEmail] closeButtonTitle:[Language ok] duration:0.0f];
            [_txtEmail becomeFirstResponder];
            return;
        }
    }
    if ([_txtPassword.text length]==0) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language Passwordcannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        [_txtPassword becomeFirstResponder];
        return;
    }
    else if(![self isValidPassword:_txtPassword.text]) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language passwordValidate] closeButtonTitle:[Language ok] duration:0.0f];
        
        return;
    }
    if ([_txtConformPassword.text length]==0) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language ReenterPasswordcannotbeempty] closeButtonTitle:[Language ok] duration:0.0f];
        return;
    }
    else if (![_txtPassword.text isEqualToString:_txtConformPassword.text]) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language PassandReentershouldBeSame] closeButtonTitle:[Language ok] duration:0.0f];
        
        return;
    }
//    if ([_txtCompanyName.text length]==0) {
//        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//        [alert setHorizontalButtons:YES];
//        [alert showSuccess:AppName subTitle:[Language PleaseSelectCompanyName] closeButtonTitle:[Language ok] duration:0.0f];
//        return;
//    }
//    if ([_txtDepartment.text length]==0) {
//        
//        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//        [alert setHorizontalButtons:YES];
//        [alert showSuccess:AppName subTitle:[Language PleaseSelectDepartment] closeButtonTitle:[Language ok] duration:0.0f];
//        return;
//    }
//    if ([_txtCompanyName.text length]==0) {
//        
//        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//        [alert setHorizontalButtons:YES];
//        [alert showSuccess:AppName subTitle:[Language PleaseSelectCompanyName] closeButtonTitle:[Language ok] duration:0.0f];
//        
//        // [Utility showAlert:AppName withMessage:[Language PleaseSelectCompanyName]];
//        return;
//    }
//    if ([_txtDepartment.text length]==0) {
//        
//        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//        [alert setHorizontalButtons:YES];
//        [alert showSuccess:AppName subTitle:[Language PleaseSelectDepartment] closeButtonTitle:[Language ok] duration:0.0f];
//        // [Utility showAlert:AppName withMessage:[Language PleaseSelectDepartment]];
//        return;
//    }
    //Storing the inputs into User Model
    User *user = [[User alloc] init];
    //    user.userType = strUserModel;
    user.userType = @"non_subscriber";
    user.userName = _txtUserName.text;
    user.usertelCode=_txtCountryCode.text;
    user.userPhoneNumber = _txtMobileNumber.text;
    user.userEmail = _txtEmail.text;
    user.userPassword = _txtPassword.text;
    user.userConfPassword = _txtConformPassword.text;
    user.userCompany = companyID;
    user.userDepartment=departmentID;
    user.userEmpId=_txtEmployID.text;
    // Calling the Registration service
    // [Utility showLoading:self];
    
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]createAccount:user andWithProfileImage:chosenImage andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        backGroundView.hidden=YES;
        [self.img setHidden:YES];
        if (!success) {
            // [Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            return;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSString *message = [result objectForKey:@"message"];
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        NSString *active=[userDict valueForKey:@"active"];
        NSString *userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert addButton:[Language ok] actionBlock:^(void)
         {
             if ([userMobVerifyStatus isEqualToString:@"NO"])
             {
                 NSString *userMobileNo=[userDict valueForKey:@"phone"];
                 NSString *userCountryCode=[userDict valueForKey:@"telcode"];
                 NSString *userType=[userDict valueForKey:@"usertype_id"];
                 MobileVerificationViewController *mobileVerification=[self.storyboard instantiateViewControllerWithIdentifier:@"MobileVerificationViewController"];
                 mobileVerification.strMobileNo=[NSString stringWithFormat:@"%@",userMobileNo];
                 mobileVerification.strCountryCode=[NSString stringWithFormat:@"%@",userCountryCode];
                 mobileVerification.strUserType=[NSString stringWithFormat:@"%@",userType];
                 [self presentViewController:mobileVerification animated:YES completion:nil];
             }
             
         }
         ];
        [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language cancel] duration:0.0f];
        
        //        RIButtonItem *okItem = [RIButtonItem itemWithLabel:[Language ok] action:^{
        //            if ([userMobVerifyStatus isEqualToString:@"NO"])
        //            {
        //                NSString *userMobileNo=[userDict valueForKey:@"phone"];
        //                NSString *userCountryCode=[userDict valueForKey:@"telcode"];
        //                NSString *userType=[userDict valueForKey:@"usertype_id"];
        //            MobileVerificationViewController *mobileVerification=[self.storyboard instantiateViewControllerWithIdentifier:@"MobileVerificationViewController"];
        //                mobileVerification.strMobileNo=[NSString stringWithFormat:@"%@",userMobileNo];
        //                mobileVerification.strCountryCode=[NSString stringWithFormat:@"%@",userCountryCode];
        //                 mobileVerification.strUserType=[NSString stringWithFormat:@"%@",userType];
        //        [self presentViewController:mobileVerification animated:YES completion:nil];
        //            }
        //        }];
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName
        //            message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
        //        [alertView show];
    }];
}

#pragma mark- Back to login page
- (IBAction)btnCloseRegTapped:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Get All Companies
-(void)getAllCompanies{
    // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllCompanies:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *categoryType = [data objectForKey:@"companies"];
        arrCompanyNames=[categoryType valueForKey:@"name"];
        arrCompanyIDs=[categoryType valueForKey:@"id"];
    }];
}

#pragma mark - Get All Departments
-(void)getAllDepartments{
    // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getAllDepartmentsWithCompanyId:companyID andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            // [Utility showAlert:AppName withMessage:result];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *categoryType = [data objectForKey:@"department"];
        arrDepartments=[categoryType valueForKey:@"name"];
        arrDepartmentIDs=[categoryType valueForKey:@"id"];
    }];
}

#pragma mark- Verify Company Secret Code
-(void)verifyCompanycode{
    _txtCompanyCode.text=verifyCode;
    // [Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]verifyCompanyWithUserType:strUserType andWithCompanyId:companyID andWithSecretCode:verifyCode andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
           // [Utility showAlert:AppName withMessage:result];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];

            
            return ;
        }
        verifyStatus=[[result objectForKey:@"status" ] intValue];
        _alertIconCompanyCode.image=[UIImage imageNamed:@"emailVerified"];
        _alertIconCompanyCode.hidden=NO;
        _btnCompanyName.enabled=NO;
        _btnDepartment.enabled=NO;
        _txtCompanyName.enabled=NO;
        _txtDepartment.enabled=NO;
        _txtCompanyCode.enabled=NO;
    }];
}
#pragma mark -Button Company Tapped
- (IBAction)btnCompanyNameTapped:(id)sender {
    [self.view endEditing:YES];
    _selectedCountryCode=0;
    departmentID=@"";
    _txtDepartment.text=@"";
   if ([arrCompanyNames count]==0) {
      //  [Utility showAlert:AppName withMessage:[Language PleaseyourNetworkConnection]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:@"No Compamies Available" closeButtonTitle:[Language ok] duration:0.0f];

        return;
    }
   else{
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectCompanyName]
                                            rows:arrCompanyNames
                                initialSelection:_selectedCountryCode
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _selectedCountryCode = selectedIndex;
                                           companyID=[arrCompanyIDs objectAtIndex:selectedIndex];
                                           _txtCompanyName.text=selectedValue;
                                           [self getAllDepartments];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];}
}

#pragma mark -Button Department Tapped
- (IBAction)btnDepartmentTapped:(id)sender {
    [self.view endEditing:YES];
    if ([_txtCompanyName.text length]==0) {
        // [Utility showAlert:AppName withMessage:[Language PleaseSelectCompanyName]];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language PleaseSelectCompanyName] closeButtonTitle:[Language ok] duration:0.0f];
        
        
        return;
    }
    else{
        _selectedCountryCode=0;
        [ActionSheetStringPicker showPickerWithTitle:[Language SelectCompanyName]
                                                rows:arrDepartments
                                    initialSelection:_selectedCountryCode
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               _selectedCountryCode = selectedIndex;
                                               departmentID=[arrDepartmentIDs objectAtIndex:selectedIndex];
                                               _txtDepartment.text=selectedValue;
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:sender];
    }
}
// Trim
//NSString *string = @" this text has spaces before and after ";
//NSString *trimmedString = [string stringByTrimmingCharactersInSet:
//                           [NSCharacterSet whitespaceCharacterSet]];

@end
