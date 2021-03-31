//
//  APIDefineManager.h
//  Created by Biipmi on 24/6/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//


#ifndef APIDefineManager_h
#define APIDefineManager_h

/////////Services for ResourceCoach

//<<<Development URL's>>

//#define BASE_URL  @"http://54.151.221.7/resourcecoach_dev/"
//#define BASE_URL_Service @"http://54.151.221.7/resourcecoach_dev/index.php/"

//<<<Live URL's>>

//#define BASE_URL @ "http://54.251.245.100/resource_coach/"
//#define BASE_URL_Service @ "http://54.251.245.100/resource_coach/index.php/"

/*
#define BASE_URL @"http://54.254.33.124/resource_coach/"
#define BASE_URL_Service @"http://54.254.33.124/resource_coach/index.php/" */

// Dev URL
#define BASE_URL @"http://54.255.115.196/resourcecoach_dev/"
#define BASE_URL_Service @"http://54.255.115.196/resourcecoach_dev/index.php/"



//define apis for user

#define Create_Account @"Register_user/create_user"
#define Verify_Account @"Register_user/verify_mobile"
#define Login_Account @"Register_user/login"
#define Resend_OTP @"Register_user/resend_verifycode_mobile"
#define ForgotPassword_Account @"Register_user/forgot_password"
#define Verify_ForgotPassword_Account @"Register_user/verify_forgot_password"
#define ResetPassword_Account @"Register_user/set_newpassword"
#define Verify_Email_Account @"Register_user/verify_email"
#define Resend_OTP_For_Email @"Register_user/resend_verifycode_email"
#define Get_Profile @"Register_user/get_user"

#define Edit_Profile @"Register_user/edit_user"
#define Verify_Company_Code @"Register_user/verify_registration"

#define Get_All_Random_Articles @"Articles/random_articles"
//define apis for Categories
#define Get_All_Categories @"Category/categories"
#define Get_All_SubCategories @"Category/all_subcategories"
#define Get_All_Subcategories_With_CatId @"Category/subcategories"
#define Get_All_Articles @"Articles/all_articles"
#define Get_Article_Details @"Articles/article_details"
#define Search_Articles @"Articles_search/getall_articles"

#define GetAllTrainersList @"Author/all_author"
#define AddTrainerToFav @"Author/favorite_author"
#define UnfavTrainer @"Author/unfavorite_author"
#define AllarticleBasedOnAuthor @"Articles/all_articles_author"





//define apis for Company Details
#define Get_All_Companies @"Company/companies"
#define Get_All_Departments @"Company/department"




// define apis for create Article
#define Create_Article @"Articles/upload_articles"



#define Get_All_Favorite_Articles @"Favorite/all_favorite"
#define Add_To_Favorite_Article @"Favorite/favorite"
#define Remove_Article_From_Favorite @"Favorite/unfavorite"

//define apis for create Quiz
#define Create_Quiz @"Articles/create_quiz"

//define apis for viewscount
#define Article_Viewed @"Views/add_views"

//define apis for pushnotifications
#define Register_Device_For_Pushnotifications @"Gcmpush/storeUser"
#define Unregister_Device_For_Pushnotofications @"Gcmpush/logout_gcm"
#define Reset_Badge_Count @"Gcmpush/update_badge"

//define apis for Review
#define Get_All_Reviews @"Review/get_review"
#define Write_Review @"Review/write_review"

//define apis for Assessment
#define Get_Assessment @"Assessment/assessment"
#define Get_AssessmentDetails @"Assessment/assessment_details"

//define apis for Sequence
#define Get_All_Sequence @"Sequence/all_sequences"
#define Get_Sequence_Details @"Sequence/sequence_details"

//Get Groups Names
#define Get_All_GroupnameDetails @"Group/group_details"

//Search
#define Search @"Articles_search/getall_articles"

//Search
#define Search @"Articles_search/getall_articles"

//Start and End time for article
#define StartAndEndTimeForArticle @"Articles_view/article_duration"

