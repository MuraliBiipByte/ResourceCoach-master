//
//  ProfileUpdateViewController.m
//  SMILES
//
//  Created by BiipByte Technologies on 20/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "ProfileUpdateViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "HomeViewController.h"
#import "UIImageView+WebCache.h"
#import "TOCropViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "ActionSheetPicker.h"
#import "RootViewController.h"
#import "ProfileDetailsViewController.h"
#import "EmailVerificationViewController.h"
#import "HYCircleLoadingView.h"
#import "Language.h"
#import "SCLAlertView.h"
@interface ProfileUpdateViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,UIActionSheetDelegate>{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *profileView;
    __weak IBOutlet UIButton *btnProfile;
    __weak IBOutlet UIImageView *profileImg;
    __weak IBOutlet UITextField *txtUserName;
    __weak IBOutlet UITextField *txtMobileNumber;
    __weak IBOutlet UITextField *txtCountryCode;
    __weak IBOutlet UIButton *btnMobileVerify;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UIButton *btnEmailVerify;
    __weak IBOutlet UITextField *txtCompanyName;
    __weak IBOutlet UITextField *txtDepartment;
    __weak IBOutlet UITextField *txtEmployeeID;
    __weak IBOutlet UIButton *btnUpdateProfile;
    __weak IBOutlet UIImageView *alertIconUserName;
    __weak IBOutlet UIImageView *alertImgUserName;
    __weak IBOutlet UILabel *alertLabelUserName;
    __weak IBOutlet UIImageView *alertIconCompanyName;
    __weak IBOutlet UIImageView *alertImgComapnyName;
    __weak IBOutlet UILabel *alertLabelCompanyName;
    __weak IBOutlet UIImageView *alertIconDepartment;
    __weak IBOutlet UIImageView *alertImgDepartment;
    __weak IBOutlet UILabel *alertLabelDepartment;
    __weak IBOutlet UIImageView *alertIconEmail;
    __weak IBOutlet UIImageView *alertImgEmail;
    __weak IBOutlet UILabel *alertLabelEmail;
    __weak IBOutlet UIButton *btnDepartment;
    UIImage *chosenImage;
    NSMutableArray *countryWithName;
    NSString *countryCode;
    NSString *strUserId,*userName,*userTelcode,*userMobileNo,*userEmail,*userEmailVerify,*userType,*userTypeId,*userProfilePic,*userMobVerifyStatus,*userActive,*userCompanyName,*userDepartment,*userEmpId;
    __weak IBOutlet UIImageView *emailVerifiedImg;
    __weak IBOutlet UIImageView *mobileVerifiedImg;
    
