//
//  APIManager.m
//
//  Created by Biipmi on 24/6/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//


#import "APIManager.h"
#import "JSONHTTPClient.h"
#import "JSONModelError.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "Macros.h"
#import "Constants.h"
#import "AFURLSessionManager.h"
#import "RequestManager.h"
#define MIME_TYPE_JPEG @"image/jpeg"
#define MIME_TYPE_VIDEO @"video/quicktime"
#define API_KEY @"tz6n5M+lnJVw007muIr7UXATrR4quD9V4Z+upTXcDXWzD7LE1eZaHdcyBe/Z3TjChzPdgS5dKvVIQm6gq6HVuw=="

@implementation APIManager

+ (APIManager *)sharedInstance{
    static dispatch_once_t onceToken;
    static APIManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//User Account Methods

- (void)createAccount:(User*)user andWithProfileImage:(UIImage *)profileImage andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:@"non_subscriber" forKey:@"user_type"];
    [params setObject:user.userName forKey:@"username"];
    [params setObject:user.usertelCode forKey:@"telcode"];
    [params setObject:user.userPhoneNumber forKey:@"phone"];
    [params setObject:user.userPassword forKey:@"password"];
    [params setObject:user.userConfPassword forKey:@"confpassword"];
    //[params setObject:user.userCompany forKey:@"company"];
    //[params setObject:user.userDepartment forKey:@"department"];
    if ([user.userEmail length]>0) {
        [params setObject:user.userEmail forKey:@"email"];
    }else{
       [params setObject:@"" forKey:@"email"];
    }
//    if ([user.userEmpId length]>0) {
//        [params setObject:user.userEmpId forKey:@"empid"];
//    }else{
//        [params setObject:@"" forKey:@"empid"];
//    }
    // Profile image
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    NSLog(@"Image is %@",profileImage);
    NSData *data = UIImageJPEGRepresentation(profileImage, 0.8);
    if ([data length]>0) {
        [files setValue:data forKey:@"profile_image"];
    }
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Create_Account) andMimeType:MIME_TYPE_JPEG andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        NSLog(@"Response is %@",result);
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

-(void)accountActivation:(NSString *)userType andWithCountryCode:(NSString *)telCode andWithPhoneNumber:(NSString *)phoneNo andWithVerificationCode:(NSString *)otpCode andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userType forKey:@"user_type"];
    [params setObject:telCode forKey:@"telcode"];
    [params setObject:phoneNo forKey:@"phone"];
    [params setObject:otpCode forKey:@"mobile_otp"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Verify_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

- (void)loginWithTelCode:(NSString *)telCode andWithMobileNumber:(NSString *)mobileNo andPassword:(NSString*)password andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:telCode forKey:@"telcode"];
    [params setObject:mobileNo forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Login_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

- (void)resendOTPWithTelCode:(NSString *)telCode andWithMobileNumber:(NSString *)mobileNo andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:telCode forKey:@"telcode"];
    [params setObject:mobileNo forKey:@"phone"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Resend_OTP) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

- (void)forgotPasswordWithTelCode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:telcode forKey:@"telcode"];
    [params setObject:mobileNo forKey:@"phone"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,ForgotPassword_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

- (void)VerifyForgotPasswordWithTelcode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andWithForgotPassOTP:(NSString *)forgotOTP andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:telcode forKey:@"telcode"];
    [params setObject:mobileNo forKey:@"phone"];
    [params setObject:forgotOTP forKey:@"forgotten_password_code"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Verify_ForgotPassword_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

- (void)setNewPasswordWithTelCode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andWithNewPassword:(NSString *)newPassword andWithNewConfirmPassword:(NSString *)newConfirmPass andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:telcode forKey:@"telcode"];
    [params setObject:mobileNo forKey:@"phone"];
    [params setObject:newPassword forKey:@"password"];
    [params setObject:newConfirmPass forKey:@"passconf"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,ResetPassword_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)verifyRegisteredEmailWithUserType:(NSString *)userType andWithEmail:(NSString *)email andWithEmailOTP:(NSString *)emailOTP andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userType forKey:@"user_type"];
    [params setObject:email forKey:@"email"];
    [params setObject:emailOTP forKey:@"email_otp"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Verify_Email_Account) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)resendOtpForEmail:(NSString *)userEmail andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userEmail forKey:@"email"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Resend_OTP_For_Email) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getUserProfileDetailsWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Get_Profile) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else {
                completeBlock(false, message);
            }
        }
    }];
}

- (void)updateUserProfile:(User*)user andWithProfileImage:(UIImage *)profileImage andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:user.userId forKey:@"user_id"];
    [params setObject:user.userName forKey:@"username"];
    [params setObject:user.usertelCode forKey:@"telcode"];
    [params setObject:user.userPhoneNumber forKey:@"phone"];
  //  [params setObject:user.userCompany forKey:@"company"];
   // [params setObject:user.userDepartment forKey:@"department"];
    if ([user.userEmail length]>0) {
        [params setObject:user.userEmail forKey:@"email"];
    }else{
        [params setObject:@"" forKey:@"email"];
    }
