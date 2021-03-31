//
//  User.h
//  SMILES
//
//  Created by Biipmi on 15/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface User : JSONModel
//Registration inputs for User
@property (nonatomic,assign) NSString *userId;
@property (nonatomic,assign) NSString *userType;
@property (nonatomic,assign) NSString *userProfileImage;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *usertelCode;
@property (nonatomic,strong) NSString *userPhoneNumber;
@property (nonatomic,strong) NSString *userEmail;
@property (nonatomic,strong) NSString *userPassword;
@property (nonatomic,strong) NSString *userConfPassword;
@property (nonatomic,strong) NSString *userCompany;
@property (nonatomic,strong) NSString *userDepartment;
@property (nonatomic,strong) NSString *userEmpId;

@end
