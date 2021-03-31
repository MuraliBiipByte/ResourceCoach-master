
//  CreateArticleWithVideoViewController.m
//  SMILES
//
//  Created by Biipmi on 27/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "CreateArticleWithVideoViewController.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "Utility.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "JVFloatLabeledTextView.h"
#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"
#import "ActionSheetPicker.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "QuizCreationViewController.h"
#import "HYCircleLoadingView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YTPlayerView.h"
#import "AKTagsDefines.h"
#import "AKTagsInputView.h"
#import "Language.h"
#import "ViewController.h"
#import "RootViewController.h"
#import "SCLAlertView.h"
@interface CreateArticleWithVideoViewController ()<UITextFieldDelegate,ELCImagePickerControllerDelegate,  UIImagePickerControllerDelegate,UINavigationBarDelegate,UITextViewDelegate,YTPlayerViewDelegate,UITextViewDelegate>
{
     NSArray *arrCatId,*arrCatName,*arrCatParentId,*arrSubCatId,*arrSubCatName,*arrSubCatParentId;
    NSString *userId;
    NSString *strCatId,*strSubCatId;
    NSURL *imgURL;
    NSData *urlData;
    IBOutlet UIView *youTubeUrlView;
    __weak IBOutlet UIScrollView *scrollview;
    __weak IBOutlet UIView *subView;
    __weak IBOutlet UIImageView *articleVIDEOIMG;
    __weak IBOutlet UIButton *btnClearVideo;
    __weak IBOutlet UIButton *btnVideo;
    __weak IBOutlet UITextField *txtArticleTitle;
   // __weak IBOutlet UITextView *txtArticleShortDescription;
    __weak IBOutlet JVFloatLabeledTextView *txtArticleShortDescription;
   // __weak IBOutlet UITextView *txtArticleDescription;
    __weak IBOutlet JVFloatLabeledTextView *txtArticleDescription;
    __weak IBOutlet UITextField *txtCategorieName;
    __weak IBOutlet UITextField *txtSubCategory;
    __weak IBOutlet UIButton *btnSubCat;
    __weak IBOutlet UIButton *btnCat;
    __weak IBOutlet UIButton *btnCreateArticle;
    NSString *articleid;
    NSString *articlename;
    UITextField*txtYoutubeUrl;
    NSString *videoId;
    YTPlayerView *ytPlayer;
    AKTagsInputView *_tagsInputView;
    NSString *subCatIdentifier;
    NSMutableArray *arrSubSubCategoryName,*arrSubSubCategoryId,*arrSubSubChildCategory,*tags,*arrSubChildCatagory;
    NSMutableArray *arrSubSubSubCategoryName,*arrSubSubSubCategoryId,*arrSubSubSubChildCategory;
    NSString *youtubeUrl;
    NSUserDefaults *defaults;
    NSString *language1,*cancel,*camera,*gallery,*alertSettings,*Ok,*Cancel;
    NSString *selectCategory,*selectSubSubSubCategory,*selectSubSubCategory,*selectSubCategory,*shortDescriptionSizeAler,*deleteImageIfThreeImages,*pleaseUploadImage,*pleaseSelectSubCat,*noSubCatFound,*netWork,*deleteImgCaption,*chooseArticleImg,*pleaseSelectCat,*pleaseSelectSubSUbCat,*pleaseSelectSubSubSubCat,*pleaseSelectArticleTitle,*pleaseSelectArtShortDes,*pleaseSelectArtDes,*loading,*enterYouTubeLink,*chooseVideo,*pleseEnterUrl,*notValidate,*valid;
    
