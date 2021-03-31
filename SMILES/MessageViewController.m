//
//  MessageViewController.m

//
//  Created by BiipByte on 14/06/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "MessageViewController.h"
@import Firebase;
#import "ChatTableViewCellXIB.h"
#import "UIImageView+WebCache.h"
#import "APIDefineManager.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "UITouchTableView.h"
#import "Utility.h"
@interface MessageViewController ()
{
    NSMutableArray *allSnaps;
    NSString *message;
    CGSize messageSize;
    FIRDataSnapshot *snapshot1;
    
    UIBarButtonItem *barButtonItem;
    UIBarButtonItem *barButtonItemRight;
    UIBarButtonItem *barButtonItemRightCancel;
    CGSize maxSize;
    UIFont *myFont;
    
    CGSize keyboardSize;
    
    NSMutableURLRequest * urlReq;
    NSURLSession * urlSession;
    NSURLSessionDataTask * urlDataTask;
    NSURLSessionConfiguration * urlConfig;
    NSMutableDictionary * dataDict;

    
    UITapGestureRecognizer *gestureRecognizer;
    int tableContentHight ;
    NSString *keyBoard;

    
}

@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (weak, nonatomic) IBOutlet UIView *chatTextBackGroundView;

//@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
//@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet UITextField *chatTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (strong, nonatomic) FIRDatabaseReference *postRef;
@property (strong, nonatomic) FIRDatabaseReference *commentsRef;


/*Uncomment second line and comment first to use XIB instead of code*/
@property (strong,nonatomic) ChatTableViewCellXIB *chatCell;



@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ref = [[FIRDatabase database] reference];
     allSnaps = [[NSMutableArray alloc] init];
    _chatTable.allowsSelection = NO;
    
   
   
   
    [[self chatTable] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[self chatTable] registerClass:[ChatTableViewCellXIB class] forCellReuseIdentifier:@"chatSend"];
    [[self chatTable] registerClass:[ChatTableViewCellXIB class] forCellReuseIdentifier:@"chatReceive"];
    

    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_chatTable addGestureRecognizer:gestureRecognizer];
     gestureRecognizer.enabled=YES;
    
    _chatTextBackGroundView.layer.cornerRadius=20;
    _chatTextBackGroundView.layer.masksToBounds=YES;
    

    _chatTextBackGroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    //_chatTextBackGroundView.layer.shadowOffset = CGSizeMake(4.0f,4.0f);
    _chatTextBackGroundView.layer.shadowOffset = CGSizeZero;
    _chatTextBackGroundView.layer.masksToBounds = NO;
    _chatTextBackGroundView.layer.shadowRadius = 4.0f;
    _chatTextBackGroundView.layer.shadowOpacity = 1.0;
    
    
 
    _btnSend.layer.cornerRadius=_btnSend.frame.size.height/2;
    _btnSend.layer.masksToBounds=YES;
    
    _btnSend.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _btnSend.layer.shadowOffset = CGSizeZero;
    _btnSend.layer.masksToBounds = NO;
    _btnSend.layer.shadowRadius = 4.0f;
    _btnSend.layer.shadowOpacity = 1.0;
    
    _chatTextView.keyboardType = UIKeyboardTypeASCIICapable;
    
    _btnSend.backgroundColor=[UIColor lightGrayColor];
     _btnSend.enabled = NO;
    
    
}





