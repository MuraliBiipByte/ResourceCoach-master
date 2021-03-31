//
//  ViewController.m
//  SMILES
//
//  Created by Biipmi on 6/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "RootViewController.h"
#import "JVFloatLabeledTextField.h"
#import "SubscriberRegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "APIManager.h"
#import "Utility.h"
#import "ForgotPasswordViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "UIActionSheet+Blocks.h"
#import "ActionSheetPicker.h"
#import "MobileVerificationViewController.h"
#import "ActionSheetStringPicker.h"
#import "UIAlertView+Blocks.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
@import Firebase;


@interface ViewController ()<UITextFieldDelegate>
{
    NSString *countryCode;
    
    NSMutableArray *countryWithName,*arrLanguages;
    __weak IBOutlet UILabel *lblTitle;
    
}
@property (nonatomic,assign) NSInteger selectedCountryCode;
@property (weak, nonatomic) IBOutlet UIImageView *alertIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *alertImg1;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelMobile;
@property (weak, nonatomic) IBOutlet UIImageView *alertIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *alertImg2;
@property (weak, nonatomic) IBOutlet UILabel *alertLabelPassword;
@property (weak, nonatomic) IBOutlet UIView *logView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumberLine;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryCodeLine;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblPasswordLine;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *subscriberRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnContributer;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *backGroundAlphaView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImg;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeLanguage;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UILabel *lblDontHaveAcc;
@property (weak, nonatomic) IBOutlet UILabel *lblOr;
@property (strong, nonatomic) FIRDatabaseReference *ref;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //----Initializing Array Values----//
    
    arrLanguages=[[NSMutableArray alloc]initWithObjects:@"English",@"Zawgyi",nil];
     countryWithName=[[NSMutableArray alloc]init];
    
    
    //-----Initialising FireBase Db For chat -----//
    
          self.ref = [[FIRDatabase database] reference];
    
    //----Setting text fields Placeholder colors----//
    
//     [_txtMobileNumber setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtCountryCode setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_txtPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//    
    //----Corner Radious of objects-----//
    
    [_logView.layer setCornerRadius:10.0f];
    [_logView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_logView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_logView.layer setShadowOpacity:0.7];
    [_logView.layer setShadowRadius:10.0f];
    [_logView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    _subscriberRegisterBtn.layer.cornerRadius=5.0f;
    _subscriberRegisterBtn.layer.masksToBounds=YES;
    _btnLogin.layer.cornerRadius=5.0f;
    _btnLogin.layer.masksToBounds=YES;
    
    
     //----Number of lines for button title-----//
    
    _btnChangeLanguage.titleLabel.numberOfLines=2;
    _btnForgot.titleLabel.numberOfLines=2;
    

    //----Get Country Code Based On Location----//
    
    NSLocale *locale = [NSLocale currentLocale];
    countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSString *country = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    NSLog(@"Current Country is- %@",country);
    NSDictionary *dict=[self dictCountryCodes];
    NSString *strCode=[dict objectForKey:countryCode];
    _txtCountryCode.text=[NSString stringWithFormat:@"+%@",strCode];
    
    
    //---Getting All CountrysWithCode From Plist---//
   
    countryWithName = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountryCodeWithName" ofType:@"plist"]];
    
    //----Setting Custom Loader----//
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45 , 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    _btnChangeLanguage.hidden=YES;
    _txtCountryCode.text=@"+95";
    _logoImg.layer.cornerRadius=4;
    _logoImg.layer.masksToBounds=YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    ///Change the language
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"LoginScreen" forKey:@"Controller"];

    _txtMobileNumber.placeholder=[Language MobileNumber];
    _txtPassword.placeholder=[Language Password];
    _lblDontHaveAcc.text=[Language DontHaveAnAccount];
    _lblOr.text=[Language Or];
    lblTitle.text=[Language DedaaBox];
    [_btnForgot setTitle:[Language ForgotPassword] forState:UIControlStateNormal];
    [_btnContributer setTitle:[Language SignUpasaContributor] forState:UIControlStateNormal];
    [_subscriberRegisterBtn setTitle:[Language SignUp] forState:UIControlStateNormal];
    [_btnChangeLanguage setTitle:[Language ChangeLanguage] forState:UIControlStateNormal];
    NSLog(@"%@",[Language Login]);
    [_btnLogin setTitle:[NSString stringWithFormat:@"%@",[Language Login]] forState:UIControlStateNormal];
    
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


