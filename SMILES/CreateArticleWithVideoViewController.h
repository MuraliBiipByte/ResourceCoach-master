//
//  CreateArticleWithVideoViewController.h
//  SMILES
//
//  Created by Biipmi on 27/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "RPFloatingPlaceholderTextField.h"

@interface CreateArticleWithVideoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *youtubeSubView;
@property (strong, nonatomic) IBOutlet UILabel *lblValidOrNot;
@property (strong, nonatomic) IBOutlet UITextView *textViewYoutubeUrl;
@property (strong, nonatomic) IBOutlet UIButton *btnValidate;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIView *txtSubview;
@property (strong, nonatomic) IBOutlet YTPlayerView *ytView;
@property (weak, nonatomic) IBOutlet UILabel *lblTagsTitle;
@property (weak, nonatomic) IBOutlet UIView *tagsview;
@property (weak, nonatomic) IBOutlet UITextField *txtSubSubCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtSubSubSubCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubSubCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubSubSubCategory;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSubSubConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSubSUbSUbConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtSubSubConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtSubSubSubConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSubConstraints;



@end
