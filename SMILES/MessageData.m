 

#import "MessageData.h"

@implementation MessageData

- (instancetype)initWithMsgId:(NSString *)msgId text:(NSString *)text date:(NSDate *)date msgType:(NSInteger)msgType mediaType:(NSInteger)medType img:(NSURL *)imgURL{
    self = [super init];
    if (self)
    {
        _msgId = msgId;
        _text = text;
        _date = date;
        _messageType = msgType;
        _mediaType = medType;
        _imgURL = imgURL;
    }
    return self;
}

@end