    __weak IBOutlet UILabel *lblUploadyoutubeUrl;
    NSString *uID,*UserType;
    
}
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation CreateArticleWithVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [btnVideo setTitle:[Language UploadVideo] forState:UIControlStateNormal];
    [btnClearVideo setTitle:[Language ClearVideo] forState:UIControlStateNormal];
    txtArticleTitle.placeholder=[Language ArticleTitle];
    txtCategorieName.placeholder=[Language SELECTCATEGORY];
    txtSubCategory.placeholder=[Language SELECTSUBCATEGORY];
    _txtSubSubCategory.placeholder=[Language SELECTSUBSUBCATEGORY];
    _txtSubSubSubCategory.placeholder=[Language SELECTSUBSUBSUBCATEGORY];
    _lblTagsTitle.text=[Language AssignedTags];
    [btnCreateArticle setTitle:[Language CreateArticle] forState:UIControlStateNormal];
    defaults=[NSUserDefaults standardUserDefaults];
    language1=[defaults valueForKey:@"language"];
    if ([language1 isEqualToString:@"2"])
    {
        txtArticleShortDescription.placeholder=[Language ShortDescription];
        txtArticleDescription.placeholder=[Language Description];
        chooseVideo=[Language ChooseVideo];
        cancel=[Language Cancel];
        camera=[Language camera];
        gallery=[Language gallary];
        alertSettings=[Language appSettings];
        Ok=[Language ok];
        pleseEnterUrl=[Language PleaseEnterUrl];
        Cancel=[Language Cancel];
        selectCategory=[Language SELECTCATEGORY];
        selectSubSubSubCategory=[Language SELECTSUBSUBSUBCATEGORY];
        selectSubSubCategory=[Language SELECTSUBSUBCATEGORY];
        shortDescriptionSizeAler=[Language ShortDescriptionmustbeatleast5characters];
        //deleteImageIfThreeImages=@"Please delete selected image, if you want add another image";
       // pleaseUploadImage=[Language please];
        selectSubCategory=[Language SELECTSUBCATEGORY];
        pleaseSelectCat=[Language SELECTCATEGORY];
        noSubCatFound=@"SUBCATEGORY မျှမတွေ့";
        netWork=[Language PleaseyourNetworkConnection];
        //deleteImgCaption=@"Delete will clear all the caption content, are you sure you want to delete this image?";
        //chooseArticleImg=@"Please Choose Article Image";
        pleaseSelectSubCat=[Language PleaseSelectSubCategory];
        pleaseSelectSubSUbCat=[Language  PleaseSelectSubSubCategory];
        pleaseSelectSubSubSubCat=[Language PleaseSelectSubSubSubCategory];
        pleaseSelectArticleTitle=[Language PleaseEnterArticleTitle];
        pleaseSelectArtShortDes=[Language PleaseEnterArticleShortDescription];
        pleaseSelectArtDes=[Language PleaseEnterArticleDescription];
        loading=[Language loading];
        enterYouTubeLink=[Language EnterYoutubeURL];
        notValidate=[Language NotValidate];
      
         valid=@"တရားဝင်သော";
    }
    else if ([language1 isEqualToString:@"3"])
    {
        
        txtArticleShortDescription.placeholder=@"တိုတောင်းသောဖော်ပြချက် (အထိ 200 ဇာတ်ကောင်)";
        txtArticleDescription.placeholder=@"ဖေါ်ပြချက်";
        chooseVideo=@"ဗီဒီယိုကိုရှေးခယျြ";
        pleseEnterUrl=@"Url ကိုထည့်သွင်းပါကျေးဇူးပြုပြီး";
        cancel=@"ဖျက်သိမ်း";
        valid=@"တရားဝင်သော";
        [_btnValidate setTitle:valid forState:UIControlStateNormal];
        [_btnCancel setTitle:cancel forState:UIControlStateNormal];
        camera=@"စံချိန်ဗီဒီယို";
        gallery=@"ပြခန်း";
        alertSettings=@"> Iphone က Settings> Privacy> ကင်မရာ ooSmiles:ooSmiles access ကိုမှသွား enable သင့်ရဲ့ Camera.To မှဝင်ရောက်ခွင့်ရှိသည်ပါဘူး";
        Ok=@"အိုကေ";
        Cancel=@"ဖျက်သိမ်း";
        selectCategory=@"အမျိုးအစားကိုရွေးပါ";
        selectSubSubSubCategory=@"Sub Sub Sub အမျိုးအစားကိုရွေးချယ်ပါ";
        selectSubSubCategory=@"Sub Sub အမျိုးအစားကိုရွေးချယ်ပါ";
        shortDescriptionSizeAler=@"က Short ဖော်ပြချက်အရွယ်အစား 200 သာဇာတ်ကောင်ဖြစ်ပါသည်";
        deleteImageIfThreeImages=@"သင်သည်အခြား image ကို add ချင်တယ်ဆိုရင်, ရွေးချယ်ထားသောပုံရိပ်ကိုဖျက်ပစ်ပေးပါ";
        pleaseUploadImage=@"Image ကို Upload လုပ်ပါကျေးဇူးပြုပြီး!";
        selectSubCategory=@"Sub အမျိုးအစားကိုရွေးချယ်ပါ";
        pleaseSelectCat=@"Category: Select လုပ်ပါကျေးဇူးပြုပြီး";
        noSubCatFound=@"SUBCATEGORY မျှမတွေ့";
        netWork=@"သင့်ရဲ့ Network ကိုချိတ်ဆက်မှု Check ပေးပါ";
        deleteImgCaption=@"လူအပေါင်းတို့သည်စာတန်းအကြောင်းအရာရှင်းလင်းလိမ့်မည်ကိုဖျက်ရမလား, သင်သည်ဤပုံရိပ်ကိုသင်ဖျက်လိုသေချာ?";
        chooseArticleImg=@"အပိုဒ်ဗီဒီယိုကိုရှေးခယျြ ကျေးဇူးပြု.";
        pleaseSelectSubCat=@"SUBCATEGORY ကို Select လုပ်ပါကျေးဇူးပြုပြီး";
        pleaseSelectSubSUbCat=@"SubSubCategory ကို Select လုပ်ပါကျေးဇူးပြုပြီး";
        pleaseSelectSubSubSubCat=@"Sub Sub SUBCATEGORY ကို Select လုပ်ပါကျေးဇူးပြုပြီး";
        pleaseSelectArticleTitle=@"အပိုဒ်ခေါင်းစဉ်ကိုရိုက်ထည့်ပေးပါ";
        pleaseSelectArtShortDes=@"အပိုဒ် Short Description Enter ကျေးဇူးပြု.";
        pleaseSelectArtDes=@"အပိုဒ်ဖျေါပွခကျြ Enter ကျေးဇူးပြု.";
        loading=@"တင်";
        enterYouTubeLink=@"တစ် youtube ကဗီဒီယို URL ကိုရိုက်ထည့်";
        notValidate=@"အတည်ပြုပြီးမဟုတ်";
        
    }
    else
    {
        txtArticleShortDescription.placeholder=@"Short Description(Up to 200 Characters)";
        txtArticleDescription.placeholder=@"Description";
        chooseVideo=@"Choose Video";
        cancel=@"Cancel";
        camera=@"Record Video";
        gallery=@"Gallery";
        alertSettings=@"ZawSMiLES does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > ZawSMiLES";
        Ok=@"ok";
        pleseEnterUrl=@"Please Enter Url";
        Cancel=@"cancel";
        selectCategory=@"Select Category";
        selectSubSubSubCategory=@"Select Sub Sub Sub Category";
        selectSubSubCategory=@"Select Sub Sub Category";
        shortDescriptionSizeAler=@"Short description size is only 200 characters";
        deleteImageIfThreeImages=@"Please delete selected image, if you want add another image";
        pleaseUploadImage=@"Please choose Article video";
        selectSubCategory=@"Select Sub Category";
        pleaseSelectCat=@"Please Select Category";
        noSubCatFound=@"No subCategories found";
        netWork=@"Please Check your Network Connection";
        deleteImgCaption=@"Delete will clear all the caption content, are you sure you want to delete this image?";
        chooseArticleImg=@"Please Choose Article Image";
        pleaseSelectSubCat=@"Please Select SubCategory";
        pleaseSelectSubSUbCat=@"Please Select SubSubCategory";
        pleaseSelectSubSubSubCat=@"Please Select Sub Sub SubCategory";
        pleaseSelectArticleTitle=@" Please Enter Article Title";
        pleaseSelectArtShortDes=@"Please Enter Article Short Description";
        pleaseSelectArtDes=@" Please Enter Article Description";
        loading=@"loading";
        enterYouTubeLink=@"Enter a youtube video URL";
        notValidate=@"Not Validate";
        valid=@"Valid";
    }
    
    _lblValidOrNot.text=[Language EnterYoutubeURL];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:loading];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [[_tagsview layer] setBorderWidth:1.0f];
    [[_tagsview layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    _tagsview.layer.cornerRadius=5;
    [[btnCat layer] setBorderWidth:1.0f];
   // [[btnCat layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    
    lblUploadyoutubeUrl.text=[Language UPLOADYOUTUBEURL];
    btnCat.layer.cornerRadius=5;
    [[btnSubCat layer] setBorderWidth:1.0f];
    //[[btnSubCat layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    btnSubCat.layer.cornerRadius=5;
    [[_btnSubSubCategory layer]setBorderWidth:1.0f];
    [[_btnSubSubCategory layer]setBorderColor:[UIColor darkGrayColor].CGColor];
    _btnSubSubCategory.layer.cornerRadius=5;
    [[_btnSubSubSubCategory layer]setBorderWidth:1.0f];
    [[_btnSubSubSubCategory layer]setBorderColor:[UIColor darkGrayColor].CGColor];
    _btnSubSubSubCategory.layer.cornerRadius=5;
    _btnSubSubCategory.hidden=YES;
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubCategory.hidden=YES;
    _txtSubSubSubCategory.hidden=YES;
    btnClearVideo.hidden=YES;
    btnCreateArticle.layer.cornerRadius=5.0f;
    arrCatId=[[NSArray alloc] init];
    arrCatName=[[NSArray alloc] init];
    arrSubCatId=[[NSArray alloc] init];
    arrSubCatName=[[NSArray alloc] init];
    arrCatParentId=[[NSArray alloc] init];
    arrSubCatParentId=[[NSArray alloc] init];
    tags=[[NSMutableArray alloc]init];
NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    self.videoController = [[MPMoviePlayerController alloc] init];
    [self getAllCategories];
    [btnClearVideo setHidden:YES];
    //v 2.0
    [youTubeUrlView setHidden:YES];
    self.youtubeSubView.layer.cornerRadius=5.0f;
    self.btnValidate.layer.cornerRadius=5.0f;
    [[self.txtSubview layer] setBorderWidth:1.0f];
    [[self.txtSubview layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    self.txtSubview.layer.cornerRadius=5;
    //[self.lblValidOrNot setHidden:YES];
    _ytView.hidden=YES;
    [[self.tagsview layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    self.tagsview.layer.cornerRadius=5;
    [self.tagsview addSubview:[self createTagsInputView]];
    
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    _txtSubSubConstraints.constant=0.0f;
    _txtSubSubConstraints.active=YES;
    
    _btnSubSUbSUbConstraints.constant=0.0f;
    _btnSubSUbSUbConstraints.active=YES;
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
    
    int hightCreateBtn=articleVIDEOIMG.frame.size.height+btnVideo.frame.size.height+txtArticleTitle.frame.size.height+txtArticleShortDescription.frame.size.height+txtArticleDescription.frame.size.height+_lblTagsTitle.frame.size.height+_tagsInputView.frame.size.height+txtCategorieName.frame.size.height+txtSubCategory.frame.size.height+50;
    
    btnCreateArticle.frame=CGRectMake(8, hightCreateBtn, self.view.frame.size.width-16, 40);



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
        if (!success)
        {
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
    
}

#pragma mak - Get All Categories
-(void)getAllCategories{
//  //  [Utility showLoading:self];
//    [self.loadingView startAnimation];
//    [self.loadingView setHidden:NO];
//    [self.img setHidden:NO];
//    [[APIManager sharedInstance]getAllCategories:^(BOOL success, id result) {
//       // [Utility hideLoading:self];
//        [self.loadingView stopAnimation];
//        [self.loadingView setHidden:YES];
//        [self.img setHidden:YES];
//        if (!success) {
//            return ;
//        }
//        NSDictionary *data = [result objectForKey:@"data"];
//        NSMutableArray *categoryType = [data objectForKey:@"categories"];
//        arrCatName=[categoryType valueForKey:@"name"];
//        arrCatParentId=[categoryType valueForKey:@"parent_id"];
//        arrCatId=[categoryType valueForKey:@"id"];
//    }];
}

#pragma mak - Get All Sub Categories
-(void)getAllSubCategories{
    txtSubCategory.text=@"";
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    //[Utility showLoading:self];
    [[APIManager sharedInstance]getAllSucbcategoriesWithCatId:strCatId andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *subCategoryType = [data objectForKey:@"subcategories"];
        arrSubChildCatagory=[subCategoryType valueForKey:@"child_cat"];
        arrSubCatId=[subCategoryType valueForKey:@"id"];
        arrSubCatName=[subCategoryType valueForKey:@"name"];
        arrSubCatParentId=[subCategoryType valueForKey:@"parent_id"];
    }];
}
#pragma mak - Get All Sub Sub Categories
-(void)getAllSubSubCategories{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    //[Utility showLoading:self];
    [[APIManager sharedInstance]getAllSucbcategoriesWithCatId:strCatId andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *subCategoryType = [data objectForKey:@"subcategories"];
        arrSubSubChildCategory=[subCategoryType valueForKey:@"child_cat"];
        arrSubSubCategoryId=[subCategoryType valueForKey:@"id"];
        arrSubSubCategoryName=[subCategoryType valueForKey:@"name"];
        //arrSubCatParentId=[subCategoryType valueForKey:@"parent_id"];
    }];
}
#pragma mak - Get All Sub Sub Sub Categories
-(void)getAllSubSubSubCategories{
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    //[Utility showLoading:self];
    [[APIManager sharedInstance]getAllSucbcategoriesWithCatId:strCatId andCompleteBlock:^(BOOL success, id result) {
        //  [Utility hideLoading:self];
        [self.loadingView stopAnimation];
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success) {
            return ;
        }
        NSDictionary *data = [result objectForKey:@"data"];
        NSMutableArray *subCategoryType = [data objectForKey:@"subcategories"];
        arrSubSubSubChildCategory=[subCategoryType valueForKey:@"child_cat"];
        arrSubSubSubCategoryId=[subCategoryType valueForKey:@"id"];
        arrSubSubSubCategoryName=[subCategoryType valueForKey:@"name"];
        //arrSubCatParentId=[subCategoryType valueForKey:@"parent_id"];
    }];
}
#pragma  mark - Create Article with Video
-(void)createArticleWithVideoUpload
{
    if ([txtArticleTitle.text length]==0) {
        //  [Utility showAlert:AppName withMessage:pleaseSelectArticleTitle];
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectArticleTitle closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [txtArticleTitle becomeFirstResponder];
        return;
    }
    if ([txtArticleShortDescription.text length]==0) {
        // [Utility showAlert:AppName withMessage:pleaseSelectArtShortDes];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
    [alert showSuccess:AppName subTitle:pleaseSelectArtShortDes closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [txtArticleShortDescription becomeFirstResponder];
        return;
    }
    if ([txtArticleDescription.text length]==0) {
        //[Utility showAlert:AppName withMessage:pleaseSelectArtDes];
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectArtDes closeButtonTitle:[Language ok] duration:0.0f];
        
        
        [txtArticleDescription becomeFirstResponder];
        return;
    }
    if ([txtCategorieName.text length]==0) {
        //[Utility showAlert:AppName withMessage:pleaseSelectCat];
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectCat closeButtonTitle:[Language ok] duration:0.0f];
        
        // [txtCategorieName becomeFirstResponder];
        return;
    }
    if ([txtSubCategory.text length]==0) {
        // [Utility showAlert:AppName withMessage:pleaseSelectSubCat];
        
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectSubCat closeButtonTitle:[Language ok] duration:0.0f];
        
        [txtSubCategory becomeFirstResponder];
        return;
    }
    if (_txtSubSubCategory.hidden==NO &&[_txtSubSubCategory.text isEqualToString:@""]) {
        // [Utility showAlert:AppName withMessage:pleaseSelectSubSUbCat];
        
        
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        [alert showSuccess:AppName subTitle:pleaseSelectSubSUbCat closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [_txtSubSubCategory becomeFirstResponder];
        return;
    }
    if (_txtSubSubSubCategory.hidden==NO &&[_txtSubSubSubCategory.text isEqualToString:@""]) {
        // [Utility showAlert:AppName withMessage:pleaseSelectSubSubSubCat];
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectSubSubSubCat closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [_txtSubSubSubCategory becomeFirstResponder];
        return;
    }
    
    NSString *lang=[UITextInputMode currentInputMode].primaryLanguage;
    NSArray *arr = [lang componentsSeparatedByString:@"-"];
    NSString *strLanguage ;
    NSString *strLanguage1 = [arr objectAtIndex:0];
    if ([strLanguage1 isEqualToString:@"my"]) {
        strLanguage = strLanguage1;
    }
    //    else if ([strLanguage1 isEqualToString:@"my"]){
    //        strLanguage = strLanguage1;
    //    }
    else{
        strLanguage=@"en";
    }
    
    if (urlData) {
        [Utility showLoading:self];
        //        [self.loadingView startAnimation];
        //        [self.loadingView setHidden:NO];
        //        [self.img setHidden:NO];
        //        [[APIManager sharedInstance]createArticleWithBrowseVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:urlData andTags:_tagsInputView.selectedTags andWithLink:@"" andCompleteBlock:^(BOOL success, id result) {
        ////            <#code#>
        ////        }]
        ////
        ////
        [[APIManager sharedInstance]createArticleWithBrowseVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:urlData andTags:_tagsInputView.selectedTags andWithLink:@"" andWithLanguage:strLanguage andCompleteBlock:^(BOOL success, id result) {
            //            [self.loadingView stopAnimation];
            //            [self.loadingView setHidden:YES];
            //            [self.img setHidden:YES];
            [Utility hideLoading:self];
            if (!success) {
                //[Utility showAlert:AppName withMessage:result];
                
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                
                [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
                
                
                
                return ;
            }
            NSString *message = [result objectForKey:@"message"];
            NSMutableDictionary *data=[result valueForKey:@"data"];
            articleid=[data valueForKey:@"article_id"];
            articlename=[data valueForKey:@"article_name"];
        NSInteger status = [[result objectForKey:@"status"] intValue];
            if (status==1)
            {
                
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                [alert addButton:[Language ok] actionBlock:^(void)
                 {
                     QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                     home.articleId=articleid;
                     home.articleName=articlename;
                     //navigationController.viewControllers=@[home];
                     //                    [self.frostedViewController hideMenuViewController];
                     //                    self.frostedViewController.contentViewController = navigationController;
                     [self.navigationController pushViewController:home animated:YES];
                     
                     
                 }
                 ];
                [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language Cancel] duration:0.0f];
                
                
                
                
                
                
                //                RIButtonItem *okItem = [RIButtonItem itemWithLabel:Ok action:^{
                //                    //   NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
                //                    QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                //                    home.articleId=articleid;
                //                    home.articleName=articlename;
                //                    //navigationController.viewControllers=@[home];
                //                    //                    [self.frostedViewController hideMenuViewController];
                //                    //                    self.frostedViewController.contentViewController = navigationController;
                //                    [self.navigationController pushViewController:home animated:YES];
                //                }];
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
                //                [alertView show];
            }
            
        }];
        
        //        [[APIManager sharedInstance]createArticleWithBrowseVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:urlData andCompleteBlock:^(BOOL success, id result) {
        //           // [Utility hideLoading:self];
        //            [self.loadingView stopAnimation];
        //            [self.loadingView setHidden:YES];
        //            [self.img setHidden:YES];
        //            if (!success) {
        //                [Utility showAlert:AppName withMessage:result];
        //                return ;
        //            }
        //            NSString *message = [result objectForKey:@"message"];
        //            NSMutableDictionary *data=[result valueForKey:@"data"];
        //            articleid=[data valueForKey:@"article_id"];
        //            articlename=[data valueForKey:@"article_name"];
        //            NSInteger status = [[result objectForKey:@"status"] intValue];
        //            if (status==1) {
        //                RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"OK" action:^{
        ////   NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        //                    QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
        //                    home.articleId=articleid;
        //                    home.articleName=articlename;
        ////                    navigationController.viewControllers=@[home];
        ////                    [self.frostedViewController hideMenuViewController];
        ////                    self.frostedViewController.contentViewController = navigationController;
        //                    [self.navigationController pushViewController:home animated:YES];
        //                }];
        //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
        //                [alertView show];
        //            }
        //        }];
    }
    else if (youtubeUrl){
        
        //        NSLog(@"youtube");
        //        if ([youtubeUrl isEqualToString:@""]) {
        //            [Utility showAlert:AppName withMessage:@"Invalid URL"];
        //            return;
        //        }
        [Utility showLoading:self];
        
        //        [[APIManager sharedInstance]createArticleWithYoutubeVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:urlData andTags:_tagsInputView.selectedTags andWithYoutube:youtubeUrl andCompleteBlock:^(BOOL success, id result) {
        //            <#code#>
        //        }]
        //
        //
        [[APIManager sharedInstance]createArticleWithYoutubeVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:urlData andTags:_tagsInputView.selectedTags andWithYoutube:youtubeUrl andWithLanguage:strLanguage andCompleteBlock:^(BOOL success, id result) {
            //            [self.loadingView stopAnimation];
            //            [self.loadingView setHidden:YES];
            //            [self.img setHidden:YES];
            [Utility hideLoading:self];
            if (!success) {
                // [Utility showAlert:AppName withMessage:result];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                
                [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
                
                
                
                
                return ;
            }
            NSString *message = [result objectForKey:@"message"];
            NSMutableDictionary *data=[result valueForKey:@"data"];
            articleid=[data valueForKey:@"article_id"];
            articlename=[data valueForKey:@"article_name"];
            NSInteger status = [[result objectForKey:@"status"] intValue];
            if (status==1) {
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                [alert addButton:[Language ok] actionBlock:^(void)
                 {
                     QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                     home.articleId=articleid;
                     home.articleName=articlename;
                     //navigationController.viewControllers=@[home];
                     //                    [self.frostedViewController hideMenuViewController];
                     //                    self.frostedViewController.contentViewController = navigationController;
                     [self.navigationController pushViewController:home animated:YES];
                     
                     
                 }
                 ];
                [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language Cancel] duration:0.0f];
                
                
                
                //
                //
                //                RIButtonItem *okItem = [RIButtonItem itemWithLabel:Ok action:^{
                //                    // NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
                //                    QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                //                    home.articleId=articleid;
                //                    home.articleName=articlename;
                //                    //                    navigationController.viewControllers=@[home];
                //                    //                    [self.frostedViewController hideMenuViewController];
                //                    //                    self.frostedViewController.contentViewController = navigationController;
                //                    [self.navigationController pushViewController:home animated:YES];
                //                }];
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
                //                [alertView show];
            }
        }];
    }
    else {
        [Utility showLoading:self];
        //        [self.loadingView startAnimation];
        //        [self.loadingView setHidden:NO];
        //        [self.img setHidden:NO];
        
        //        [[APIManager sharedInstance]createArticleWithVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:imgURL andWithTags:_tagsInputView.selectedTags andWithLink:@"" andCompleteBlock:^(BOOL success, id result) {
        //            <#code#>
        //        }]
        //
        [[APIManager sharedInstance]createArticleWithVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:imgURL andWithTags:_tagsInputView.selectedTags andWithLink:@"" andWithLanguage:strLanguage andCompleteBlock:^(BOOL success, id result) {
            [Utility hideLoading:self];
            //            [self.loadingView stopAnimation];
            //            [self.loadingView setHidden:YES];
            //            [self.img setHidden:YES];
            if (!success) {
                // [Utility showAlert:AppName withMessage:result];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                
                [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
                
                
                
                
                
                return ;
            }
            NSString *message = [result objectForKey:@"message"];
            NSMutableDictionary *data=[result valueForKey:@"data"];
            articleid=[data valueForKey:@"article_id"];
            articlename=[data valueForKey:@"article_name"];
            NSInteger status = [[result objectForKey:@"status"] intValue];
            if (status==1) {
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setHorizontalButtons:YES];
                [alert addButton:[Language ok] actionBlock:^(void)
                 {
                     QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                     home.articleId=articleid;
                     home.articleName=articlename;
                     //navigationController.viewControllers=@[home];
                     //                    [self.frostedViewController hideMenuViewController];
                     //                    self.frostedViewController.contentViewController = navigationController;
                     [self.navigationController pushViewController:home animated:YES];
                     
                     
                 }
                 ];
                [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language Cancel] duration:0.0f];
                
                
                
                
                
                //                RIButtonItem *okItem = [RIButtonItem itemWithLabel:Ok action:^{
                //                    // NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
                //                    QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                //                    home.articleId=articleid;
                //                    home.articleName=articlename;
                //                    //                    navigationController.viewControllers=@[home];
                //                    //                    [self.frostedViewController hideMenuViewController];
                //                    //                    self.frostedViewController.contentViewController = navigationController;
                //                    [self.navigationController pushViewController:home animated:YES];
                //                }];
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
                //                [alertView show];
            }
            
        }];
        
        //        [[APIManager sharedInstance]createArticleWithVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:imgURL andCompleteBlock:^(BOOL success, id result) {
        //           // [Utility hideLoading:self];
        //            [self.loadingView stopAnimation];
        //            [self.loadingView setHidden:YES];
        //            [self.img setHidden:YES];
        //            if (!success) {
        //                [Utility showAlert:AppName withMessage:result];
        //                return ;
        //            }
        //            NSString *message = [result objectForKey:@"message"];
        //            NSMutableDictionary *data=[result valueForKey:@"data"];
        //            articleid=[data valueForKey:@"article_id"];
        //            articlename=[data valueForKey:@"article_name"];
        //            NSInteger status = [[result objectForKey:@"status"] intValue];
        //            if (status==1) {
        //                RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"OK" action:^{
        //// NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        //                    QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
        //                    home.articleId=articleid;
        //                    home.articleName=articlename;
        ////                    navigationController.viewControllers=@[home];
        ////                    [self.frostedViewController hideMenuViewController];
        ////                    self.frostedViewController.contentViewController = navigationController;
        //                   [self.navigationController pushViewController:home animated:YES];
        //                }];
        //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
        //                [alertView show];
        //            }
        //        }];
    }
}

#pragma mark -Clear Video Button Tapped
- (IBAction)btnClearVideoTaapped:(id)sender
{
    if (_ytView.hidden==NO) {
        [_ytView stopVideo];
        _ytView.hidden=YES;
        videoId=@"";
         btnClearVideo.hidden=YES;
        btnVideo.hidden=NO;
        _textViewYoutubeUrl.text=@"";
        self.lblValidOrNot.text=@"";
    }
   [self.videoController stop];
    [self.videoController.view setHidden:YES];
    btnClearVideo.hidden=YES;
    btnVideo.hidden=NO;
}

#pragma mark -Article Video Button Tapped
- (IBAction)btnVideoTapped:(id)sender {
    [self.videoController.view setHidden:YES];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:chooseVideo preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancel1 = [UIAlertAction
                              actionWithTitle:Cancel
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action){
                              }];
    UIAlertAction *camera1=[UIAlertAction actionWithTitle:camera style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.videoController.view setHidden:NO];
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        picker.delegate=self;
        picker.allowsEditing=YES;
        [picker setVideoMaximumDuration:180];
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *gallery1=[UIAlertAction actionWithTitle:gallery style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        elcPicker.maximumImagesCount = 1;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        elcPicker.onOrder = YES;
        elcPicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        elcPicker.imagePickerDelegate = self;
        [self presentViewController:elcPicker animated:YES completion:nil];
    }];
