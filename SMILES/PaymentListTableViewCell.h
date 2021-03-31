//
//  PaymentListTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 21/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSubscriptionName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubscriptionDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
@property (weak, nonatomic) IBOutlet UIView *payListView;

@end
