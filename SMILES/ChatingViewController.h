 

#import "JSMessagesViewController.h"
@import Firebase;

@interface ChatingViewController : JSMessagesViewController

@property(nonatomic,retain)NSString *userId;
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