-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if ([allSnaps count]>0)
//    {
//        NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
//    [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }
    if ([allSnaps count]>0)
    {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
        [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
   
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//     [self reciveMessages];
//    
//    
//}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{

    barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoBack:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    barButtonItemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chatedit"] style:UIBarButtonItemStylePlain target:self action:@selector(editChat)];
    [self.navigationItem setRightBarButtonItem:barButtonItemRight];
    
   
   // [self.navigationItem setRightBarButtonItem:barButtonItemRightCancel];
  
     self.title=self.authorName;
    
    
}

-(void)gotoBack:(id)sender
{
    NSUserDefaults *notifications=[NSUserDefaults standardUserDefaults];
        [notifications setValue:@"" forKey:@"othersId"];
        [notifications setValue:@"" forKey:@"articleid"];
        [notifications setValue:@"" forKey:@"othersProfileImg"];
        [notifications setValue:@"" forKey:@"othersName"];
    
       [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)editChat
{
    _chatTable.editing=YES;
    barButtonItemRight.enabled=NO;
    barButtonItemRightCancel.enabled=YES;
    [barButtonItemRight setTintColor:nil];
    
    barButtonItemRightCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEdit)];
    
    barButtonItemRightCancel.enabled=YES;
    [barButtonItemRightCancel setTintColor:[UIColor whiteColor]];
    
    self.chatTable.delegate=self;
    [self.navigationItem setRightBarButtonItem:barButtonItemRightCancel];

    
    
//    barButtonItemRightCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEdit)];
    
}
-(void)cancelEdit
{
    _chatTable.editing=NO;
    barButtonItemRight.enabled=YES;
    [barButtonItemRight setTintColor:[UIColor whiteColor]];
    barButtonItemRightCancel.enabled=NO;
    [barButtonItemRightCancel setTintColor:nil];
    self.chatTable.delegate=self;

    [self navigationConfiguration];

}