    NSArray *arrDepartmentId,*arrDepartmentName;
    NSString *departmentId,*companyId;
    NSString *verifyNow,*Ok,*Cancel,*cancel,*gallery,*camera,*appSettingsAlert,*selectDepartment;
    UIView*backGroundView;
}
@property (nonatomic,assign) NSInteger selectedCountryCode;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle;
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation ProfileUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    txtUserName.placeholder=[Language FullName];
    txtMobileNumber.placeholder=[Language MobileNumber];
    txtCountryCode.placeholder=[Language Code];
    txtEmail.placeholder=[Language Email];
    txtCompanyName.placeholder=[Language CompanyName];
    txtEmployeeID.placeholder=[Language LearnerID];
    
    alertLabelUserName.text=[Language FullNamecannotbeempty];
    alertLabelEmail.text=[Language InvalidEmail];
    alertLabelCompanyName.text=[Language CompanyName];
    
    
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

    //hiding Alerts
    alertIconUserName.hidden=YES;
    alertImgUserName.hidden=YES;
    alertLabelUserName.hidden=YES;
    alertIconCompanyName.hidden=YES;
    alertImgComapnyName.hidden=YES;
    alertLabelCompanyName.hidden=YES;
    alertIconDepartment.hidden=YES;
    alertImgDepartment.hidden=YES;
    alertLabelDepartment.hidden=YES;
    alertIconEmail.hidden=YES;
    alertImgEmail.hidden=YES;
    alertLabelEmail.hidden=YES;
   
    [txtCountryCode setEnabled:NO];
    [txtMobileNumber setEnabled:NO];
    [txtCompanyName setEnabled:NO];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    strUserId=[userDefaults  objectForKey:@"id"];
    
    [self getTheUserProfileDetails];
    
    [btnMobileVerify setHidden:YES];
    [btnEmailVerify setHidden:YES];
    [emailVerifiedImg setHidden:YES];
    [mobileVerifiedImg setHidden:YES];
    
    [self navigationConfiguration];
    
    arrDepartmentId=[[NSArray alloc] init];
    arrDepartmentName=[[NSArray alloc] init];
    [[btnDepartment layer] setBorderWidth:2.0f];
    [[btnDepartment layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    btnDepartment.layer.cornerRadius=4;
  
    profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
    profileImg.layer.masksToBounds = YES;
    profileImg.layer.borderWidth = 3.0f;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
       // self.title=[Language EditProfile];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = [Language EditProfile];
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
        
        verifyNow=[Language VerifyNow];
        Ok=[Language ok];
        Cancel=[Language Cancel];
        cancel=[Language Cancel];
        gallery=[Language gallary];
        camera=[Language camera];
        appSettingsAlert=[Language appSettings];
        selectDepartment=[Language SelectDepartment];
        [ btnUpdateProfile setTitle:[Language SAVE] forState:UIControlStateNormal];
    }
    else if ([language1 isEqualToString:@"3"]){
        // self.title=@"ပရိုဖိုင်းကို";
        verifyNow=@"အခုတော့ Verify";
        Ok=@"အိုကေ";
        Cancel=@"ဖျက်သိမ်း";
        cancel=@"ပရိုဖိုင်းကို";
        gallery=@"ပြခန်း";
        camera=@"ကင်မရာ";
        appSettingsAlert=@"> Iphone က Settings> Privacy> ကင်မရာ DedaaBox: DedaaBox access ကိုမှသွား enable သင့်ရဲ့ Camera.To မှဝင်ရောက်ခွင့်ရှိသည်ပါဘူး";
        selectDepartment=@"ဦးစီးဌာနကို Select လုပ်ပါ";
        [btnUpdateProfile setTitle:@"Profile ကို Save" forState:UIControlStateNormal];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"သင့်ရဲ့ကိုယ့်ရေးကိုယ်တာကိုပြုပြင်ရန်";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        self.navigationItem.titleView = view;
        [label setFont:[UIFont fontWithName:@"Roboto-Regular" size:14]];
    }
    else{
        self.title=@"Edit Profile";
        verifyNow=@"Verify Now";
        Ok=@"ok";
        Cancel=@"cancel";
        cancel=@"cancel";
        gallery=@"Gallery";
        camera=@"Camera";
        appSettingsAlert=@"Resource Coach does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > Resource Coach";
        selectDepartment=@"Select Department";
        [btnUpdateProfile setTitle:@"Save Profile" forState:UIControlStateNormal];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"ProfileEdit" forKey:@"Controller"];

//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    strUserId=[userDefaults  objectForKey:@"id"];
//    [self getTheUserProfileDetails];
}

