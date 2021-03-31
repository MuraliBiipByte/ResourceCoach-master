//
//  CreateArticleWithImageViewController.m
//  SMILES
//
//  Created by Biipmi on 27/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "CreateArticleWithImageViewController.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "ActionSheetPicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "TOCropViewController.h"
#import "UIActionSheet+Blocks.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "HomeViewController.h"
#import "RootViewController.h"
#import "NavigationViewController.h"
#import "QuizCreationViewController.h"
#import "HYCircleLoadingView.h"
#import "AKTagsDefines.h"
#import "AKTagsInputView.h"
#import "TOCropToolbar.h"
#import "JVFloatLabeledTextView.h"
#import "Language.h"
#import "ViewController.h"
#import "SCLAlertView.h"
#import "RPFloatingPlaceholderTextField.h"

@interface CreateArticleWithImageViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,UITextViewDelegate>
{
    NSArray *arrCatId,*arrCatName,*arrCatParentId,*arrSubCatId,*arrSubCatName,*arrSubCatParentId;
    NSString *userId;
    NSMutableArray *selectedImages,*selectedImagesTitles;
    UIImage *uploadImage1,*uploadImage2,*uploadImage3;
    NSString *strCatId,*strSubCatId;
    __weak IBOutlet UIScrollView *scrollview;
    __weak IBOutlet UIButton *btnCategory;
    __weak IBOutlet UIImageView *articlePhoto;
    __weak IBOutlet UIButton *btnDelete;
    __weak IBOutlet UIButton *btnLeft;
    __weak IBOutlet UIButton *btnRight;
    __weak IBOutlet UIButton *btnPhoto;
    __weak IBOutlet UIButton *btnSubCategory;
    __weak IBOutlet RPFloatingPlaceholderTextField *txtArticleTitle;
 //   __weak IBOutlet UITextField *txtArticleTitle;
   // __weak IBOutlet UITextView *txtArticleShortDescription;
    __weak IBOutlet JVFloatLabeledTextView *txtArticleShortDescription;
   // __weak IBOutlet UITextView *txtArticleDescription;
    __weak IBOutlet JVFloatLabeledTextView *txtArticleDescription;
    __weak IBOutlet UITextField *txtCategorieName;
    __weak IBOutlet UITextField *txtSubCategory;
    __weak IBOutlet UIButton *btnArticleCreate;
    __weak IBOutlet UIButton *btnAddmore;
    __weak IBOutlet UILabel *lblImgTitle;
    __weak IBOutlet UILabel *lblImgTitleBackground;
    __weak IBOutlet UIView *articlesDetailView;
    __weak IBOutlet UIView *imgTitlesView;
    
    
    NSUInteger curentIndex;
    NSUInteger prevIndex;
    NSURL *imgURL;
    NSURL *videoURL;
    NSData *urlData;
    UIImage *chosenImage;
    UIImagePickerController *picker;
    NSString *vidoIdentify;
    NSString *photoIdentify;
    UITextField *txtImgCaption;
    NSString *subCatIdentifier;
    AKTagsInputView *_tagsInputView;
    NSMutableArray *arrSubSubCategoryName,*arrSubSubCategoryId,*arrSubSubChildCategory,*arrSubChildCatagory,*tags;
    NSMutableArray *arrSubSubSubCategoryName,*arrSubSubSubCategoryId,*arrSubSubSubChildCategory;
    //For language
    NSString *language1,*cancel,*camera,*gallery,*alertSettings,*Ok,*Cancel;
    NSString *selectCategory,*selectSubSubSubCategory,*selectSubSubCategory,*selectSubCategory,*shortDescriptionSizeAler,*deleteImageIfThreeImages,*pleaseUploadImage,*pleaseSelectSubCat,*noSubCatFound,*netWork,*deleteImgCaption,*chooseArticleImg,*pleaseSelectCat,*pleaseSelectSubSUbCat,*pleaseSelectSubSubSubCat,*pleaseSelectArticleTitle,*pleaseSelectArtShortDes,*pleaseSelectArtDes,*loading,*enterYouTubeLink,*chooseVideo,*pleseEnterUrl,*notValidate,*valid;
    NSString *uID,*UserType;
}
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;

@end

