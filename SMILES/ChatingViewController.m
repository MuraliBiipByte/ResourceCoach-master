

#import "ChatingViewController.h"
#import "MessageData.h"
@import Firebase;
#import "ChatTableViewCellXIB.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "MessageData.h"
#import "JSMessagesViewController.h"
#import "Utility.h"
#import "JSMessageTextView.h"
#import "JSMessageInputView.h"
#import "Language.h"


@interface ChatingViewController () <JSMessagesViewDelegate, JSMessagesViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource, UITableViewDelegate>
{
    UIImage *authoreImg;
    UIImage *senderImg;
  
    UIImage *image;
    UIBarButtonItem *barButtonItem;
    UIBarButtonItem *barButtonItemRight;
    UIBarButtonItem *barButtonItemRightCancel;
      MessageData *message1;
    NSMutableArray *allSnaps;
    
    NSString *message;
    CGSize messageSize;
    FIRDataSnapshot *snapshot1;
    
    NSString *totalString;
   
    CGSize maxSize;
    UIFont *myFont;
    
    CGSize keyboardSize;
    
    NSMutableURLRequest * urlReq;
    NSURLSession * urlSession;
    NSURLSessionDataTask * urlDataTask;
    NSURLSessionConfiguration * urlConfig;
    NSMutableDictionary * dataDict;
    
    NSTimer *myTimer;
    
    UITapGestureRecognizer *gestureRecognizer;
    int tableContentHight ;
    NSString *keyBoard;
    JSMessageTextView *textView;
    UITapGestureRecognizer *gestureRecognizerTouch;
    UIImageView *imgBackgroundEmptyMessages;
    
    NSString *strForValidation;
    
    
}

@property (strong, nonatomic) NSMutableArray *messageArray;
@property (nonatomic,strong) UIImage *willSendImage;

@property (strong, nonatomic) FIRDatabaseReference *postRef;
@property (strong, nonatomic) FIRDatabaseReference *commentsRef;



@end

@implementation ChatingViewController

@synthesize messageArray;


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = self.authorName;
    
    self.delegate = self;
    self.dataSource = self;
    
    _ref = [[FIRDatabase database] reference];
     self.messageArray = [NSMutableArray array];
    allSnaps=[[NSMutableArray alloc]init];
    
   
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
        
        
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,self.authoreImage]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        authoreImg= [UIImage imageWithData:imageData];
        
        
        NSURL *imageSender = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[userDefaults valueForKey:@"profileimage"]]];
        
        NSData *imageSenderData = [NSData dataWithContentsOfURL:imageSender];
        senderImg = [UIImage imageWithData:imageSenderData];
      
    });
      [self reciveMessages];
    [self navigationConfiguration];
    gestureRecognizerTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizerTouch];

  
    self.dislikeButton.enabled=YES;
    self.likeButton.enabled=YES;
    
}
- (void) hideKeyboard
{
    
    if ([textView.text isEqualToString:@""]||[textView.text isEqual:[NSNull null]])
    {
        [self finishSend:YES];
    }
    [self.inputToolBarView.textView resignFirstResponder];
}


#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    
    barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoBack1:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    barButtonItemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chatedit"] style:UIBarButtonItemStylePlain target:self action:@selector(editChat1)];
    [self.navigationItem setRightBarButtonItem:barButtonItemRight];
    
    
    // [self.navigationItem setRightBarButtonItem:barButtonItemRightCancel];
    
    self.title=self.authorName;
    
    
}

-(void)gotoBack1:(id)sender
{
    NSUserDefaults *notifications=[NSUserDefaults standardUserDefaults];
    [notifications setValue:@"" forKey:@"othersId"];
    [notifications setValue:@"" forKey:@"articleid"];
    [notifications setValue:@"" forKey:@"othersProfileImg"];
    [notifications setValue:@"" forKey:@"othersName"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)editChat1
{
    
    self.tableView.editing=YES;
    gestureRecognizerTouch.enabled=NO;
    barButtonItemRight.enabled=NO;
    barButtonItemRightCancel.enabled=YES;
    [barButtonItemRight setTintColor:nil];
    
    
    barButtonItemRightCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEdit1)];
    
    barButtonItemRightCancel.enabled=YES;
    [barButtonItemRightCancel setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:barButtonItemRightCancel];
    
    
    
    //    barButtonItemRightCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEdit)];
    
}
-(void)cancelEdit1
{
    

    self.tableView.editing=NO;
    barButtonItemRight.enabled=YES;
     gestureRecognizerTouch.enabled=YES;
    [barButtonItemRight setTintColor:[UIColor whiteColor]];
    barButtonItemRightCancel.enabled=NO;
    [barButtonItemRightCancel setTintColor:nil];
    
    [self navigationConfiguration];
    
}


