//
//  BankAccountViewController.h
//  DedaaBox
//
//  Created by BiipByte on 10/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTocollectCertificate;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *accountNumbersView;
@property (weak, nonatomic) IBOutlet UILabel *lblAccount1;
@property (weak, nonatomic) IBOutlet UILabel *lblAccount2;
@property (weak, nonatomic) IBOutlet UILabel *lblAccount3;
@property (weak, nonatomic) IBOutlet UILabel *lblCallCustomer;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountViewHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountDetailsHight;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountHolderNmae;


@end
