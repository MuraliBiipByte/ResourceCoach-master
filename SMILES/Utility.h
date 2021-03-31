//
//  Utility.h
//  HygieneWatch
//
//  Created by Subba AV on 25/04/2016.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "INTULocationManager.h"


@interface Utility : NSObject

+ (void)changeBackgroundViewFor:(UIColor *)color andButton:(UIView*)button;
+ (void)changeBackgroundButtonFor:(BUTTON_COLOR)color andButton:(UIButton*)button;
+ (BOOL)validateEmail:(NSString *)emailStr;
+(void)showAlert:(NSString *)title withMessage:(NSString *)message;
+ (void)showLoading:(UIViewController *)viewController;
+ (void)hideLoading:(UIViewController *)viewController;
+ (float) scaleiPhone5;
+ (float) scaleiPhone6Plus;
+ (NSString *)convertDateTime:(NSDate*)date andFormatDate:(NSString*)formatDate;
+ (NSString *)convertDateTimeToSKU:(NSDate*)date;
+ (BOOL)checkNetworkAvailable;
+ (void)networkIndicator:(BOOL)turnOn;
+ (NSString*)generateString;
+ (NSString *)getErrorDescription:(INTULocationStatus)status;
+ (NSString*) encryptString:(NSString*)str;
+ (NSString*) decryptString:(NSString*)str;
+ (NSDate *)convertStringToDate:(NSString *)strDate;
+ (NSString*)convertStringToDateString:(NSString*)strDate;
+ (NSString *)convertDateStringToLocalDate:(NSString*)dateString;
+ (NSString *)convertLocalDateToGTMZero:(NSString*)localDate;
+ (NSTimeInterval)convertDateToTimeInterval:(NSString*)dateString;
+ (NSString *)htmlFromBodyString:(NSString *)htmlBodyString
                        textFont:(UIFont *)font
                       textColor:(UIColor *)textColor;
+ (void)labelSizeToFit:(UILabel*)label andText:(NSString*)text andOriginY:(CGFloat)y;




@end