//Adding youTube URl Alert (v.2.0)
    UIAlertAction *youTubeUrl=[UIAlertAction actionWithTitle:enterYouTubeLink style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [scrollview setHidden:YES];
        [youTubeUrlView setHidden:NO];
       
    }];
    [alert addAction:cancel1];
    [alert addAction:camera1];
    [alert addAction:gallery1];
    [alert addAction:youTubeUrl];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -Category Button Tapped
- (IBAction)btnCategoryTapped:(id)sender
{
    [self.view endEditing:YES];
    
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    _txtSubSubConstraints.constant=0.0f;
    _txtSubSubConstraints.active=YES;
    
    _btnSubSUbSUbConstraints.constant=0.0f;
    _btnSubSUbSUbConstraints.active=YES;
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
    
    
    _btnSubSubCategory.hidden=YES;
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubCategory.text=@"";
    _txtSubSubSubCategory.text=@"";
    _txtSubSubCategory.hidden=@"";
    _txtSubSubSubCategory.hidden=@"";
    txtSubCategory.text=@"";

    
        NSInteger selectedCatType;
    selectedCatType=0;
    if ([arrCatName count]==0) {
        //[Utility showAlert:AppName withMessage:@"Please check your Network Connection"];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language PleaseyourNetworkConnection] closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        return;
    }
    [ActionSheetStringPicker showPickerWithTitle:[Language SELECTCATEGORY]
                                            rows:arrCatName
                                initialSelection:selectedCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           txtCategorieName.text = selectedValue;
                                           strCatId=[arrCatId objectAtIndex:selectedIndex];
                                           [self getAllSubCategories];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker)
    {
        
        
        NSLog(@"Block Picker Canceled");
        
    }
                                          origin:sender];
    
}