- (IBAction)btnSendMessage:(id)sender
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.mainAuthoreId=[userDefaults valueForKey:@"mainAuthoreId"];
    
    NSString *senderId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"id"]];
    NSString *senderUserId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"id"]];
    
    NSString *senderName=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"name"]];
    NSString *senderImage=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"profileimage"]];
    NSString *reciverId=[NSString stringWithFormat:@"-%@",self.authorId];
    
    if ([reciverId isEqualToString:@"-"]) {
        reciverId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"othersId"]];
        self.articleId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"articleid"]];
        
        
        _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
        _reciverMessageId=[NSString stringWithFormat:@"%@_%@_%@",reciverId,senderId,self.articleId];
        
        //self.title=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"othersName"]];
        //self.authoreImage=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"othersProfileImg"]];
    }
    else{
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
    
    if ([reciverId isEqualToString:@"-"]||[reciverId isEqual:[NSNull null]]||[reciverId isEqualToString:@"(null)"]||[self.articleId isEqualToString:@""]||[self.articleId isEqual:[NSNull null]]||[self.articleId isEqualToString:@"(null)"]) {
        NSLog(@"Some Value is missing");
    }
    else
    {
        [[[[_ref child:@"messages"]child:_senderMessageId]childByAutoId]
         
         setValue:@{@"user":senderUserId,@"message":_chatTextView.text,@"time":str}];
        
        [[APIManager sharedInstance]sendingFCM_Notifications:reciverId withMessage:_chatTextView.text withReciverName:senderName withReciverProfile:senderImage withReciverUserId:senderUserId withArticleId:self.articleId andCompleteBlock:^(BOOL success, id result) {
            if (!success) {
                return ;
            }
            else{
                NSLog(@"%@",result);
            }
            
        }];
        
        
        
        
        [[[[_ref child:@"messages"]child:_reciverMessageId]childByAutoId]
         setValue:@{@"user":senderUserId ,@"message":_chatTextView.text,@"time":str}];
        
        NSLog(@"main Auth,Defaults Auth %@-%@",self.mainAuthoreId,[userDefaults valueForKey:@"othersId"]);
        
        if ([senderId isEqualToString:self.mainAuthoreId]||[senderUserId isEqualToString:[userDefaults valueForKey:@"othersId"]])
        {
            
        }
        else{
            [[[[_ref child:@"article_user"]child:[NSString stringWithFormat:@"-%@",self.articleId]]child:senderId ]
             setValue:@{@"sender_image":senderImage ,@"sender_name":senderName,@"sender_id":[userDefaults valueForKey:@"id"]}];
        }
        
    }
    _chatTextView.text=@"";
    _btnSend.backgroundColor=[UIColor lightGrayColor];
    _btnSend.enabled = NO;
    if (tableContentHight<=280) {
        [self.view endEditing:YES];
    }
    // [self reciveMessages];

    
    
}
#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allSnaps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    NSString * strMyId=[NSString stringWithFormat:@"%@",[defa valueForKey:@"id"]];
    snapshot1 = [allSnaps objectAtIndex:indexPath.row];
    message = snapshot1.value[@"message"];
    
    NSString *loginUserImg=[NSString stringWithFormat:@"%@",[defa valueForKey:@"profileimage"]];
    
    
    NSString* strId=snapshot1.value[@"user"];
    NSString* time=snapshot1.value[@"time"];
    double timestramp=[time doubleValue];
    NSTimeInterval timeinterval=timestramp/1000;
    
    
    
    if ([allSnaps count]>0) {
        if([strMyId isEqualToString:strId])
        {
            
            [_chatTable registerNib:[UINib nibWithNibName:@"ChatSendCell" bundle:nil] forCellReuseIdentifier:@"chatSend"];
            _chatCell=[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
            _chatCell.backgroundColor=[UIColor clearColor];
            _chatCell.chatMessageLabel.text = message;
            
            _chatCell.chatUserImage.layer.cornerRadius=_chatCell.chatUserImage.frame.size.height/2;
            
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
            
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:@"hh:mm a, dd MMM yyyy"];
            NSString *dateString=[dateformatter stringFromDate:date];
            
            _chatCell.lblTimeSender.text=dateString;
            
           _chatCell.UpCurve.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chatbackground"]];

            [_chatCell.chatUserImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,loginUserImg]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
            if (_chatCell.chatUserImage.image==nil) {
                _chatCell.chatUserImage.image=[UIImage imageNamed:@"userprofile"];
            }
            
        
                  }
        else
        {
            [_chatTable registerNib:[UINib nibWithNibName:@"ChatReceiveCell" bundle:nil] forCellReuseIdentifier:@"chatReceive"];
            _chatCell=[tableView dequeueReusableCellWithIdentifier:@"chatReceive"];
            _chatCell.backgroundColor=[UIColor clearColor];
            _chatCell.chatMessageLabel1.text=message;
            _chatCell.chatUserImage1.layer.cornerRadius=_chatCell.chatUserImage1.frame.size.height/2;
           _chatCell.UpCurveSender.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chatbackground"]];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
            
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:@"hh:mm a, dd MMM yyyy"];
            NSString *dateString=[dateformatter stringFromDate:date];
            
            _chatCell.lblTimeReciver.text=dateString;
            
            [_chatCell.chatUserImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,self.authoreImage]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
            if (_chatCell.chatUserImage1.image==nil) {
                _chatCell.chatUserImage1.image=[UIImage imageNamed:@"userprofile"];
            }
        }
        
    }
    else
    {
        NSLog(@"No Value");
    }
    
    
    maxSize=CGSizeMake(280.0f, MAXFLOAT);
    myFont=[UIFont fontWithName:@"Helvetica" size:17.0];
    messageSize=[message sizeWithFont:myFont constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    return _chatCell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int rowhight= messageSize.height+40;
    tableContentHight=0;
    
    for (int i=0; i<[allSnaps count]; i++) {
        tableContentHight=tableContentHight+rowhight;
    }
    NSLog(@"tablecontent hight %d",tableContentHight);
    
    
    return rowhight;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    gestureRecognizer.enabled=NO;

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.chatTable)
    {
       if (editingStyle == UITableViewCellEditingStyleDelete)
        {
           
            FIRDataSnapshot *snapshotMessage = [allSnaps objectAtIndex:indexPath.row];
            [snapshotMessage.ref removeValue];
        }

    }

   
    
}

