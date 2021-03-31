//
//  PaymentViewController.h
//  DedaaBox
//
//  Created by BiipByte on 22/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface PaymentViewController : UIViewController<UIWebViewDelegate>

//Outlets

@property (weak, nonatomic) IBOutlet UIWebView *paymentWebView;
@property (nonatomic, retain) NSString *sourceNumber;
@property (nonatomic, retain) NSString *AccountHolder;
@property (nonatomic, retain) NSString *subscriptionId;
@property (nonatomic, retain) NSString *amount;


@end