#pragma mark - CountryCode Button Tapped
- (IBAction)btnCountryCodeTapped:(id)sender
{
    [self.view endEditing:YES];
 
       
    _selectedCountryCode=0;
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectCountryCode]
                                            rows:countryWithName
                                initialSelection:_selectedCountryCode
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

#pragma mark - User Login Button Tapped
- (IBAction)Login:(id)sender {
    [self.view endEditing:YES];


    
    if ([_txtMobileNumber.text length]==0 && [_txtPassword.text length]==0) {
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        //   alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
        [alert showSuccess:AppName subTitle:[Language MobileNumbercannotbeempty] closeButtonTitle:@"OK" duration:0.0f];
        
        return;
    }
    
    if ([_txtMobileNumber.text length]==0) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        // alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
        [alert showSuccess:AppName subTitle:[Language MobileNumbercannotbeempty] closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    if ([_txtPassword.text length]==0) {
        _alertIcon2.hidden=NO;
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        // alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
        [alert showSuccess:AppName subTitle:[Language Passwordcannotbeempty] closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]loginWithTelCode:_txtCountryCode.text andWithMobileNumber:_txtMobileNumber.text andPassword:_txtPassword.text andCompleteBlock:^(BOOL success, id result) {
        // [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            //[Utility showAlert:AppName withMessage:result];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            // alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:@"OK" duration:0.0f];
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        NSString *errorMsg=[result valueForKey:@"message"];
        NSString *userId,*userName,*userTelcode,*userMobileNo,*userEmail,*userType,*userTypeId,*userProfilePic,*userMobVerifyStatus,*userActive,*userDeptId,*userDeptName;
        userId=[userDict valueForKey:@"id"];
        userName=[userDict valueForKey:@"username"];
        userTelcode=[userDict valueForKey:@"telcode"];
        userMobileNo=[userDict valueForKey:@"phone"];
        userEmail=[userDict valueForKey:@"email"];
        userType=[userDict valueForKey:@"usertype"];
        userTypeId=[userDict valueForKey:@"usertype_id"];
        userProfilePic=[userDict valueForKey:@"photo_user"];
        userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
        userDeptId=[userDict valueForKey:@"department_id"];
        userDeptName=[userDict valueForKey:@"department_name"];
        userActive=[userDict valueForKey:@"active"];
        if ([userMobVerifyStatus isEqualToString:@"NO"]||[userMobVerifyStatus isEqual:[NSNull null]]) {
            //            [Utility showAlert:AppName withMessage:errorMsg];
            //            return;
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert addButton:[Language ok] actionBlock:^(void)
             {
                 MobileVerificationViewController *mobileVerification=[self.storyboard instantiateViewControllerWithIdentifier:@"MobileVerificationViewController"];
                 mobileVerification.strMobileNo=[NSString stringWithFormat:@"%@",userMobileNo];
                 mobileVerification.strCountryCode=[NSString stringWithFormat:@"%@",userTelcode];
                 mobileVerification.strUserType=[NSString stringWithFormat:@"%@",userTypeId];
                 [self presentViewController:mobileVerification animated:YES completion:nil];
             }
             ];
            [alert showSuccess:AppName subTitle:errorMsg closeButtonTitle:[Language Cancel] duration:0.0f];
            
                }
        else{
            if ([userActive isEqualToString:@"0"]) {
                [Utility showAlert:AppName withMessage:errorMsg];
                return;
            }
            
        
                NSString *fcmToken = [FIRMessaging messaging].FCMToken;
                NSLog(@"FCM registration token: %@", fcmToken);
            
            NSString *fcmToken1 = [FIRMessaging messaging].FCMToken;
            NSLog(@"FCM registration token1: %@", fcmToken1);
            
            if (![fcmToken isEqual:[NSNull null]])
            {
                
//                [[[[_ref child:@"fcm_token"]child:[NSString stringWithFormat:@"-%@",userId]]childByAutoId]child:fcmToken];
            }
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userId forKey:@"id"];
            [userDefaults setObject:userName forKey:@"name"];
            [userDefaults setObject:userType forKey:@"usertype"];
            [userDefaults setObject:userTypeId forKey:@"usertypeid"];
            [userDefaults setObject:userTelcode forKey:@"telcode"];
            [userDefaults setObject:userMobileNo forKey:@"phone"];
            [userDefaults setObject:userDeptId forKey:@"deptid"];
            [userDefaults setObject:userDeptName forKey:@"deptname"];
        [userDefaults setObject:fcmToken forKey:@"fcmtoken"];
            
            if ([userEmail isEqual:[NSNull null]]) {
                [userDefaults setObject:@"" forKey:@"email"];
            }else{
                [userDefaults setObject:userEmail forKey:@"email"];
            }
            if ([userProfilePic isEqual:[NSNull null]]) {
                [userDefaults setObject:@"" forKey:@"profileimage"];
            }else{
                [userDefaults setObject:userProfilePic forKey:@"profileimage"];
            }
            [userDefaults synchronize];
            NSUserDefaults *devieDefaults=[NSUserDefaults standardUserDefaults];
            NSString *deviceid=[devieDefaults objectForKey:@"token"];
            
            if (deviceid==nil) {
                NSLog(@"Device id is not found");
            }
            else{
                [[APIManager sharedInstance]registerDeviceForPushnotificationsWithUserId:userId andWithDeviceType:@"ios" andWithDeviceId:deviceid andWithregisterId:@"" andCompleteBlock:^(BOOL success, id result) {
                    if (!success) {
                        NSLog(@"device is not registered");
                        return ;
                    }
                    NSLog(@"device is registered");
                }];
            }
            
//        //Registering users in FireBase///
            
//            [[[_ref child:@"users"] child:[NSString stringWithFormat:@"-%@",userId]]
//             setValue:@{@"user_name": userName,@"mobile_number":userMobileNo,@"user_type":userType}];
//
//        //Registering FCM_tocken in Firebase for Push Notifications////
//
//            [[[[_ref child:@"fcm_token"] child:[NSString stringWithFormat:@"-%@",userId]]childByAutoId]
//             setValue:@{@"fcm_id": fcmToken,@"type":@"ios"}];
              
            RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
            [self presentViewController:homeView animated:YES completion:nil];
        }
    }];
}

