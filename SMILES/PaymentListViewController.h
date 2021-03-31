//
//  PaymentListViewController.h
//  DedaaBox
//
//  Created by BiipByte on 21/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentListViewController : UIViewController


//for EnteringMobileNumber
@property (nonatomic,weak) IBOutlet UIView *viewMobilenumber;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak,nonatomic) IBOutlet UILabel *lblMobilenumberWrong;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumber;
@property (weak,nonatomic) IBOutlet UIButton *btnPopupHiden;



@end