//- (void)testData
//{
//    MessageData *message1 = [[MessageData alloc] initWithMsgId:@"0001" text:@"This is a Chat Demo like iMessage.app" date:[NSDate date] msgType:JSBubbleMessageTypeIncoming mediaType:JSBubbleMediaTypeText img:nil];
//
//    [self.messageArray addObject:message1];
//
//    MessageData *message2 = [[MessageData alloc] initWithMsgId:@"0002" text:nil date:[NSDate date] msgType:JSBubbleMessageTypeOutgoing mediaType:JSBubbleMediaTypeImage img:@"demo1.jpg"];
//
//    [self.messageArray addObject:message2];
//
//    MessageData *message3 = [[MessageData alloc] initWithMsgId:@"0003" text:@"Up-to-date for iOS 6.0 and ARC (iOS 5.0+ required) Universal for iPhone Allows arbitrary message (and bubble) sizes Copy & paste text message && Save image message " date:[NSDate date] msgType:JSBubbleMessageTypeOutgoing mediaType:JSBubbleMediaTypeText img:nil];
//
//    [self.messageArray addObject:message3];
//}

-(void)reciveMessages
{
    [Utility showLoading:self];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.userId=[userDefaults valueForKey:@"id"];
    NSString *senderId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"id"]];
    NSString *reciverId;
    
    if ([self.authorId isEqualToString:@""])
    {
        reciverId=[NSString stringWithFormat:@"-%@", [userDefaults valueForKey:@"othersId"]];
        self.articleId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"articleid"]];
        self.title=[userDefaults valueForKey:@"othersName"];
        self.authoreImage=[userDefaults valueForKey:@"othersProfileImg"];
        
        _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
    }
    else
    {
        
        reciverId=[NSString stringWithFormat:@"-%@",self.authorId];
        NSLog(@"Author %@",[NSString stringWithFormat:@"%@",self.authorId]);
        _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
    }
    
    //NSString *reciverMessageId=[NSString stringWithFormat:@"%@_%@_%@",reciverId,senderId,self.articleId];

    
  
    
   
    [[[_ref child:@"messages"] child:_senderMessageId]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         [allSnaps removeAllObjects];
         [self.messageArray removeAllObjects];
         
         NSMutableDictionary *dictionary=snapshot.value;
         if ([dictionary isEqual:[NSNull null]])
         {
             self.tableView.hidden=YES;
              self.tableView.editing=NO;
             
             NSLog(@"All Messages deleted");
             barButtonItemRight.enabled=NO;
             barButtonItemRight.tintColor=[UIColor clearColor];
             barButtonItemRightCancel.enabled=NO;
             barButtonItemRightCancel.tintColor=[UIColor clearColor];
            imgBackgroundEmptyMessages=[[UIImageView alloc]initWithFrame:self.view.bounds];
             imgBackgroundEmptyMessages.image=[UIImage imageNamed:@"chatbackground"];
             [self.view addSubview:imgBackgroundEmptyMessages];
             [self.view bringSubviewToFront:self.inputToolBarView];
//
             
             [Utility hideLoading:self];
                    return ;
         }
         
         else
         
         {
             
             for (snapshot in snapshot.children)
             {
                 imgBackgroundEmptyMessages.hidden=YES;
                 barButtonItemRight.enabled=YES;
                 barButtonItemRight.tintColor=[UIColor whiteColor];
               
               [allSnaps addObject:snapshot];
                  self.tableView.hidden=NO;
                 
                  [Utility hideLoading:self];
                 NSString *userId=snapshot.value[@"user"];
                 
                 NSString* time=snapshot.value[@"time"];
                 double timestramp=[time doubleValue];
                 NSTimeInterval timeinterval=timestramp/1000;
              
                 if ([[userDefaults valueForKey:@"id"] isEqualToString:userId])
                 {
                     
                     NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
                     
                     NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
                     [dateformatter setDateFormat:@"hh:mm a, dd MMM yyyy"];
                    
                     
                     NSString *keywordString=@"resourcecoach_live_images";
                     totalString=snapshot.value[@"message"];
                     NSRange range = [totalString rangeOfString:keywordString];
                     if (range.location == NSNotFound)
                     {
                    message1 = [[MessageData alloc] initWithMsgId:@"" text:snapshot.value[@"message"] date:date msgType:JSBubbleMessageTypeOutgoing mediaType:JSBubbleMediaTypeText img:nil];
                         
                         [self.messageArray addObject:message1];
                     }
                     else
                     {
                        message1 = [[MessageData alloc] initWithMsgId:@"" text:nil date:date msgType:JSBubbleMessageTypeOutgoing mediaType:JSBubbleMediaTypeImage img:snapshot.value[@"message"]];
                         
                         [self.messageArray addObject:message1];
                     }
                     
                 }
                 else
                 {
                     NSString *keywordString=@"resourcecoach_live_images";
                      totalString=snapshot.value[@"message"];
                     NSRange range = [totalString rangeOfString:keywordString];
                     
                     NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
                     
                     NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
                     [dateformatter setDateFormat:@"hh:mm a, dd MMM yyyy"];
                    
                     
                     
                     if (range.location == NSNotFound)
                     {
                         
                     message1 = [[MessageData alloc] initWithMsgId:@"" text:snapshot.value[@"message"] date:date msgType:JSBubbleMessageTypeIncoming mediaType:JSBubbleMediaTypeText img:nil];
                         
                         [self.messageArray addObject:message1];
                         
                     }
                     else
                     {
                        message1 = [[MessageData alloc] initWithMsgId:@"" text:nil date:date msgType:JSBubbleMessageTypeIncoming mediaType:JSBubbleMediaTypeImage img:snapshot.value[@"message"]];
                         
                         [self.messageArray addObject:message1];
                     }
                 }
                 
                 
             }
               [self.tableView reloadData];
             
             NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0];
             [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
             
         }
     }
     ];
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==self.tableView)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
           MessageData *data;
           FIRDataSnapshot *snapshotMessage = [allSnaps objectAtIndex:indexPath.row];
            [snapshotMessage.ref removeValue];

        }

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//     NSString *keywordString=@"omlknowledgebank_live_images";
//    NSRange range = [totalString rangeOfString:keywordString];
//  if (range.location == NSNotFound)
//  {
//  }
//  else
//  {
//      ShowingImagesViewController *imagesClass=[self.storyboard instantiateViewControllerWithIdentifier:@"ShowingImagesViewController"];
//      imagesClass.strImageUrl=totalString;
//      [self.navigationController pushViewController:imagesClass animated:YES];
//  }
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text withUrl:(NSURL *)imageUrl
{
    
    
    NSString *strImageUrl=[imageUrl absoluteString];
    strForValidation=[NSString stringWithFormat:@"%@",text];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.mainAuthoreId=[userDefaults valueForKey:@"mainAuthoreId"];
    
    NSString *senderId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"id"]];
    NSString *senderUserId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"id"]];
    
    NSString *senderName=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"name"]];
    NSString *senderImage=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"profileimage"]];
    NSString *reciverId=[NSString stringWithFormat:@"-%@",self.authorId];
    
    if ([reciverId isEqualToString:@"-"])
    {
        reciverId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"othersId"]];
        self.articleId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"articleid"]];
        
        
        _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
        _reciverMessageId=[NSString stringWithFormat:@"%@_%@_%@",reciverId,senderId,self.articleId];
        
        //self.title=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"othersName"]];
        //self.authoreImage=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"othersProfileImg"]];
    }
    else
    {
        _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
        _reciverMessageId=[NSString stringWithFormat:@"%@_%@_%@",reciverId,senderId,self.articleId];
        
    }
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd-mm-yyyy  HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:currentDate];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:currentTime];
    NSTimeInterval timeInMiliseconds = [dateFromString timeIntervalSince1970]*1000;
    NSString *timeString=[NSString stringWithFormat:@"%f",timeInMiliseconds ];
    
    NSArray* foo = [timeString componentsSeparatedByString: @"."];
    
    FIRDatabaseReference *userLastOnlineRef ;
    
    [userLastOnlineRef onDisconnectSetValue:[FIRServerValue timestamp]];
    NSString *str = [FIRServerValue timestamp];
    
    if ([reciverId isEqualToString:@"-"]||[reciverId isEqual:[NSNull null]]||[reciverId isEqualToString:@"(null)"]||[self.articleId isEqualToString:@""]||[self.articleId isEqual:[NSNull null]]||[self.articleId isEqualToString:@"(null)"])
    {
        NSLog(@"Some Value is missing");
    }
    else
    {
        if (!(strImageUrl==NULL))
            {
                [[[[_ref child:@"messages"]child:_senderMessageId]childByAutoId]
                 
                 setValue:@{@"user":senderUserId,@"message":strImageUrl,@"time":str}];
                
                
            }
        else
        {
            [[[[_ref child:@"messages"]child:_senderMessageId]childByAutoId]
             
             setValue:@{@"user":senderUserId,@"message":text,@"time":str}];
            
           
        }
        
        if (!(strImageUrl==NULL))
        {
            [[APIManager sharedInstance]sendingFCM_Notifications:reciverId withMessage:strImageUrl withReciverName:senderName withReciverProfile:senderImage withReciverUserId:senderUserId withArticleId:self.articleId andCompleteBlock:^(BOOL success, id result)
             {
                 if (!success)
                 {
                     return ;
                 }
                 else

                 {
                     NSLog(@"%@",result);
                 }

             }];
        }
        else
        {
            [[APIManager sharedInstance]sendingFCM_Notifications:reciverId withMessage:text withReciverName:senderName withReciverProfile:senderImage withReciverUserId:senderUserId withArticleId:self.articleId andCompleteBlock:^(BOOL success, id result)
             {
                 if (!success)
                 {
                     return ;
                 }
                 else

                 {
                     NSLog(@"%@",result);
                 }

             }];
        }
        
        if (!(strImageUrl==NULL))
        {
            [[[[_ref child:@"messages"]child:_reciverMessageId]childByAutoId]
             setValue:@{@"user":senderUserId ,@"message":strImageUrl,@"time":str}];
        }
        else
        {
            [[[[_ref child:@"messages"]child:_reciverMessageId]childByAutoId]
             setValue:@{@"user":senderUserId ,@"message":text,@"time":str}];
        }
        
        
        
        NSLog(@"main Auth,Defaults Auth %@-%@",self.mainAuthoreId,[userDefaults valueForKey:@"othersId"]);
        
        if ([senderId isEqualToString:self.mainAuthoreId]||[senderUserId isEqualToString:[userDefaults valueForKey:@"othersId"]])
        {
            
        }
        else
        {
            [[[[_ref child:@"article_user"]child:[NSString stringWithFormat:@"-%@",self.articleId]]child:senderId]
             setValue:@{@"sender_image":senderImage ,@"sender_name":senderName,@"sender_id":[userDefaults valueForKey:@"id"]}];
        }
        
    }
   self.inputToolBarView.textView.text=@"";
    _btnSend.backgroundColor=[UIColor lightGrayColor];
    
    textView.delegate=self;
    [self finishSend:NO];
   _btnSend.enabled = NO;

}

