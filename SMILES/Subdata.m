//
//  Subdata.m
//  SMILES
//
//  Created by Biipmi on 28/10/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "Subdata.h"

@implementation Subdata

+ (JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                            @"id": @"catid",
                            @"name": @"name",
        }];
}


@end
