//
//  APIManager.h
//  Created by Biipmi on 24/6/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"
#define AppName @"Resource Coach"


@interface APIManager : NSObject
typedef void (^CompletionHandler)(BOOL success, id result);
+ (APIManager *)sharedInstance;
//Method definitions//

//User Account Methods
- (void)createAccount:(User*)user andWithProfileImage:(UIImage *)profileImage andCompleteBlock:(CompletionHandler)completeBlock;

-(void)accountActivation:(NSString *)userType andWithCountryCode:(NSString *)telCode andWithPhoneNumber:(NSString *)phoneNo andWithVerificationCode:(NSString *)otpCode andCompleteBlock:(CompletionHandler)completeBlock;

- (void)loginWithTelCode:(NSString *)telCode andWithMobileNumber:(NSString *)mobileNo andPassword:(NSString*)password andCompleteBlock:(CompletionHandler)completeBlock;

- (void)resendOTPWithTelCode:(NSString *)telCode andWithMobileNumber:(NSString *)mobileNo andCompleteBlock:(CompletionHandler)completeBlock;

- (void)forgotPasswordWithTelCode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andCompleteBlock:(CompletionHandler)completeBlock;

- (void)VerifyForgotPasswordWithTelcode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andWithForgotPassOTP:(NSString *)forgotOTP andCompleteBlock:(CompletionHandler)completeBlock;

- (void)setNewPasswordWithTelCode:(NSString *)telcode andWithMobileNumber:(NSString *)mobileNo andWithNewPassword:(NSString *)newPassword andWithNewConfirmPassword:(NSString *)newConfirmPass andCompleteBlock:(CompletionHandler)completeBlock;

-(void)verifyRegisteredEmailWithUserType:(NSString *)userType andWithEmail:(NSString *)email andWithEmailOTP:(NSString *)emailOTP andCompleteBlock:(CompletionHandler)completeBlock;

-(void)resendOtpForEmail:(NSString *)userEmail andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getUserProfileDetailsWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

- (void)updateUserProfile:(User*)user andWithProfileImage:(UIImage *)profileImage andCompleteBlock:(CompletionHandler)completeBlock;

-(void)verifyCompanyWithUserType:(NSString *)userType andWithCompanyId:(NSString *)compId andWithSecretCode:(NSString *)secretCode andCompleteBlock:(CompletionHandler)completeBlock;

//Company Methods
-(void)getAllCompanies:(CompletionHandler)completeBlock;

-(void)getAllDepartmentsWithCompanyId:(NSString *)companyId andCompleteBlock:(CompletionHandler)completeBlock;

//Categories Methods
//Categories Methods
-(void)getAllCategoriesWithUserID:(NSString *)userID andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getAllSubCategories:(CompletionHandler)completeBlock;

-(void)getAllSucbcategoriesWithCatId:(NSString *)catId andCompleteBlock:(CompletionHandler)completeBlock;

// Create Article Methods
//-(void)createArticleWithImagesUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithImage1:(UIImage *)img1 andWithImage2:(UIImage *)img2 andWithImage3:(UIImage *)img3 andCompleteBlock:(CompletionHandler)completeBlock;
-(void)createArticleWithImagesUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithImage1:(UIImage *)img1 andWithImage2:(UIImage *)img2 andWithImage3:(UIImage *)img3 andImgTitle1:(NSString *)imgTitle1 andImgTitle2:(NSString *)imgTitle2 andImgTitle3:(NSString *)imgTitle3 andTags:(NSMutableArray *)tags andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

//-(void)createArticleWithVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSURL *)video  andCompleteBlock:(CompletionHandler)completeBlock;
-(void)createArticleWithVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSURL *)video  andWithTags:(NSMutableArray *)tags andWithLink:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

//-(void)createArticleWithBrowseVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSData *)video andCompleteBlock:(CompletionHandler)completeBlock;
-(void)createArticleWithBrowseVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSData *)video andTags:(NSMutableArray *)tags andWithLink:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

-(void)createArticleWithYoutubeVideoUserId:(NSString *)userId andWithArticletitle:(NSString *)articleTitle andWithSubCatId:(NSString *)subCatId andWithShortDescription:(NSString *)shortDescription andWithLongDescription:(NSString *)longDescription andWithVideo:(NSData *)video andTags:(NSMutableArray *)tags andWithYoutube:(NSString *)link andWithLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

//Get Articles Methods
-(void)getAllArticlesWithSubCatId:(NSString *)subCatId andWithUserid:(NSString *)userId andLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getAllRandomArticles:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getArticleDetailsWithArticleId:(NSString *)articleId withUserid:(NSString *)userId andWithAssessmentId:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getAllSearchArticlesWithSearchKey:(NSString *)searchKey andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getAllFavoriteArticlesWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)addArticleToMyFavoriteArticlesWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)removeArticleFromMyFavoriteArticlesWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

