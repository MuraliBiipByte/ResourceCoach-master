

#import <Foundation/Foundation.h>

@interface MessageData : NSObject

@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, assign) NSInteger mediaType;
@property (nonatomic, strong) NSURL *imgURL;

- (instancetype)initWithMsgId:(NSString *)msgId text:(NSString *)text date:(NSDate *)date msgType:(NSInteger)msgType mediaType:(NSInteger)medType img:(NSURL *)imgURL;


@end
