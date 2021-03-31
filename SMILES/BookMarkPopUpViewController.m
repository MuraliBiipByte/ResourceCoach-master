//
//  BookMarkPopUpViewController.m
//  Resource Coach
//
//  Created by Admin on 07/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "BookMarkPopUpViewController.h"
#import "UIActionSheet+Blocks.h"
#import "ActionSheetPicker.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "SCLAlertView.h"
#import "UIViewController+ENPopUp.h"
#import "UIViewController+MaryPopin.h"
#import "JWBlurView.h"
#import "ArticleDetailsViewController.h"
@interface BookMarkPopUpViewController ()
{
    NSMutableArray *arrNames;
    NSMutableArray *arrIds;
    NSInteger selecteIndex;
    NSString *uID,*UserType,*strFolderId,*strFolderName;
    NSMutableArray *arrBookMarkData;
    
    BookMarkPopUpViewController *pop;
    JWBlurView *blurView;
}

@end

@implementation BookMarkPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    strFolderId =@"";
    strFolderName=@"";
    _btnFolder.layer.cornerRadius = 4.0f;
    _btnFolder.layer.masksToBounds=YES;
    _btnFolder.layer.borderWidth = 1;
    _btnFolder.layer.borderColor =[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1].CGColor ;
    
    _txtCreateFolder.layer.cornerRadius = 4.0f;
    _txtCreateFolder.layer.masksToBounds=YES;
    _txtCreateFolder.layer.borderWidth = 1;
    _txtCreateFolder.layer.borderColor = [UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1].CGColor ;
    _createFolderHight.constant=0;
    
    arrNames = [[NSMutableArray alloc]init];
    arrIds = [[NSMutableArray alloc]init];
    arrBookMarkData=[[NSMutableArray alloc]init];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self getAllFolders];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
    _lblArticleTitle.text =[NSString stringWithFormat:@"%@",_strArticleName];
}
- (IBAction)btnSubmitTapped:(id)sender
{
    [self.view endEditing:YES];
    
    if ([strFolderId isEqualToString:@"0"]) {
        strFolderName = _txtCreateFolder.text;
    }
    
    
    if ([strFolderId isEqualToString:@"0"]&& [strFolderName isEqualToString:@""]) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
        //   alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
        [alert showSuccess:AppName subTitle:@"Plese Enter FolderName" closeButtonTitle:@"OK" duration:0.0f];
        
        return;
    }
    if ([strFolderId isEqualToString:@""]||[strFolderId isEqual:[NSNull null]]||[strFolderId isEqualToString:@"<nil>"]) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setHorizontalButtons:YES];
   alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
        [alert showSuccess:AppName subTitle:@"Plese Select FolderName" closeButtonTitle:@"OK" duration:0.0f];
        return;
    }
    
    [Utility showLoading:self];
    [[APIManager sharedInstance]saveBookMarksWithUserId:uID andWithArticleId:_strArticleId andWithArticleName:_strArticleName andWithStickers:@"" andWithFolderName:strFolderName andWithFolderId:strFolderId andCompleteBlock:^(BOOL success, id result) {
        [Utility hideLoading:self];
        if (!success) {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setHorizontalButtons:YES];
            //   alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep-04.mp3", [NSBundle mainBundle].resourcePath]];
            [alert showSuccess:AppName subTitle:result closeButtonTitle:@"OK" duration:0.0f];
        }
        else{
            NSString *status =[NSString stringWithFormat:@"%@", [result valueForKey:@"status"]];
            NSString *message =[NSString stringWithFormat:@"%@", [result valueForKey:@"message"]];
            if ([status isEqualToString:@"1"])
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:AppName
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                          [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
                                                                              NSLog(@"Popin dismissed !");
                                                                              [[NSNotificationCenter defaultCenter]
                                                                               postNotificationName:@"SecondViewControllerDismissed"
                                                                               object:nil userInfo:nil];
                                                                          }];
                                                                          
                                                                      }];
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
}
- (IBAction)btnFolderTapped:(id)sender {
    [self.view endEditing:YES];
    selecteIndex=0;
    [ActionSheetStringPicker showPickerWithTitle:@"Name"
                                            rows:arrNames
                                initialSelection:selecteIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           selecteIndex = selectedIndex;
                                           
                                           strFolderName = [arrNames objectAtIndex:selecteIndex];
                                           strFolderId =[arrIds objectAtIndex:selecteIndex];
                                           if ([strFolderId isEqualToString:@"0"]) {
                                               _txtCreateFolder.placeholder = @"Enter FolderName";
                                               _txtCreateFolder.textColor =[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1] ;
                                                  _lblFolderName.text = [NSString stringWithFormat:@"%@",strFolderName];
                                               _createFolderHight.constant=40;
                                               
                                               
                                           }
                                           else{
                                               [_btnFolder setTitle:[NSString stringWithFormat:@"%@",strFolderName] forState:UIControlStateNormal];
                                               _lblFolderName.text = [NSString stringWithFormat:@"%@",strFolderName];
                                               _createFolderHight.constant=0;
                                               _txtCreateFolder.text=@"";
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker)
    {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
-(void)getAllFolders
{
    
    [arrIds removeAllObjects];
    [arrNames removeAllObjects];
    [Utility showLoading:self];
    [[APIManager sharedInstance]getBookMarkFolderWithUserId:uID andCompleteBlock:^(BOOL success, id result) {
        [Utility hideLoading:self];
        if (!success)
        {
                 return ;
        }
        arrBookMarkData=[result valueForKey:@"bookmark_data"];
        for (int z=0; z<[arrBookMarkData count];z++)
        {
            [arrIds addObject:[[arrBookMarkData objectAtIndex:z]valueForKey:@"id"]];
            [arrNames addObject:[[arrBookMarkData objectAtIndex:z]valueForKey:@"folder_name"]];
        }
    
       
        
    }];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [_txtCreateFolder resignFirstResponder];
    return YES;
}
- (IBAction)btnCrossTapped:(id)sender
{
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:
     ^{
        NSLog(@"Popin dismissed !");
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"SecondViewControllerDismissed"
         object:nil userInfo:nil];
    }];
}

/*

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