// Push notification Methods
-(void)registerDeviceForPushnotificationsWithUserId:(NSString *)userId andWithDeviceType:(NSString *)deviceType andWithDeviceId:(NSString *)deviceId andWithregisterId:(NSString *)regId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)unRegisterDeviceForPushnotificationsWithUserId:(NSString *)userId andWithDeviceType:(NSString *)deviceType andWithDeviceId:(NSString *)deviceId andWithregisterId:(NSString *)regId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)resetBadgeCountWithDeviceId:(NSString *)deviceId andCompleteBlock:(CompletionHandler)completeBlock;

//Review Methods
-(void)getAllReviewsForParticularArticle:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

-(void)writeReviewForArticleWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andWithRating:(NSString *)rating andWithComment:(NSString *)comment andCompleteBlock:(CompletionHandler)completeBlock;

//Article viewed Methods
-(void)articleViewedWithUserid:(NSString *)userId andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

//Assessment Methods
-(void)getAllAssessmentsWithUserId:(NSString *)userId andWithDepartmentId:(NSString *)deptId andCompleteBlock:(CompletionHandler)completeBlock;
-(void)getAllAssessmentsWithUserId:(NSString *)userId  andCompleteBlock:(CompletionHandler)completeBlock;
-(void)getAssementDetailsWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

//Sequence Methods
-(void)getAllSequencesWithUserId:(NSString *)userid andCompleteBlock:(CompletionHandler)completeBlock;

-(void)getSequenceDetailsWithUserId:(NSString *)userId andWithSequenceId:(NSString *)seqId andCompleteBlock:(CompletionHandler)completeBlock;

//Quiz Methods
-(void)createQuizFortheArticleWithArticleId:(NSString *)articleId andWithQuestionName:(NSString *)quizName andWithOption1:(NSString *)option1 andWithOption2:(NSString *)option2 andWithOption3:(NSString *)option3 andWithOption4:(NSString *)option4 andWithAnswer:(NSString *)answer andCompleteBlock:(CompletionHandler)completeBlock;

//GroupName and Details
-(void)getGroupNameDetails:(NSString *)apiKey andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Search
-(void)search:(NSString*)apiKey andWithKeyText:(NSString *)keyText andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Start And End Time for Article read duration

-(void)startAndEndTimeforArticle:(NSString *)startTime andWithEndTime:(NSString *)endTime withUserId:(NSString *)userid andWithArticleId:(NSString *)articleId andCompleteBlock:(CompletionHandler)completeBlock;

//Article duration
-(void)articleDuration:(NSString *)articleid andwithYear:(NSString *)year andCompleteBlock:(CompletionHandler)completeBlock;

//users for article
-(void)userForOneArticle:(NSString *)articleid  andCompleteBlock:(CompletionHandler)completeBlock;

//Checking usertype

-(void)checkingUserType:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Get All My Articles

-(void)getAllMyArticles:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//create Sub Article
-(void)createSubArticle:(NSString *)article_id withUserId:(NSString *)userid withTitle:(NSString *)title withDescription:(NSString *)Description withLanguage:(NSString *)languag andCompleteBlock:(CompletionHandler)completeBlock;

//Sending Notifications using FCM....
-(void)sendingFCM_Notifications:(NSString *)reciverId withMessage:(NSString *)message withReciverName:(NSString *)receiverName withReciverProfile:(NSString *)reciverProfileImg withReciverUserId:(NSString *)reciverUserId withArticleId:(NSString *)articleId  andCompleteBlock:(CompletionHandler)completeBlock;

//VerificationPromoCode...
-(void)verifyPromoCode:(NSString *)userid withPromocode:(NSString *)promocode andCompleteBlock:(CompletionHandler)completeBlock;

//GetAll Trainers list Including Fav Trainers..
-(void)TrainersIncludingFav:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;
//Add Trainer To Fav..
-(void)AddTrainerToFavourite:(NSString *)userId andWithTrainerId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock;
//Remove Trainer from Fav..
-(void)RemoveTrainerFromFav:(NSString *)userId andWithTrainerId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock;
-(void)GetAllArticlesBasedonAuthoreId:(NSString *)userLanguage andwithUserId:(NSString *)userId andWithAuthoreId:(NSString *)authoreId andCompleteBlock:(CompletionHandler)completeBlock;

//GetAllMiniCertificates...
-(void)getAllMiniCertificatesListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//MiniCertificate Details...
-(void)miniCertificateDetailsWithId:(NSString *)miniCerId anduserID:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;
//Aurthore Details...
-(void)authoreDetailsWithAuthId:(NSString *)authoreId andCompleteBlock:(CompletionHandler)completeBlock;

//HomeCategory Article List..
-(void)homeCategoryArticlesListWithCatId:(NSString *)catId andWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Video Duration


-(void)updatingVideoDurationWithUserId:(NSString *)userId andWithAssementId:(NSString *)assessmentId withArticleId:(NSString *)articleId withStartTime:(NSString *)startTime andWithEndTime:(NSString *)endTime andCompleteBlock:(CompletionHandler)completeBlock;

//Save QuizAnswers
-(void)saveQuizWithUserId:(NSString *)userID withassementId:(NSString*)miniCertificateId withQuestionsId:(NSArray *)questionIds withAnswers:(NSArray *)answers withResult:(NSString *)result andwithScore:(NSString *)score andCompleteBlock:(CompletionHandler)completeBlock;