#pragma mark - Get Profile Details
-(void)getTheUserProfileDetails{
    //  [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getUserProfileDetailsWithUserId:strUserId andCompleteBlock:^(BOOL success, id result) {
        //[Utility hideLoading:self];
        backGroundView.hidden=YES;
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
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        strUserId=[userDict valueForKey:@"id"];
        userName=[userDict valueForKey:@"username"];
        userTelcode=[userDict valueForKey:@"telcode"];
        userMobileNo=[userDict valueForKey:@"phone"];
        userEmail=[userDict valueForKey:@"email"];
        userType=[userDict valueForKey:@"usertype"];
        userTypeId=[userDict valueForKey:@"usertype_id"];
        userProfilePic=[userDict valueForKey:@"photo_user"];
        userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
        userActive=[userDict valueForKey:@"active"];
        userEmailVerify=[userDict valueForKey:@"email_verify"];
        userCompanyName=[userDict valueForKey:@"company_name"];
        userDepartment=[userDict valueForKey:@"department_name"];
        departmentId=[userDict valueForKey:@"department_id"];
        companyId=[userDict valueForKey:@"company_id"];
        userEmpId=[userDict valueForKey:@"empid"];
       // [self getAllDepartmensForUserCompany];
        if ([userProfilePic isEqual:[NSNull null]]) {
            profileImg.image=[UIImage imageNamed:@"userprofile"];
        }else{
            [profileImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,userProfilePic]]
                          placeholderImage:[UIImage imageNamed:@"userprofile"]];
            if (!profileImg.image) {
                profileImg.image=[UIImage imageNamed:@"userprofile"];
            }
        }
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
        profileImg.layer.masksToBounds = YES;
        profileImg.layer.borderWidth = 3.0f;
        profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
        txtUserName.text=userName;
        txtCountryCode.text=[NSString stringWithFormat:@"%@",userTelcode];
        txtMobileNumber.text=userMobileNo;
        
        if ([userMobVerifyStatus isEqualToString:@"NO"]) {
            [btnMobileVerify setHidden:NO];
            [btnMobileVerify setTitle:verifyNow forState:UIControlStateNormal];
        }
        else{
            //            [btnMobileVerify setHidden:NO];
            //            [btnMobileVerify setImage:[UIImage imageNamed:@"emailVerified"] forState:UIControlStateNormal];
            //            [btnMobileVerify setHidden:YES];
            //            [btnMobileVerify setEnabled:NO];
            //            [mobileVerifiedImg setHidden:NO];
            //             mobileVerifiedImg.image=[UIImage imageNamed:@"emailVerified"];
            [btnMobileVerify setEnabled:NO];
            [mobileVerifiedImg setHidden:YES];
        }
        if ([userEmail isEqual:[NSNull null]] || [userEmail isEqualToString:@""])
        {
            // [txtEmail setPlaceholder:@"Not Available"];
            [btnEmailVerify setHidden:YES];
        }
        else
        {
            NSUserDefaults *emailDefaults=[NSUserDefaults standardUserDefaults];
            [emailDefaults setObject:userEmail forKey:@"email"];
            [emailDefaults setObject:userTypeId forKey:@"usertypeid"];
            txtEmail.text=userEmail;
            [btnEmailVerify setHidden:NO];
            [emailVerifiedImg setHidden:YES];
            if ([userEmailVerify isEqualToString:@"NO"])
            {
                [btnEmailVerify setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnEmailVerify setTitle:verifyNow forState:UIControlStateNormal];
                btnEmailVerify.layer.cornerRadius=8.0f;
            }
            else
            {
                //                [btnEmailVerify setEnabled:NO];
                //                [btnEmailVerify setHidden:YES];
                //                [emailVerifiedImg setHidden:NO];
                //                emailVerifiedImg.image=[UIImage imageNamed:@"emailVerified"];
                [btnEmailVerify setHidden:YES];
                [emailVerifiedImg setHidden:YES];
            }
        }
        txtCompanyName.text=userCompanyName;
        txtDepartment.text=userDepartment;
        if ([userEmpId isEqual:[NSNull null]])
        {
            // [txtEmployeeID setPlaceholder:@"Not Available"];
        }
        else
        {
            txtEmployeeID.text=userEmpId;
        }
    }];
}

#pragma mark - Get All Departments
-(void)getAllDepartmensForUserCompany
{
    [[APIManager sharedInstance]getAllDepartmentsWithCompanyId:companyId andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *departmentType = [data objectForKey:@"department"];
        arrDepartmentId=[departmentType valueForKey:@"id"];
        arrDepartmentName=[departmentType valueForKey:@"name"];
    }];
}

