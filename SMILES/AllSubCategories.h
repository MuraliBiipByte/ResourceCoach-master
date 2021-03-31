//
//  AllSubCategories.h
//  SMILES
//
//  Created by Biipmi on 23/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface AllSubCategories : JSONModel
@property (nonatomic,strong) NSString   *subCatId;
@property (nonatomic,strong) NSString   *subCatName;
@property (nonatomic,strong) NSString   *subCatParentId;

@end
