//
//  JSBubbleMessageCell.m
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  Largely based on work by Sam Soffes
//  https://github.com/soffes
//
//  SSMessagesViewController
//  https://github.com/soffes/ssmessagesviewcontroller
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSBubbleMessageCell.h"
#import "UIColor+JSMessagesView.h"
#import "UIImage+JSMessagesView.h"
#import "UIImageView+WebCache.h"

#define TIMESTAMP_LABEL_HEIGHT 14.5f
static const CGFloat kJSLabelPadding = 5.0f;
static const CGFloat kJSTimeStampLabelHeight = 15.0f;
static const CGFloat kJSSubtitleLabelHeight = 15.0f;

@interface JSBubbleMessageCell()


- (void)setup;
- (void)configureTimestampLabel;

- (void)configureWithType:(JSBubbleMessageType)type
              bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
              avatarStyle:(JSAvatarStyle)avatarStyle
                mediaType:(JSBubbleMediaType)mediaType
                timestamp:(BOOL)hasTimestamp;

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress;
- (void)handleMenuWillHideNotification:(NSNotification *)notification;
- (void)handleMenuWillShowNotification:(NSNotification *)notification;

@end


float hightForTimeStramp;
@implementation JSBubbleMessageCell

#pragma mark - Setup
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.imageView.image = nil;
    self.imageView.hidden = YES;
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.detailTextLabel.text = nil;
    self.detailTextLabel.hidden = YES;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [recognizer setMinimumPressDuration:0.4];
    [self addGestureRecognizer:recognizer];
}

- (void)configureTimestampLabel
{
    CGSize textSize=CGSizeZero;
      self.timestampLabel.text=@"";
     textSize = [JSBubbleView textSizeForText:self.bubbleView.text];
    NSString *strTextValidationString=self.bubbleView.text;
    CGSize imageSize=CGSizeZero;
    imageSize=[JSBubbleView imageSizeForImage:self.bubbleView.bubbleImage];
    
    if ((strTextValidationString==NULL) || [strTextValidationString isEqualToString:@""] || strTextValidationString.length==0 || [strTextValidationString isEqual:[NSNull null]])
    {
        self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                                        imageSize.height+25,
                                                                        self.contentView.frame.size.width-16,
                                                                        TIMESTAMP_LABEL_HEIGHT)];
       
       
    }
    else
    {
        self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                                        textSize.height+45,
                                                                        self.contentView.frame.size.width-16,
                                                                        TIMESTAMP_LABEL_HEIGHT)];
        
    }
    
    self.timestampLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    self.timestampLabel.backgroundColor = [UIColor clearColor];
    self.timestampLabel.textAlignment = NSTextAlignmentCenter;
    self.timestampLabel.textColor = [UIColor darkGrayColor];
    //self.timestampLabel.shadowColor = [UIColor whiteColor];
    //self.timestampLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //self.timestampLabel.font = [UIFont boldSystemFontOfSize:11.5f];
    [self.timestampLabel setFont:[UIFont systemFontOfSize:10]];
   // self.timestampLabel.backgroundColor=[UIColor redColor];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.contentView bringSubviewToFront:self.timestampLabel];
}

- (void)configureWithType:(JSBubbleMessageType)type
              bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
              avatarStyle:(JSAvatarStyle)avatarStyle
                mediaType:(JSBubbleMediaType)mediaType
                timestamp:(BOOL)hasTimestamp
{
    CGFloat bubbleY = 0.0f;
    CGFloat bubbleX = 0.0f;
    
    if(hasTimestamp) {
  //  [self configureTimestampLabel];
        bubbleY = 14.0f;
    }
    
    CGFloat offsetX = 0.0f;
    
    if(avatarStyle != JSAvatarStyleNone) {
        offsetX = 4.0f;
        bubbleX = kJSAvatarSize;
        CGFloat avatarX = 0.5f;
        
        if(type == JSBubbleMessageTypeOutgoing)
        {
            avatarX = (self.contentView.frame.size.width - kJSAvatarSize);
            offsetX = kJSAvatarSize - 4.0f;
        }
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX,
                                                                             self.contentView.frame.size.height - kJSAvatarSize-15,
                                                                             kJSAvatarSize,
                                                                             kJSAvatarSize)];
        
        self.avatarImageView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                                 | UIViewAutoresizingFlexibleLeftMargin
                                                 | UIViewAutoresizingFlexibleRightMargin);
        [self.contentView addSubview:self.avatarImageView];
    }
    
    CGRect frame = CGRectMake(bubbleX - offsetX,
                              bubbleY,
                              self.contentView.frame.size.width - bubbleX,
                              self.contentView.frame.size.height - 14.5f);
    
    self.bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                               bubbleType:type
                                              bubbleStyle:bubbleStyle
                                                mediaType:mediaType];
    
    [self.contentView addSubview:self.bubbleView];
    //[self configureTimestampLabel];
    [self.contentView sendSubviewToBack:self.bubbleView];
}

#pragma mark - Initialization
- (id)initWithBubbleType:(JSBubbleMessageType)type
             bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
             avatarStyle:(JSAvatarStyle)avatarStyle
               mediaType:(JSBubbleMediaType)mediaType
            hasTimestamp:(BOOL)hasTimestamp
         reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        self.avatarImageStyle = avatarStyle;
        [self configureWithType:type
                    bubbleStyle:bubbleStyle
                    avatarStyle:avatarStyle
                      mediaType:mediaType
                      timestamp:hasTimestamp];
    }
    return self;
}

