//
//  Utility.m
//  HygieneWatch
//
//  Created by Subba AV on 25/04/2016.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Utility.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "APIDefineManager.h"
#import "Constants.h"
#import "Macros.h"
#import "HYCircleLoadingView.h"

@implementation Utility



+ (void)changeBackgroundButtonFor:(BUTTON_COLOR)color andButton:(UIButton*)button
{
    NSString *imageName = @"orangeButton.png";
    NSString *imageHighlightName = @"orangeButton.png";
    
    switch (color) {
        case BLACK_COLOR:
            imageName = @"blackButton.png";
            imageHighlightName = @"blackButtonHighlight.png";
            break;
        case BLUE_COLOR:
            imageName = @"blueButton.png";
            imageHighlightName = @"blueButtonHighlight.png";
            break;
        case GREEN_COLOR:
            imageName = @"greenButton.png";
            imageHighlightName = @"greenButtonHighlight.png";
            break;
        case GREY_COLOR:
            imageName = @"greyButton.png";
            imageHighlightName = @"greyButtonHighlight.png";
            break;
        case ORANGE_COLOR:
            imageName = @"orangeButton.png";
            imageHighlightName = @"orangeButtonHighlight.png";
            break;
        case TAN_COLOR:
            imageName = @"tanButton.png";
            imageHighlightName = @"tanButtonHighlight.png";
            break;
        case WHITE_COLOR:
            imageName = @"whiteButton.png";
            imageHighlightName = @"whiteButtonHighlight.png";
            break;
        default:
            break;
    }
    
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
}


//Email Validation

+ (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

//AlertController
+(void)showAlert:(NSString *)title withMessage:(NSString *)message;
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
       delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];

    [alert show];
}



+ (float) scaleiPhone5{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float scale = (float) screenRect.size.height / (float)568;
    return scale;
}

+ (float)scaleiPhone6Plus
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float scale = (float) screenRect.size.height / (float)736;
    return scale;
}

+ (NSString *)convertDateTimeToSKU:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyMMddHHmmss";
    
    NSString *todayFromString = [dateFormatter stringFromDate:date];
    return todayFromString;
}

+ (NSString *)convertDateTime:(NSDate*)date andFormatDate:(NSString*)formatDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatDate;
    
    NSString *todayFromString = [dateFormatter stringFromDate:date];
    return todayFromString;
}

+ (NSDate *)convertStringToDate:(NSString *)strDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *serverDate = [dateFormatter dateFromString:strDate];
    return serverDate;
}

+ (NSString*)convertStringToDateString:(NSString*)strDate
{
    NSDate *date = [self convertStringToDate:strDate];
    NSString *dateStr = [self convertDateTime:date andFormatDate:FORMAT_DATE_01];
    return dateStr;
}

+ (NSString *)convertDateStringToLocalDate:(NSString*)dateString
{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //Create the date assuming the given string is in GMT
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date = [df dateFromString:dateString];
    
    //Create a date string in the local timezone
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSString *localDateString = [df stringFromDate:date];
    return localDateString;
}

+ (NSString*)convertLocalDateToGTMZero:(NSString*)localDate
{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //Create the date assuming the given string is in GMT
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSDate *date = [df dateFromString:localDate];
    
    //Create a date string in the local timezone
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSString *dateString = [df stringFromDate:date];
    return dateString;
}

+ (NSTimeInterval)convertDateToTimeInterval:(NSString*)dateString
{
    NSString *localDateString = [self convertDateStringToLocalDate:dateString];
    //    NSLog(@"date = %@", localDateString);
    NSDate *localDate = [self convertStringToDate:localDateString];
    
    NSTimeInterval timeInterval = [localDate timeIntervalSinceNow];
    return timeInterval;
}

+ (BOOL)checkNetworkAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    return [reachability currentReachabilityStatus];
}

+ (void)networkIndicator:(BOOL)turnOn {
    if (turnOn)
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    else
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}




//Loading View
+ (void)showLoading:(UIViewController *)viewController
{
    //    if (isShowOverlay) [self showOverLay:viewController.view];
    MBProgressHUD *_hud = (MBProgressHUD*)[viewController.view viewWithTag:99999];
    
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:viewController.view];
        _hud.tag = 99999;
        _hud.labelText = @"Loading";
        [viewController.view addSubview:_hud];
    }
    [viewController.navigationController.navigationBar setUserInteractionEnabled:NO];
    [viewController.tabBarController.tabBar setUserInteractionEnabled:NO];
    [viewController.view setUserInteractionEnabled:NO];
    [_hud show:YES];
}



+ (void)hideLoading:(UIViewController *)viewController
{
    MBProgressHUD *_hud = (MBProgressHUD*)[viewController.view viewWithTag:99999];
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:viewController.view];
        _hud.tag = 99999;
        _hud.labelText = @"Loading";
       
       
        [viewController.view addSubview:_hud];
    }
    [viewController.navigationController.navigationBar setUserInteractionEnabled:YES];
    [viewController.tabBarController.tabBar setUserInteractionEnabled:YES];
    [viewController.view setUserInteractionEnabled:YES];
    //    [self hideOverLay:viewController.view];
    [_hud hide:YES];
}