//    if ([user.userEmpId length]>0) {
//        [params setObject:user.userEmpId forKey:@"empid"];
//    }else{
//        [params setObject:@"" forKey:@"empid"];
//    }
    // Profile image
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    NSLog(@"Image is %@",profileImage);
    NSData *data = UIImageJPEGRepresentation(profileImage, 0.8);
    if ([data length]>0) {
        [files setValue:data forKey:@"profile_image"];
    }
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Edit_Profile) andMimeType:MIME_TYPE_JPEG andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

-(void)verifyCompanyWithUserType:(NSString *)userType andWithCompanyId:(NSString *)compId andWithSecretCode:(NSString *)secretCode andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userType forKey:@"user_type"];
    [params setObject:compId forKey:@"company_id"];
    [params setObject:secretCode forKey:@"registration_otp"];
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Verify_Company_Code) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

//Company Methods

-(void)getAllCompanies:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    NSUserDefaults *str=[NSUserDefaults standardUserDefaults];
    NSString *strLanCode=[str objectForKey:@"language"];
    if ([strLanCode isEqualToString:@"2"]) {
        [params setObject:@"my" forKey:@"language"];
    }
    else if ([strLanCode isEqualToString:@"3"]){
        [params setObject:@"my" forKey:@"language"];
    }
    else{
        [params setObject:@"en" forKey:@"language"];
    }
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Get_All_Companies) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result){
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllDepartmentsWithCompanyId:(NSString *)companyId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:companyId forKey:@"company_id"];
    NSUserDefaults *str=[NSUserDefaults standardUserDefaults];
    NSString *strLanCode=[str objectForKey:@"language"];
    if ([strLanCode isEqualToString:@"2"]) {
        [params setObject:@"my" forKey:@"language"];
    }
    else if ([strLanCode isEqualToString:@"3"]){
        [params setObject:@"my" forKey:@"language"];
    }
    else{
        [params setObject:@"en" forKey:@"language"];
    }
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Get_All_Departments) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result){
        if (!success){
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Categories Methods

-(void)getAllCategoriesWithUserID:(NSString *)userID andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    NSUserDefaults *str=[NSUserDefaults standardUserDefaults];
    NSString *strLanCode=[str objectForKey:@"language"];
    if ([strLanCode isEqualToString:@"2"]) {
        [params setObject:@"my" forKey:@"language"];
    }
    else if ([strLanCode isEqualToString:@"3"]){
        [params setObject:@"my" forKey:@"language"];
    }
    else{
        [params setObject:@"en" forKey:@"language"];
    }
    [params setObject:userID forKey:@"user_id"];
    [JSONHTTPClient postJSONFromURLWithString:CONCAT_URL(BASE_URL_Service,Get_All_Categories) params:params completion:^(id json, JSONModelError *err) {
        if (err) {
            completeBlock(false, err.localizedDescription);
        }
        else
        {
            NSDictionary *response = [json objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}
-(void)getAllSubCategories:(CompletionHandler)completeBlock{
    [JSONHTTPClient postJSONFromURLWithString:CONCAT_URL(BASE_URL_Service,Get_All_SubCategories) params:nil completion:^(id json, JSONModelError *err) {
        if (err) {
            completeBlock(false, err.localizedDescription);
        }
        else
        {
            NSDictionary *response = [json objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllSucbcategoriesWithCatId:(NSString *)catId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:catId forKey:@"category_id"];
    
    NSUserDefaults *str=[NSUserDefaults standardUserDefaults];
    NSString *strLanCode=[str objectForKey:@"language"];
    if ([strLanCode isEqualToString:@"2"]) {
        [params setObject:@"my" forKey:@"language"];
    }
    else if ([strLanCode isEqualToString:@"3"]){
        [params setObject:@"my" forKey:@"language"];
    }
    else{
        [params setObject:@"en" forKey:@"language"];
    }
    [JSONHTTPClient postJSONFromURLWithString:CONCAT_URL(BASE_URL_Service,Get_All_Subcategories_With_CatId) params:params completion:^(id json, JSONModelError *err) {
        if (err) {
            completeBlock(false, err.localizedDescription);
        }
        else
        {
            NSDictionary *response = [json objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];

}

// Create Article Methods

//-(void)createArticleWithImagesUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithImage1:(UIImage *)img1 andWithImage2:(UIImage *)img2 andWithImage3:(UIImage *)img3 andCompleteBlock:(CompletionHandler)completeBlock{
//    //Params
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:API_KEY forKey:@"api_key_data"];
//    [params setObject:userId forKey:@"user_id"];
//    [params setObject:articleTitle forKey:@"title"];
//    [params setObject:subCatId forKey:@"cat_id"];
//    [params setObject:shortDescription forKey:@"short_desc"];
//    [params setObject:longDescription forKey:@"description"];
//    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
//    NSLog(@"Image is %@",img1);
//    NSData *data1 = UIImageJPEGRepresentation(img1, 0.8);
//    if ([data1 length]>0) {
//        [files setValue:data1 forKey:@"article_image1"];
//    }
//    NSData *data2 = UIImageJPEGRepresentation(img2, 0.8);
//    if ([data2 length]>0) {
//        [files setValue:data2 forKey:@"article_image2"];
//    }
//    NSData *data3 = UIImageJPEGRepresentation(img3, 0.8);
//    if ([data3 length]>0) {
//        [files setValue:data3 forKey:@"article_image3"];
//    }
//    NSLog(@"count is %lu",(unsigned long)[files count]);
//    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Create_Article) andMimeType:MIME_TYPE_JPEG andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
//        if (!success){
//            completeBlock(false, result);
//        }
//        else{
//            NSDictionary *response = [result objectForKey:@"response"];
//            NSString *message = [response objectForKey:@"message"];
//            NSInteger status = [[response objectForKey:@"status"] intValue];
//            if (status == 1) {
//                completeBlock(true, response);
//            }
//            else{
//                completeBlock(false, message);
//            }
//        }
//    }];
//}
-(void)createArticleWithImagesUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithImage1:(UIImage *)img1 andWithImage2:(UIImage *)img2 andWithImage3:(UIImage *)img3 andImgTitle1:(NSString *)imgTitle1 andImgTitle2:(NSString *)imgTitle2 andImgTitle3:(NSString *)imgTitle3 andTags:(NSMutableArray *)tags andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleTitle forKey:@"title"];
    [params setObject:subCatId forKey:@"cat_id"];
    [params setObject:shortDescription forKey:@"short_desc"];
    [params setObject:longDescription forKey:@"description"];
    [params setObject:languag forKey:@"language"];
     [params setObject:@"ios" forKey:@"platform"];
    
    if (imgTitle1.length ==0) {
        [params setObject:@"" forKey:@"caption_image1"];
    }
    else{
        [params setObject:imgTitle1 forKey:@"caption_image1"];
    }
    if (imgTitle2.length==0) {
        [params setObject:@"" forKey:@"caption_image2"];
    }
    else{
        [params setObject:imgTitle2 forKey:@"caption_image2"];
    }
    if (imgTitle3.length==0) {
        [params setObject:@"" forKey:@"caption_image3"];
    }
    else{
        [params setObject:imgTitle3 forKey:@"caption_image3"];
    }
    [params setObject:tags forKey:@"tag"];
    
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    NSLog(@"Image is %@",img1);
    NSData *data1 = UIImageJPEGRepresentation(img1, 0.8);
    if ([data1 length]>0) {
        [files setValue:data1 forKey:@"article_image1"];
    }
    NSData *data2 = UIImageJPEGRepresentation(img2, 0.8);
    if ([data2 length]>0) {
        [files setValue:data2 forKey:@"article_image2"];
    }
    NSData *data3 = UIImageJPEGRepresentation(img3, 0.8);
    if ([data3 length]>0) {
        [files setValue:data3 forKey:@"article_image3"];
    }
    NSLog(@"count is %lu",(unsigned long)[files count]);
    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,Create_Article) andMimeType:MIME_TYPE_JPEG andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success){
            completeBlock(false, result);
        }
        else{
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

-(void)createArticleWithVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSURL *)video  andWithTags:(NSMutableArray *)tags andWithLink:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleTitle forKey:@"title"];
    [params setObject:subCatId forKey:@"cat_id"];
       [params setObject:@"ios" forKey:@"platform"];
    
    [params setObject:shortDescription forKey:@"short_desc"];
   
    
    
    
    [params setObject:longDescription forKey:@"description"];
    [params setObject:tags forKey:@"tag"];
    [params setObject:@"" forKey:@"link"];
    [params setObject:languag forKey:@"language"];
    
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    NSLog(@"Url is %@",video);
    NSData *data = [NSData dataWithContentsOfURL:video];
  
   [files setObject:data forKey:@"article_video"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Create_Article) andVideoType:MIME_TYPE_VIDEO andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
    
//    ////NSURLSessions usage
//    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    NSString *linkVideo=@"";
//    
////      NSString *Finalstr = [NSString stringWithFormat: @"%@api_key_data%@user_id%@title%@cat_id%@short_desc%@description%@tag%@link%@language%@article_video",API_KEY,userId,articleTitle,subCatId,shortDescription,longDescription,tags,linkVideo,language,myString];
//      NSString *Finalstr = [NSString stringWithFormat: @"api_key_data=%@&user_id=%@&title%@&cat_id%@&short_desc%@&description=%@&tag%@&link%@&language=%@&article_video%@",API_KEY,userId,articleTitle,subCatId,shortDescription,longDescription,tags,linkVideo,language,data];
//    
//    
//    
//    NSURL * url = [NSURL URLWithString:CONCAT_URL(BASE_URL_Service_Service,Create_Article)];
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[Finalstr dataUsingEncoding:NSUTF8StringEncoding]];
//    
////
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
////    NSData *data1 =[Finalstr dataUsingEncoding:NSUTF8StringEncoding];
////    NSURLSession *session = [NSURLSession sharedSession];
////    NSURLSessionUploadTask *uploadTask = [session  uploadTaskWithRequest:request
////                                                               fromData:data1
////                                                      completionHandler:
////                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
////                                              NSLog(@"Response:%@ %@\n", response, error);
////                                                                                                         if(error == nil)
////                                                                                                         {
////                                                                                                             NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
////                                                                                                             NSLog(@"Data = %@",text);
////                                                                                                         }
////                                          }];
////    
////    [uploadTask resume];
//    
//    NSURLSessionDataTask * dataTask =[defaultSession  dat dataTaskWithRequest:urlRequest
//                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                           NSLog(@"Response:%@ %@\n", response, error);
//                                                           if(error == nil)
//                                                           {
//                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                                                               NSLog(@"Data = %@",text);
//                                                           }
//                                                         //  completeBlock(true, response);
//                                                           
//                                                       }];
//    [dataTask resume];


    
    
}

-(void)createArticleWithBrowseVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSData *)video andTags:(NSMutableArray *)tags andWithLink:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleTitle forKey:@"title"];
    [params setObject:subCatId forKey:@"cat_id"];
    
    /**** short description encoding .....*****/
    
     NSString* newString = [shortDescription stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     [params setObject:@"ios" forKey:@"platform"];
    [params setObject:newString forKey:@"short_desc"];
    [params setObject:longDescription forKey:@"description"];
    [params setObject:tags forKey:@"tag"];
    [params setObject:@"" forKey:@"link"];
    [params setObject:languag forKey:@"language"];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    [files setObject:video forKey:@"article_video"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Create_Article) andVideoType:MIME_TYPE_VIDEO andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)createArticleWithYoutubeVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSData *)video andTags:(NSMutableArray *)tags andWithYoutube:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleTitle forKey:@"title"];
    [params setObject:subCatId forKey:@"cat_id"];
     [params setObject:@"ios" forKey:@"platform"];
     NSString* newString = [shortDescription stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [params setObject:shortDescription forKey:@"short_desc"];
    [params setObject:longDescription forKey:@"description"];
    [params setObject:tags forKey:@"tag"];
    [params setObject:link forKey:@"link"];
    [params setObject:languag forKey:@"language"];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    [files setObject:@"" forKey:@"article_video"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Create_Article) andVideoType:MIME_TYPE_VIDEO andFileData:files andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
    
}
//Get Articles Methods

