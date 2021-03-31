//
//  CreateArticleWithImageViewController.h
//  SMILES
//
//  Created by Biipmi on 27/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKIT/UIView.h>

@interface CreateArticleWithImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtSubSubCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtSubSubSubCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubSubCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubSubSubCategory;
@property (weak, nonatomic) IBOutlet UIView *assignedTagsView;
@property (weak, nonatomic) IBOutlet UILabel *lblTagsTitle;
@property (weak, nonatomic) IBOutlet UITextField *imageCaptionOneTextField;
@property (weak, nonatomic) IBOutlet UILabel *imageOneLabel;
@property (weak, nonatomic) IBOutlet UITextField *imageCaptionTwoTextField;
@property (weak, nonatomic) IBOutlet UILabel *imageTwoLabel;
@property (weak, nonatomic) IBOutlet UITextField *imageThreeCaptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *imageThreeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTiltleViewConstrant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnAddMoreConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnPhotoConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSubSubConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSubSubSubConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtSubSubCatConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtSubSubSubConstraints;





@end
