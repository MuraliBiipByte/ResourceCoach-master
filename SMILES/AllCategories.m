//
//  AllCategories.m
//  SMILES
//
//  Created by Biipmi on 23/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "AllCategories.h"

@implementation AllCategories
+ (JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                    @"id": @"subCatId",
                                    @"name": @"subCatName",
                                    @"parent_id":@"catParentId"
                                                       }];
}


@end
