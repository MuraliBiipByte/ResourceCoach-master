//
//  AuthoreProfileViewController.h
//  DedaaBox
//
//  Created by BiipByte on 04/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthoreProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgAuthore;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthoreName;
@property (weak, nonatomic) IBOutlet UIButton *btnVideosCount;
@property (weak, nonatomic) IBOutlet UIButton *btnLikesCount;
@property (weak, nonatomic) IBOutlet UILabel *lblAboutAuthore;
@property (weak, nonatomic) IBOutlet UIView *aboutAuthoreView;
@property (weak, nonatomic) IBOutlet NSString *authoreId;
@property (weak, nonatomic) IBOutlet NSString *strControllerIdentifier;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthoreTitle;
@end
