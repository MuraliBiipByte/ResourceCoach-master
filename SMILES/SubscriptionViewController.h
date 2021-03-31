//
//  SubscriptionViewController.h
//  DedaaBox
//
//  Created by BiipByte on 20/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscriptionViewController : UIViewController<UITextFieldDelegate>

//Uiviews for Payment
@property (nonatomic,weak) IBOutlet UIView *viewPromoCode;
@property (nonatomic,weak) IBOutlet UIView *viewScratchCard;
@property (nonatomic,weak) IBOutlet UIView *viewSuccess;


//for Promocode
@property (weak, nonatomic) IBOutlet UIButton *btnCouponApply;
@property (weak, nonatomic) IBOutlet UITextField *txtCopounCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCouponCodeWrong;
@property (weak, nonatomic) IBOutlet UILabel *lblApplyCouponTitle;

//for Scratch card
@property (weak, nonatomic) IBOutlet UIButton *btnScratchCardApply;
@property (weak, nonatomic) IBOutlet UITextField *txtScratchCardCode;
@property (weak, nonatomic) IBOutlet UILabel *lblScratchCodeWrong;
@property (weak, nonatomic) IBOutlet UILabel *lblScratchTitle;

@property (weak,nonatomic) IBOutlet UIButton *btnPopupHiden;

@end