#pragma mark -Profile pic Button Tapped
- (IBAction)btnProfileTapped:(id)sender {
    [self.view endEditing:YES];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil message:nil
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* button0 = [UIAlertAction
                                  actionWithTitle:Cancel
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action){
                                  }];
        UIAlertAction* button1 = [UIAlertAction
                                  actionWithTitle:camera
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self cameraClick];                                  }];
        UIAlertAction* button2 = [UIAlertAction
                                  actionWithTitle:gallery
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
    else if(status == AVAuthorizationStatusDenied){
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:appSettingsAlert preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:Ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:Cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
                                          actionWithTitle:Cancel
                                          style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction * action){
                                          }];
                UIAlertAction* button1 = [UIAlertAction
                                          actionWithTitle:camera
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [self cameraClick];
                                          }];
                UIAlertAction* button2 = [UIAlertAction
                                          actionWithTitle:gallery
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

#pragma mark - Profile Image Button Tapped
-(void)cameraClick{
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
    profilePicker.modalPresentationStyle = UIModalPresentationPopover;
    profilePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    profilePicker.allowsEditing = NO;
    profilePicker.delegate = self;
  //  profilePicker.preferredContentSize = CGSizeMake(512,512);
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
   // profilePicker.preferredContentSize = CGSizeMake(512,512);
    profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:profilePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.imageCropFrame=CGRectMake(0, 0, profileImg.frame.size.width, profileImg.frame.size.height);
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
   profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
    profileImg.clipsToBounds = YES;
    profileImg.layer.borderWidth = 3.0f;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImg.image = image;
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

#pragma mark -Mobile Verify Button Tapped
- (IBAction)btnMobileVerifiedTapped:(id)sender
{
}

#pragma mark -Email Verify Button Tapped
- (IBAction)btnEmailVerifiedTapped:(id)sender
{
}

#pragma TextField Deligates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
        return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==txtUserName) {
        if ([txtUserName.text length]==0&&alertIconUserName.hidden==NO) {
            alertImgUserName.hidden=NO;
            alertLabelUserName.hidden=NO;
            alertImgComapnyName.hidden=YES;
            alertLabelCompanyName.hidden=YES;
            alertImgDepartment.hidden=YES;
            alertLabelDepartment.hidden=YES;
        }
        else{
            alertImgUserName.hidden=YES;
            alertLabelUserName.hidden=YES;
        }
    }
    if (textField==txtEmail) {
        if ([txtEmail.text length]==0&&alertIconEmail.hidden==NO) {
            alertImgEmail.hidden=NO;
            alertLabelEmail.hidden=NO;
            alertImgUserName.hidden=YES;
            alertLabelUserName.hidden=YES;
            alertImgDepartment.hidden=YES;
            alertLabelDepartment.hidden=YES;
        }
        else{
            alertImgEmail.hidden=YES;
            alertLabelEmail.hidden=YES;
        }
    }
    if (textField==txtCompanyName) {
        if ([txtCompanyName.text length]==0&&alertIconCompanyName.hidden==NO) {
            alertImgComapnyName.hidden=NO;
            alertLabelCompanyName.hidden=NO;
            alertImgUserName.hidden=YES;
            alertLabelUserName.hidden=YES;
            alertImgDepartment.hidden=YES;
            alertLabelDepartment.hidden=YES;
        }
        else{
            alertImgComapnyName.hidden=YES;
            alertLabelCompanyName.hidden=YES;
        }
    }
//    if (textField==txtDepartment) {
//        if ([txtDepartment.text length]==0 && alertIconDepartment.hidden==NO) {
//            alertImgDepartment.hidden=NO;
//            alertLabelDepartment.hidden=NO;
//            alertImgComapnyName.hidden=YES;
//            alertLabelCompanyName.hidden=YES;
//            alertImgUserName.hidden=YES;
//            alertLabelUserName.hidden=YES;
//        }
//        else{
//            alertImgDepartment.hidden=YES;
//            alertImgDepartment.hidden=YES;
//        }
//    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==txtUserName) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            alertIconUserName.hidden=YES;
            alertImgUserName.hidden=YES;
            alertLabelUserName.hidden=YES;
        }
    }
       if (textField==txtEmail) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            alertIconEmail.hidden=YES;
            alertImgEmail.hidden=YES;
            alertLabelEmail.hidden=YES;
        }
    }
    if (textField==txtCompanyName) {
        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([str length]>0) {
            alertIconCompanyName.hidden=YES;
            alertImgComapnyName.hidden=YES;
            alertLabelCompanyName.hidden=YES;
        }
    }
//    if (textField==txtDepartment) {
//        NSString *str=[textField.text stringByReplacingCharactersInRange:range withString:string];
//        if ([str length]>0) {
//            alertIconDepartment.hidden=YES;
//            alertImgDepartment.hidden=YES;
//            alertLabelDepartment.hidden=YES;
//        }
//    }
    return YES;
}