-(void)reciveMessages
{
    [Utility showLoading:self];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *senderId=[NSString stringWithFormat:@"-%@",[userDefaults valueForKey:@"id"]];
    NSString *reciverId;
    
    
//    [notificationDefaults setValue:othersId forKey:@"othersId"];
//    [notificationDefaults setValue:articleid forKey:@"articleid"];
//    [notificationDefaults setValue:othersProfileImg forKey:@"othersProfileImg"];
//    [notificationDefaults setValue:othersName forKey:@"othersName"];

    if ([self.authorId isEqualToString:@""]) {
        reciverId=[NSString stringWithFormat:@"-%@", [userDefaults valueForKey:@"othersId"]];
        self.articleId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"articleid"]];
        self.title=[userDefaults valueForKey:@"othersName"];
        self.authoreImage=[userDefaults valueForKey:@"othersProfileImg"];
        
         _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
    }
    else{
    
    reciverId=[NSString stringWithFormat:@"-%@",self.authorId];
    NSLog(@"Author %@",[NSString stringWithFormat:@"%@",self.authorId]);
   
   _senderMessageId=[NSString stringWithFormat:@"%@_%@_%@",senderId,reciverId,self.articleId];
    }
    
    //NSString *reciverMessageId=[NSString stringWithFormat:@"%@_%@_%@",reciverId,senderId,self.articleId];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[ref child:@"messages"] child:_senderMessageId]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         [allSnaps removeAllObjects];
         [Utility hideLoading:self];
         
         NSMutableDictionary *dictionary=snapshot.value;
         if ([dictionary isEqual:[NSNull null]]) {
             NSLog(@"All Messages deleted");
             _chatTable.hidden=YES;
             _chatTable.editing=NO;
                 return ;
         }
         
         else{
         
         for (snapshot in snapshot.children)
         {
             
             [allSnaps addObject:snapshot];
             
              _chatTable.hidden=NO;
             
             [_chatTable reloadData];
             
             if([self.chatTable numberOfRowsInSection:0]!=0)
             {
                 NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
                 [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                 
             }
         }
         }
         
         
       
     }
     ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [_chatTextView resignFirstResponder];
    
    // This will also add the message to our local array self.chat because
    // the FEventTypeChildAdded event will be immediately fired.
   
    return NO;
}
#pragma mark - Keyboard handling

// Subscribe to keyboard show/hide notifications.
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification object:nil];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *senderUserId=[NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"id"]];
    [[APIManager sharedInstance]getUserProfileDetailsWithUserId:senderUserId andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            return ;
        }
        else{
            NSDictionary *data = [result objectForKey:@"data"];
            NSDictionary *userDict = [data objectForKey:@"userdata"];
            NSString *userProfilePic;
            
            userProfilePic=[userDict valueForKey:@"photo_user"];
            if ([userProfilePic isEqual:[NSNull null]]) {
                 [userDefaults setValue:@"" forKey:@"profileimage"];
            }
            else{
            
            [userDefaults setValue:userProfilePic forKey:@"profileimage"];
            }
            
        }
    }];

    
     [self navigationConfiguration];
    [self reciveMessages];
}

// Unsubscribe from keyboard show/hide notifications.
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// Setup keyboard handlers to slide the view containing the table view and
// text field upwards when the keyboard shows, and downwards when it hides.
- (void)keyboardWillShow:(NSNotification*)notification
{
  
  
         [self moveView:[notification userInfo] up:YES];
    
    
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    
    [self moveView:[notification userInfo] up:NO];
}

- (void)moveView:(NSDictionary*)userInfo up:(BOOL)up
{
    
   
      
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]
     getValue:&keyboardEndFrame];
    
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]
     getValue:&animationCurve];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]
     getValue:&animationDuration];
    
    // Get the correct keyboard size to we slide the right amount.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    int y = keyboardFrame.size.height * (up ? -1 : 1);
    self.view.frame = CGRectOffset(self.view.frame, 0, y);
    
    [UIView commitAnimations];
   
    
}

// This method will be called when the user touches on the tableView, at
// which point we will hide the keyboard (if open). This method is called
// because UITouchTableView.m calls nextResponder in its touch handler.
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    self.view.frame = CGRectOffset(self.view.frame, 0, 0);
    if ([_chatTextView isFirstResponder])
    {
        
        
        [_chatTextView resignFirstResponder];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    
    NSString *str=[_chatTextView.text stringByReplacingCharactersInRange:range withString:string];
     NSString *withOutSpaceString=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([withOutSpaceString length]>0)
    {
        _btnSend.enabled = YES;
        _btnSend.backgroundColor=[UIColor colorWithRed:8.0/255.0 green:170.0/255.0 blue:87.0/255.0 alpha:1];
    }
    else
    {
        _btnSend.enabled = NO;
         _btnSend.backgroundColor=[UIColor lightGrayColor];
    }
    return YES;
}
- (IBAction)editingChanged:(UITextField *)textField
{
    //if text field is empty, disable the button
    _btnSend.enabled = textField.text.length > 0;
}

@end
