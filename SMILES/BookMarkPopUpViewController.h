//
//  BookMarkPopUpViewController.h
//  Resource Coach
//
//  Created by Admin on 07/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkPopUpViewController : UIViewController
@property (weak, nonatomic) NSString *strArticleId;
@property (weak, nonatomic) NSString *strArticleName;


@property (weak, nonatomic) IBOutlet UILabel *lblSelectCreate;
@property (weak, nonatomic) IBOutlet UITextField *txtCreateFolder;
@property (weak, nonatomic) IBOutlet UIButton *btnFolder;
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtSticker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *createFolderHight;
@property (weak, nonatomic) IBOutlet UILabel *lblFolderName;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnCross;

@end
