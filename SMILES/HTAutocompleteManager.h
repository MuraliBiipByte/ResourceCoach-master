//
//  HTAutocompleteManager.h
//  HygieneWatch
//
//  Created by Biipmi on 12/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAutocompleteTextField.h"

typedef enum {
    HTAutocompleteTypeEmail, // Default
    HTAutocompleteTypeColor,
} HTAutocompleteType;

@interface HTAutocompleteManager : NSObject <HTAutocompleteDataSource>

+ (HTAutocompleteManager *)sharedManager;

@end
