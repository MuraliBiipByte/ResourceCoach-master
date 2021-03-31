//
//  MessageViewController.h

//
//  Created by BiipByte on 14/06/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,retain)NSString *authorId;
@property(nonatomic,retain)NSString *authorName;
@property(nonatomic,retain)NSString *articleId;
@property(nonatomic,retain)NSString *authoreImage;
@property(nonatomic,retain)NSString *mainAuthoreId;

@property(nonatomic,retain)NSString *senderMessageId;
@property(nonatomic,retain)NSString *reciverMessageId;

@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@property (nonatomic, readonly, strong) FIRDatabaseReference * ref;
@property (assign, nonatomic, readonly) UIEdgeInsets originalTableViewContentInset;
@property (assign, nonatomic) CGFloat previousTextViewContentHeight;



@end
