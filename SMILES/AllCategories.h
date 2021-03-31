//
//  AllCategories.h
//  SMILES
//
//  Created by Biipmi on 23/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface AllCategories : JSONModel
@property (nonatomic,strong) NSString   *catId;
@property (nonatomic,strong) NSString   *catName;
@property (nonatomic,strong) NSString   *catParentId;

@end