//SendQuery
-(void)sendQueryWithUserId:(NSString *)userId andwithQuey:(NSString *)query andCompleteBlock:(CompletionHandler)completeBlock;

//Bank Account Details
-(void)bankAccDetails :(CompletionHandler)completeBlock;

//Updating Quiz Score
-(void)quizScoreUpdateWithUserId:(NSString *)userId andAssmentId:(NSString *)assment andName:(NSString *)name andEmail:(NSString *)email andMobileNumber:(NSString *)mobilenumber andTeleCode:(NSString *)telecode  andScore:(NSString *)score andCompleteBlock:(CompletionHandler)completeBlock;

//Getting Recorded Score
-(void)getingRecordedScoreWithUserId:(NSString *)userId andwithMinCerId:(NSString *)miniCerId ndCompleteBlock:(CompletionHandler)completeBlock;

//View Answer
-(void)viewAnswerwithUserId:(NSString *)userId andWithMinCerID:(NSString *)miniCerId andCompleteBlock:(CompletionHandler)completeBlock;

//History
-(void)historywithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//SubscriptionList
-(void)subscrptionList :(CompletionHandler)completeBlock;

//Subscription Type checking
-(void)subscriptionTypeCheckingwithUserId:(NSString *)userID andCompleteBlock:(CompletionHandler)completeBlock;

//Scratch Card Validity
-(void)scratchCartdValidatewithUserId:(NSString *)userId andwithScratchCard:(NSString *)scratchCard andCompleteBlock:(CompletionHandler)completeBlock;

//Remained me later

-(void)remainedMeLaterWithUserId:(NSString*)userId andWithAssessmentId:(NSString *)assessmentId andWithAuthorId:(NSString *)AuthoreId andCompleteBlock:(CompletionHandler)completeBlock;
//Get All BookMark Folders
-(void)getBookMarkFolderWithUserId :(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Save Book Marks
-(void)saveBookMarksWithUserId:(NSString *)userId andWithArticleId:(NSString *)articleId andWithArticleName:(NSString *)articleName andWithStickers:(NSString *)sticker andWithFolderName:(NSString *)folderName andWithFolderId:(NSString *)folderId andCompleteBlock:(CompletionHandler)completeBlock;
//GetUserFolders
-(void)getUserFoldersWithUserId :(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;


//Delete BookMarkFolder
-(void)deleteBookMarkFolderWithUserId:(NSString *)userId andWithFolderName:(NSString *)folderId andCompleteBlock:(CompletionHandler)completeBlock;

//Delete BookMark Details
-(void)deleteBookMarkDetailsWithUserId:(NSString *)userId andwithBookMarkId:(NSString *)articleID andCompleteBlock:(CompletionHandler)completeBlock;

//Notification Settings list
-(void)notificationPermissionsListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//update_notifications_status
-(void)notificationUpdateStatusWithUserId:(NSString *)userId  andWithPermissionId:(NSString *)permissionId andWithStatus:(NSString *)status andCompleteBlock:(CompletionHandler)completeBlock;
//Get Book Marked Articles
-(void)getBookMarkedArticlesWithUserId:(NSString *)userId andwithBookMarkId:(NSString *)bookMarkId andCompleteBlock:(CompletionHandler)completeBlock;

//Search History
-(void)getSearchHistoryWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Clear Search History
-(void)clearSearchHistoryWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Get MiniCertificates List
-(void)getMiniCerListWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;

//Get All Categories for Settings
-(void)getCategoriesForSettingsWithUserId:(NSString *)userId andCompleteBlock:(CompletionHandler)completeBlock;
//Update Intrest Categories Id
-(void)updateIntrestedCategoriesWithUserId:(NSString *)userId andWithCategoryId:(NSArray *)selectCategoryIds andWithUnselectCatId:(NSArray *)unselectCategoryIds andCompleteBlock:(CompletionHandler)completeBlock;

//Get Report Analytics Value
-(void)getAnalyticsResultWithAssesmentid:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock;

//Leader Board
-(void)leaderBoardDetailsWithUserId:(NSString *)strUserId andCompleteBlock:(CompletionHandler)completeBlock;

//Likes & dislikes
-(void)sendingLikesandDislikeswithUserId:(NSString *)strUserId andArticleid:(NSString *)articleid andAuthorid:(NSString *)authorid andlikes:(NSString *)likes andCompleteBlock:(CompletionHandler)completeBlock;

//Get Report Analytics for user list
-(void)getAnalyticsResultForUserResultWithAssesmentid:(NSString *)assmentId andCompleteBlock:(CompletionHandler)completeBlock;

//Stripe Payment
-(void)stripePaymentWithUserId:(NSString *)userId andEnvironMent:(NSString *)environMent andStripetoken:(NSString *)stripeToken andCardNumber:(NSString *)cardnumber andexpyear:(NSString *)expiryyear andexpmonth:(NSString *)expirymonth andsubscriptionId:(NSString *)subscriptionId andCompleteBlock:(CompletionHandler)completeBlock;
@end
