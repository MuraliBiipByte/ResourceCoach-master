//
//  CreateArticleViewController.m
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "CreateArticleViewController.h"
#import "REFrostedViewController.h"
#import "Utility.h"
#import "UIAlertView+Blocks.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "AllCategories.h"
#import "AllSubCategories.h"
#import "UIActionSheet+Blocks.h"
#import "ActionSheetPicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "TOCropViewController.h"
#import "YSLContainerViewController.h"
#import "CreateArticleWithImageViewController.h"
#import "CreateArticleWithVideoViewController.h"
#import "HYCircleLoadingView.h"
#import "ViewController.h"
#import "RootViewController.h"


@interface CreateArticleViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate,TOCropViewControllerDelegate,YSLContainerViewControllerDelegate>{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *imgView;
    __weak IBOutlet UIImageView *articleImg;
    __weak IBOutlet UIView *btnsView;
    __weak IBOutlet UIButton *btnPhoto;
    __weak IBOutlet UIButton *btnVideo;
    __weak IBOutlet UIView *articleView;
    __weak IBOutlet RPFloatingPlaceholderTextField *txtArticleTitle; 
    __weak IBOutlet UITextView *txtArticleShortDescription;
    __weak IBOutlet UITextView *txtArticleDescription;
    __weak IBOutlet UIView *categoriesView;
    __weak IBOutlet UIImageView *catImgDropDown;
    __weak IBOutlet UIImageView *subCatImgDropdown;
    __weak IBOutlet UITextField *txtCategorieName;
    __weak IBOutlet UITextField *txtSubCategory;
    __weak IBOutlet UIButton *btnCreateArticle;
    __weak IBOutlet UIButton *btnCatName;
    __weak IBOutlet UIButton *btnSubCatName;
    __weak IBOutlet UIButton *btnLeft;
    __weak IBOutlet UIButton *btnRight;
    __weak IBOutlet UIButton *btnDelet;
    NSArray *arrCatId,*arrCatName,*arrCatParentId,*arrSubCatId,*arrSubCatName,*arrSubCatParentId;
    NSURL *imgURL;
    NSURL *videoURL;
    NSString *strSubCatId;
    NSData *urlData;
    NSString *userId;
    UIImage *chosenImage;
    NSMutableArray *selectedImages;
    UIImage *uploadImage1,*uploadImage2,*uploadImage3;
    UIImagePickerController *picker;
    NSString *vidoIdentify;
    NSString *photoIdentify;
    NSUInteger curentIndex;
    NSUInteger prevIndex;
    NSString *uID,*UserType;
}
@property (nonatomic,assign) BOOL disablePanGesture;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle;
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@end

@implementation CreateArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiguration];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language=[defaults objectForKey:@"language"];
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    [self.view addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    [self.view addSubview:self.loadingView];
    // SetUp ViewControllers
    CreateArticleWithImageViewController *imgUpload = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateArticleWithImageViewController"];
    if ([language isEqualToString:@"2"]) {
        imgUpload.title=@"ကင္မရာ";
    }
    else if ([language isEqualToString:@"3"]){
        imgUpload.title=@"ကင်မရာ";
    }
    else
    {
        imgUpload.title = @"Camera";
    }
    CreateArticleWithVideoViewController *videoUpload = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateArticleWithVideoViewController"];
    if ([language isEqualToString:@"2"]) {
        videoUpload.title=@"ဗီဒီယို";
    }
    else if ([language isEqualToString:@"3"]){
        videoUpload.title=@"ကင်မရာ";
    }
    else
    {
        videoUpload.title = @"Video";
    }
    //    // ContainerView
    //    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    float statusHeight =0;
    float navigationHeight = 0;
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[imgUpload,videoUpload] topBarHeight:statusHeight + navigationHeight parentViewController:self];
    containerVC.accessibilityFrame=CGRectMake(0,statusHeight + navigationHeight, self.view.frame.size.width, 40) ;
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    containerVC.menuBackGroudColor=[UIColor colorWithRed:8.0/255.0 green:170.0/255.0 blue:87.0/255.0 alpha:1];
    [self.view addSubview:containerVC.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    NSLog(@"current Index : %ld",(long)index);
    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
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
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *language=[defaults objectForKey:@"language"];
    if ([language isEqualToString:@"2"]) {
       // self.title=@"ေဆာင္းပါးဖန္တီးရန္";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"ေဆာင္းပါးဖန္တီးရန္";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        [view addSubview:label];
        self.navigationItem.titleView = view;

        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    }
    else if ([language isEqualToString:@"3"]){
        //  self.title=@"အပိုဒ် Create";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"အပိုဒ် Create";
        label.textColor=[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"FuturaStd-Medium" size:17]];
        [view addSubview:label];
        self.navigationItem.titleView = view;
    }
    else{
        self.title=@"Create Article";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Medium" size:17]}];
    }
    //self.title=@"Create Article";
    
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

