//
//  AppDelegate.m
//  SMILES
//
//  Created by Biipmi on 6/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

//#import "Resource_Coach-Swift.h"
#import "AppDelegate.h"
#import "SplashScreenViewController.h"
#import "RootViewController.h"
#import "NavigationViewController.h"
#import "APIManager.h"
#import "AGPushNoteView.h"
#import "Utility.h"
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotification.h>
#import <UserNotifications/UNNotificationRequest.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationResponse.h>
#import "APIManager.h"
#import "APIDefineManager.h"
#import "APIDefineManager.h"
#import "HomeViewController.h"
#import "ChatingViewController.h"
#import "AVPlayerOverlayVC.h"
#import "AVPlayerVC.h"
#import "NotificationService.h"
@import AVKit;
@import Firebase;
#import "Stripe.h"


#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>{
    UIStoryboard *storyBoard;
    NSString *deviceToken;
    NavigationViewController* navigationController;
    NSUserDefaults *startEndTimeDefaults;
    NSString *startTime,*endTime,*identify,*userid,*articleid;
    AVPlayerVC*playerVC;
  
}
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FIRApp configure];
    
    NSUserDefaults *notificationDefaults=[NSUserDefaults standardUserDefaults];
    NSString *loginId=[NSString stringWithFormat:@"-%@",[notificationDefaults valueForKey:@"id"]];
    [notificationDefaults setValue:@"" forKey:@"othersId"];
    [notificationDefaults setValue:@"" forKey:@"articleid"];
    [notificationDefaults setValue:@"" forKey:@"othersProfileImg"];
    [notificationDefaults setValue:@"" forKey:@"othersName"];
    
    
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);
    
      [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:41.0/255.0 green:54.0/255.0 blue:102.0/255.0 alpha:1]];
//
//    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:65.0/255.0 green:112.0/255.0 blue:182.0/255.0 alpha:1]];
    
   
     //  [[UINavigationBar appearance]t:[UIColor whiteColor]];
    
    // [NSThread sleepForTimeInterval:4.0];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
    storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //Splash screen implementation
    BOOL flagVal = [[NSUserDefaults standardUserDefaults] boolForKey:@"startFlag"];
    if (!flagVal) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"startFlag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SplashScreenViewController *splash = [[SplashScreenViewController alloc] init];
    [self.window setRootViewController:splash];
    }
    else{
        [self tooltipFlag:application];
    }
    [self.window makeKeyAndVisible];
      [self registerForRemoteNotification];
    
//    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_5JgHvNZaz0txLM7DKQwRdutU"];
//    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_TYooMQauvdEDq54NiTphI7jx"];
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_VH4UAn3hX7FuPahqTlEkpI41"];

//    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_VH4UAn3hX7FuPahqTlEkpI41"];


    return YES;

}

-(void) tooltipFlag:(UIApplication *)application
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *userId=[defaults objectForKey:@"id"];
    if ([userId length]>0)
    {
//        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//        [defaults setObject:language forKey:@""];

        RootViewController *homeView=[storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
        self.window.rootViewController = homeView;
        [self.window makeKeyAndVisible];
    }
    else
    {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    startEndTimeDefaults=[NSUserDefaults standardUserDefaults];
    identify=[startEndTimeDefaults valueForKey:@"identity"];
    startTime=[startEndTimeDefaults valueForKey:@"starttime"];
    if ([identify isEqualToString:@"identity"]) {
        if (![startTime isEqualToString:@""]) {
            NSDate *currentDate = [[NSDate alloc] init];
            NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:timeZone];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            endTime = [dateFormatter stringFromDate:currentDate];
            [startEndTimeDefaults setObject:endTime forKey:@"endtime"];
            
            userid=[startEndTimeDefaults valueForKey:@"userid"];
            articleid=[startEndTimeDefaults valueForKey:@"articleid"];
            startTime=[startEndTimeDefaults valueForKey:@"starttime"];
            endTime=[startEndTimeDefaults valueForKey:@"endtime"];
            
            __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
                
                [application endBackgroundTask:bgTask];
                bgTask = UIBackgroundTaskInvalid;
            }];
            
            // Start the long-running task and return immediately.
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[APIManager sharedInstance]startAndEndTimeforArticle:startTime andWithEndTime:endTime withUserId:userid andWithArticleId:articleid andCompleteBlock:^(BOOL success, id result) {
                    if (!success) {
                        return ;
                    }
                    else{
                        [startEndTimeDefaults setObject:@"" forKey:@"starttime"];
                        
                    }
                    [application endBackgroundTask:bgTask];
                    bgTask = UIBackgroundTaskInvalid;
                }];
                
            });
        }
        else{
            NSLog(@"No Start Time");
        }
    }
    else
    {
        [startEndTimeDefaults setObject:@"" forKey:@"identity"];
        [startEndTimeDefaults setObject:@"" forKey:@"starttime"];
        
    }   
    