#pragma mark -Subcategory Button Tapped
- (IBAction)btnSubCAtegoryTapped:(id)sender
{
    [self.view endEditing:YES];
    
    _btnSubSubCategory.hidden=YES;
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubCategory.text=@"";
    _txtSubSubSubCategory.text=@"";
    _txtSubSubCategory.hidden=@"";
    _txtSubSubSubCategory.hidden=@"";
    
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    _txtSubSubConstraints.constant=0.0f;
    _txtSubSubConstraints.active=YES;
    
    _btnSubSUbSUbConstraints.constant=0.0f;
    _btnSubSUbSUbConstraints.active=YES;
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
   
    if (arrSubCatId.count==0) {
        // [Utility showAlert:AppName withMessage:@"No subCategories found"];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:noSubCatFound closeButtonTitle:[Language ok] duration:0.0f];
        
        
        return;
    }
    if ([txtCategorieName.text isEqualToString:@""]) {
        strSubCatId=@"";
        // [Utility showAlert:AppName withMessage:@"Please Select Category"];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectCat closeButtonTitle:[Language ok] duration:0.0f];
        
        
        return;
    }
    else
    {
        NSInteger selectSubCatType;
        selectSubCatType=0;
        [ActionSheetStringPicker showPickerWithTitle:[Language SELECTSUBCATEGORY]
                                                rows:arrSubCatName
                                    initialSelection:selectSubCatType
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               txtSubCategory.text = selectedValue;
                                               strSubCatId=[arrSubCatId objectAtIndex:selectedIndex];
                                               subCatIdentifier=[arrSubChildCatagory objectAtIndex:selectedIndex];
                                               if ([subCatIdentifier isEqualToString:@"1"])
                                               {
                                                   _btnSubSubCategory.hidden=NO;
                                                   _txtSubSubCategory.hidden=NO;
                                                   _btnSubSubConstraints.constant=txtSubCategory.frame.size.height+3.0f;
                                                   _btnSubSubConstraints.active=YES;
                                                   _txtSubSubConstraints.constant=txtSubCategory.frame.size.height+3.0f;
                                                
                                                   strCatId=strSubCatId;
                                                   
                                                   [self getAllSubSubCategories];
                                               }
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker)
        {
            
            
            NSLog(@"Block Picker Canceled");
                                         }
                                              origin:sender];
    }
}
#pragma mark -SubSubcategory Button Tapped

