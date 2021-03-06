/*
 http://www.imcore.net | hosihito@gmail.com
 Developer. Kyoungbin Lee
 2012.05.25

 AES256 EnCrypt / DeCrypt
*/
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSData (AESTest)

- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;
@end