//ArticleDuration

#define ArticleDuration @"Articles_view/article_duration_month"

//Article seen by users list
#define UsersofArticle @"Articles_view/article_duration_sum"

//Checking UserType
#define User_Type @"Register_user/user_type"

//My Article
#define GetAllMyArticles @"Articles_search/my_article"

//Create Sub Article

#define SubArticleCreation @"Sub_articles/upload_subarticles"
//#define FCM_NOTIFICATIONS @"Fcm_notification/push_notification"


//Notification FCM
#define FCM_NOTIFICATIONS @"Fcm_notification/push_notification"

//CoupunCode..
#define CouponCodeVerification @"Promocode/validate_promocode"

//GetAllMiniCertificates
#define GetAllMiniVertificates @"Assessment/mini_certify_by_author"

//MiniCertificatesDetails
#define MiniCertificatesDetails @"Assessment/mini_certification_details"

//AuthoreProfile
#define AuthoreDetails @"Assessment/author_details"

//HomeCategory details...
#define homeCatDetails @"Articles/article_by_category"

//Video Duration Update...
#define videoDuration @"Assessment/video_time"

//Saving QuizData
#define saveQuizAnswers @"Assessment/save_quiz_answer"

//Send Quary/////
#define sendQuary @"Assessment/feedback"

//BankAccountDetails
#define bankAccountDetails @"Assessment/money"

//Updating Quiz Score
#define quizScoreUpdate @"Assessment/save_customer_certifcate"

//getting Recorded Score
#define gettingScore @"Assessment/get_score"

//Quiz user Answers
#define viewAnswer @"Assessment/quiz_user_record"

//History
#define history @"History/all_history"

//Get All Subscription

#define SubscriptionList @"Promocode/get_all_subscription"

//Checking subscription
#define subscriptionchecking @"Promocode/get_user_subscription"

//ScratchCard validity
#define ScratchCardValidity @"Promocode/validate_scratchcard"

//Payment Url

#define PaymentUrl @"Payment_web/payment_send_response"

//<<<Privacy Test Url's>>>

#define PRIVACY_POLICY_URL  @"Welcome/privacypolicy"

//<<<<Remaindme later >>>>>
#define Remaind_Me_Later @"Assessment/save_remind_me_later"

//<<<Get User Folders>>>///
#define Get_user_Folders @"Articles/get_bookmark_folders"

//<<Save Book Mark>>///
#define save_BookMark @"Articles/save_bookmark_details"

//Get User BookMarkFolders
#define get_UserFolders @"Articles/get_user_book_marked_folder"

//<<DeleteBookMark Folder>>
#define Delete_BookMarkFolder @"Articles/delete_bookmark_folder"
//<<Delete BookMark>>>
#define Delete_BookMark_Details @"Articles/delete_bookmark"

//Notification Settings list
#define Notification_SettingsList @"Articles/get_notifications_setting_status"
//update_notifications_status
#define Notification_updateStatus @"Articles/update_notifications_setting_status"

//Get Book MarkArticles
#define bookMarked_Articles @"Articles/get_book_marked_folder_article"

//Minicertificate certificates
#define getMiniCertificatesList @"Register_user/get_user_certificate"
//Search History
#define SearchHistory @"Articles_search/get_all_search_history"

//Clearing Search history
#define clearSearchHistory @"Articles_search/clear_history"

//Settings Category
#define Settings_Category @"Articles/all_categories"
//IntrestedCategories
#define Intrested_Categories_Update @"Articles/update_category_article"

//GLobal GraphMarksResult
#define Global_Quiz_Result @"Assessment/global_user_marks"

//GLobal QuizResult
#define Global_User_Result @"Assessment/global_user_results"

//Leader board
#define Leader_board @"Articles/leader_boards_lists"

//Likes & DisLikes
#define Likes_dislikes @"Articles/personal_coaching"

#define Stripe_Url @"Stripe/stripeInfo"

#endif