- (IBAction)btnSubSubCAtegoryTapped:(id)sender
{
    
    
    [self.view endEditing:YES];
    
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubSubCategory.hidden=@"";
    _txtSubSubSubCategory.text=@"";
    
    _txtSubSubCategory.text=@"";
    
    
    _btnSubSUbSUbConstraints.constant=0.0f;
    _btnSubSUbSUbConstraints.active=YES;
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
    
    if (arrSubCatId.count==0)
    {
        // [Utility showAlert:AppName withMessage:@"No subCategories found"];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:noSubCatFound closeButtonTitle:[Language ok] duration:0.0f];
        
        
        return;
    }
    if ([txtCategorieName.text isEqualToString:@""])
    {
        strSubCatId=@"";
        // [Utility showAlert:AppName withMessage:@"Please Select Category"];
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectCat closeButtonTitle:[Language ok] duration:0.0f];
        
        
        return;
    }
    else
    {
        NSInteger selectSubCatType;
        selectSubCatType=0;
        [ActionSheetStringPicker showPickerWithTitle:selectSubSubCategory
                                                rows:arrSubSubCategoryName
                                    initialSelection:selectSubCatType
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               _txtSubSubCategory.text = selectedValue;
                                               strSubCatId=[arrSubSubCategoryId objectAtIndex:selectedIndex];
                                               subCatIdentifier=[arrSubSubChildCategory objectAtIndex:selectedIndex];
                                               if ([subCatIdentifier isEqualToString:@"1"])
                                               {                                                   _btnSubSubSubCategory.hidden=NO;
                                                   _txtSubSubSubCategory.hidden=NO;
                                                   _btnSubSubCategory.hidden=NO;
                                                   _txtSubSubCategory.hidden=NO;
                                                   _btnSubSUbSUbConstraints.constant=_txtSubSubCategory.frame.size.height;
                                                   _btnSubSUbSUbConstraints.active=YES;
                                                   _txtSubSubSubConstraints.constant=_txtSubSubCategory.frame.size.height;
                                                   _txtSubSubSubConstraints.active=YES;
                                                   strCatId=strSubCatId;
                                                   [self getAllSubSubSubCategories];
                                               }
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker)
         {
             
            
             
             NSLog(@"Block Picker Canceled");
             
         }
                                              origin:sender];
    }
}
#pragma mark -SubSubSubcategory Button Tapped
- (IBAction)btnSubSubSubCAtegoryTapped:(id)sender
{
   

    NSInteger selectSubCatType;
    selectSubCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:selectSubSubSubCategory
                                            rows:arrSubSubSubCategoryName
                                initialSelection:selectSubCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _txtSubSubSubCategory.text = selectedValue;
                                           strSubCatId=[arrSubSubSubCategoryId objectAtIndex:selectedIndex];
                                           subCatIdentifier=[arrSubSubSubChildCategory objectAtIndex:selectedIndex];
                                           
                                           
                                           
                                           
                                           //
                                           //                                           }
                                           //
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker)
    {
        
        NSLog(@"Block Picker Canceled");
        
                                     }
                                          origin:sender];

}