#pragma mark- Subscriber Register Button Tapped
- (IBAction)subscriberRegisterTapped:(id)sender {
    SubscriberRegisterViewController *subscriber=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriberRegisterViewController"];
    subscriber.strHeaderTitle=@"Subscriber Sign Up";
    subscriber.strUserModel=@"3";
    subscriber.strUserType=@"subscriber";
   [self presentViewController:subscriber animated:YES completion:nil];
}

#pragma mark- Subscriber Register Button Tapped
- (IBAction)btnContributerRegisterTapped:(id)sender {
    SubscriberRegisterViewController *subscriber=[self.storyboard instantiateViewControllerWithIdentifier:@"SubscriberRegisterViewController"];
    subscriber.strHeaderTitle=@"Contributor Sign Up";
    subscriber.strUserModel=@"2";
    subscriber.strUserType=@"contributor";
    [self presentViewController:subscriber animated:YES completion:nil];
}

#pragma mark- Forgot Button Tapped
- (IBAction)btnForgotTapped:(id)sender {
    ForgotPasswordViewController *forgotPassword=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self presentViewController:forgotPassword animated:YES completion:nil];
}
- (IBAction)btnChangeLanguageTapped:(id)sender {
    [self.view endEditing:YES];
    _selectedCountryCode=0;
    [ActionSheetStringPicker showPickerWithTitle:[Language SelectLanguage]
                                            rows:arrLanguages
                                initialSelection:_selectedCountryCode
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _selectedCountryCode = selectedIndex;
                                           _txtMobileNumber.text=@"";
                                           _txtPassword.text=@"";
                                           NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                                           
                                           if ([selectedValue isEqualToString:@"Zawgyi"]) {
                                               
                                               [defaults setObject:@"2" forKey:@"language"];
                                               [self viewWillAppear:YES];
                                           }
                                           else {
                                               
                                               [defaults setObject:@"1" forKey:@"language"];
                                               [self viewWillAppear:YES];
                                           }
                                           
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}


@end
