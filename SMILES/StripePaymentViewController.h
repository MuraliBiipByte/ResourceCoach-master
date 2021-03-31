//
//  StripePaymentViewController.h
//  Bakester
//
//  Created by BiipByte Technologies on 10/04/17.
//  Copyright © 2017 BiipByte. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StripePaymentViewController : UIViewController

@property (nonatomic,weak) NSString *totalAmount;
@property (nonatomic,weak) NSString *subscriptionID;

@end