@implementation CreateArticleWithImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self.view addSubview:scrollview];
    [[self.assignedTagsView layer] setBorderWidth:1.0f];
    [[self.assignedTagsView layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    self.assignedTagsView.layer.cornerRadius=5;
    [self.assignedTagsView addSubview:[self createTagsInputView]];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    [[btnCategory layer] setBorderWidth:1.0f];
    [[btnCategory layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    btnCategory.layer.cornerRadius=5;
    [[btnSubCategory layer] setBorderWidth:1.0f];
    [[btnSubCategory layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    btnSubCategory.layer.cornerRadius=5;
    btnArticleCreate.layer.cornerRadius=5.0f;
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
    arrCatId=[[NSArray alloc] init];
    arrCatName=[[NSArray alloc] init];
    arrSubCatId=[[NSArray alloc] init];
    arrSubCatName=[[NSArray alloc] init];
    arrCatParentId=[[NSArray alloc] init];
    arrSubCatParentId=[[NSArray alloc] init];
    selectedImagesTitles=[[NSMutableArray alloc]init];
    arrSubChildCatagory=[[NSMutableArray alloc]init];
     arrSubSubChildCategory=[[NSMutableArray alloc]init];
     arrSubSubSubChildCategory=[[NSMutableArray alloc]init];
    tags=[[NSMutableArray alloc]init];
    arrSubSubCategoryName=[[NSMutableArray alloc]init];
    arrSubSubSubCategoryName=[[NSMutableArray alloc]init];
    arrSubSubCategoryId=[[NSMutableArray alloc]init];
    arrSubSubSubCategoryId=[[NSMutableArray alloc]init];
    [btnPhoto setTitle:[Language UploadPhoto] forState:UIControlStateNormal];
    [btnAddmore setTitle:[Language AddMorePhotos] forState:UIControlStateNormal];
    txtArticleTitle.placeholder=[Language ArticleTitle];
    txtCategorieName.placeholder=[Language SELECTCATEGORY];
    txtSubCategory.placeholder=[Language SELECTSUBCATEGORY];
    _txtSubSubCategory.placeholder=[Language SELECTSUBSUBCATEGORY];
    _txtSubSubSubCategory.placeholder=[Language SELECTSUBSUBSUBCATEGORY];
    [btnArticleCreate setTitle:[Language CreateArticle] forState:UIControlStateNormal];
    _lblTagsTitle.text=[Language AssignedTags];
    self.imageCaptionOneTextField.placeholder=[Language ImageoneCaption];
    self.imageCaptionTwoTextField.placeholder=[Language ImagetwoCaption];
    self.imageThreeCaptionTextField.placeholder=[Language ImagethreeCaption];
    self.imageOneLabel.text=[Language Image1];
    self.imageTwoLabel.text=[Language Image2];
    self.imageThreeLabel.text=[Language Image3];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userId=[userDefaults  objectForKey:@"id"];
    language1=[userDefaults objectForKey:@"language"];
    if ([language1 isEqualToString:@"2"]) {
        txtArticleShortDescription.placeholder=[Language ShortDescription];
        txtArticleDescription.placeholder=[Language Description];
        pleseEnterUrl=[Language PleaseEnterUrl];
        chooseVideo=[Language ChooseVideo];
        cancel=[Language cancel];
        camera=[Language camera];
        gallery=[Language gallary];
        alertSettings=[Language appSettings];
        Ok=[Language ok];
        Cancel=@"取消";
        selectCategory =[Language SELECTCATEGORY];
        selectSubSubSubCategory=[Language SELECTSUBSUBSUBCATEGORY];
        selectSubSubCategory=[Language SELECTSUBSUBCATEGORY];
        shortDescriptionSizeAler=[Language ShortDescriptionmustbeatleast5characters];
        deleteImageIfThreeImages=[Language Deletewillclearallthecaptioncontent];
        pleaseUploadImage=[Language UploadPhoto];
        selectSubCategory=[Language SELECTSUBCATEGORY];
        pleaseSelectCat=[Language PleaseSelectCategory];
        noSubCatFound=@"找不到子类别";
        netWork=@"请检查您的网络连接";
        deleteImgCaption=[Language Deletewillclearallthecaptioncontent];
        chooseArticleImg=[Language PleaseChooseArticleImage];
        pleaseSelectSubCat=[Language PleaseSelectSubCategory];
        pleaseSelectSubSUbCat=[Language PleaseSelectSubSubCategory];
        pleaseSelectSubSubSubCat=[Language PleaseSelectSubSubSubCategory];
        pleaseSelectArticleTitle=[Language PleaseEnterTitle];
        pleaseSelectArtShortDes=[Language PleaseEnterArticleShortDescription];
        pleaseSelectArtDes=[Language PleaseEnterDescription];
        loading=[Language loading];
        enterYouTubeLink=[Language EnterYoutubeURL];
        notValidate=[Language NotValidate];
        valid=@"有效";
    }
    else if ([language1 isEqualToString:@"3"]){
        txtArticleShortDescription.placeholder=@"တိုတောင်းသောဖော်ပြချက် (အထိ 200 ဇာတ်ကောင်)";
        txtArticleDescription.placeholder=@"ဖေါ်ပြချက်";
        chooseVideo=@"ဗီဒီယိုကိုရှေးခယျြ";
        pleseEnterUrl=@"Url ကိုထည့်သွင်းပါကျေးဇူးပြုပြီး";
        cancel=@"ဖျက်သိမ်း";
        camera=@"ကင်မရာ";
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
        pleaseSelectSubSUbCat=@"Sub Sub Category ကို Select လုပ်ပါကျေးဇူးပြုပြီး";
        pleaseSelectSubSubSubCat=@"Sub Sub Sub Category ကို Select လုပ်ပါကျေးဇူးပြုပြီး";
        pleaseSelectArticleTitle=@"အပိုဒ်ခေါင်းစဉ်ကိုရိုက်ထည့်ပေးပါ";
        pleaseSelectArtShortDes=@"အပိုဒ် Short Description Enter ကျေးဇူးပြု.";
        pleaseSelectArtDes=@"အပိုဒ်ဖျေါပွခကျြ Enter ကျေးဇူးပြု.";
        loading=@"တင်";
        enterYouTubeLink=@"တစ် youtube ကဗီဒီယို URL ကိုရိုက်ထည့်";
        notValidate=@"အတည်ပြုပြီးမဟုတ်";
        valid=@"တရားဝင်သော";
    }
    else{
        txtArticleShortDescription.placeholder=@"Short Description(Up to 200 Characters)";
        txtArticleDescription.placeholder=@"Description";
        chooseVideo=@"Choose Video";
        cancel=@"Cancel";
        camera=@"Camera";
        gallery=@"Gallery";
        alertSettings=@"ooSmiles does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera >ooSmiles";
        Ok=@"ok";
        pleseEnterUrl=@"Please Enter Url";
        Cancel=@"cancel";
        selectCategory=@"Select Category";
        selectSubSubSubCategory=@"Select Sub Sub Sub Category";
        selectSubSubCategory=@"Select Sub Sub Category";
        shortDescriptionSizeAler=@"Short description size is only 200 characters";
        deleteImageIfThreeImages=@"Please delete selected image, if you want add another image";
        pleaseUploadImage=@"Please Choose Article Image";
        selectSubCategory=@"Select Sub Category";
        pleaseSelectCat=@"Please Select Category";
        noSubCatFound=@"No subCategories found";
        netWork=@"Please Check your Network Connection";
        deleteImgCaption=@"Delete will clear all the caption content, are you sure you want to delete this image?";
        chooseArticleImg=@"Please Choose Article Image";
        pleaseSelectSubCat=@"Please Select Sub Category";
        pleaseSelectSubSUbCat=@"Please Select Sub Sub Category";
        pleaseSelectSubSubSubCat=@"Please Select Sub Sub SubCategory";
        pleaseSelectArticleTitle=@" Please Enter Article Title";
        pleaseSelectArtShortDes=@"Please Enter Article Short Description";
        pleaseSelectArtDes=@" Please Enter Article Description";
        loading=@"loading";
        enterYouTubeLink=@"Enter a youtube video URL";
        notValidate=@"Not Validate";
        valid=@"Valid";
    }
    [self getAllCategories];
    selectedImages=[[NSMutableArray alloc] init];
    btnLeft.hidden=YES;
    btnRight.hidden=YES;
    btnDelete.hidden=YES;
    [btnAddmore setHidden:YES];
    btnAddmore.layer.borderWidth=1.0f;
    lblImgTitleBackground.hidden=YES;
    _imageCaptionOneTextField.hidden=YES;
    _imageCaptionTwoTextField.hidden=YES;
    _imageThreeCaptionTextField.hidden=YES;
    _imageOneLabel.hidden=YES;
    _imageTwoLabel.hidden=YES;
    _imageThreeLabel.hidden=YES;
    
    
    
    //Setting Dynamic Hights....
    
    imgTitlesView.hidden=YES;
    _imgTiltleViewConstrant.constant=0.0f;
    _imgTiltleViewConstrant.active=YES;
    
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    
   
    _btnSubSubSubConstraints.constant=0.0f;
    _btnSubSubSubConstraints.active=YES;
    
    _txtSubSubCatConstraints.constant=0.0f;
    _txtSubSubCatConstraints.active=YES;
    
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
    
    lblImgTitleBackground.hidden=YES;
    lblImgTitle.textColor=[UIColor whiteColor];
    
    
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaultsforPlacehodercolor=[NSUserDefaults standardUserDefaults];
    [defaultsforPlacehodercolor setValue:@"CreateArticleWithImage" forKey:@"Controller"];

    
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
    
}

#pragma mak - Get All Categories
-(void)getAllCategories{
//   // [Utility showLoading:self];
//    [self.loadingView startAnimation];
//    [self.loadingView setHidden:NO];
//    [self.img setHidden:NO];
//    [[APIManager sharedInstance]getAllCategories:^(BOOL success, id result) {
//        //[Utility hideLoading:self];
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
    }];
}

#pragma mark -Create Article With Images
-(void)createArticlesWithImages
{
    
    if ([txtArticleTitle.text length]==0)
    {
        // [Utility showAlert:AppName withMessage:pleaseSelectArticleTitle];
        
        
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
    if ([txtArticleDescription.text length]==0)
    {
        // [Utility showAlert:AppName withMessage:pleaseSelectArtDes];
        
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectArtDes closeButtonTitle:[Language ok] duration:0.0f];
        
        [txtArticleDescription becomeFirstResponder];
        return;
    }
    if ([txtCategorieName.text length]==0) {
        // [Utility showAlert:AppName withMessage:pleaseSelectCat];
        
        
        
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
        
        // [txtSubCategory becomeFirstResponder];
        return;
    }
    if (_txtSubSubCategory.hidden==NO &&[_txtSubSubCategory.text isEqualToString:@""]) {
        //[Utility showAlert:AppName withMessage:pleaseSelectSubSUbCat];
        
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectSubSUbCat closeButtonTitle:[Language ok] duration:0.0f];
        
        // [_txtSubSubCategory becomeFirstResponder];
        return;
    }
    if (_txtSubSubSubCategory.hidden==NO &&[_txtSubSubSubCategory.text isEqualToString:@""]) {
        // [Utility showAlert:AppName withMessage:pleaseSelectSubSubSubCat];
        
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectSubSubSubCat closeButtonTitle:[Language ok] duration:0.0f];
        
        //[_txtSubSubSubCategory becomeFirstResponder];
        return;
    }
    
    if ([selectedImages count]==0) {
        // [Utility showAlert:AppName withMessage:chooseArticleImg];
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:chooseArticleImg closeButtonTitle:[Language ok] duration:0.0f];
        
        return;
    }
    else if ([selectedImages count]==1) {
        uploadImage1=[selectedImages objectAtIndex:0];
        uploadImage2=[UIImage imageNamed:@""];
        uploadImage3=[UIImage imageNamed:@""];
    }
    else if ([selectedImages count]==2){
        uploadImage1=[selectedImages objectAtIndex:0];
        uploadImage2=[selectedImages objectAtIndex:1];
        uploadImage3=[UIImage imageNamed:@""];
    }
    else if ([selectedImages count]==3){
        uploadImage1=[selectedImages objectAtIndex:0];
        uploadImage2=[selectedImages objectAtIndex:1];
        uploadImage3=[selectedImages objectAtIndex:2];
    }
    NSString *imgTitle1,*imgTitle2,*imgTitle3;
    if ([selectedImagesTitles count]==1) {
        imgTitle1=[selectedImagesTitles objectAtIndex:0];
        imgTitle2=@"";
        imgTitle3=@"";
    }
    else if ([selectedImagesTitles count]==2){
        imgTitle1=[selectedImagesTitles objectAtIndex:0];
        imgTitle2=[selectedImagesTitles objectAtIndex:1];
        imgTitle3=@"";
    }
    else if ([selectedImagesTitles count]==3){
        imgTitle1=[selectedImagesTitles objectAtIndex:0];
        imgTitle2=[selectedImagesTitles objectAtIndex:1];
        imgTitle3=[selectedImagesTitles objectAtIndex:2];
    }
    
    NSString *lang=[UITextInputMode currentInputMode].primaryLanguage;
    NSArray *arr = [lang componentsSeparatedByString:@"-"];
    NSString *strLanguage ;
    NSString *strLanguage1 = [arr objectAtIndex:0];
    if ([strLanguage1 isEqualToString:@"my"])
    {
        strLanguage = strLanguage1;
    }
    //    else if ([strLanguage1 isEqualToString:@"my"]){
    //        strLanguage = strLanguage1;
    //    }
    else
    {
        strLanguage=@"en";
    }
    
    //    NSString *imgTitle1=[selectedImagesTitles objectAtIndex:0];
    //    NSString *imgTitle2=[selectedImagesTitles objectAtIndex:1];
    //    NSString *imgTitle3=[selectedImagesTitles objectAtIndex:2];
    //
    //    [[APIManager sharedInstance]createArticleWithImagesUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithImage1:uploadImage1 andWithImage2:uploadImage2 andWithImage3:uploadImage3 andImgTitle1:imgTitle1 andImgTitle2:imgTitle2 andImgTitle3:imgTitle3 andTags:_tagsInputView.selectedTags andCompleteBlock:^(BOOL success, id result) {
    //        [self.loadingView stopAnimation];
    //        [self.loadingView setHidden:YES];
    [Utility showLoading:self];
    //    [self.loadingView startAnimation];
    //    [self.loadingView setHidden:NO];
    //    [self.img setHidden:NO];
    
    //    [[APIManager sharedInstance]createArticleWithImagesUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithImage1:uploadImage1 andWithImage2:uploadImage2 andWithImage3:uploadImage3 andImgTitle1:_imageCaptionOneTextField.text  andImgTitle2:_imageCaptionTwoTextField.text andImgTitle3:_imageThreeCaptionTextField.text andTags:_tagsInputView.selectedTags andCompleteBlock:^(BOOL success, id result) {
    ////        <#code#>
    ////    }]
    ////
    ////
    [[APIManager sharedInstance]createArticleWithImagesUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithImage1:uploadImage1 andWithImage2:uploadImage2 andWithImage3:uploadImage3 andImgTitle1:_imageCaptionOneTextField.text andImgTitle2:_imageCaptionTwoTextField.text andImgTitle3:_imageThreeCaptionTextField.text andTags:_tagsInputView.selectedTags andWithLanguage:strLanguage andCompleteBlock:^(BOOL success, id result)
    {
        //                [self.loadingView stopAnimation];
        //                [self.loadingView setHidden:YES];
        //                [self.img setHidden:YES];
        //
        [Utility hideLoading:self];
        if (!success)
        {
            // [Utility showAlert:AppName withMessage:result];
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:[Language ok] duration:0.0f];
            
            
            return ;
        }
        NSMutableDictionary *data=[result valueForKey:@"data"];
        NSString *articleid=[data valueForKey:@"article_id"];
        NSString *articlename=[data valueForKey:@"article_name"];
        NSString *message = [result objectForKey:@"message"];
        NSInteger status = [[result objectForKey:@"status"] intValue];
        if (status==1) {
            
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            [alert addButton:[Language ok] actionBlock:^(void)
             { //  NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
                 QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
                 home.articleId=articleid;
                 home.articleName=articlename;
                 //            navigationController.viewControllers=@[home];
                 //            [self.frostedViewController hideMenuViewController];
                 //            self.frostedViewController.contentViewController = navigationController;
                 [self.navigationController pushViewController:home animated:YES];
                 
             }
             ];
            [alert showSuccess:AppName subTitle:message closeButtonTitle:[Language Cancel] duration:0.0f];
            
            
            
            //            RIButtonItem *okItem = [RIButtonItem itemWithLabel:Ok action:^{
            //                //  NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
            //                QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
            //                home.articleId=articleid;
            //                home.articleName=articlename;
            //                //            navigationController.viewControllers=@[home];
            //                //            [self.frostedViewController hideMenuViewController];
            //                //            self.frostedViewController.contentViewController = navigationController;
            //                [self.navigationController pushViewController:home animated:YES];
            //            }];
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName
            //                                                                message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
            //            [alertView show];
        }
    }];
    //    [[APIManager sharedInstance]createArticleWithImagesUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithImage1:uploadImage1 andWithImage2:uploadImage2 andWithImage3:uploadImage3 andCompleteBlock:^(BOOL success, id result) {
    //       // [Utility hideLoading:self];
    //        [self.loadingView stopAnimation];
    //        [self.loadingView setHidden:YES];
    //        [self.img setHidden:YES];
    //        if (!success) {
    //            [Utility showAlert:AppName withMessage:result];
    //            return ;
    //        }
    //        NSMutableDictionary *data=[result valueForKey:@"data"];
    //        NSString *articleid=[data valueForKey:@"article_id"];
    //        NSString *articlename=[data valueForKey:@"article_name"];
    //        NSString *message = [result objectForKey:@"message"];
    //        NSInteger status = [[result objectForKey:@"status"] intValue];
    //        if (status==1) {
    //        RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"OK" action:^{
    //           //  NavigationViewController*navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    //            QuizCreationViewController *home=[self.storyboard instantiateViewControllerWithIdentifier:@"QuizCreationViewController"];
    //            home.articleId=articleid;
    //            home.articleName=articlename;
    ////            navigationController.viewControllers=@[home];
    ////            [self.frostedViewController hideMenuViewController];
    ////            self.frostedViewController.contentViewController = navigationController;
    //            [self.navigationController pushViewController:home animated:YES];
    //        }];
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AppName
    //            message:message cancelButtonItem:nil otherButtonItems:okItem, nil];
    //        [alertView show];
    //    }
    //    }];
}