#pragma mark - Article Photo Button Tapped
- (IBAction)btnPhotoTapped:(id)sender {
    [self.view endEditing:YES];
    photoIdentify=@"1";
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil message:nil
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* button0 = [UIAlertAction
                                  actionWithTitle:@"Cancel"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action){
                                  }];
        UIAlertAction* button1 = [UIAlertAction
                                  actionWithTitle:@"Camera"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self cameraClick];
                                  }];
        UIAlertAction* button2 = [UIAlertAction
                                  actionWithTitle:@"Gallery"
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
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"PrinceSELF does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > PrinceSELF" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
                                          actionWithTitle:@"Cancel"
                                          style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction * action){
                                          }];
                UIAlertAction* button1 = [UIAlertAction
                                          actionWithTitle:@"Camera"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [self cameraClick];
                                          }];
                UIAlertAction* button2 = [UIAlertAction
                                          actionWithTitle:@"Gallery"
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

#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType1 = [info objectForKey: UIImagePickerControllerMediaType];
    if (CFStringCompare ((__bridge CFStringRef) mediaType1, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        [self.videoController.view setHidden:NO];
        btnPhoto.hidden=YES;
        btnVideo.frame=CGRectMake(0, 9, btnsView.frame.size.width, 30);
        [btnVideo setTitle:@"  Clear Video" forState:UIControlStateNormal];
        vidoIdentify=@"1";
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        imgURL=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        NSString *moviePath = [videoUrl path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil,nil, nil);
            [self.videoController setContentURL:videoUrl];
            [self.videoController.view setFrame:CGRectMake (0, 0, articleImg.frame.size.width, 293)];
            [articleImg addSubview:self.videoController.view];
            self.videoController.fullscreen = YES;
            [self.videoController play];
        }
        else{
            NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            NSLog(@"Picked a movie at URL %@",  [info objectForKey:UIImagePickerControllerMediaURL]);
            videoURL =  [info objectForKey:UIImagePickerControllerMediaURL];
            NSLog(@"> %@", [videoURL absoluteString]);
            [self.videoController.view setHidden:NO];
            [self.videoController setContentURL:videoURL];
            [self.videoController.view setFrame:CGRectMake (0, 0, articleImg.frame.size.width, 293)];
            [articleImg addSubview:self.videoController.view];
            [self.videoController setControlStyle:MPMovieControlStyleEmbedded];;
            self.videoController.shouldAutoplay = YES;
            [self.videoController setFullscreen:YES animated:YES];
            [self.videoController play];
            ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
            [assetLibrary assetForURL:[info  valueForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset){
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                Byte *buffer = (Byte*)malloc(rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                urlData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is NSData may be what you want
            }
                         failureBlock:^(NSError *err) {
                             NSLog(@"Error: %@",[err localizedDescription]);
                         }];
        }
    }
    else{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
        cropController.delegate = self;
        self.image = image;
        if (self.croppingStyle == TOCropViewCroppingStyleCircular) {
            [picker pushViewController:cropController animated:YES];
        }
        else {
            [picker dismissViewControllerAnimated:YES completion:^{
                [self presentViewController:cropController animated:YES completion:nil];
            }];
            cropController.delegate = self;
            articleImg.image = image;
            chosenImage=image;
            [selectedImages addObject:image];
            if ([selectedImages count]>1) {
                btnLeft.hidden=NO;
                btnRight.hidden=NO;
                btnDelet.hidden=NO;
            }
            if ([selectedImages count]>0) {
                if ([selectedImages count]==3) {
                    btnVideo.hidden=YES;
                    btnPhoto.hidden=YES;
                }
                else{
                    btnVideo.hidden=YES;
                    btnPhoto.frame=CGRectMake(0, 9, btnsView.frame.size.width, 30);
                    [btnPhoto setTitle:@"  Add More Images" forState:UIControlStateNormal];
                }
            }
            
            //    if ([productImages count]==1) {
            //        [btnLeft setHidden:YES];
            //        [btnRight setHidden:YES];
            //        [btnDelete setHidden:NO];
            //
            //    }else{
            //        [btnLeft setHidden:NO];
            //        [btnRight setHidden:NO];
            //        [btnDelete setHidden:NO];
            //    }
            NSLog(@"Images count is %lu",(unsigned long)[selectedImages count]);
            // imageView.image=[selectedImages objectAtIndex:0];
            //    for (int i=0; i<[productImages count]; i++) {
            //        curentIndex=i;
            //
            //    }
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
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
    articleImg.image = image;
    chosenImage=image;
    // [self layoutImageView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [selectedImages addObject:image];
    if ([selectedImages count]>1) {
        btnLeft.hidden=NO;
        btnRight.hidden=NO;
    }
    if ([selectedImages count]>0) {
        if ([selectedImages count]==3) {
            btnVideo.hidden=YES;
            btnPhoto.hidden=YES;
        }
        else{
            btnVideo.hidden=YES;
            btnPhoto.frame=CGRectMake(0, 9, btnsView.frame.size.width, 30);
            [btnPhoto setTitle:@"  Add More Images" forState:UIControlStateNormal];
        }
    }
    
    //    if ([productImages count]==1) {
    //        [btnLeft setHidden:YES];
    //        [btnRight setHidden:YES];
    //        [btnDelete setHidden:NO];
    //
    //    }else{
    //        [btnLeft setHidden:NO];
    //        [btnRight setHidden:NO];
    //        [btnDelete setHidden:NO];
    //    }
    NSLog(@"Images count is %lu",(unsigned long)[selectedImages count]);
    // imageView.image=[selectedImages objectAtIndex:0];
    //    for (int i=0; i<[productImages count]; i++) {
    //        curentIndex=i;
    //
    //    }
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

#pragma mark -Create Article With Images
-(void)createArticlesWithImages{
    if ([txtArticleTitle.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Title"];
        [txtArticleTitle becomeFirstResponder];
        return;
    }
    if ([txtArticleShortDescription.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Short Description"];
        [txtArticleShortDescription becomeFirstResponder];
        return;
    }
    if ([txtArticleDescription.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Description"];
        [txtArticleDescription becomeFirstResponder];
        return;
    }
    if ([txtCategorieName.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Select Category Name"];
        [txtCategorieName becomeFirstResponder];
        return;
    }
    if ([txtSubCategory.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Select SubCategory Name"];
        [txtSubCategory becomeFirstResponder];
        return;
    }
    if ([selectedImages count]==0) {
        //        uploadImage1=[UIImage imageNamed:@""];
        //        uploadImage2=[UIImage imageNamed:@""];
        //        uploadImage3=[UIImage imageNamed:@""];
        [Utility showAlert:AppName withMessage:@"Please Select SubCategory Name"];
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
    else if ([selectedImages count]==4){
        uploadImage1=[selectedImages objectAtIndex:0];
        uploadImage2=[selectedImages objectAtIndex:1];
        uploadImage3=[selectedImages objectAtIndex:2];
    }
    //[Utility showLoading:self];
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    
    //   [[APIManager sharedInstance]createArticleWithImagesUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithImage1:uploadImage1 andWithImage2:uploadImage2 andWithImage3:uploadImage3 andCompleteBlock:^(BOOL success, id result) {
    //      // [Utility hideLoading:self];
    //       [self.loadingView stopAnimation];
    //       [self.loadingView setHidden:YES];
    //       [self.img setHidden:YES];
    //       if (!success) {
    //           [Utility showAlert:AppName withMessage:result];
    //           return ;
    //       }
    //       NSString *message = [result objectForKey:@"message"];
    //       [Utility showAlert:AppName withMessage:message];
    //       [self.videoController.view setHidden:YES];
    //       [self.navigationController popToRootViewControllerAnimated:YES];
    //   }];
}

#pragma mark - Article Video Button Tapped
- (IBAction)btnVideoTapped:(id)sender {
    [self.view endEditing:YES];
    btnDelet.hidden=YES;
    photoIdentify=@"2";
    //UIAlertController *alert;
    if ([vidoIdentify isEqualToString:@"1"]) {
        imgURL=nil;
        self.videoController.view.hidden=YES;
        btnPhoto.hidden=NO;
        btnVideo.frame=CGRectMake(btnPhoto.frame.size.width, 9, btnPhoto.frame.size.width, 30);
        [btnVideo setTitle:@" Upload Video" forState:UIControlStateNormal];
        vidoIdentify=@"";
        return;
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:@"Choose Video" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action){
                              }];
    UIAlertAction *gallary=[UIAlertAction actionWithTitle:@"Record Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        picker.delegate=self;
        picker.allowsEditing=YES;
        [picker setVideoMaximumDuration:120];
        [self presentViewController:picker animated:YES completion:nil];
        //        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        //        elcPicker.maximumImagesCount = 1;
        //        elcPicker.returnsOriginalImage = YES;
        //        elcPicker.returnsImage = YES;
        //        elcPicker.onOrder = YES;
        //        elcPicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        //        elcPicker.imagePickerDelegate = self;
        //        [self presentViewController:elcPicker animated:YES completion:nil];
        //
    }];
    UIAlertAction *camera=[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        elcPicker.maximumImagesCount = 1;
        elcPicker.returnsOriginalImage = YES;
        elcPicker.returnsImage = YES;
        elcPicker.onOrder = YES;
        elcPicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        elcPicker.imagePickerDelegate = self;
        [self presentViewController:elcPicker animated:YES completion:nil];
        //       picker=[[UIImagePickerController alloc]init];
        //        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        //        picker.delegate=self;
        //        picker.allowsEditing=YES;
        //       // [picker setVideoMaximumDuration:120];
        //        [self presentViewController:picker animated:YES completion:nil];
    }];
    [alert addAction:button0];
    [alert addAction:gallary];
    [alert addAction:camera];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType]==ALAssetTypeVideo){
            [self.videoController.view setHidden:NO];
            if ([dict objectForKey:UIImagePickerControllerReferenceURL]){
                NSURL *videoUrl=(NSURL*)[dict objectForKey:UIImagePickerControllerReferenceURL];
                // imgURL=(NSURL*)[dict objectForKey:UIImagePickerControllerReferenceURL];
                [self.videoController setContentURL:videoUrl];
                // [self.videoController.view setFrame:CGRectMake (0, 47, self.view.frame.size.width, 188)];
                //[self.view addSubview:self.videoController.view];
                [self.videoController.view setFrame:CGRectMake (0, 0, articleImg.frame.size.width, 296)];
                [articleImg addSubview:self.videoController.view];
                [self.videoController setControlStyle:MPMovieControlStyleEmbedded];;
                self.videoController.shouldAutoplay = YES;
                // [self.videoController setFullscreen:YES animated:YES];
                [self.videoController play];
                ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
                [assetLibrary assetForURL:[dict  valueForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset){
                    ALAssetRepresentation *rep = [asset defaultRepresentation];
                    Byte *buffer = (Byte*)malloc(rep.size);
                    NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                    urlData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is NSData may be what you want
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

#pragma mark - UIImagePickerControllerDelegate Methods
//- (void)imagePickerController:(UIImagePickerController *)picker
//didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//
//    NSString *mediaType1 = [info objectForKey: UIImagePickerControllerMediaType];
//    if (CFStringCompare ((__bridge CFStringRef) mediaType1, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//        [self.videoController.view setHidden:NO];
//        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
//        imgURL=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
//        //        NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
//
//        NSString *moviePath = [videoUrl path];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil,nil, nil);
//            [self.videoController setContentURL:videoUrl];
//            //            [self.videoController.view setFrame:CGRectMake (0, 47, self.view.frame.size.width, 200)];
//            //            [self.view addSubview:self.videoController.view];
//            [self.videoController.view setFrame:CGRectMake (0, 0, articleImg.frame.size.width, 293)];
//            [articleImg addSubview:self.videoController.view];
//
//            self.videoController.fullscreen = YES;
//            //[self.videoController setUseApplicationAudioSession:TRUE];
//
//            [self.videoController play];
//        }
//    }
//}
//
////- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
////    [self dismissViewControllerAnimated:YES completion:nil];
////}
//
//#pragma mark ELCImagePickerControllerDelegate Methods
//
//- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//    for (NSDictionary *dict in info) {
//
//        if ([dict objectForKey:UIImagePickerControllerMediaType]==ALAssetTypeVideo){
//
//            [self.videoController.view setHidden:NO];
//            if ([dict objectForKey:UIImagePickerControllerReferenceURL]){
//
//                NSURL *videoUrl=(NSURL*)[dict objectForKey:UIImagePickerControllerReferenceURL];
//                // imgURL=(NSURL*)[dict objectForKey:UIImagePickerControllerReferenceURL];
//                [self.videoController setContentURL:videoUrl];
//                //                [self.videoController.view setFrame:CGRectMake (0, 47, self.view.frame.size.width, 188)];
//                //[self.view addSubview:self.videoController.view];
//                [self.videoController.view setFrame:CGRectMake (0, 0, articleImg.frame.size.width, 293)];
//                [articleImg addSubview:self.videoController.view];
//                [self.videoController setControlStyle:MPMovieControlStyleEmbedded];;
//                self.videoController.shouldAutoplay = YES;
//                // [self.videoController setFullscreen:YES animated:YES];
//                [self.videoController play];
//
//                ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
//                [assetLibrary assetForURL:[dict  valueForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset)
//                 {
//                     ALAssetRepresentation *rep = [asset defaultRepresentation];
//                     Byte *buffer = (Byte*)malloc(rep.size);
//                     NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
//                     urlData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is NSData may be what you want
//
//
//                 }
//                             failureBlock:^(NSError *err) {
//                                 NSLog(@"Error: %@",[err localizedDescription]);
//                             }];
//
//            }
//        }
//
//    }//for
//
//
//}
//
//- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)createArticleWithVideoUpload{
    if ([txtArticleTitle.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Title"];
        [txtArticleTitle becomeFirstResponder];
        return;
    }
    if ([txtArticleShortDescription.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Short Description"];
        [txtArticleShortDescription becomeFirstResponder];
        return;
    }
    if ([txtArticleDescription.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Enter Article Description"];
        [txtArticleDescription becomeFirstResponder];
        return;
    }
    if ([txtCategorieName.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Select Category Name"];
        [txtCategorieName becomeFirstResponder];
        return;
    }
    if ([txtSubCategory.text length]==0) {
        [Utility showAlert:AppName withMessage:@"Please Select SubCategory Name"];
        [txtSubCategory becomeFirstResponder];
        return;
    }
    if (urlData) {
        // [Utility showLoading:self];
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        
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
        //            [Utility showAlert:AppName withMessage:message];
        //            [self.videoController.view setHidden:YES];
        //            [self.navigationController popToRootViewControllerAnimated:YES];
        //        }];
    }
    else {
        //[Utility showLoading:self];
        [self.loadingView startAnimation];
        [self.loadingView setHidden:NO];
        [self.img setHidden:NO];
        //        [[APIManager sharedInstance]createArticleWithVideoUserId:userId andWithArticletitle:txtArticleTitle.text andWithSubCatId:strSubCatId andWithShortDescription:txtArticleShortDescription.text andWithLongDescription:txtArticleDescription.text andWithVideo:imgURL andCompleteBlock:^(BOOL success, id result) {
        //            //[Utility hideLoading:self];
        //            [self.loadingView stopAnimation];
        //            [self.loadingView setHidden:YES];
        //            [self.img setHidden:YES];
        //            if (!success) {
        //                [Utility showAlert:AppName withMessage:result];
        //                return ;
        //            }
        //            NSString *message = [result objectForKey:@"message"];
        //            [Utility showAlert:AppName withMessage:message];
        //            [self.videoController.view setHidden:YES];
        //            [self.navigationController popToRootViewControllerAnimated:YES];
        //        }];
    }
}

#pragma mark - Category Button Tapped
- (IBAction)btnCategory:(id)sender {
    [self.view endEditing:YES];
    NSInteger selectedCatType;
    selectedCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:@"Select Category"
                                            rows:arrCatName
                                initialSelection:selectedCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           txtCategorieName.text = selectedValue;
                                           [btnCatName setTitle:@"" forState:UIControlStateNormal];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

#pragma mark - Sub Category Button Tapped
- (IBAction)btnSubCategory:(id)sender {
    [self.view endEditing:YES];
    NSInteger selectSubCatType;
    selectSubCatType=0;
    [ActionSheetStringPicker showPickerWithTitle:@"Select Sub Category"
                                            rows:arrSubCatName
                                initialSelection:selectSubCatType
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           txtSubCategory.text = selectedValue;
                                           strSubCatId=[arrSubCatId objectAtIndex:selectedIndex];
                                           [btnSubCatName setTitle:@"" forState:UIControlStateNormal];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

#pragma mark - Create Article Button Tapped
- (IBAction)btnCreateArticle:(id)sender {
    [self.view endEditing:YES];
    //    if (!chosenImage) {
    //        [Utility showAlert:AppName withMessage:@"Please Choose Image Or Video"];
    //        return;
    //    }
    if ([selectedImages count]>0) {
        [self createArticlesWithImages];
    }
    else{
        [self createArticleWithVideoUpload];
    }
    
}

#pragma mark -Button Left Tapped
- (IBAction)btnLeftTapped:(id)sender {
    [self.view endEditing:YES];
    if(curentIndex == 0){
        prevIndex = [selectedImages count] - 1;
    }else{
        prevIndex = (curentIndex-1)%[selectedImages count];
    }
    articleImg.image = selectedImages[prevIndex];
    curentIndex = prevIndex;
}

#pragma mark -Button Right Tapped
- (IBAction)btnRightTapped:(id)sender {
    [self.view endEditing:YES];
    NSUInteger nextIndex = (curentIndex+1)%[selectedImages count];
    articleImg.image = selectedImages[nextIndex];
    curentIndex = nextIndex;
}

#pragma mark -Button Delete Tapped
- (IBAction)btnDeleteTapped:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"%lu",(unsigned long)curentIndex);
    if ([selectedImages count]==0) {
        [btnLeft setHidden:YES];
        [btnRight setHidden:YES];
        [btnDelet setHidden:YES];
    }
    else{
        [selectedImages removeObjectAtIndex:curentIndex];
        // lblImagesCount.text=[NSString stringWithFormat:@"Images are %d out of 3",[productImages count]];
        NSLog(@"%lu",(unsigned long)curentIndex);
        if ([selectedImages count]==0) {
            // productImage.image=[UIImage imageNamed:@"productPlaceholder"];
            //             lblImagesCount.text=[NSString stringWithFormat:@"Images are %lu out of 3",(unsigned long)[productImages count]];
            [btnLeft setHidden:YES];
            [btnRight setHidden:YES];
            [btnDelet setHidden:YES];
        }
        else if ([selectedImages count]==1){
            [btnLeft setHidden:YES];
            [btnRight setHidden:YES];
            if (curentIndex==0) {
                articleImg.image=[selectedImages objectAtIndex:curentIndex];
                // lblImagesCount.text=[NSString stringWithFormat:@"Images are %d out of 3",[productImages count]];
            }
            else{
                curentIndex=curentIndex-1;
                articleImg.image=[selectedImages objectAtIndex:curentIndex];
                //lblImagesCount.text=[NSString stringWithFormat:@"Images are %d out of 3",[productImages count]];
            }
        }
        else{
            if (curentIndex==0) {
                articleImg.image=[selectedImages objectAtIndex:curentIndex];
                //lblImagesCount.text=[NSString stringWithFormat:@"Images are %d out of 3",[productImages count]];
                [btnLeft setHidden:NO];
                [btnRight setHidden:NO];
                [btnDelet setHidden:NO];
            }
            else{
                curentIndex=curentIndex-1;
                articleImg.image=[selectedImages objectAtIndex:curentIndex];
                //lblImagesCount.text=[NSString stringWithFormat:@"Images are %d out of 3",[productImages count]];
                [btnLeft setHidden:NO];
                [btnRight setHidden:NO];
                [btnDelet setHidden:NO];
            }
        }
    }
}

@end
