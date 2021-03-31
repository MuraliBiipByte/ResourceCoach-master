//
//  RequestManager.h
//  HygieneWatch
//
//  Created by Biipmi on 10/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 * @brief Request Method
 */
typedef enum {
    METHOD_POST,
    METHOD_GET,
    METHOD_DELETE,
    METHOD_PUT,
    METHOD_GET_EXCEPTION
} REQUEST_METHOD;
typedef void (^CompletionHandler)(BOOL success, id result);


@interface RequestManager : NSObject


/**
 * @brief Requestmanager instance
 * @return A request manager instance
 */
+ (RequestManager *)sharedInstance;

/**
 * @brief Send request
 * @param pathString - URL
 * @param param - Params dictionary
 * @param requestMethod - Method type
 * @param completeBlock - Completed block
 */
- (void)sendRequest:(NSString *)pathString andParam:(NSDictionary *)param andRequestMethod:(REQUEST_METHOD)requestMethod andCompleteBlock:(CompletionHandler)completeBlock;
/**
 * @brief download file
 * @param urlAddress NSString
 * @param fileName NSString
 * @param completeBlock CompletionHandler
 */
- (void)downloadFile:(NSString *)urlAddress andFileName:(NSString*)fileName andCompleteBlock:(CompletionHandler)completeBlock;

/**
 * @brief upload file
 * @param pathString NSString
 * @param mimyType NSString
 * @param filesData NSDictionary
 * @param param NSDictionary
 * @param completeBlock CompletionHandler
 */
- (void)uploadFile:(NSString *)pathString andMimeType:(NSString *)mimeType andFileData:(NSDictionary*)filesData andParam:(NSDictionary*)param andCompleteBlock:(CompletionHandler)completeBlock;


/**
 * @brief upload Video
 * @param pathString NSString
 * @param mimyType NSString
 * @param filesData NSDictionary
 * @param param NSDictionary
 * @param completeBlock CompletionHandler
 */
- (void)uploadVideo:(NSString *)pathString andVideoType:(NSString *)videoType andFileData:(NSDictionary*)filesData andParam:(NSDictionary*)param andCompleteBlock:(CompletionHandler)completeBlock;

@end