#pragma mark - Photo Button Tapped
- (IBAction)btnPhotoTapped:(id)sender {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil message:nil
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* button0 = [UIAlertAction
                                  actionWithTitle:cancel
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
    }
    else if(status == AVAuthorizationStatusDenied){
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:alertSettings preferredStyle:UIAlertControllerStyleAlert];
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
                                          actionWithTitle:cancel
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

#pragma mark - Article Image Button Tapped
-(void)cameraClick{
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
    standardPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    standardPicker.allowsEditing = NO;
    standardPicker.delegate = self;
    [self presentViewController:standardPicker animated:YES completion:nil];
}

-(void)galleryClick{
    self.croppingStyle = TOCropViewCroppingStyleDefault;
    UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
    standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    standardPicker.allowsEditing = NO;
    standardPicker.delegate = self;
    [self presentViewController:standardPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.imageCropFrame=CGRectMake(0, 0, self.view.bounds.size.width, 230);
//adding of image title (V 2.0)
//    UIView *imgTitleView=[[UIView alloc]initWithFrame:CGRectMake(0,64, cropController.view.frame.size.width, 50)];
//    [cropController.view addSubview:imgTitleView];
//    [imgTitleView setBackgroundColor:[UIColor blackColor]];
//    txtImgCaption=[[UITextField alloc]initWithFrame:CGRectMake(8, 8, imgTitleView.frame.size.width-16, imgTitleView.frame.size.height-16)];
//    [imgTitleView addSubview:txtImgCaption];
//    [txtImgCaption setBackgroundColor:[UIColor lightGrayColor]];
//    txtImgCaption.placeholder=@"Enter Image Caption";
//    txtImgCaption.delegate=self;
//    txtImgCaption.layer.cornerRadius=5;
//    txtImgCaption.layer.masksToBounds=YES;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [txtImgCaption resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
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
    
    if (textField==self.imageCaptionOneTextField)
    {
     if(range.length + range.location > self.imageCaptionOneTextField.text.length)
     {
        return NO;
     }
     
    NSUInteger newLength = [self.imageCaptionOneTextField.text length] + [string length] - range.length;
    
    return newLength <= 20;
     
        
    }
   else if (textField==self.imageCaptionTwoTextField)
    {
        if(range.length + range.location > self.imageCaptionTwoTextField.text.length)
        {
            return NO;
        }
       
        
        NSUInteger newLength = [self.imageCaptionTwoTextField.text length] + [string length] - range.length;
        
        return newLength <= 20;
        
 
    }
    
   else if (textField==self.imageThreeCaptionTextField)
    {
        if(range.length + range.location > self.imageThreeCaptionTextField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [self.imageThreeCaptionTextField.text length] + [string length] - range.length;
        
        return newLength <= 20;
        
    }
    return YES;
}

#pragma mark - Cropper Delegate

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
    articlePhoto.image = image;
    chosenImage=image;
//    if ([txtImgCaption.text length]>0) {
//        [selectedImagesTitles addObject:txtImgCaption.text];
//        lblImgTitle.text=txtImgCaption.text;
//        if ([lblImgTitle.text isEqualToString:@""]) {
//            lblImgTitleBackground.hidden=YES;
//        }
//        else{
//            lblImgTitleBackground.hidden=NO;
//        }
//    }
//    else{
//         [selectedImagesTitles addObject:@""];
//         lblImgTitle.text=@"";
//        if ([lblImgTitle.text isEqualToString:@""]) {
//            lblImgTitleBackground.hidden=YES;
//        }
//        else{
//            lblImgTitleBackground.hidden=NO;
//        }
//    }
//    NSLog(@"Image titles %@",selectedImagesTitles);
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [selectedImages addObject:image];
    
     imgTitlesView.hidden=NO;
    lblImgTitleBackground.hidden=NO;
   // _imgTiltleViewConstrant.active=NO;
    
    
    if ([selectedImages count]==1) {
        btnLeft.hidden=YES;
        btnRight.hidden=YES;
        btnDelete.hidden=NO;
        btnPhoto.hidden=YES;
        btnAddmore.hidden=NO;
        ///IMAGE TITLES TEXT FIELDS
        _imageCaptionOneTextField.hidden=NO;
        _imageCaptionTwoTextField.hidden=YES;
        _imageThreeCaptionTextField.hidden=YES;
        _imageOneLabel.hidden=NO;
        _imageTwoLabel.hidden=YES;
        _imageThreeLabel.hidden=YES;
        _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+10.0f;
    }
    else if ([selectedImages count]==2){
        btnLeft.hidden=NO;
        btnRight.hidden=NO;
        btnDelete.hidden=NO;
        btnPhoto.hidden=YES;
        btnAddmore.hidden=NO;
        _imageCaptionOneTextField.hidden=NO;
        _imageCaptionTwoTextField.hidden=NO;
        _imageThreeCaptionTextField.hidden=YES;
        _imageOneLabel.hidden=NO;
        _imageTwoLabel.hidden=NO;
        _imageThreeLabel.hidden=YES;
        _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+self.imageCaptionTwoTextField.frame.size.height+13.0f;
    }
    else if ([selectedImages count]==3){
        btnLeft.hidden=NO;
        btnRight.hidden=NO;
        btnDelete.hidden=NO;
        btnPhoto.hidden=YES;
        btnAddmore.hidden=YES;
        _imageCaptionOneTextField.hidden=NO;
        _imageCaptionTwoTextField.hidden=NO;
        _imageThreeCaptionTextField.hidden=NO;
        _imageOneLabel.hidden=NO;
        _imageTwoLabel.hidden=NO;
        _imageThreeLabel.hidden=NO;
        
        _btnAddMoreConstraints.constant=0.0f;
        _btnAddMoreConstraints.active=YES;
        _btnPhotoConstraints.constant=0.0f;
        _btnPhotoConstraints.active=YES;
        
        _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+self.imageCaptionTwoTextField.frame.size.height+self.imageThreeCaptionTextField.frame.size.height+16.0f;
        
       
        
    }
//    if ([selectedImages count]>1) ------{
//        btnLeft.hidden=NO;
//        btnRight.hidden=NO;
//    }
//    if ([selectedImages count]>0) {
//        if ([selectedImages count]==3) {
//            btnAddmore.hidden=YES;
//            btnPhoto.hidden=YES;
//        }
//        else{
//            btnAddmore.hidden=YES;
//        }
//    }
//    //    if ([productImages count]==1) {
//    //        [btnLeft setHidden:YES];
//    //        [btnRight setHidden:YES];
//    //        [btnDelete setHidden:NO];
//    //    }else{
//    //        [btnLeft setHidden:NO];
//    //        [btnRight setHidden:NO];
//    //        [btnDelete setHidden:NO];
//    //    }
//    NSLog(@"Images count is %lu",(unsigned long)[selectedImages count]);
//    // imageView.image=[selectedImages objectAtIndex:0];
//    //    for (int i=0; i<[productImages count]; i++) {
//    //        curentIndex=i;
//    //
//    //    }
    NSLog(@"Images count is %lu",(unsigned long)[selectedImages count]);
    NSInteger i=[selectedImages count];
    lblImgTitle.text=[NSString stringWithFormat:@"%ld/3",(long)i];
    lblImgTitle.textColor=[UIColor whiteColor];
    [lblImgTitle setHidden:NO];
    
//         articlePhoto.image=[selectedImages objectAtIndex:0];
//        for (int i=0; i<[selectedImages count]; i++) {
//            curentIndex=i;
//        }
    [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - Left Rotate Button Tapped
- (IBAction)btnImageLeftRotateTapped:(id)sender {
    [self.view endEditing:YES];
    if(curentIndex == 0){
        prevIndex = [selectedImages count] - 1;
    }else{
        prevIndex = (curentIndex-1)%[selectedImages count];
    }
    articlePhoto.image = selectedImages[prevIndex];
    curentIndex = prevIndex;
//    lblImgTitleBackground.hidden=NO;
//    lblImgTitle.text=[NSString stringWithFormat:@"%@",[selectedImagesTitles objectAtIndex:curentIndex]];
}

#pragma mark - Right Rotate Button Tapped
- (IBAction)btnImageRighttapped:(id)sender {
    [self.view endEditing:YES];
    NSUInteger nextIndex = (curentIndex+1)%[selectedImages count];
    articlePhoto.image = selectedImages[nextIndex];
    curentIndex = nextIndex;
//    lblImgTitle.text=[NSString stringWithFormat:@"%@",[selectedImagesTitles objectAtIndex:curentIndex]];
//    if ([lblImgTitle.text isEqualToString:@""]) {
//        lblImgTitleBackground.hidden=YES;
//    }
//    else{
//        lblImgTitleBackground.hidden=NO;
//    }
}

#pragma mark - Delete Image Button Tapped
- (IBAction)btnImageDeleteTapped:(id)sender
{
    [self.view endEditing:YES];
    NSLog(@"%lu",(unsigned long)curentIndex);
    _btnAddMoreConstraints.constant=40.0f;
    //_btnSubSubSubConstraints.active=NO;
    
    _btnPhotoConstraints.constant=40.0f;
    _btnPhotoConstraints.active=NO;
    
    if ([_imageCaptionOneTextField.text length]>0||[_imageCaptionTwoTextField.text length]>0||[_imageThreeCaptionTextField.text length]>0) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:deleteImgCaption preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:Ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _imageThreeCaptionTextField.text=@"";
            _imageCaptionOneTextField.text=@"";
            _imageCaptionTwoTextField.text=@"";
            _imageOneLabel.hidden=YES;
            _imageTwoLabel.hidden=YES;
            _imageThreeLabel.hidden=YES;
            if ([selectedImages count]==0) {
                [btnLeft setHidden:YES];
                [btnRight setHidden:YES];
                [btnDelete setHidden:YES];
                btnPhoto.hidden=NO;
                btnAddmore.hidden=YES;
            
            }
            else{
                [selectedImages removeObjectAtIndex:curentIndex];
                //[selectedImagesTitles removeObjectAtIndex:curentIndex];
                NSLog(@"%lu",(unsigned long)curentIndex);
                ////Last image delete
                if ([selectedImages count]==0)
                {
                    [btnLeft setHidden:YES];
                    [btnRight setHidden:YES];
                    [btnDelete setHidden:YES];
                    btnPhoto.hidden=NO;
                    btnAddmore.hidden=YES;
                    articlePhoto.image=[UIImage imageNamed:@"place_holder (3).png"];
                    lblImgTitle.text=@"";
                    
                    _imageCaptionOneTextField.hidden=YES;
                    _imageCaptionTwoTextField.hidden=YES;
                    _imageThreeCaptionTextField.hidden=YES;
                    _imageOneLabel.hidden=YES;
                    _imageTwoLabel.hidden=YES;
                    _imageThreeLabel.hidden=YES;
                    _imageCaptionOneTextField.text=@"";
                    _imageCaptionTwoTextField.text=@"";
                    _imageThreeCaptionTextField.text=@"";
                    
                }
                else if ([selectedImages count]==1){
                    [btnLeft setHidden:YES];
                    [btnRight setHidden:YES];
                    [btnDelete setHidden:NO];
                    btnPhoto.hidden=YES;
                    btnAddmore.hidden=NO;
                    _imageCaptionOneTextField.hidden=NO;
                    _imageCaptionTwoTextField.hidden=YES;
                    _imageThreeCaptionTextField.hidden=YES;
                    
                    
                    _imageOneLabel.hidden=NO;
                    _imageTwoLabel.hidden=YES;
                    _imageThreeLabel.hidden=YES;
                    _imageCaptionTwoTextField.text=@"";
                    _imageThreeCaptionTextField.text=@"";
                    if (curentIndex==0) {
                        articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                       
                    }
                    else{
                        curentIndex=curentIndex-1;
                        articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                 
                    }
                    
                }
                else{
                    //Third images and delete first 1
                    btnPhoto.hidden=YES;
                    btnAddmore.hidden=NO;
                    _imageCaptionOneTextField.hidden=NO;
                    _imageCaptionTwoTextField.hidden=NO;
                    _imageThreeCaptionTextField.hidden=YES;
        
                    _imageOneLabel.hidden=NO;
                    _imageTwoLabel.hidden=NO;
                    _imageThreeLabel.hidden=YES;
                    _imageThreeCaptionTextField.text=@"";
                    if (curentIndex==0) {
                        articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                        [btnLeft setHidden:NO];
                        [btnRight setHidden:NO];
                        [btnDelete setHidden:NO];
                    }
                    else{
                        curentIndex=curentIndex-1;
                        articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                        [btnLeft setHidden:NO];
                        [btnRight setHidden:NO];
                        [btnDelete setHidden:NO];
                    }
                    
                }
            }
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:Cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        if ([selectedImages count]==0) {
            [btnLeft setHidden:YES];
            [btnRight setHidden:YES];
            [btnDelete setHidden:YES];
            lblImgTitleBackground.hidden=YES;
            [lblImgTitle setHidden:YES];
            btnPhoto.hidden=NO;
            btnAddmore.hidden=YES;
                   }
        else{
            [selectedImages removeObjectAtIndex:curentIndex];
            //[selectedImagesTitles removeObjectAtIndex:curentIndex];
            NSLog(@"%lu",(unsigned long)curentIndex);
            ////Last image delete
            if ([selectedImages count]==0) {
                [btnLeft setHidden:YES];
                [btnRight setHidden:YES];
                [btnDelete setHidden:YES];
                btnPhoto.hidden=NO;
                btnAddmore.hidden=YES;
                articlePhoto.image=[UIImage imageNamed:@"place_holder (3).png"];
                lblImgTitle.text=@"";
                _imageCaptionOneTextField.hidden=YES;
                _imageCaptionTwoTextField.hidden=YES;
                _imageThreeCaptionTextField.hidden=YES;
                _imageOneLabel.hidden=YES;
                _imageTwoLabel.hidden=YES;
                _imageThreeLabel.hidden=YES;
                _imageCaptionOneTextField.text=@"";
                _imageCaptionTwoTextField.text=@"";
                _imageThreeCaptionTextField.text=@"";
          
            }
            else if ([selectedImages count]==1){
                [btnLeft setHidden:YES];
                [btnRight setHidden:YES];
                [btnDelete setHidden:NO];
                btnPhoto.hidden=YES;
                btnAddmore.hidden=NO;
                _imageCaptionOneTextField.hidden=NO;
                _imageCaptionTwoTextField.hidden=YES;
                _imageThreeCaptionTextField.hidden=YES;
                _imageOneLabel.hidden=NO;
                _imageTwoLabel.hidden=YES;
                _imageThreeLabel.hidden=YES;
                _imageCaptionTwoTextField.text=@"";
                _imageThreeCaptionTextField.text=@"";
                if (curentIndex==0) {
                    articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                                   }
                else{
                    curentIndex=curentIndex-1;
                    articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                 
                }
            }
            else{
                //Third images and delete first 1
                btnPhoto.hidden=YES;
                btnAddmore.hidden=NO;
                _imageCaptionOneTextField.hidden=NO;
                _imageCaptionTwoTextField.hidden=NO;
                _imageThreeCaptionTextField.hidden=YES;
                _imageOneLabel.hidden=NO;
                _imageTwoLabel.hidden=NO;
                _imageThreeLabel.hidden=YES;
                _imageThreeCaptionTextField.text=@"";
                if (curentIndex==0) {
                    articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                  
                    [btnLeft setHidden:NO];
                    [btnRight setHidden:NO];
                    [btnDelete setHidden:NO];
                }
                else{
                    curentIndex=curentIndex-1;
                    articlePhoto.image=[selectedImages objectAtIndex:curentIndex];
                  
                    [btnLeft setHidden:NO];
                    [btnRight setHidden:NO];
                    [btnDelete setHidden:NO];
                }
            }
        }
    }
    NSInteger i=[selectedImages count];
    if (i==0) {
         _imgTiltleViewConstrant.constant=0.0f;
    }
    else if (i==1){
         _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+10.0f;
    }
    else if (i==2){
         _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+self.imageCaptionTwoTextField.frame.size.height+13.0f;
    }
    else
    {
        _imgTiltleViewConstrant.constant=self.imageCaptionOneTextField.frame.size.height+self.imageCaptionTwoTextField.frame.size.height+self.imageThreeCaptionTextField.frame.size.height+16.0f;
        
    }
    lblImgTitle.text=[NSString stringWithFormat:@"%ld/3",(long)i];
    lblImgTitle.textColor=[UIColor whiteColor];
    [lblImgTitle setHidden:NO];
    
    if ([selectedImages count]==0) {
       
        lblImgTitleBackground.hidden=YES;
        [lblImgTitle setHidden:YES];
    }
   
        //NSLog(@"%@",selectedImagesTitles);
}

#pragma mark - Category Button Tapped
- (IBAction)btnCategoryTapped:(id)sender {
    [self.view endEditing:YES];
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    
    
    _btnSubSubSubConstraints.constant=0.0f;
    _btnSubSubSubConstraints.active=YES;
    
    _txtSubSubCatConstraints.constant=0.0f;
    _txtSubSubCatConstraints.active=YES;
    
    _txtSubSubCatConstraints.constant=0.0f;
    _txtSubSubCatConstraints.active=YES;
    
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
        [Utility showAlert:AppName withMessage:netWork];
        return;
    }
    [ActionSheetStringPicker showPickerWithTitle:selectCategory
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

#pragma mark - Subcategory Button Tapped
- (IBAction)btnSubCategoryTapped:(id)sender
{
    [self.view endEditing:YES];
    _btnSubSubConstraints.constant=0.0f;
    _btnSubSubConstraints.active=YES;
    
    
    _btnSubSubSubConstraints.constant=0.0f;
    _btnSubSubSubConstraints.active=YES;
    
    _txtSubSubCatConstraints.constant=0.0f;
    _txtSubSubCatConstraints.active=YES;
    
    _txtSubSubCatConstraints.constant=0.0f;
    _txtSubSubCatConstraints.active=YES;
    
    
    
    
    
    _btnSubSubCategory.hidden=YES;
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubCategory.text=@"";
    _txtSubSubSubCategory.text=@"";
    _txtSubSubCategory.hidden=@"";
    _txtSubSubSubCategory.hidden=@"";

    
    if (arrSubCatId.count==0)
    {
       // [Utility showAlert:AppName withMessage:noSubCatFound];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:noSubCatFound closeButtonTitle:[Language ok] duration:0.0f];
        return;
    }
    if ([txtCategorieName.text isEqualToString:@""]) {
        strSubCatId=@"";
       // [Utility showAlert:AppName withMessage:pleaseSelectCat];
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:pleaseSelectCat closeButtonTitle:[Language ok] duration:0.0f];
        return;
    }
    else{
    NSInteger selectSubCatType;
    selectSubCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:selectSubCategory
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
                                               
                                               _btnSubSubConstraints.constant=btnSubCategory.frame.size.height+3.0f;
                                               _btnSubSubConstraints.active=YES;
                                               
                                               _txtSubSubCatConstraints.constant=btnSubCategory.frame.size.height+3.0f;
                                               _txtSubSubCatConstraints.active=YES;
                                               
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

#pragma mark - Create Article Button Tapped
- (IBAction)btnCrateArticleTapped:(id)sender {
    [self.view endEditing:YES];
    
    [self checkUserTypeSubmit];
    

    }

-(void)checkUserTypeSubmit{
    
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
                if ([selectedImages count]==0) {
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert setHorizontalButtons:YES];
                    
                    [alert showSuccess:AppName subTitle:pleaseUploadImage closeButtonTitle:[Language ok] duration:0.0f];
                    
                    return;
                }
                else{
                    [self createArticlesWithImages];
                }

            }
        }
    }];
}