- (void)dealloc
{
    self.bubbleView = nil;
    self.timestampLabel = nil;
    self.avatarImageView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters
- (void)setBackgroundColor:(UIColor *)color
{
    [super setBackgroundColor:color];
    [self.contentView setBackgroundColor:color];
    [self.bubbleView setBackgroundColor:color];
}

#pragma mark - Message Cell
- (void)setMessage:(NSString *)msg
{
    self.bubbleView.text = msg;
    [self configureTimestampLabel];
}


- (void)setMedia:(id)data
{
    
    NSLog(@"Url is %@",data);
    NSString *url=[NSString stringWithFormat:@"%@",data];
    
    if (![url isEqualToString:@"(null)"])
    {
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:self.bubbleView.frame];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data]]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.bubbleView.data = imgView.image;
        //        self.bubbleView.backgroundColor = [UIColor clearColor];
    }
    else
    
    {
        //        self.bubbleView.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
    //    if ([data isKindOfClass:[UIImage class]])
    //    {
    //        // image
    //        NSLog(@"show the image here");
    //
    //        UIImageView *imgView=[[UIImageView alloc]initWithFrame:self.bubbleView.frame];
    //        [self.bubbleView addSubview:imgView];
    //        imgView.image=[UIImage imageNamed:@"userprofile"];
    //   //    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data]]
    //  //  placeholderImage:[UIImage imageNamed:@"userprofile"]];
    //
    //       // self.bubbleView.data = data;
    //
    //    }
    //    else if ([data isKindOfClass:[NSData class]])
    //    {
    //        // show a button / icon to view details
    //        NSLog(@"icon view");
    //    }
}

- (void)setTimestamp:(NSDate *)date
{

    self.timestampLabel.text = [NSDateFormatter localizedStringFromDate:date
                                                              dateStyle:NSDateFormatterMediumStyle
                                                              timeStyle:NSDateFormatterShortStyle];
   // }
}

- (void)setAvatarImage:(UIImage *)image
{
    UIImage *styledImg = nil;
    switch (self.avatarImageStyle)
    {
        case JSAvatarStyleCircle:
            
            styledImg = [image circleImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleSquare:
            styledImg = [image squareImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleNone:
        default:
            break;
    }
    
    self.avatarImageView.image = styledImg;
    if (self.avatarImageView.image==nil) {
       
        self.avatarImageView.layer.cornerRadius=self.avatarImageView.frame.size.height/2;
        self.avatarImageView.layer.masksToBounds=YES;
        self.avatarImageView.image=[[UIImage imageNamed:@"userprofile"] circleImageWithSize:kJSAvatarSize];
       
            }
}

- (void)setAvatarImageTarget:(id)target action:(SEL)action
{
    self.avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *actionTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.avatarImageView addGestureRecognizer:actionTap];
}

+ (CGFloat)neededHeightForText:(NSString *)bubbleViewText timestamp:(BOOL)hasTimestamp avatar:(BOOL)hasAvatar
{
    CGFloat timestampHeight = (hasTimestamp) ? TIMESTAMP_LABEL_HEIGHT : 0.0f;
    CGFloat avatarHeight = (hasAvatar) ? kJSAvatarSize : 0.0f;
    return MAX(avatarHeight, [JSBubbleView cellHeightForText:bubbleViewText]) + timestampHeight+15;
}

+ (CGFloat)neededHeightForImage:(UIImage *)bubbleViewImage timestamp:(BOOL)hasTimestamp avatar:(BOOL)hasAvatar
{
    CGFloat timestampHeight = (hasTimestamp) ? TIMESTAMP_LABEL_HEIGHT : 0.0f;
    CGFloat avatarHeight = (hasAvatar) ? kJSAvatarSize : 0.0f;
    return MAX(avatarHeight, [JSBubbleView cellHeightForImage:bubbleViewImage]) + timestampHeight+20;
}

#pragma mark - Copying
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(self.bubbleView.data)
    {
//        if(action == @selector(saveImage:))
//            return YES;
    }
    else
    {
        if(action == @selector(copy:))
            return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.bubbleView.text];
    [self resignFirstResponder];
}

#pragma mark - Touch events
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if(![self isFirstResponder])
        return;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
    [menu update];
    [self resignFirstResponder];
}

#pragma mark - Gestures
- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    
  
    
    if(longPress.state != UIGestureRecognizerStateBegan
       || ![self becomeFirstResponder])
        return;
    
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *saveItem;
    if(self.bubbleView.data)
    {
        saveItem = [[UIMenuItem alloc] initWithTitle:@"Save" action:@selector(saveImage:)];
    }
    else
    {
        saveItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(saveImage:)];
    }
   
    UIMenuItem *delete=[[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(saveImage:)];
    [menu setMenuItems:@[delete,saveItem]];
    
    
    CGRect targetRect = [self convertRect:[self.bubbleView bubbleFrame]
                                 fromView:self.bubbleView];
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
    
    [menu update];
}

#pragma mark - Save Image
-(void)saveImage:(id)sender{
    
    UIImageWriteToSavedPhotosAlbum(self.bubbleView.data, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    UIAlertView *alertView;
    
    if (error != NULL){
        alertView = [[UIAlertView alloc] initWithTitle:@"Save Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
    }else
    { 
        alertView = [[UIAlertView alloc] initWithTitle:@"Save Success" message:@"Image has Saved !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    [alertView show];
}




#pragma mark - Notification
- (void)handleMenuWillHideNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
    self.bubbleView.selectedToShowCopyMenu = NO;
}

- (void)handleMenuWillShowNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillHideNotification:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
    
    self.bubbleView.selectedToShowCopyMenu = YES;
}

@end