-(void)getAllArticlesWithSubCatId:(NSString *)subCatId andWithUserid:(NSString *)userId andLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock
{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:subCatId forKey:@"subcat_id"];
    [params setObject:userId forKey:@"user_id"];
    
    if ([languag isEqualToString:@"en"]) {
        [params setObject:languag forKey:@"language"];
    }
    else if ([languag isEqualToString:@"zh"]) {
        [params setObject:languag forKey:@"language"];
    }
    
    else  if ([languag isEqualToString:@"my"]) {
        [params setObject:languag forKey:@"language"];
    }
    
    
    else{
        [params setObject:@"" forKey:@"language"];
        
    }
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_Articles) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1)
            {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllRandomArticles:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_Random_Articles) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success)
        {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1)
            {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getArticleDetailsWithArticleId:(NSString *)articleId withUserid:(NSString *)userId andWithAssessmentId:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleId forKey:@"article_id"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:assmentId forKey:@"assesment_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_Article_Details) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success)
        {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllSearchArticlesWithSearchKey:(NSString *)searchKey andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:searchKey forKey:@"keyword"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Search_Articles) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllFavoriteArticlesWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_Favorite_Articles) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)addArticleToMyFavoriteArticlesWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Add_To_Favorite_Article) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)removeArticleFromMyFavoriteArticlesWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Remove_Article_From_Favorite) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