#pragma mark -Button Add More Photos Tapped
- (IBAction)btnAddMorePhotosTapped:(id)sender {
    if ([selectedImages count]==3) {
        [btnDelete setHidden:NO];
        btnPhoto.hidden=YES;
        btnAddmore.hidden=YES;
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        
        [alert showSuccess:AppName subTitle:deleteImageIfThreeImages closeButtonTitle:[Language ok] duration:0.0f];
       // [Utility showAlert:AppName withMessage:deleteImageIfThreeImages];
        return ;
    }
    else{
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil
                                    message:nil
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* button0 = [UIAlertAction
                                  actionWithTitle:cancel
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
    }
}



#pragma mark - UITextview delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
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


//v 2.0 for sub category
- (IBAction)btnSubSubCategoryTapped:(id)sender
{
    [self.view endEditing:YES];
    _btnSubSubSubCategory.hidden=YES;
    _txtSubSubSubCategory.text=@"";
    _txtSubSubSubCategory.hidden=YES;
    
    _txtSubSubCategory.text=@"";
    
    _btnSubSubSubConstraints.constant=0.0f;
    _btnSubSubSubConstraints.active=YES;
    _txtSubSubSubConstraints.constant=0.0f;
    _txtSubSubSubConstraints.active=YES;
    NSInteger selectSubCatType;
    selectSubCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:selectSubSubCategory
                                            rows:arrSubSubCategoryName
                                initialSelection:selectSubCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
    {
                                           _txtSubSubCategory.text = selectedValue;
                                           strSubCatId=[arrSubSubCategoryId objectAtIndex:selectedIndex];
                                        subCatIdentifier=[arrSubSubChildCategory objectAtIndex:selectedIndex];
                                           if ([subCatIdentifier isEqualToString:@"1"])
                                           {
                                               _btnSubSubCategory.hidden=NO;
                                               _txtSubSubCategory.hidden=NO;
                                               
                                               _btnSubSubSubConstraints.constant=_btnSubSubCategory.frame.size.height+3.0f;
                                               _btnSubSubSubConstraints.active=YES;
                                               
                                               _txtSubSubSubConstraints.constant=_btnSubSubCategory.frame.size.height+3.0f;
                                               _txtSubSubCatConstraints.active=YES;
                                               

//                                               _btnSubSubSubConstraints.constant=45.0f;
//                                               _btnSubSubSubConstraints.active=NO;
//                                               _txtSubSubSubConstraints.constant=45.0f;
//                                               _txtSubSubSubConstraints.active=NO;
////
                                               
                                               _btnSubSubSubCategory.hidden=NO;
                                               _txtSubSubSubCategory.hidden=NO;
                                               strCatId=strSubCatId;
                                               
                                               CGRect contentRect = CGRectZero;
                                               for (UIView *view in scrollview.subviews)
                                               {
                                                   contentRect = CGRectUnion(contentRect, view.frame);
                                               }
                                               scrollview.contentSize = contentRect.size;
                                               [self getAllSubSubSubCategories];
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker)
    {
      
        
        NSLog(@"Block Picker Canceled");
        
    }
       origin:sender];
}

- (IBAction)btnSubSubSubCategoryTapped:(id)sender
{
    [self.view endEditing:YES];
    NSInteger selectSubCatType;
    selectSubCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:selectSubSubSubCategory
                                            rows:arrSubSubSubCategoryName
                                initialSelection:selectSubCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _txtSubSubSubCategory.text = selectedValue;
                                           strSubCatId=[arrSubSubSubCategoryId objectAtIndex:selectedIndex];
                                           subCatIdentifier=[arrSubSubSubChildCategory objectAtIndex:selectedIndex];
                                        
                                           
                                           
                                           CGRect contentRect = CGRectZero;
                                           for (UIView *view in scrollview.subviews)
                                           {
                                               contentRect = CGRectUnion(contentRect, view.frame);
                                           }
                                           scrollview.contentSize = contentRect.size;
                                           


//                                              
//                                           }
//                                           
                                       }
                                     cancelBlock:^( ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}


#pragma mark - This is what you are looking for:
-(AKTagsInputView*)createTagsInputView{
    _tagsInputView = [[AKTagsInputView alloc] initWithFrame:CGRectMake(0, 0.0f, CGRectGetWidth(self.assignedTagsView.bounds), 44.0f)];
    _tagsInputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tagsInputView.enableTagsLookup = YES;
    return _tagsInputView;
}

@end