- (void)cameraPressed:(id)sender

{
    
    [self.inputToolBarView.textView resignFirstResponder];
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:[Language Cancel]
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                              }];
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:[Language camera]
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self cameraClick];
                              }];
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:[Language Gallery]
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self galleryClick];
                              }];
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
}

//#pragma mark -- UIActionSheet Delegate
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex)
//    {
//        case 0:
//        {
//            [self cameraClick];
//        }
//        case 1:
//        {
//            int value = arc4random() % 1000;
//            NSString *msgId = [NSString stringWithFormat:@"%d",value];
//            
//            JSBubbleMessageType msgType;
//            if((self.messageArray.count - 1) % 2)
//            {
//                msgType = JSBubbleMessageTypeOutgoing;
//                [JSMessageSoundEffect playMessageSentSound];
//            }else
//            {
//                msgType = JSBubbleMessageTypeIncoming;
//                [JSMessageSoundEffect playMessageReceivedSound];
//            }
//            
//            MessageData *message2 = [[MessageData alloc] initWithMsgId:msgId text:nil date:[NSDate date] msgType:msgType mediaType:JSBubbleMediaTypeImage img:@"demo1.jpg"];
//            
//            
//            
//            [self.messageArray addObject:message2];
//            
//            [self finishSend:YES];
//        }
//            break;
//    }
//}

