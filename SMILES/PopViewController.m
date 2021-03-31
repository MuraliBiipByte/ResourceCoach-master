//
//  PopViewController.m
//  SMILES
//
//  Created by BiipByte on 30/03/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "PopViewController.h"
#import "JVFloatLabeledTextView.h"
#import "Utility.h"
#import "APIManager.h"
#import "APIDefineManager.h"
#import "UIViewController+ENPopUp.h"
#import "JWBlurView.h"
#import "GCPlaceholderTextView.h"
#import "MyArticlesViewController.h"
#import "UIViewController+MaryPopin.h"
#import "Language.h"
#import "HomeViewController.h"
@interface PopViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    PopViewController *pop;
    JWBlurView *blurView;
    UILabel *lblPlaceholderDescription;
  
}
@property (weak, nonatomic) IBOutlet UITextField *txtSubArticleTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *txtDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblAddSubArticle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubDescription;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblAddSubArticle.text=[Language SubArticleHeader];
    _lblSubTitle.text=[Language SubArticleTitle];
    _lblSubDescription.text=[Language SubArticleDescription];
    _txtSubArticleTitle.placeholder=[Language SubArticleTitlePlaceHolder];
    [_btnCancel setTitle:[Language CANCEL] forState:UIControlStateNormal];
     [_btnCreate setTitle:[Language SUBMIT] forState:UIControlStateNormal];
   
     _txtDescription.placeholderColor = [UIColor lightGrayColor];
    _txtDescription.placeholder = NSLocalizedString([Language SubArticleDescriptionPlaceHolder],);
    _txtSubArticleTitle.tintColor=[UIColor colorWithRed:80.0/255.0 green:210.0/255.0 blue:194.0/255.0 alpha:1];
     _txtDescription.tintColor=[UIColor colorWithRed:80.0/255.0 green:210.0/255.0 blue:194.0/255.0 alpha:1];
    
        UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tapGus)];
    [self.view addGestureRecognizer: tapRec];
    
    _txtSubArticleTitle.layer.cornerRadius=8;
    _txtSubArticleTitle.layer.masksToBounds=YES;
    
    [_txtSubArticleTitle setBorderStyle:UITextBorderStyleRoundedRect];
    _txtSubArticleTitle.layer.borderWidth = 1;
    _txtSubArticleTitle.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    
    _txtDescription.layer.borderWidth = 1;
    _txtDescription.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _txtDescription.layer.cornerRadius=8;
    _txtDescription.layer.masksToBounds=YES;
   
    
    
    // Do any additional setup after loading the view.
}
-(void)tapGus{
     [_txtDescription resignFirstResponder];
  

    if (_txtSubArticleTitle) {
        [_txtSubArticleTitle resignFirstResponder];
    }
    else{
    [_txtDescription resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCreateTapped:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   // [defaults setObject:strArticleId forKey:@"artId"];
    NSString *articleId=[defaults valueForKey:@"artId"];
    NSString *userId=[defaults valueForKey:@"id"];
    
 
    if ([_txtSubArticleTitle.text isEqualToString:@"" ] && [_txtDescription.text isEqualToString:@""]) {
        
        [Utility showAlert:AppName withMessage:[Language PleaseEnterAllTheFields]];
        [_txtSubArticleTitle resignFirstResponder];
        NSLog(@"Please enter the title and description");
        
        return;
    }else if ([_txtSubArticleTitle.text isEqualToString:@"" ]) {
        
         [Utility showAlert:AppName withMessage:[Language PleaseEnterTitle]];
            NSLog(@"please enter the title");
        return;
    }
    else if ([_txtDescription.text isEqualToString:@"" ]) {
         [Utility showAlert:AppName withMessage:[Language PleaseEnterDescription]];
        NSLog(@"please enter the description");
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
    NSLog(@"success");
    [Utility showLoading:self];
    [[APIManager sharedInstance]createSubArticle:articleId withUserId:userId withTitle:_txtSubArticleTitle.text withDescription:_txtDescription.text withLanguage:strLanguage andCompleteBlock:^(BOOL success, id result) {
        [Utility hideLoading:self];
        if (!success) {
            [Utility showAlert:AppName withMessage:result];
            return ;
        }
        NSMutableDictionary *response=[result valueForKey:@"response"];
        NSMutableDictionary *data=[response valueForKey:@"data"];
        //[Utility showAlert:AppName withMessage:[response valueForKey:@"message"]];
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:AppName message:[response valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:[Language ok] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            MyArticlesViewController *my;
            [my.tblMyArticles reloadData];
            
            HomeViewController *Home=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:Home animated:YES];
            
            [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
                NSLog(@"Popin dismissed !");
            }];
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:NO];
}

- (void) animateTextView:(BOOL) up
{
//    const int movementDistance =300; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    int movement= movement = (up ? -movementDistance : movementDistance);
//    NSLog(@"%d",movement);
//    
//    [UIView beginAnimations: @"anim" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectMake(10, 80, self.view.frame.size.width-20, 300);
//    [UIView commitAnimations];
    MyArticlesViewController *ar;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:ar.backGroundView cache:YES];
    ar.backGroundView.frame = CGRectMake(10, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)btnCancelTapped:(id)sender {
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
        NSLog(@"Popin dismissed !");
    }];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}


@end