// Push notification Methods

-(void)registerDeviceForPushnotificationsWithUserId:(NSString *)userId andWithDeviceType:(NSString *)deviceType andWithDeviceId:(NSString *)deviceId andWithregisterId:(NSString *)regId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:deviceType forKey:@"type"];
    [params setObject:deviceId forKey:@"gcm_regid"];
    [params setObject:regId forKey:@"device_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Register_Device_For_Pushnotifications) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)unRegisterDeviceForPushnotificationsWithUserId:(NSString *)userId andWithDeviceType:(NSString *)deviceType andWithDeviceId:(NSString *)deviceId andWithregisterId:(NSString *)regId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:deviceType forKey:@"type"];
    [params setObject:deviceId forKey:@"gcm_regid"];
    [params setObject:regId forKey:@"device_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Unregister_Device_For_Pushnotofications) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)resetBadgeCountWithDeviceId:(NSString *)deviceId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    //[params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:deviceId forKey:@"device_token"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Reset_Badge_Count) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Review Methods

-(void)getAllReviewsForParticularArticle:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
     NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleId forKey:@"article_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_Reviews) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)writeReviewForArticleWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andWithRating:(NSString *)rating andWithComment:(NSString *)comment andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [params setObject:rating forKey:@"rate"];
    [params setObject:comment forKey:@"comment"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Write_Review) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Article viewed

-(void)articleViewedWithUserid:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Article_Viewed) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Assessment Methods

-(void)getAllAssessmentsWithUserId:(NSString *)userId andWithDepartmentId:(NSString *)deptId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:deptId forKey:@"dept_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_Assessment) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getAllAssessmentsWithUserId:(NSString *)userId  andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_Assessment) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, response);
            }
        }
    }];
}