#pragma mark -Create Article Button Tapped
- (IBAction)btnCreateArticleTapped:(id)sender {
    [self.view endEditing:YES];
    [self checkUserTypeSubmit];
    
    }

-(void)checkUserTypeSubmit
{
    
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
            
            
            else{
                if (!imgURL && [urlData length]==0 && [youtubeUrl length]==0) {
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert setHorizontalButtons:YES];
                    
                    [alert showSuccess:AppName subTitle:pleaseUploadImage closeButtonTitle:[Language ok] duration:0.0f];
                    return;
                    
                }
                else{
                    [self createArticleWithVideoUpload];
                }
            }
        }
    }];
}



#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSString *mediaType1 = [info objectForKey: UIImagePickerControllerMediaType];
    if (CFStringCompare ((__bridge CFStringRef) mediaType1, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        [self.videoController.view setHidden:NO];
        btnVideo.hidden=YES;
        btnClearVideo.hidden=NO;
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        imgURL=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        NSString *moviePath = [videoUrl path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil,nil, nil);
            [self.videoController setContentURL:videoUrl];
            [self.videoController.view setFrame:CGRectMake (0, 0, scrollview.frame.size.width, 290)];
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollview.frame.size.width,articleVIDEOIMG.frame.size.height)] ;
            [scrollview addSubview:view];
            [view addSubview:self.videoController.view];
             self.videoController.fullscreen = YES;
            [self.videoController setUseApplicationAudioSession:TRUE];
            [self.videoController play];
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType]==ALAssetTypeVideo){
            [self.videoController.view setHidden:NO];
            btnVideo.hidden=YES;
            btnClearVideo.hidden=NO;
            if ([dict objectForKey:UIImagePickerControllerReferenceURL]){
                NSURL *videoUrl=(NSURL*)[dict objectForKey:UIImagePickerControllerReferenceURL];
                [self.videoController setContentURL:videoUrl];
                [self.videoController.view setFrame:CGRectMake (0, 0, scrollview.frame.size.width, 290)];
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollview.frame.size.width,articleVIDEOIMG.frame.size.height)] ;
                [scrollview addSubview:view];
                [view addSubview:self.videoController.view];
               // [articleVIDEOIMG addSubview:self.videoController.view];
