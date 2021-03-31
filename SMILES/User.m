//
//  User.m
//  SMILES
//
//  Created by Biipmi on 15/9/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import "User.h"

@implementation User
//    User type
//    1 Admin
//    2 Contributor
//    3 Subscriber
//    4 facilitator
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                            @"user_id": @"userId",
                            @"user_type":@"userType",
                            @"profile_image": @"userProfileImage",
                            @"username": @"userName",
                            @"telcode" : @"usertelCode",
                            @"phone" : @"userPhoneNumber",
                            @"email" : @"userEmail",
                            @"password" : @"userPassword",
                            @"confpassword" : @"userConfPassword",
                            @"company" : @"userCompany",
                            @"department" : @"userDepartment",
                            @"empid" : @"userEmpId"
                            }];
}

@end