-(void)getAssementDetailsWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleId forKey:@"assessment_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_AssessmentDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}
//Sequence Methods

-(void)getAllSequencesWithUserId:(NSString *)userid andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userid forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_Sequence) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

-(void)getSequenceDetailsWithUserId:(NSString *)userId andWithSequenceId:(NSString *)seqId andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:seqId forKey:@"sequence_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_Sequence_Details) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Quiz Methods

-(void)createQuizFortheArticleWithArticleId:(NSString *)articleId andWithQuestionName:(NSString *)quizName andWithOption1:(NSString *)option1 andWithOption2:(NSString *)option2 andWithOption3:(NSString *)option3 andWithOption4:(NSString *)option4 andWithAnswer:(NSString *)answer andCompleteBlock:(CompletionHandler)completeBlock{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleId forKey:@"article_id"];
    [params setObject:quizName forKey:@"question"];
    [params setObject:option1 forKey:@"option1"];
    [params setObject:option2 forKey:@"option2"];
    [params setObject:option3 forKey:@"option3"];
    [params setObject:option4 forKey:@"option4"];
    [params setObject:answer forKey:@"answer_key"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Create_Quiz) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}

//Group name

-(void)getGroupNameDetails:(NSString *)apiKey andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_All_GroupnameDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            completeBlock(true, result );
            
                   }
    }];
}

//search
-(void)search:(NSString*)apiKey andWithKeyText:(NSString *)keyText andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:keyText forKey:@"keyword"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Search) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
}

//Start and Endtime for article
-(void)startAndEndTimeforArticle:(NSString *)startTime andWithEndTime:(NSString *)endTime withUserId:(NSString *)userid andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:startTime forKey:@"start_time"];
    [params setObject:endTime forKey:@"end_time"];
    [params setObject:userid forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [params setObject:@"ios" forKey:@"type"];
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,StartAndEndTimeForArticle) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
}
-(void)articleDuration:(NSString *)articleid andwithYear:(NSString *)year andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleid forKey:@"article_id"];
    [params setObject:year forKey:@"year"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,ArticleDuration) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
}
//users for article
-(void)userForOneArticle:(NSString *)articleid  andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:articleid forKey:@"article_id"];
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,UsersofArticle) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
}

//Checking usertype

-(void)checkingUserType:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,User_Type) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
    
}

//Get All My Articles

-(void)getAllMyArticles:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,GetAllMyArticles) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
}