//                [self.videoController setControlStyle:MPMovieControlStyleEmbedded];
                //self.videoController.shouldAutoplay = YES;
                [_videoController setUseApplicationAudioSession:TRUE];
                 self.videoController.fullscreen=YES;
                [self.videoController play];
                ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
                [assetLibrary assetForURL:[dict  valueForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset){
                     ALAssetRepresentation *rep = [asset defaultRepresentation];
                     Byte *buffer = (Byte*)malloc(rep.size);
                     NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                     urlData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                 }
                failureBlock:^(NSError *err) {
                NSLog(@"Error: %@",[err localizedDescription]);
                             }];
            }
        }
    }//for
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [_videoController.view setFrame:CGRectMake(0, 70, 320, 270)];
    } else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [_videoController.view setFrame:CGRectMake(0, 0, 480, 320)];
    }
    return YES;
}
#pragma mark - UITextField delegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField==txtArticleTitle)
    {
    NSString *str=[txtArticleTitle.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([str length]>=61)
        {
            [txtArticleTitle resignFirstResponder];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:[Language ArticleTitleAlert] closeButtonTitle:[Language ok] duration:0.0f];
            
            return NO;
        }
    }

     return YES;
}
#pragma mark - UITextview delegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView==txtArticleShortDescription)
    {
        NSString *str=[textView.text stringByReplacingCharactersInRange:range withString:text];
        
        if ([str length]>=201)
        {
            [txtArticleShortDescription resignFirstResponder];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            
            [alert showSuccess:AppName subTitle:shortDescriptionSizeAler closeButtonTitle:[Language ok] duration:0.0f];
            
            return NO;
        }
    }
    
    
    return YES;
}

