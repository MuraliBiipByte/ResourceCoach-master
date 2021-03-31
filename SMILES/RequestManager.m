//
//  RequestManager.m
//  HygieneWatch
//
//  Created by Biipmi on 10/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "Utility.h"


#import "RequestManager.h"
@interface RequestManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestOperationManager;
@end

@implementation RequestManager

/**
 * @brief RequestManager instance
 */
+ (RequestManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static RequestManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

/**
 * @brief initial
 */
- (id)init
{
    if (self = [super init]) {
        //Operation manager
        _requestOperationManager = [AFHTTPRequestOperationManager manager];
        _requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

/**
 * @brief download file
 * @param urlAddress NSString
 * @param fileName NSString
 * @param completeBlock CompletionHandler
 */
- (void)downloadFile:(NSString *)urlAddress andFileName:(NSString*)fileName
    andCompleteBlock:(CompletionHandler)completeBlock
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
        completeBlock(true,path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completeBlock(false,@"Please try again");
    }];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float percentDownload = (float)totalBytesRead / totalBytesExpectedToRead;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:percentDownload],@"progress",[fileName stringByDeletingPathExtension],@"fileName", nil]];
    }];
    [operation start];
}

/**
 * @brief Send request
 * @param pathString - URL
 * @param param - Params dictionary
 * @param requestMethod - Method type
 * @param completeBlock - Completed block
 */
- (void)sendRequest:(NSString *)pathString
           andParam:(NSDictionary *)param andRequestMethod:(REQUEST_METHOD)requestMethod
   andCompleteBlock:(CompletionHandler)completeBlock
{
//    //Check network available
//    if (![Utility checkNetworkAvailable]) {
//        completeBlock(false, @"Internet is not working");
//        return;
//    }
//    
    //URL
    NSString *fullURLString = pathString.length > 0 ? pathString : @"";
    
    //Show connecting indicator
//    [Utility networkIndicator:YES];
    
    switch (requestMethod) {
        case METHOD_POST: //Post method
        {
            [_requestOperationManager POST:fullURLString parameters:param
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       //Hide connecting indicator
                                      // [Utility networkIndicator:NO];
                                       
                                       [self getResultFrom:responseObject andCompleteBlock:completeBlock];
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       //Request error
                                       completeBlock(false, error.description);
                                   }];
            break;
        }
        case METHOD_GET: //Get method
        {
            [_requestOperationManager GET:fullURLString parameters:param
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      //Hide connecting indicator
                                     // [Utility networkIndicator:NO];
                                      
                                      //Response
                                      [self getResultFrom:responseObject andCompleteBlock:completeBlock];
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      //Request error
                                      completeBlock(false, error.localizedDescription);
                                  }];
            break;
        }
        case METHOD_DELETE: //Delete method
        {
            [_requestOperationManager DELETE:fullURLString parameters:param
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         //Hide connecting indicator
                                       //  [Utility networkIndicator:NO];
                                         
                                         //Response
                                         [self getResultFrom:responseObject andCompleteBlock:completeBlock];
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         //Error
                                         completeBlock(false, error.localizedDescription);
                                     }];
            break;
        }
        case METHOD_PUT: //Put method
        {
            [_requestOperationManager PUT:fullURLString parameters:param
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      //Hide connecting indicator
                                     // [Utility networkIndicator:NO];
                                      
                                      //Response
                                      [self getResultFrom:responseObject andCompleteBlock:completeBlock];
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      //Request error
                                      completeBlock(false, error.localizedDescription);
                                  }];
            break;
        }
        case METHOD_GET_EXCEPTION:
            
            break;
        default:
            break;
    }
}

/**
 * @brief upload file
 * @param pathString NSString
 * @param mimyType NSString
 * @param filesData NSDictionary
 * @param param NSDictionary
 * @param completeBlock CompletionHandler
 */
- (void)uploadFile:(NSString *)pathString andMimeType:(NSString *)mimeType
       andFileData:(NSDictionary*)filesData andParam:(NSDictionary*)param
  andCompleteBlock:(CompletionHandler)completeBlock
{
    NSString *fullURLString = pathString;
    NSLog(@"fullURL: %@", fullURLString);
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:fullURLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0 ; i < filesData.count; i++) {
            NSString *keyName = [[filesData allKeys] objectAtIndex:i];
            NSData *fileData = [filesData objectForKey:keyName];
            [formData appendPartWithFileData:fileData
                                        name:keyName
                                    fileName:[NSString stringWithFormat:@"%@.jpeg",[Utility generateString]]
                                    mimeType:mimeType];
        }
        
    } error:nil];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         completeBlock(true, responseObject);
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         completeBlock(false, error.localizedDescription);
                                     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
    }];
    
    // 5. Begin!
    [operation start];
}

//Upload the video

- (void)uploadVideo:(NSString *)pathString andVideoType:(NSString *)videoType andFileData:(NSDictionary*)filesData andParam:(NSDictionary*)param andCompleteBlock:(CompletionHandler)completeBlock{
    
    NSString *fullURLString = pathString;
    NSLog(@"fullURL: %@", fullURLString);
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:fullURLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        for (int i = 0 ; i < filesData.count; i++)
        {
            NSString *keyName = [[filesData allKeys] objectAtIndex:i];
            NSData *fileData = [filesData objectForKey:keyName];
            [formData appendPartWithFileData:fileData
                                        name:keyName
                                    fileName:[NSString stringWithFormat:@"%@.MOV",[Utility generateString]]
                                    mimeType:videoType];
        }
        
    } error:nil];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         completeBlock(true, responseObject);
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         completeBlock(false, error.localizedDescription);
                                     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
    }];
    
    // 5. Begin!
    [operation start];

    
}


/**
 * @brief Parser result
 * @param responseObject NSData
 * @param completeBlock CompletionHandler
 */
- (void)getResultFrom:(NSData*)responseObject andCompleteBlock:(CompletionHandler)completeBlock
{
    NSError *e;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&e];
    if (e) {
    completeBlock(false,nil);
    }
    else
        completeBlock(true,dict);
}







@end