//create Sub Article
-(void)createSubArticle:(NSString *)article_id withUserId:(NSString *)userid withTitle:(NSString *)title withDescription:(NSString *)Description withLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userid forKey:@"user_id"];
    [params setObject:article_id forKey:@"article_id"];
    [params setObject:title forKey:@"title"];
    [params setObject:Description forKey:@"description"];
    [params setObject:languag forKey:@"language"];
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,SubArticleCreation) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, result);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
    
}
-(void)sendingFCM_Notifications:(NSString *)reciverId withMessage:(NSString *)message withReciverName:(NSString *)receiverName withReciverProfile:(NSString *)reciverProfileImg withReciverUserId:(NSString *)reciverUserId withArticleId:(NSString *)articleId  andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:reciverId forKey:@"id"];
    [params setObject:message forKey:@"message"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:receiverName forKey:@"receiver_usename"];
    [params setObject:reciverProfileImg forKey:@"receiver_profileimg"];
    [params setObject:reciverUserId forKey:@"receiver_userid"];
    [params setObject:articleId forKey:@"receiver_artical_id"];
    
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,FCM_NOTIFICATIONS) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, result);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    
}
//VerificationPromoCode...
-(void)verifyPromoCode:(NSString *)userid withPromocode:(NSString *)promocode andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
      [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userid forKey:@"user_id"];
     [params setObject:promocode forKey:@"promocode"];
   
    NSLog(@"%@",params);
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,CouponCodeVerification) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    
    

}
//GetAll Trainers list Including Fav Trainers..
-(void)TrainersIncludingFav:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
   
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,GetAllTrainersList) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];

    
}
//Add Trainer To Fav..
-(void)AddTrainerToFavourite:(NSString *)userId andWithTrainerId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
     [params setObject:AuthoreId forKey:@"author_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,AddTrainerToFav) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];
    

}
//Remove Trainer from Fav..
-(void)RemoveTrainerFromFav:(NSString *)userId andWithTrainerId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:AuthoreId forKey:@"author_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,UnfavTrainer) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];

}
-(void)GetAllArticlesBasedonAuthoreId:(NSString *)userLanguage andwithUserId:(NSString *)userId andWithAuthoreId:(NSString *)authoreId andCompleteBlock:(CompletionHandler)completeBlock;
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:@"" forKey:@"language"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:authoreId forKey:@"author_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,AllarticleBasedOnAuthor) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else
            {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(false, data);
            }
        }
    }];

}
-(void)getAllMiniCertificatesListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,GetAllMiniVertificates) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            
            NSString *message = [response objectForKey:@"message"];
            NSLog(@"%@",response);
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, response);
            }
            else{
                completeBlock(false, message);
            }
        }
    }];

    
}
//MiniCertificate Details...
-(void)miniCertificateDetailsWithId:(NSString *)miniCerId anduserID:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:miniCerId forKey:@"assessment_id"];
        [params setObject:userId forKey:@"user_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,MiniCertificatesDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSDictionary *data = [response objectForKey:@"data"];
            completeBlock(true, data);

            
            
//            NSString *message = [response objectForKey:@"message"];
//            NSLog(@"%@",response);
//            NSInteger status = [[response objectForKey:@"status"] intValue];
//            if (status == 1) {
//                NSDictionary *data = [response objectForKey:@"data"];
//                completeBlock(true, data);
//            }
//            else{
//                completeBlock(false, message);
//            }
        }
    }];

}
//Aurthore Details...
-(void)authoreDetailsWithAuthId:(NSString *)authoreId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:authoreId forKey:@"author_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,AuthoreDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        NSLog(@"params are %@",params);
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSDictionary *data = [response objectForKey:@"data"];
            completeBlock(true, data);
            
            
            
            //            NSString *message = [response objectForKey:@"message"];
            //            NSLog(@"%@",response);
            //            NSInteger status = [[response objectForKey:@"status"] intValue];
            //            if (status == 1) {
            //                NSDictionary *data = [response objectForKey:@"data"];
            //                completeBlock(true, data);
            //            }
            //            else{
            //                completeBlock(false, message);
            //            }
        }
    }];

}
//HomeCategory Article List..
-(void)homeCategoryArticlesListWithCatId:(NSString *)catId andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:catId forKey:@"category"];
    [params setObject:userId forKey:@"user_id"];
    
   
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,homeCatDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            NSDictionary *data=[response valueForKey:@"data"];
            completeBlock(true, data);
//            if (status == 1) {
//                NSDictionary *data = [response objectForKey:@"data"];
//                completeBlock(true, data);
//            }
//            else{
//                completeBlock(false, message);
//            }
        }
    }];

}

//Video Duration
-(void)updatingVideoDurationWithUserId:(NSString *)userId andWithAssementId:(NSString *)assessmentId withArticleId:(NSString *)articleId withStartTime:(NSString *)startTime andWithEndTime:(NSString *)endTime andCompleteBlock:(CompletionHandler)completeBlock
{
     //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
   
    [params setObject:userId forKey:@"user_id"];
     [params setObject:articleId forKey:@"article_id"];
     [params setObject:startTime forKey:@"start_time"];
     [params setObject:endTime forKey:@"end_time"];
    [params setObject:assessmentId forKey:@"assesment_id"];
   
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,videoDuration) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            NSDictionary *data=[response valueForKey:@"data"];
            completeBlock(true, data);
            //            if (status == 1) {
            //                NSDictionary *data = [response objectForKey:@"data"];
            //                completeBlock(true, data);
            //            }
            //            else{
            //                completeBlock(false, message);
            //            }
        }
    }];

}
//Save QuizAnswers
-(void)saveQuizWithUserId:(NSString *)userID withassementId:(NSString*)miniCertificateId withQuestionsId:(NSArray *)questionIds withAnswers:(NSArray *)answers withResult:(NSString *)result andwithScore:(NSString *)score andCompleteBlock:(CompletionHandler)completeBlock
{
    //Params
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [params setObject:userID forKey:@"user_id"];
    [params setObject:miniCertificateId forKey:@"assesment_id"];
    [params setObject:questionIds forKey:@"article_quiz_id"];
    [params setObject:answers forKey:@"user_answer"];
    [params setObject:result forKey:@"result"];
    [params setObject:score forKey:@"score"];
     
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,saveQuizAnswers) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            NSDictionary *data=[response valueForKey:@"data"];
            
                        if (status == 1) {
                            NSDictionary *data = [response objectForKey:@"data"];
                            completeBlock(true, response);
                        }
                        else{
                            completeBlock(false, message);
                        }
        }
    }];

}
//SendQuery
-(void)sendQueryWithUserId:(NSString *)userId andwithQuey:(NSString *)query andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
     [params setObject:query forKey:@"feedback"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,sendQuary) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            NSDictionary *data=[response valueForKey:@"data"];
            completeBlock(true, response);
            //            if (status == 1) {
            //                NSDictionary *data = [response objectForKey:@"data"];
            //                completeBlock(true, data);
            //            }
            //            else{
            //                completeBlock(false, message);
            //            }
        }
    }];

}