-(void)cameraClick
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
-(void)galleryClick
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerEditedImage];
    NSData* pictureData = UIImageJPEGRepresentation(image,1.0f);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    NSString *strDate=[NSString stringWithFormat:@"%@.jpg",[dateFormatter stringFromDate:[NSDate date]]];
    [self uploadFileTofireBaseWithUrl:pictureData filename:strDate];
    
    [Utility showLoading:self];

[picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadFileTofireBaseWithUrl:(NSData *)fileData filename:(NSString *)fileName
        {
            
            FIRStorage *storage=[FIRStorage storage];
            FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
            metadata.contentType = @"image/jpeg";
            FIRStorageReference *storageRef = [storage reference];
            NSString *fileFullName=[NSString stringWithFormat:@"resourcecoach_live_images/%@",fileName];
            FIRStorageReference *riversRef = [storageRef child:fileFullName];
            FIRStorageUploadTask *uploadTask = [riversRef putData:fileData metadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error)
                                                {
                                                    if (error != nil)
                                                    {
                                                        // Uh-oh, an error occurred!
                                                    }
                                                    else
                                                    {
                                                        // Metadata contains file metadata such as size, content-type, and download URL.
                        
                   
                    NSURL *downloadURL = metadata.downloadURL;
                    NSLog(@"Url %@",downloadURL);
                    [self sendPressed:nil withText:@"" withUrl:downloadURL];
                    [self finishSend:YES];
                    
                                                    }
                                                    
                                                }];
            [Utility hideLoading:self];
            [uploadTask resume];
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageData *message2 = self.messageArray[indexPath.row];
    return message2.messageType;
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JSBubbleMessageStyleFlat;
}

