//
//  Macros.h
//
//  Created by Biipmi on 23/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#define APP_DELEGATE [[UIApplication sharedApplication] delegate]

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT
////

//return string
#define FileLog(format, ...) \
[NSString stringWithFormat:@"\n %s [Line %d] \n %@", \
__PRETTY_FUNCTION__, \
__LINE__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]]

#define CONCAT_URL(...)                     [NSString stringWithFormat:@"%@%@",__VA_ARGS__]

#define SET_OBJECT(key,value) \
[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:value]\
forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define GET_OBJECT(key)\
![[NSUserDefaults standardUserDefaults] objectForKey:key] ? nil :[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7_0 @"7.0"