//Bank Account Details
-(void)bankAccDetails :(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
   
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,bankAccountDetails) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            NSDictionary *data=[response valueForKey:@"data"];
           
                        if (status == 1) {
                            NSDictionary *data = [response objectForKey:@"data"];
                            completeBlock(true, data);
                        }
                        else{
                            completeBlock(false, message);
                        }
        }
    }];

}
//Updating Quiz Score
-(void)quizScoreUpdateWithUserId:(NSString *)userId andAssmentId:(NSString *)assment andName:(NSString *)name andEmail:(NSString *)email andMobileNumber:(NSString *)mobilenumber andTeleCode:(NSString *)telecode  andScore:(NSString *)score andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId  forKey:@"user_id"];
    [params setObject:assment forKey:@"assesment_id"];
    [params setObject:name forKey:@"name"];
    [params setObject:email forKey:@"email"];
    [params setObject:score forKey:@"score"];
    [params setObject:mobilenumber forKey:@"mobile"];
    [params setObject:telecode forKey:@"telcode"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,quizScoreUpdate) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             NSString *message = [response objectForKey:@"message"];
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1)
             {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else
             {
                 completeBlock(false, response);
             }
         }
     }];


}

//Getting Recorded Score
-(void)getingRecordedScoreWithUserId:(NSString *)userId andwithMinCerId:(NSString *)miniCerId ndCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId  forKey:@"user_id"];
    [params setObject:miniCerId  forKey:@"assessment_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,gettingScore) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, response);
            }
        }
    }];

    
}

-(void)viewAnswerwithUserId:(NSString *)userId andWithMinCerID:(NSString *)miniCerId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId  forKey:@"user_id"];
    [params setObject:miniCerId forKey:@"assessment_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,viewAnswer) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result) {
        if (!success) {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, response);
            }
        }
    }];
    
}

//History
-(void)historywithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId  forKey:@"user_id"];
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,history) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
    {
        if (!success)
        {
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                NSDictionary *data = [response objectForKey:@"data"];
                completeBlock(true, data);
            }
            else{
                completeBlock(false, response);
            }
        }
    }];

    
}

//Subscription
-(void)subscrptionList :(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
   
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,SubscriptionList) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             NSString *message = [response objectForKey:@"message"];
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, response);
             }
         }
     }];
 
}

//Subscription Type checking
-(void)subscriptionTypeCheckingwithUserId:(NSString *)userID andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
     [params setObject:userID forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,subscriptionchecking) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             NSString *message = [response objectForKey:@"message"];
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, response);
             }
         }
     }];

}
//Scratch Card Validity
-(void)scratchCartdValidatewithUserId:(NSString *)userId andwithScratchCard:(NSString *)scratchCard andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:scratchCard forKey:@"scratchcard"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,ScratchCardValidity) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];

}
//Remained me later

-(void)remainedMeLaterWithUserId:(NSString*)userId andWithAssessmentId:(NSString *)assessmentId andWithAuthorId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
     [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
     [params setObject:assessmentId forKey:@"assessment_id"];
     [params setObject:AuthoreId forKey:@"author_id"];
 
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Remaind_Me_Later) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Get All BookMark Folders
-(void)getBookMarkFolderWithUserId :(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
   
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Get_user_Folders) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1||status==0) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}

//Save Book Marks
-(void)saveBookMarksWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andWithArticleName:(NSString *)articleName andWithStickers:(NSString *)sticker andWithFolderName:(NSString *)folderName andWithFolderId:(NSString *)folderId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleId forKey:@"article_id"];
    [params setObject:articleName forKey:@"article_name"];
    // [params setObject:@"" forKey:@"stickers"];
      [params setObject:folderName forKey:@"folder_name"];
    [params setObject:folderId forKey:@"folder_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,save_BookMark) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//GetUserFolders
-(void)getUserFoldersWithUserId :(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,get_UserFolders) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1||status==0) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else
             {
                 completeBlock(false, message);
             }
         }
     }];
}

//Delete BookMarkFolder
-(void)deleteBookMarkFolderWithUserId:(NSString *)userId andWithFolderName:(NSString *)folderId andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:folderId forKey:@"folder_id"];
  
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Delete_BookMarkFolder) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}