- (JSBubbleMediaType)messageMediaTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageData *message2 = self.messageArray[indexPath.row];
    return message2.mediaType;
}

- (UIButton *)sendButton
{
    return [UIButton defaultSendButton];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    /*
     JSMessagesViewTimestampPolicyAll = 0,
     JSMessagesViewTimestampPolicyAlternating,
     JSMessagesViewTimestampPolicyEveryThree,
     JSMessagesViewTimestampPolicyEveryFive,
     JSMessagesViewTimestampPolicyCustom
     */
    return   JSMessagesViewTimestampPolicyAll;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    /*
     JSMessagesViewAvatarPolicyIncomingOnly = 0,
     JSMessagesViewAvatarPolicyBoth,
     JSMessagesViewAvatarPolicyNone
     */
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    /*
     JSAvatarStyleCircle = 0,
     JSAvatarStyleSquare,
     JSAvatarStyleNone
     */
    return JSAvatarStyleCircle;
}

- (JSInputBarStyle)inputBarStyle
{
    /*
     JSInputBarStyleDefault,
     JSInputBarStyleFlat

     */
    return JSInputBarStyleFlat;
}

//  Optional delegate method
//  Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MessageData *message2 = self.messageArray[indexPath.row];
    return message2.text;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageData *message2 = self.messageArray[indexPath.row];
    return message2.date;
}

- (UIImage *)avatarImageForIncomingMessage
{
    if ([authoreImg isEqual:[NSNull null]])
    
    {
        authoreImg=[UIImage imageNamed:@"userprofile"];
    }
    

   
    return authoreImg;
}

- (SEL)avatarImageForIncomingMessageAction
{
    return @selector(onInComingAvatarImageClick);
}

- (void)onInComingAvatarImageClick
{
    NSLog(@"__%s__",__func__);
}

- (SEL)avatarImageForOutgoingMessageAction
{
    return @selector(onOutgoingAvatarImageClick);
}

- (void)onOutgoingAvatarImageClick
{
    NSLog(@"__%s__",__func__);
}

- (UIImage *)avatarImageForOutgoingMessage
{
    
    if ([senderImg isEqual:[NSNull null]])
    {
        senderImg=[UIImage imageNamed:@"userprofile"];
    }

    return senderImg;
}

- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageData *message2 =[self.messageArray objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",message2.imgURL]];
    return imageURL;
}

//For like we need to send the value as '1' and for dislike we need to send the value as '0'
//Like
- (void)likePressed:(UIButton *)sender
{
    [Utility showLoading:self];
    
    [[APIManager sharedInstance]sendingLikesandDislikeswithUserId:self.userId andArticleid:self.articleId andAuthorid:self.authorId andlikes:@"1" andCompleteBlock:^(BOOL success, id result)
    {
        [Utility hideLoading:self];
        if (!success)
        {
            NSLog(@"Something went wrong");
        }
        else
        {
            [self.likeButton setImage:[UIImage imageNamed:@"likefilled"] forState:UIControlStateNormal];
            [self.dislikeButton setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
            
            self.dislikeButton.enabled=NO;
            self.likeButton.enabled=NO;
        }
        
    }];
    
    NSLog(@"like clicked");
}
//Dislike
- (void)dislikePressed:(UIButton *)sender
{
    [Utility showLoading:self];
    [[APIManager sharedInstance]sendingLikesandDislikeswithUserId:self.userId andArticleid:self.articleId andAuthorid:self.authorId andlikes:@"0" andCompleteBlock:^(BOOL success, id result)
    {
        [Utility hideLoading:self];
        
        if (!success)
        {
            NSLog(@"Something went wrong");
        }
        else
        {
            [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            [self.dislikeButton setImage:[UIImage imageNamed:@"dislikefill"] forState:UIControlStateNormal];
            
            self.dislikeButton.enabled=NO;
            self.likeButton.enabled=NO;
        }

    }];
    NSLog(@"dislike clicked");
    
}

@end