//    //Updating VideoTime
//    
//    [playerVC.player pause];
//    AVPlayerOverlayVC *avPlay=[[AVPlayerOverlayVC alloc]init];
//    CMTime duration = playerVC.player.currentItem.duration; //total time
//    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
//    
//    NSUInteger cHours = floor(cTotalSeconds / 3600);
//    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
//    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
//    
//    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
//    NSLog(@"time :%@",videoDurationText);
//    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
//    CMTime currentTime =playerVC.player.currentTime; //playing time
//    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
//    
//    NSUInteger dHours = floor(dTotalSeconds / 3600);
//    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
//    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
//    
//    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
//    NSLog(@"time :%@",cvideoDurationText);
//    
//    NSUserDefaults *defaul=[NSUserDefaults standardUserDefaults];
//    [defaul setValue:cvideoDurationText forKey:@"VCT"];
//    
//    
//    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
//
//   
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    NSString *VideostartTime=@"00:00:00";
//    NSString *VideoendTime=  [defaults valueForKey:@"VCT"];
//    NSString *miniCertId=[defaults valueForKey:@"miniid"];
//    NSString *artId=[defaults valueForKey:@"artid"];
//    
//    
//    if (!(miniCertId.length==0)) {
//        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userid andWithAssementId:miniCertId withArticleId:artId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result) {
//            if(!success)
//            {
//                return ;
//                
//            }
//            else{
//                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//                [defaults setValue:@"" forKey:@"VCT"];
//                [defaults setValue:@"" forKey:@"miniid"];
//                [defaults setValue:@"" forKey:@"artid"];
//                
//                NSLog(@"Success");
//            }
//        }];
//        
//        
//    }
//    else{
//        NSLog(@"No mini cer id");
//    }
    }

- (void)applicationDidEnterBackground:(UIApplication *)application {

  }

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application


