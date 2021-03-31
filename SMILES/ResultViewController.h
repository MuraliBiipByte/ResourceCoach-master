//
//  ResultViewController.h
//  DedaaBox
//
//  Created by BiipByte on 08/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblSuccessMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblCongratulations;
@property (weak, nonatomic) IBOutlet UIView *viewUserDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblPleasesubmitDetails;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblFeeAplied;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UITextField *txtmobilenumber;

@property (nonatomic, retain) NSString *strPercentage;
@property (nonatomic, retain) NSString *strMiniCertification;
@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;

@end
