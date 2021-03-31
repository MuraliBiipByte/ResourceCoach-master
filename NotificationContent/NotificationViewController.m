//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by Admin on 20/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>


@property IBOutlet UIImageView *picURL;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}
- (void)didReceiveNotification:(UNNotification *)notification
{
    //self.label.text = notification.request.content.body;
    
    NSDictionary *dict = notification.request.content.userInfo;
    
    for (UNNotificationAttachment *attachment in notification.request.content.attachments)
    {
        if ([dict objectForKey:@"pic_url"] && [attachment.identifier
                                               isEqualToString:[[dict objectForKey:@"pic_url"] lastPathComponent]])
        {
            if ([attachment.URL startAccessingSecurityScopedResource])
            {
                NSData *imageData = [NSData dataWithContentsOfURL:attachment.URL];
                
                self.picURL.image = [UIImage imageWithData:imageData];
                
                // This is done if the spread url is not downloaded then both the image view will show cover url.
                self.picURL.image = [UIImage imageWithData:imageData];
                [attachment.URL stopAccessingSecurityScopedResource];
            }
        }
    }
}


@end