{
    application.applicationIconBadgeNumber=0;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
       deviceToken=[defaults objectForKey:@"token"];
    if ([deviceToken length]==0) {
        NSLog(@"Ok");
    }
    else{
        [[APIManager sharedInstance]resetBadgeCountWithDeviceId:deviceToken andCompleteBlock:^(BOOL success, id result) {
                      if (!success) {
                NSLog(@"count is not reset");
                return ;
            }
            NSLog(@"count is reset");
        }];
    }
    identify=[startEndTimeDefaults valueForKey:@"identity"];
    if ([identify isEqualToString:@"identity"]) {
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        startTime = [dateFormatter stringFromDate:currentDate];
        [startEndTimeDefaults setObject:startTime forKey:@"starttime"];
    }
    else{
        NSLog(@"Need to go some other controller");
    }
    
//    [playerVC.player pause];
//    AVPlayerOverlayVC *avPlay=[[AVPlayerOverlayVC alloc]init];
//    CMTime duration = playerVC.player.currentItem.duration; //total time
//    NSUInteger cTotalSeconds = CMTimeGetSeconds(duration);
//    
//    NSUInteger cHours = floor(cTotalSeconds / 3600);
//    NSUInteger cMinutes = floor(cTotalSeconds % 3600 / 60);
//    NSUInteger cSeconds = floor(cTotalSeconds % 3600 % 60);
//    
//    NSString *videoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",cHours, cMinutes, cSeconds];
//    NSLog(@"time :%@",videoDurationText);
//    NSLog(@"seconds = %f", CMTimeGetSeconds(duration));
//    CMTime currentTime =playerVC.player.currentTime; //playing time
//    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentTime);
//    
//    NSUInteger dHours = floor(dTotalSeconds / 3600);
//    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
//    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
//    
//    NSString *cvideoDurationText = [NSString stringWithFormat:@"%02i:%02i:%02i",dHours, dMinutes, dSeconds];
//    NSLog(@"time :%@",cvideoDurationText);
//    
//    NSUserDefaults *defaul=[NSUserDefaults standardUserDefaults];
//    [defaul setValue:cvideoDurationText forKey:@"VCT"];
//    
//    
//    NSLog(@"seconds = %f", CMTimeGetSeconds(currentTime));
//    
//    
//    //Updating VideoTime
//    NSUserDefaults *defaultsVideo=[NSUserDefaults standardUserDefaults];
//    NSString *VideostartTime=@"00:00:00";
//    NSString *VideoendTime=  [defaultsVideo valueForKey:@"VCT"];
//    NSString *miniCertId=[defaultsVideo valueForKey:@"miniid"];
//    NSString *artId=[defaultsVideo valueForKey:@"artid"];
//    
//    if (!(miniCertId.length==0)) {
//        [[APIManager sharedInstance]updatingVideoDurationWithUserId:userid andWithAssementId:miniCertId withArticleId:artId withStartTime:VideostartTime andWithEndTime:VideoendTime andCompleteBlock:^(BOOL success, id result) {
//            if(!success)
//            {
//                return ;
//                
//            }
//            else{
//                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//                [defaults setValue:@"" forKey:@"VCT"];
//                [defaults setValue:@"" forKey:@"miniid"];
//                [defaults setValue:@"" forKey:@"artid"];
//                
//                NSLog(@"Success");
//            }
//        }];
//
//        
//    }
//    else{
//        NSLog(@"No mini cer id");
//       }
//
   }

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    NSLog(@"app terminate");
}



#pragma mark - Remote Notification Delegate // <= iOS 9.x

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Device not registered");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *strDevicetoken = [[NSString alloc]initWithFormat:@"%@",[[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSLog(@"Device Token = %@",strDevicetoken);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:strDevicetoken forKey:@"token"];
    [defaults synchronize];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Push Response is %@",userInfo);
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        
        NSString *articleId=[userInfo valueForKey:@"gcm.notification.receiver_artical_id"];
        NSMutableDictionary *apsDict=[userInfo valueForKey:@"aps"];
        NSString *message;
        
        if ([articleId isEqual:[NSNull null]]) {
            NSMutableDictionary *alertDictionary=[apsDict valueForKey:@"alert"];
               NSLog(@"alertDictionary %@",alertDictionary);
        
              message=[alertDictionary valueForKey:@"title"];
        }
        else{
        
        message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        }
        [AGPushNoteView showWithNotificationMessage:[NSString stringWithFormat:message]];
        [AGPushNoteView setMessageAction:^(NSString *message) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DedaaBox"
                                                            message:message  delegate:nil  cancelButtonTitle:@"Close"
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    } else {
        NSLog(@"No Notification");
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    deviceToken=[defaults objectForKey:@"token"];
    if ([deviceToken length]==0) {
        NSLog(@"Ok");
    }
    else{
        [[APIManager sharedInstance]resetBadgeCountWithDeviceId:deviceToken andCompleteBlock:^(BOOL success, id result) {
            if (!success) {
                NSLog(@"count is not reset");
                return ;
            }
            NSLog(@"count is reset");
        }];
    }
}

