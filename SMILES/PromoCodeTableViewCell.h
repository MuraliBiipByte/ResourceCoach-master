//
//  PromoCodeTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 11/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoCodeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPromoCode;
@property (weak, nonatomic) IBOutlet UILabel *lblValidFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblValidTill;


@property (weak, nonatomic) IBOutlet UILabel *lblSubscriptionName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubValidFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblSUbValidTill;






@end