#pragma mark -Update Profile Button Tapped
- (IBAction)btnUpdateProfileTapped:(id)sender {
    [self.view endEditing:YES];

  
    if ([txtUserName.text length]==0) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:[Language FullNamecannotbeempty] closeButtonTitle:[Language Cancel] duration:0.0f];
        
        
        [txtUserName becomeFirstResponder];
        return;
    }
    if ([txtEmail.text length]>0) {
        if (![Utility validateEmail:txtEmail.text]) {
         
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:[Language InvalidEmail] closeButtonTitle:[Language ok] duration:0.0f];
            
            [txtEmail becomeFirstResponder];
            return;
        }
    }
         //Storing the inputs into User Model
    User *user = [[User alloc] init];
    user.userId=strUserId;
    user.userName = txtUserName.text;
    user.usertelCode=userTelcode;
    user.userPhoneNumber=userMobileNo;
    user.userEmail = txtEmail.text;
    //    user.userCompany = txtCompanyName.text;
    //    user.userDepartment=txtDepartment.text;
    user.userCompany =companyId;
    user.userDepartment=departmentId;
    user.userEmpId=txtEmployeeID.text;
    // [Utility showLoading:self];
    backGroundView.hidden=NO;
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]updateUserProfile:user andWithProfileImage:chosenImage andCompleteBlock:^(BOOL success, id result) {
        //        [Utility hideLoading:self];
        backGroundView.hidden=YES;
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
        NSDictionary *userDict = [data objectForKey:@"userdata"];
        NSString *errorMsg=[result valueForKey:@"message"];
        NSString *userId,*userName1,*userTelcode1,*userMobileNo1,*userEmail1,*userType1,*userTypeId1,*userProfilePic1,*userMobVerifyStatus1,*userActive1,*userDeptId;
        userId=[userDict valueForKey:@"id"];
        userName1=[userDict valueForKey:@"username"];
        userTelcode1=[userDict valueForKey:@"telcode"];
        userMobileNo1=[userDict valueForKey:@"phone"];
        userEmail1=[userDict valueForKey:@"email"];
        userType1=[userDict valueForKey:@"usertype"];
        userTypeId1=[userDict valueForKey:@"usertype_id"];
        userProfilePic1=[userDict valueForKey:@"photo_user"];
        userMobVerifyStatus1=[userDict valueForKey:@"mobile_verify"];
        userActive1=[userDict valueForKey:@"active"];
        userDeptId=[userDict valueForKey:@"department_id"];
        if ([userMobVerifyStatus1 isEqualToString:@"YES"]) {
            
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert addButton:[Language ok] actionBlock:^(void)
             {
                 NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:userId forKey:@"id"];
                 [userDefaults setObject:userName1 forKey:@"name"];
                 [userDefaults setObject:userType1 forKey:@"usertype"];
                 [userDefaults setObject:userTypeId1 forKey:@"usertypeid"];
                 [userDefaults setObject:userTelcode1 forKey:@"telcode"];
                 [userDefaults setObject:userMobileNo1 forKey:@"phone"];
                 [userDefaults setObject:userDeptId forKey:@"deptid"];
                 if ([userEmail1 isEqual:[NSNull null]]) {
                     [userDefaults setObject:@"" forKey:@"email"];
                 }else{
                     [userDefaults setObject:userEmail1 forKey:@"email"];
                 }
                 if ([userProfilePic1 isEqual:[NSNull null]]) {
                     [userDefaults setObject:@"" forKey:@"profileimage"];
                 }else{
                     [userDefaults setObject:userProfilePic1 forKey:@"profileimage"];
                 }
                 [userDefaults synchronize];
                 RootViewController *homeView=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                 [self presentViewController:homeView animated:YES completion:nil];
                 
             }
             ];
            [alert showSuccess:AppName subTitle:errorMsg closeButtonTitle:[Language Cancel] duration:0.0f];
            
               }
        else{
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:errorMsg closeButtonTitle:[Language ok] duration:0.0f];
            
           
            return;
        }
    }];
}

#pragma mark - Back Button Tapped
- (IBAction)btnNavigationBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Deparment Button Tapped
- (IBAction)btnDepartmentTapped:(id)sender {
    [self.view endEditing:YES];
    NSInteger selectSubCatType;
    selectSubCatType=0;
    if ([arrDepartmentName count]==0) {
        return;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"Select Department"
                                            rows:arrDepartmentName
                                initialSelection:selectSubCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           txtDepartment.text = selectedValue;
                                           departmentId=[arrDepartmentId objectAtIndex:selectedIndex];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"emailverify"]) {
        EmailVerificationViewController *destViewController = segue.destinationViewController;
        destViewController.editEmail =txtEmail.text;
    }
}

@end
