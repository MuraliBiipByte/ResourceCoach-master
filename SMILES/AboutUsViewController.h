//
//  AboutUsViewController.h
//  SMILES
//
//  Created by Biipmi on 20/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *queryView;
@property (weak, nonatomic) IBOutlet UILabel *lblCallUs;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEnterQuery;
@property (weak, nonatomic) IBOutlet UITextView *txtEnterQuery;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnPopupHiden;
@property (weak, nonatomic) IBOutlet UIView *queryEnterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