//v 2.0;
#pragma mark - validate Youtrube Url

- (IBAction)btnValidateTapped:(id)sender {
    [self.view endEditing:YES];
    if ([self.textViewYoutubeUrl.text length]==0) {
        [self.lblValidOrNot setHidden:NO];
        self.lblValidOrNot.text=@"";
        // [Utility showAlert:AppName withMessage:@"Please Enter Url"];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:[Language PleaseEnterUrl] closeButtonTitle:[Language ok] duration:0.0f];
        
        
        
        [self.textViewYoutubeUrl becomeFirstResponder];
        return;
    }
    else{
        //@"https://www.youtube.com/watch?v=IPMQPeDzLJA"
        
        // https://youtu.be/dWO9uP_VJV8
        NSString *strUrl=[NSString stringWithFormat:@"%@",_textViewYoutubeUrl.text];
        NSArray* foo = [strUrl componentsSeparatedByString: @".be/"];
        NSString* firstBit = [foo objectAtIndex: 0];
        if ([firstBit isEqualToString:@"https://youtu"]) {
            videoId = [foo objectAtIndex:1];
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.textViewYoutubeUrl.text]];
            NSString *urlStr = [url absoluteString];
            if (![firstBit isEqualToString:@"https://youtu"]) {
                NSLog(@"no url");
                [self.lblValidOrNot setHidden:NO];
                _lblValidOrNot.text=[Language NotValidate];
                _lblValidOrNot.textColor=[UIColor redColor];
                [youTubeUrlView setHidden:NO];
            }
            else{
                if (videoId ==nil) {
                    NSLog(@"Wrong URL");
                }
                else{
                    [youTubeUrlView setHidden:YES];
                    [scrollview setHidden:NO];
                    [_ytView setHidden:NO];
                    _ytView.hidden=NO;
                    [self performSelector:@selector(showVideo) withObject:self afterDelay:0];
                    btnVideo.hidden=YES;
                    btnClearVideo.hidden=NO;
                    youtubeUrl=self.textViewYoutubeUrl.text;
                    [Utility showLoading:self];
                    
                }
            }
        }
        else{
            [self extractYoutubeIdFromLink:[NSString stringWithFormat:@"%@",self.textViewYoutubeUrl.text]];
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.textViewYoutubeUrl.text]];
            NSString *urlStr = [url absoluteString];
            if ([_lblValidOrNot.text isEqualToString:[Language NotValidate]]) {
                NSLog(@"no url");
                [self.lblValidOrNot setHidden:NO];
            }
            else{
                
                videoId = [urlStr substringFromIndex:[urlStr rangeOfString:@"="].location + 1];
                if (videoId ==nil) {
                    NSLog(@"Wrong URL");
                }
                else{
                    _ytView.hidden=NO;
                    [self performSelector:@selector(showVideo) withObject:self afterDelay:0];
                    btnVideo.hidden=YES;
                    btnClearVideo.hidden=NO;
                    youtubeUrl=self.textViewYoutubeUrl.text;
                    [Utility showLoading:self];
                }
            }
        }//else
    }}

#pragma mark - Custom Methods
-(void)showVideo{
    [Utility showLoading:self];
    [self playVideoWithId:videoId];
}
- (void)playVideoWithId:(NSString *)videoId {
    NSLog(@"%f",self.view.frame.size.height);
    NSDictionary *playerVars = @{
                                 @"controls" : @"1",
                                 @"playsinline" : @"1",
                                 @"autohide" : @"1",
                                 @"showinfo" : @"1",
                                 @"autoplay" : @"0",
                                 @"fs" : @"1",
                                 @"rel" : @"0",
                                 @"loop" : @"0",
                                 @"enablejsapi" : @"1",
                                 @"modestbranding" : @"1",
                                 };
    _ytView.delegate = self;
    [_ytView loadWithVideoId:videoId playerVars:playerVars];
}
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:{
            break;
        }
        case kYTPlayerStateUnstarted:
            NSLog(@"kYTPlayerStateUnstarted");
            break;
        case kYTPlayerStateBuffering:
            NSLog(@"kYTPlayerStateBuffering");
            break;
        case kYTPlayerStatePaused:{
            [ytPlayer stopVideo];
            NSLog(@"kYTPlayerStatePaused");
            break;
        }
        case kYTPlayerStateEnded:
            NSLog(@"End");
        case kYTPlayerStateQueued:
            NSLog(@"Queued");
        case kYTPlayerStateUnknown:
            NSLog(@"StateUnknown");
        default:
            NSLog(@"State %ld",(long)state);
            break;
    }
}
- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    [Utility hideLoading:self];
    NSLog(@"playerViewDidBecomeReady");
}
- (void)playerView:(YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality{
    NSLog(@"YTPlayerView : didChangeToQuality");
}
- (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error{
    [Utility hideLoading:self];
   // youtubeUrl=@"";
    NSLog(@"receivedError");
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0)
    {
        NSTextCheckingResult *result = array.firstObject;
      //  _lblUrl.text=@"Url is valid";
        _lblValidOrNot.text=valid;
        _lblValidOrNot.textColor=[UIColor greenColor];
        [self.lblValidOrNot setHidden:NO];
        [scrollview setHidden:NO];
        [_ytView setHidden:NO];
        [youTubeUrlView setHidden:YES];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
        return [link substringWithRange:result.range];
    }
    else{
       [self.lblValidOrNot setHidden:NO];
        _lblValidOrNot.text=notValidate;
        _lblValidOrNot.textColor=[UIColor redColor];
        return nil;
    }
}

- (IBAction)btnCancelTapped:(id)sender
{
    [youTubeUrlView setHidden:YES];
     [scrollview setHidden:NO];
    _textViewYoutubeUrl.text=@"";
    _lblValidOrNot.text=@"";
}


#pragma mark - This is what you are looking for:
-(AKTagsInputView*)createTagsInputView{
    _tagsInputView = [[AKTagsInputView alloc] initWithFrame:CGRectMake(0, 0.0f, CGRectGetWidth(self.tagsview.bounds), 44.0f)];
    _tagsInputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tagsInputView.enableTagsLookup = YES;
    return _tagsInputView;
}
@end