//Delete BookMark Details
-(void)deleteBookMarkDetailsWithUserId:(NSString *)userId andwithBookMarkId:(NSString *)articleID andCompleteBlock:(CompletionHandler)completeBlock{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:articleID forKey:@"article_id"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Delete_BookMark_Details) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Notification Settings list
-(void)notificationPermissionsListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
   
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Notification_SettingsList) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];

}
//update_notifications_status
-(void)notificationUpdateStatusWithUserId:(NSString *)userId  andWithPermissionId:(NSString *)permissionId andWithStatus:(NSString *)status andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
      [params setObject:permissionId forKey:@"id"];
    [params setObject:status forKey:@"status"];
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Notification_updateStatus) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Get Book Marked Articles
-(void)getBookMarkedArticlesWithUserId:(NSString *)userId andwithBookMarkId:(NSString *)bookMarkId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:bookMarkId forKey:@"folder_id"];

    [[RequestManager sharedInstance]uploadFile:CONCAT_URL(BASE_URL_Service,bookMarked_Articles) andMimeType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result){
        if (!success){
            completeBlock(false, result);
        }
        else
        {
            NSDictionary *response = [result objectForKey:@"response"];
            NSString *message = [response objectForKey:@"message"];
            NSInteger status = [[response objectForKey:@"status"] intValue];
            if (status == 1) {
                completeBlock(true, response);
            }
            else
            {
                completeBlock(false, message);
            }
        }
    }];
}
//Search History
-(void)getSearchHistoryWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,SearchHistory) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
    
}
//Clear Search History
-(void)clearSearchHistoryWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,clearSearchHistory) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
    
}
//Get MiniCertificates List
-(void)getMiniCerListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,getMiniCertificatesList) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, response);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
    
}
//Get ALl Categories for Settings
-(void)getCategoriesForSettingsWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Settings_Category) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Update Intrest Categories Id
-(void)updateIntrestedCategoriesWithUserId:(NSString *)userId andWithCategoryId:(NSArray *)selectCategoryIds andWithUnselectCatId:(NSArray *)unselectCategoryIds andCompleteBlock:(CompletionHandler)completeBlock;
{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:selectCategoryIds forKey:@"selected_category_id"];
    [params setObject:unselectCategoryIds forKey:@"un_selected_category_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    NSLog(@"Params Are %@",params);
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Intrested_Categories_Update) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
    
}
//Get Report Analytics Value
-(void)getAnalyticsResultWithAssesmentid:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:assmentId forKey:@"assessment_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    NSLog(@"Params Are %@",params);
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Global_Quiz_Result) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Get Report Analytics for user list 
-(void)getAnalyticsResultForUserResultWithAssesmentid:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:assmentId forKey:@"assessment_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    NSLog(@"Params Are %@",params);
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Global_User_Result) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else{
                 completeBlock(false, message);
             }
         }
     }];
}
//Leader Board
-(void)leaderBoardDetailsWithUserId:(NSString *)strUserId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:strUserId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    NSLog(@"Params Are %@",params);
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Leader_board) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1) {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else
             {
                 completeBlock(false, message);
             }
         }
     }];
    
}
//Likes & dislikes
-(void)sendingLikesandDislikeswithUserId:(NSString *)strUserId andArticleid:(NSString *)articleid andAuthorid:(NSString *)authorid andlikes:(NSString *)likes andCompleteBlock:(CompletionHandler)completeBlock\
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:strUserId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:authorid forKey:@"author_id"];
    [params setObject:articleid forKey:@"article_id"];
    [params setObject:likes forKey:@"likes"];
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Likes_dislikes) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             NSString *message = [response objectForKey:@"message"];
             NSLog(@"%@",response);
             NSInteger status = [[response objectForKey:@"status"] intValue];
             if (status == 1)
             {
                 NSDictionary *data = [response objectForKey:@"data"];
                 completeBlock(true, data);
             }
             else
             {
                 completeBlock(false, message);
             }
         }
     }];
}

//Stripe Paymnet
-(void)stripePaymentWithUserId:(NSString *)userId andEnvironMent:(NSString *)environMent andStripetoken:(NSString *)stripeToken andCardNumber:(NSString *)cardnumber andexpyear:(NSString *)expiryyear andexpmonth:(NSString *)expirymonth andsubscriptionId:(NSString *)subscriptionId andCompleteBlock:(CompletionHandler)completeBlock
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:API_KEY forKey:@"api_key_data"];
    [params setObject:environMent forKey:@"environment"];
    [params setObject:subscriptionId forKey:@"subscription_id"];
    [params setObject:cardnumber forKey:@"cardnumber"];
    [params setObject:expiryyear forKey:@"exp_year"];
    [params setObject:expirymonth forKey:@"exp_month"];
    [params setObject:stripeToken forKey:@"stripetoken"];
    
    
    [[RequestManager sharedInstance]uploadVideo:CONCAT_URL(BASE_URL_Service,Stripe_Url) andVideoType:nil andFileData:nil andParam:params andCompleteBlock:^(BOOL success, id result)
     {
         if (!success)
         {
             completeBlock(false, result);
         }
         else
         {
             NSDictionary *response = [result objectForKey:@"response"];
             
             if ([response isEqual:[NSNull null]])
             {
                 completeBlock(false, result);
             }
             else
             { 
                 NSString *message = [response objectForKey:@"message"];
                 NSInteger status = [[response objectForKey:@"status"] intValue];
                 if (status == 1)
                 {
                     
                     completeBlock(true, response);
                 }
                 else
                 {
                     completeBlock(false, message);
                 }
             }
             
         }
     }];
}
@end