#pragma mark - UNUserNotificationCenter Delegate // >= iOS 10

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog(@"User Info = %@",notification.request.content.userInfo);
   // [NSBundle bundleForClass:[NotificationService class]];
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
//    
//    NSLog(@"User Info User Info1 = %@",response.notification.request.content.userInfo);
//    
//    NSMutableDictionary *apsDictionary = [response.notification.request.content.userInfo valueForKey:@"aps"] ;
//    NSLog(@"apsDictionary %@",apsDictionary);
//    
//    NSMutableDictionary *alertDictionary=[apsDictionary valueForKey:@"alert"];
//    NSLog(@"alertDictionary %@",alertDictionary);
//    
//    NSString *megtitle=[alertDictionary valueForKey:@"title"];
//    NSString *articleId=[response.notification.request.content.userInfo valueForKey:@"gcm.notification.receiver_artical_id"];
//    
//   
//    
//    
//    
//    completionHandler();
//}
//
//#pragma mark - Class Methods
//
///**
// Notification Registration
// */
- (void)registerForRemoteNotification {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error )
            {
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                   [[UIApplication sharedApplication] registerForRemoteNotifications];
                });

                
            }
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSDictionary *Info=userInfo;
    NSLog(@"userInfo this is =>%@", Info);
    
    NSUserDefaults *notificationDefaults=[NSUserDefaults standardUserDefaults];
    NSString *loginId=[NSString stringWithFormat:@"-%@",[notificationDefaults valueForKey:@"id"]];
    [notificationDefaults setValue:@"" forKey:@"othersId"];
    [notificationDefaults setValue:@"" forKey:@"articleid"];
    [notificationDefaults setValue:@"" forKey:@"othersProfileImg"];
    [notificationDefaults setValue:@"" forKey:@"othersName"];
    [notificationDefaults setValue:@"" forKey:@"miniid"];
    [notificationDefaults setValue:@"" forKey:@"count"];
    
//    for (NSDictionary *project in userInfo[@"gcm.notification.receiver_userid"])
//    {
//        NSLog(@"Project name: %@", project);
//    }
//
    
    
    if ([Info objectForKey:@"quiz_count"])
    {
        NSLog(@"There's an object set for key @\"b\"!");
    } else {
        
        NSDictionary *aps=[Info valueForKey:@"aps"];
        NSString *strCount=[NSString stringWithFormat:@"%@",[aps valueForKey:@"quiz_count"]];
        [notificationDefaults setValue:strCount forKey:@"count"];
        
        if ([strCount isEqualToString:@"1"]) {
           
            NSString *dictAssement=[aps valueForKey:@"assessment"];
            NSLog(@"dictAssement is %@",dictAssement);
            [notificationDefaults setValue:dictAssement forKey:@"miniid"];
        }
        else {
             [notificationDefaults setValue:@"" forKey:@"miniid"];
        }
        RootViewController *homeView=[storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
        self.window.rootViewController = homeView;
        [self.window makeKeyAndVisible];
    }
    
   
    
    NSString *articleID=[Info valueForKey:@"gcm.notification.receiver_artical_id"];
    NSString *othersProfileImg=[Info valueForKey:@"gcm.notification.receiver_profileimg"];
     NSString *othersName=[Info valueForKey:@"gcm.notification.receiver_usename"];
     NSString *othersId=[NSString stringWithFormat:@"%@",[Info valueForKey:@"gcm.notification.receiver_userid"]];
    
    
    BOOL firbase;
    NSString *t_st = @"(";
    NSRange rang =[othersId rangeOfString:t_st options:NSCaseInsensitiveSearch];
    
    if (rang.length == [t_st length])
    {
        firbase=YES;
    }
    else
    {
        firbase=NO;
    }
    
    if (firbase==NO)
    {
     
        [notificationDefaults setValue:othersId forKey:@"othersId"];
        [notificationDefaults setValue:articleID forKey:@"articleid"];
        [notificationDefaults setValue:othersProfileImg forKey:@"othersProfileImg"];
        [notificationDefaults setValue:othersName forKey:@"othersName"];
        
        NSString *userId=[notificationDefaults objectForKey:@"id"];

        
        if (userId.length>0) {
            RootViewController *homeView=[storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
            self.window.rootViewController = homeView;
            [self.window makeKeyAndVisible];

        }
        else{
            [notificationDefaults setValue:@"" forKey:@"othersId"];
            [notificationDefaults setValue:@"" forKey:@"articleid"];
            [notificationDefaults setValue:@"" forKey:@"othersProfileImg"];
            [notificationDefaults setValue:@"" forKey:@"othersName"];

        }
        
        
    }
    else{
        
        [notificationDefaults setValue:@"" forKey:@"othersId"];
        [notificationDefaults setValue:@"" forKey:@"articleid"];
        [notificationDefaults setValue:@"" forKey:@"othersProfileImg"];
        [notificationDefaults setValue:@"" forKey:@"othersName"];
    }
    
    
    
    
    
}

@end