+ (NSString*)generateString
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    return [dateFormatter stringFromDate:now];
}

+ (NSString *)getErrorDescription:(INTULocationStatus)status
{
    if (status == INTULocationStatusServicesNotDetermined) {
        return @"Error: User has not responded to the permissions alert.";
    }
    if (status == INTULocationStatusServicesDenied) {
        return @"Error: User has denied this app permissions to access device location.";
    }
    if (status == INTULocationStatusServicesRestricted) {
        return @"Error: User is restricted from using location services by a usage policy.";
    }
    if (status == INTULocationStatusServicesDisabled) {
        return @"Error: Location services are turned off for all apps on this device.";
    }
    return @"An unknown error occurred.\n(Are you using iOS Simulator with location set to 'None'?)";
}

+ (NSString*) encryptString:(NSString*)str
{
    NSData *cipherData = [[str dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:AES256_KEY];
    NSString *base64Text = [cipherData base64EncodedString];
    return base64Text;
}

+ (NSString*) decryptString:(NSString*)str
{
    NSData *cipherData = [str base64DecodedData];
    NSString *plainText  = [[NSString alloc] initWithData:[cipherData AES256DecryptWithKey:AES256_KEY] encoding:NSUTF8StringEncoding];
    return plainText;
}

//+ (User*)getMyUser
//{
//    User *user = (User *)(GET_OBJECT(USER_DATA));
//    if (user.userPhoto) {
//        user.userPhoto = [NSString stringWithFormat:@"%@/%@",BASE_URL,[Utility decryptString:user.userPhoto]];
//        
//        NSLog(@"User image is %@",user.userPhoto);
//    }
//    if (user.userPhoto) {
//        user.userPhoto = [NSString stringWithFormat:@"%@/%@",BASE_URL,[Utility decryptString:user.userPhoto]];
//        NSLog(@"User image is %@",user.userPhoto);
//    }
//    SET_OBJECT(USER_DATA, user);
//    return user;
//}
//
//+ (User *)decryptUser:(User *)user
//{
////    if (user.urlPhoto) {
////        user.urlPhoto = [NSString stringWithFormat:@"%@/%@",BASE_URL,[Utility decryptString:user.urlPhoto]];
////        
////        NSLog(@"User image is %@",user.urlPhoto);
////        
////    }
////    
////    if (user.urlPhotothumb) {
////        user.urlPhotothumb = [NSString stringWithFormat:@"%@/%@",BASE_URL,[Utility decryptString:user.urlPhotothumb]];
////        NSLog(@"User Thumb is %@",user.urlPhotothumb);
////        
////    }
//    return user;
//}

+ (NSString *)htmlFromBodyString:(NSString *)htmlBodyString
                        textFont:(UIFont *)font
                       textColor:(UIColor *)textColor
{
    NSInteger numComponents = CGColorGetNumberOfComponents([textColor CGColor]);
    
    NSAssert(numComponents == 4 || numComponents == 2, @"Unsupported color format");
    
    // E.g. FF00A5
    NSString *colorHexString = nil;
    
    const CGFloat *components = CGColorGetComponents([textColor CGColor]);
    
    if (numComponents == 4)
    {
        unsigned int red = components[0] * 255;
        unsigned int green = components[1] * 255;
        unsigned int blue = components[2] * 255;
        colorHexString = [NSString stringWithFormat:@"%02X%02X%02X", red, green, blue];
    }
    else
    {
        unsigned int white = components[0] * 255;
        colorHexString = [NSString stringWithFormat:@"%02X%02X%02X", white, white, white];
    }
    //-ms-word-break: break-all; word-break: break-all;
    
    NSString *HTML = [NSString stringWithFormat:@"<html>\n"
                      "<head>\n"
                      "<style type=\"text/css\">\n"
                      "body {font-family: \"%@\"; font-size: %@; color:#%@;}\n"
                      "</style>\n"
                      "</head>\n"
                      "<body>%@</body>\n"
                      "</html>",
                      font.familyName, @(font.pointSize), colorHexString, htmlBodyString];
    
    return HTML;
}

+ (void)labelSizeToFit:(UILabel*)label andText:(NSString*)text andOriginY:(CGFloat)y
{
    //    label.numberOfLines = 1;
    label.text = text;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: label.font}];
    
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, adjustedSize.height + 5);
    //    CGSize lLabelSize = [text sizeWithFont:label.font forWidth:label.frame.size.width lineBreakMode:label.lineBreakMode];
    //    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, lLabelSize.height);
    //    label.font = [UIFont fontWithName:label.font.fontName size:label.font.pointSize * [Utilities scaleiPhone6Plus]];
    //    [label sizeToFit];
    
    CGRect rect = label.frame;
    rect.origin.y = y;
    label.frame = rect;
}


@end
