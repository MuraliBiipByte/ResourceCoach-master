//
//  Language.m
//  SMILES
//
//  Created by BiipByte Technologies on 10/01/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Language.h"

//....AppSettings...///
//DedaaBox does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > DedaaBox.
#define eAppSettings @"Resource Coach does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > Resource Coach"
#define zAppSettings @"DedaaBox does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > DedaaBox"
#define mAppSettings @"> Iphone က Settings> Privacy> ကင်မရာ DedaaBox: DedaaBox access ကိုမှသွား enable သင့်ရဲ့ Camera.To မှဝင်ရောက်ခွင့်ရှိသည်ပါဘူး"
#define cAppSettings @">DedaaBox无法访问您的相机。要启用访问，请执行以下操作：Iphone设置>隐私>相机> DedaaBox"

//...NetWorkChecking..../////
//Please check your network Connection
#define echeckNet @"Please check your network Connection"
#define zcheckNet @"သင့္ အင္တာနက္ကို စစ္ေဆးပါ"
#define mcheckNet @"password နဲ့ပြန်ထည့်ပါ Password ကိုအတူတူပင်ဖြစ်သင့်သည်"
#define ccheckNet @"请检查您的网络连接，然后重试！"

//Login Page






#define eDedaaBox @"Resource Coach"
#define zDedaaBox @"DedaaBox"
#define mDedaaBox @"DedaaBox"
#define cDedaaBox @"DedaaBox"

//Mobile Number
#define eMobileNumber @"Mobile Number"
#define zMobileNumber @"ဖုန်းနံပါတ်"
#define mMobileNumber @"လက်ကိုင်ဖုန်းနာပတ်"
#define cMobileNumber @"手机号码"
//Password
#define ePassword @"Password"
#define zPassword @"စကားဝှက်"
#define mPassword @"Password ကို"
#define cPassword @"密码"

//ForgotPassword
#define eForgotPassword @"Forgot Password ?"
#define zForgotPassword @"လျှို့ဝှက်နံပါတ်ပြောင်းလိုပါသလား ?"
#define mForgotPassword @"စကားဝှက်ကိုမေ့နေပါသလား ?"
#define cForgotPassword @"忘记密码？"


//Change Language
#define  eChangeLanguage @"Change Language ?"
#define  zChangeLanguage @"ဘာသာစကား ပြောင်းလိုပါသလား ?"
#define  mChangeLanguage @"ဘာသာစကားများပြောင်းမလား?"
#define  cChangeLanguage @"改变语言？"
//Select Language
#define  eSelectLanguage @"Select Language"
#define  zSelectLanguage @"ဘာသာစကားရွေးချယ်"
#define  mSelectLanguage @"ဘာသာစကားကိုရွေးချယ်ပါ"
#define  cSelectLanguage @"选择语言"


//Login
#define eLogin @"Login"
#define zLogin @"လော့ဂ်အင်"
#define mLogin @"လော့ဂ်အင်"
#define cLogin @"注册"

//Don't Have An Account
#define eDonthaveanAccount @"Don’t have an Account ? SignUp As"
#define zDonthaveanAccount @"အကောင့် မရှိဘူးလား ? အကောင့် အသစ်ဖွင့်ပါ ။"
#define mDonthaveanAccount @"အကောင့်တခုဖွင်ရှိသည်မဟုတ်လော အမျှ Signup"
#define cDonthaveanAccount @"还没有账号？"


//SignUp
#define eSignUp @"SignUp"
#define zSignUp @"ဆိုင်းအပ်"
#define mSignUp @"ဆိုင်းအပ်"
#define cSignUp @"注册"

//SelectCountryCode
#define eSelectCountryCode @"Select Country"
#define zSelectCountryCode @"ဘာသာစကားေရြးခ်ယ္ပါ"
#define mSelectCountryCode @"Country ကို Select လုပ်ပါ"
#define cSelectCountryCode @"选择国家代码"

//MobileNumbercannotbeempty
#define eMobileNumbercannotbeempty @"Mobile Number cannot be empty!"
#define zMobileNumbercannotbeempty @"ဖုနျးနံပါတျခနြျထားလို့ မရပါ"
#define mMobileNumbercannotbeempty @"မိုဘိုင်းနံပါတ်အချည်းနှီးမဖွစျနိုငျ!"
#define cMobileNumbercannotbeempty @"手机号码不能为空！"

//Passwordcannotbeempty
#define ePasswordcannotbeempty @"Password cannot be empty!"
#define zPasswordcannotbeempty @"စကားဝှက်ချန်ထားလို့ မရပါ"
#define mPasswordcannotbeempty @"Password ကိုအချည်းနှီးမဖွစျနိုငျ!"
#define cPasswordcannotbeempty @"密码不能为空！"

//...Registrations...///


//FullName
#define eFullName @"Full Name"
#define zFullName @"အမည္အျပည့္အစံု"
#define mFullName @"နာမည်အပြည့်အစုံ"
#define cFullName @"全名"
//EmailOptional
#define eEmailOptional @"Email (Optional)"
#define zEmailOptional @"အီးေမးလ္ (Optional)"
#define mEmailOptional @"အီးမေးလ် (Optional)"
#define cEmailOptional @"电子邮件（可选）"
//ReEnterPassword
#define eReEnterPassword @"Re-Enter Password"
#define zReEnterPassword @"စကား၀ွက္ျပန္ရိုက္ထည့္ပါ"
#define mReEnterPassword @"လှို့ဝှက်စကားလုံးထပ်ရိုက်ပါ"
#define cReEnterPassword @"重新输入密码"
//FullNamecannotbeempty
#define eFullNamecannotbeempty @"Full Name cannot be empty!"
#define zFullNamecannotbeempty @"နာမည္ခ်န္ထားလို႔ မရပါ"
#define mFullNamecannotbeempty @"အပြည့်အဝ Name ကိုအချည်းနှီးမဖွစျနိုငျ!"
#define cFullNamecannotbeempty @"全名不能为空！"
//Re-enter Password cannot be empty!
#define eReenterPassEmpty @"Re-enter Password cannot be empty!"
#define zReenterPassEmpty @"စကား၀ွက္ခ်န္ထားလို႔မရပါ"
#define mReenterPassEmpty @"re-ရိုက်ထည့်ပါ Password ကိုအချည်းနှီးမဖွစျနိုငျ!"
#define cReenterPassEmpty @"重新输入密码不能为空！"

//Password and Re-enter Password should be same
#define ePassandReenterpassSame @"Password and Re-enter Password should be same"
#define zPassandReenterpassSame @"စကား၀ွက္ႏွင့္ ေနာက္တစ္ႀကိမ္ထပ္ရိုက္ေသာ စကား၀ွက္ တူညီရပါမည္ ။"
#define mPassandReenterpassSame @"password နဲ့ပြန်ထည့်ပါ Password ကိုအတူတူပင်ဖြစ်သင့်သည်"
#define cPassandReenterpassSame @"密码和重新输入密码应该相同"
//passwordValidate
#define epasswordValidate @"Password should be combination of alphanumeric and minimum 6 character and maximum 25 characters"
#define zpasswordValidate @"Password should be combination of alphanumeric and minimum 6 character and maximum 25 characters"
#define mpasswordValidate @"Password ကိုအက္ခရာနံပါတ်ပါတဲ့ခြင်းနှင့်နိမ့်ဆုံး 6 ဇာတ်ကောင်နှင့်အမြင့်ဆုံး 25 ဇာတ်ကောင်များ၏ပေါင်းစပ်ဖြစ်သင့်"
#define cpasswordValidate @"密码应为字母数字和最小6个字符，最多25个字符的组合"
//Camera
#define ecamera @"Camera"
#define zcamera @"ကင္မရာ"
#define mcamera @"ကင်မရာ"
#define ccamera @"相机"
//Gallery
#define eGallery @"Gallery"
#define zGallery @"Gallery"
#define mGallery @"ပြခန်း"
#define cGallery @"画廊"
//REGISTER
#define eREGISTER @"REGISTER"
#define zREGISTER @"စာရင္းသြင္းပါ"
#define mREGISTER @"REGISTER"
#define cREGISTER @"寄存器"
//InvalidEmail
#define eInvalidEmail @"Invalid Email"
#define zInvalidEmail @"အီးေမးလ္ မွားယြင္းေနပါသည္"
#define mInvalidEmail @"မှားနေသောအီးမေးလ်"
#define cInvalidEmail @"Invalid Email"

//Cancel
#define eCancel @"Cancel"
#define zCancel @"ပယ္ဖ်က္ပါ"
#define mCancel @"Cancel"
#define cCancel @"取消"
//Done
#define eDone @"Done"
#define zDone @"Done"
#define mDone @"ပြီးပြီ"
#define cDone @"完成"
//...MobileVerification....///

//MobileVerification
#define eMobileVerification @"Mobile Verification"
#define zMobileVerification @"Mobile Verification"
#define mMobileVerification @"မိုဘိုင်း Verification"
#define cMobileVerification @"移动验证"

//sentSMSverificationcodetothenumberbelow
#define esentSMSverificationcodetothenumberbelow @"We have sent you an SMS with a verification code to the number below"
#define zsentSMSverificationcodetothenumberbelow @"ေအာက္ေဖာ္ျပပါ နံပါတ္သို႔ Verification Code အား SMS ျဖင့္ေပးပို႔ လိုက္ပါၿပီ"
#define msentSMSverificationcodetothenumberbelow @"ကျနော်တို့အောက်ကအရေအတွက်အတည်ပြုရန်ကုဒ်နှင့်တကွသင် SMS တခုစေလွှတ်ပြီ"
#define csentSMSverificationcodetothenumberbelow @"我们已向您发送一封带有验证码的短信，并附上以下号码"

//FourdigitVerificationcode
#define eFourdigitVerificationcode @"To complete your phone number verification, please enter the 4-digit Verification code"
#define zFourdigitVerificationcode @"Verification ၿပီးဆံုးဖို႔ 4-digit Code အား ရိုက္ထည့္ပါ"
#define mFourdigitVerificationcode @"သင့်ရဲ့ဖုန်းနံပါတ်စိစစ်အတည်ပြုဖြည့်စွက်ဖို့, 4-ဂဏန်း Verification code ကိုရိုက်ထည့်ပါ"
#define cFourdigitVerificationcode @"要完成电话号码验证，请输入4位数的验证码"

//EnterVerificationCode
#define eEnterVerificationCode @"Enter Verification Code"
#define zEnterVerificationCode @"Verification Code ရိုက္ထည့္ပါ"
#define mEnterVerificationCode @"Verification Code ကိုရိုက်ထည့်"
#define cEnterVerificationCode @"输入验证码"

//NotReceivedVerificationCode
#define eNotReceivedVerificationCode @"Not received Verification Code?"
#define zNotReceivedVerificationCode @"Verification Code မရရွိေသးဘူးလား ?"
#define mNotReceivedVerificationCode @"Verification Code ကိုလက်ခံရရှိသည်မဟုတ်လော"
#define cNotReceivedVerificationCode @"输入验证码"
//RESEND
#define eRESEND @"RESEND"
#define zRESEND @"ထပ္မံပို႕ရန္"
#define mRESEND @"ပြန်ပို့မည်"
#define cRESEND @"重发"

//...<<ForgotPassword....>>///

//Forgot Password Page
//Forgot Password
#define eForgotPasswordTitle @"Forgot Password"
#define zForgotPasswordTitle @"စကား၀ွက္ေမ့ေနပါသလား"
#define mForgotPasswordTitle @"စကားဝှက်ကိုမေ့နေပါသလား"
#define cForgotPasswordTitle @"忘记密码"

//enterRegisteredMobileNumber
#define eenterRegisteredMobileNumber @"Please enter your registered Mobile Number"
#define zenterRegisteredMobileNumber @"စာရင္းသြင္းၿပီးသား ဖုန္းနံပါတ္ကို ထည့္သြင္းပါ"
#define menterRegisteredMobileNumber @"သင့်ရဲ့မှတ်ပုံတင်မိုဘိုင်းနံပါတ်ရိုက်ထည့်ပေးပါ"
#define centerRegisteredMobileNumber @"请输入您注册的手机号码"
//Code
#define eCode @"Code"
#define zCode @"Code"
#define mCode @"ကုဒ်"
#define cCode @"码"
//SUBMIT
#define eSUBMIT @"SUBMIT"
#define zSUBMIT @"ျဖည့္သြင္းပါ"
#define mSUBMIT @"သွင်းပါ"
#define cSUBMIT @"提交"

//...>>>Reset Password...>>

//sentOTPtoYourRegisteredMobileNumber
#define esentOTPtoYourRegisteredMobileNumber @"We have sent OTP to your registered Mobile Number"
#define zsentOTPtoYourRegisteredMobileNumber @"OTP နံပါတ္အား သင့္ဖုန္းသို႔ ေပးပို႔လိုက္ပါၿပီ"
#define msentOTPtoYourRegisteredMobileNumber @"ငါတို့သည်သင်တို့၏မှတ်ပုံတင်မိုဘိုင်းနံပါတ်မှ OTP စေလွှတ်ပြီ"
#define csentOTPtoYourRegisteredMobileNumber @"我们已将OTP发送到您注册的手机号码"

//notReceivedOTPPleaseclickonResendOTPButton
#define enotReceivedOTPPleaseclickonResendOTPButton @"Note:If you have given correct Mobile Number and still did not received OTP.Please click on Resend OTP Button"
#define znotReceivedOTPPleaseclickonResendOTPButton @"ဖုန္းနံပါတ္ အမွန္ရိုက္သြင္းၿပီးမွ OTP မရရိွပါက “OTP ထပ္ပို႔ရန္” ခလုတ္အားႏွိပ္ပါ"
#define mnotReceivedOTPPleaseclickonResendOTPButton @"မှတ်ချက်: အကယ်. သင်သည်မှန်ကန်သောမိုဘိုင်းနံပါတ်ပေးပြီနှင့်နေဆဲပြန်ပို့ရန် OTP Button ကိုနှိပ်ပါ OTP.Please လက်ခံရရှိဘူးဆိုရငျ	"
#define cnotReceivedOTPPleaseclickonResendOTPButton @"注意：如果您提供了正确的手机号码，但仍未收到OTP。请单击重新发送OTP按钮"
//EnterOTP
#define eEnterOTP @"Enter OTP"
#define zEnterOTP @"OTP နံပါတ္ထည့္သြင္းပါ"
#define mEnterOTP @"OTP Enter"
#define cEnterOTP @"输入OTP"
//ResendOTP
#define eResendOTP @"Resend OTP ?"
#define zResendOTP @"OTP ထပ္ပို႕ရန္"
#define mResendOTP @"OTP ပြန်ပို့မည်?"
#define cResendOTP @"重新发送OTP？"
//EnterNewPassword
#define eEnterNewPassword @"Enter New Password"
#define zEnterNewPassword @"စကား၀ွက္ အသစ္ရိုက္ထည့္ပါ"
#define mEnterNewPassword @"နယူး Password ကိုရိုက်ထည့်"
#define cEnterNewPassword @"输入新密码"
//SAVE
#define eSAVE @"SAVE"
#define zSAVE @"Save"
#define mSAVE @"တဘက်က"
#define cSAVE @"保存"

//..MenuList...///

#define eHome @"Home"
#define zHome @"မူလစာမ်က္ႏွာ"
#define mHome @"မူလစာမ်က္ႏွာ"
#define cHome @"首页"

#define eTopics @"Modules"
#define zTopics @"ခေါင်းစဉ်များ"
#define mTopics @"ခေါင်းစဉ်များ"
#define cTopics @"保存"

#define eTrainers @"Trainers"
#define zTrainers @"သင်တန်းဆရာ"
#define mTrainers @"သင်တန်းဆရာ"
#define cTrainers @"培训师"

#define eFavouriteVideos @"My Favourite Lessons"
#define zFavouriteVideos @"အကြိုက်ဆုံးဗီဒီယိုများ"
#define mFavouriteVideos @"My Favourite Lessons"
#define cFavouriteVideos @"我最喜欢的视频"

#define eSubscribe @"Subscription List"
#define zSubscribe @"Subscription List"
#define mSubscribe @"Subscription List"
#define cSubscribe @"Subscription List"

#define eHistory @"History"
#define zHistory @"သမိုင်း"
#define mHistory @"သမိုင်း"
#define cHistory @"历史"


#define eMyProfile @"My Profile"
#define zMyProfile @"ကၽြႏ္ုပ္၏ အခ်က္အလက္"
#define mMyProfile @"ကၽြႏ္ုပ္၏ အခ်က္အလက္"
#define cMyProfile @"我的简历"

#define eUserGuide @"User Guide"
#define zUserGuide @"အသံုးျပဳပံု အညႊန္း"
#define mUserGuide @"အသံုးျပဳပံု အညႊန္း"
#define cUserGuide @"用户指南"

#define eLogout @"LOGOUT"
#define zLogout @"logout"
#define mLogout @"LOGOUT"
#define cLogout @"登出"

//...Home Page...////
#define eLatestVideos @"Latest Lessons"
#define zLatestVideos @"LatestLessons"
#define mLatestVideos @"LatestLessons"
#define cLatestVideos @"LatestLessons"

#define eTrendingVideos @"Trending"
#define zTrendingVideos @"Trending"
#define mTrendingVideos @"Trending"
#define cTrendingVideos @"Trending"

#define eContinueReading @"Most Favourite Lessons"
#define zContinueReading @"စာဖတ်ခြင်းContinue"
#define mContinueReading @"စာဖတ်ခြင်းContinue"
#define cContinueReading @"继续阅读"

//....<<Topics>>...///

//NoArticlecategoryavailable
#define eNoArticlecategoryavailable @"No Modules available"
#define zNoArticlecategoryavailable @"ေဆာင္းပါးမ်ား၏ Category မေတြ႕ရွိပါ"
#define mNoArticlecategoryavailable @"မရှိနိုင်ပါအပိုဒ်အမျိုးအစား"
#define cNoArticlecategoryavailable @"မရှိနိုင်ပါအပိုဒ်အမျိုးအစား"

//Articles List  Page
//ArticlesList
#define eArticlesList @"Videos"
#define zArticlesList @"ေဆာင္းပါးမ်ား စာရင္း"
#define mArticlesList @"အပိုဒ်များစာရင်း"
#define cArticlesList @"视频列表"

//By
#define eBy @"By "
#define zBy @"By/မွ :"
#define mBy @"အားဖြင့် :"
#define cBy @"အားဖြင့် :"
//Views
#define eViews @"Views : "
#define zViews @"ၾကည့္ရူမႈ: "
#define mViews @"views : "
#define cViews @"views : "

//Are you sure, you want to remove this article from your Bookmark?

//removearticlefromFavouriteList
#define eremovearticlefromFavouriteList @"Are you sure, you want to remove this lesson from your favorite list?"
#define zremovearticlefromFavouriteList @"သင်အကြိုက်ဆုံးစာရင်းကနေဒီဗီဒီယိုကိုဖယ်ရှားပစ်ရန်လိုတာသေချာလား?"
#define mremovearticlefromFavouriteList @"သင် Favourite List ကိုမှဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?"
#define cremovearticlefromFavouriteList @"您确定要将此视频从您的收藏列表中删除吗？"
//ok
#define eok @"ok"
#define zok @"အိုကေ"
#define mok @"အိုကေ"
#define cok @"好"
//cancel
#define ecancel @"cancel"
#define zcancel @"ပယ္ဖ်က္ပါ"
#define mcancel @"ဖျက်သိမ်း"
#define ccancel @"取消"


//.........<<ArticleDetails........>>>>>>.//
//ArticleDetails

#define eArticleDetails @"Video Details."
#define zArticleDetails @"ေဆာင္းပါးအေသးစိတ္"
#define mArticleDetails @"အပိုဒ်အသေးစိတ်"
#define cArticleDetails @"继续阅读"

//PostedOn
#define ePostedOn @"Posted On: "
#define zPostedOn @"Posted On: "
#define mPostedOn @"တွင် Posted: "
#define cPostedOn @"发表于： "



//WriteReview
#define eWriteReview @"Comment"
#define zWriteReview @"ဆန္းစစ္ခ်က္ေရးရန္"
#define mWriteReview @"ဆန်းစစ်ခြင်းရေးထား"
#define cWriteReview @"写评论"

//Description
#define eDescription @"Description"
#define zDescription @"ေဖာ္ျပခ်က္"
#define mDescription @"ဖေါ်ပြချက်"
#define cDescription @"描述"

//View Analytics
#define eViewAnalytics @"View Analytics"
#define zViewAnalytics @"စီစစ္ခ်က္ၾကည့္ရႈပါ"
#define mViewAnalytics @"ကြည့်ရန် Analytics မှ"
#define cViewAnalytics @"查看分析"

//Quiz
#define eQuiz @"Quiz"
#define zQuiz @"စစ်ဆေးမေးမြန်းခြင်း"
#define mQuiz @"စစ်ဆေးမေးမြန်းခြင်း"
#define cQuiz @"测验"

//SubmitAnswer
#define eSubmitAnswer @"SUBMIT ANSWER"
#define zSubmitAnswer @"အေျဖထည့္သြင္းရန္"
#define mSubmitAnswer @"အဖြေ Submit"
#define cSubmitAnswer @"提交答复"

//Recommend Videos
#define eRecommendVideos @"Recommend Videos"
#define zRecommendVideos @"ဗီဒီယိုများအကြံပြု"
#define mRecommendVideos @"ဗီဒီယိုများအကြံပြု"
#define cRecommendVideos @"推荐影片"


//Download
#define eDownload @"Download"
#define zDownload @"ဒေါင်းလုပ်"
#define mDownload @"ဒေါင်းလုပ်"
#define cDownload @"下载"

//Share
#define eShare @"Share"
#define zShare @"ဝေစု"
#define mShare @"ဝေစု"
#define cShare @"分享"


//PleaseSelectOption
#define ePleaseSelectOption @"Please select option"
#define zPleaseSelectOption @"Option ေရြးခ်ယ္ပါ"
#define mPleaseSelectOption @"option ကို select လုပ်ပါကျေးဇူးပြုပြီး	"
#define cPleaseSelectOption @"请选择选项"


//..ReviewPage...///
//Review
#define eReview @"Comments"
#define zReview @"ဆန္းစစ္ခ်က္"
#define mReview @"ဆန်းစစ်ခြင်း"
#define cReview @"评论"
//WriteReviewForArticles

#define eWriteReviewForArticles @"Write your Comments..."
#define zWriteReviewForArticles @"写评论这篇文章"
#define mWriteReviewForArticles @"ဒီဆောင်းပါးအဘို့ကိုပြန်လည်ဆန်းစစ်ခြင်းရေးထား"
#define cWriteReviewForArticles @"写你的评论..."

//Rate
#define eRate @"Rate"
#define zRate @"Rate/အမွတ္ေပးပါ"
#define mRate @"rate"
#define cRate @"率"
//Submit
#define  eSubmit @"SUBMIT"
#define  zSubmit @"ျဖည့္သြင္းပါ"
#define  mSubmit @"Submit"
#define  cSubmit @"提交"

//Add your comment!
#define  eAddyourcomment @"Add your comment!"
#define  zAddyourcomment @"သင့်ရဲ့မှတ်ချက်ကိုထည့်သွင်းပါ!"
#define  mAddyourcomment @"သင့်ရဲ့မှတ်ချက်ကိုထည့်သွင်းပါ!"
#define  cAddyourcomment @"添加您的评论！"

//Rating
#define  eRating @"Rating :"
#define  zRating @"ျrating"
#define  mRating @"Submit"
#define  cRating @"提交"

//...Trainers...////
//No Data Available

#define eNodataAvailable @"No Data Available"
#define zNodataAvailable @"ရရှိနိုင်သောအဘယ်သူမျှမဒေတာများ"
#define mNodataAvailable @"သင်တန်းပေးအကြောင်း:"
#define cNodataAvailable @"No Data Available"

// MY Favourites
#define eMyFavourites @"My Favourite Trainers"
#define zMyFavourites @"သင်တန်းပေးအကြောင်း:"
#define mMyFavourites @"သင်တန်းပေးအကြောင်း:"
#define cMyFavourites @"My Favourites"
//Author Details
#define eAuthorDetails @"Trainer Details"
#define zAuthorDetails @"စာရေးသူကအသေးစိတ်"
#define mAuthorDetails @"စာရေးသူကအသေးစိတ်"
#define cAuthorDetails @"作者细节"

//VIDEOS
#define eVideos @"Lessons"
#define zVideos @"Lessons"
#define mVideos @"Lessons"
#define cVideos @"影片"

//LIKES
#define eLikes @"LIKES"
#define zLikes @"ကဲ့သို့"
#define mLikes @"ကဲ့သို့"
#define cLikes @"影片"

//About Trainer
#define eAboutTrainer @"About Trainer:"
#define zAboutTrainer @"သင်တန်းပေးအကြောင်း:"
#define mAboutTrainer @"သင်တန်းပေးအကြောင်း:"
#define cAboutTrainer @"关于培训师："


//.........<<Mini Certifications>>>>>>.//

// Mini Certifications
//#define eMiniCertifications @"Mini Certifications"
#define eMiniCertifications @"Mock assessment"
#define zMiniCertifications @"mini ကိုလက်မှတ်"
#define mMiniCertifications @"mini ကိုလက်မှတ်"
#define cMiniCertifications @"迷你认证"

// Read More
#define eReadMore @"READ MORE"
#define zReadMore @"ဆက်ဖတ်ရန်"
#define mReadMore @"mini ကိုလက်မှတ်"
#define cReadMore @"阅读更多"

// Courses
#define eCourses @"COURSES"
#define zCourses @"သင်တန်းများ"
#define mCourses @"သင်တန်းများ"
#define cCourses @"培训班"

// Count
#define eCount @"Count"
#define zCount @"သင်တန်းများ"
#define mCount @"သင်တန်းများ"
#define cCount @"培训班"

//.........<<Course Name>>>>>>.//
//CourseName
#define eCourseName @"Course Name"
#define zCourseName @"CourseName"
#define mCourseName @"CourseName"
#define cCourseName @"课程名"

//COURSE OVERVIEW
#define eCourseOverview @"COURSE OVERVIEW"
#define zCourseOverview @"သင်တန်းကိုခြုံငုံသုံးသပ်ရန်"
#define mCourseOverview @"သင်တန်းကိုခြုံငုံသုံးသပ်ရန်"
#define cCourseOverview @"课程大纲"

//LESSONS
#define eLessons @"LESSONS"
#define zLessons @"သငျခနျးစာ"
#define mLessons @"သငျခနျးစာ"
#define cLessons @"教训"

//DURATION
#define eDuration @"DURATION"
#define zDuration @"DURATION တွင်"
#define mDuration @"DURATION တွင်"
#define cDuration @"期限"

// Take the Quiz
#define eTakeTheQuiz @"TAKE THE QUIZ"
#define zTakeTheQuiz @"THE ပဟေဠိယူ"
#define mTakeTheQuiz @"THE ပဟေဠိယူ"
#define cTakeTheQuiz @"获得QUIZ"

//ViewScore
#define eViewScore @"View Score"
#define zViewScore @"ကြည့်ရန်ရမှတ်"
#define mViewScore @"ကြည့်ရန်ရမှတ်"
#define cViewScore @"获得QUIZ"

//RedeemCertificate
#define eRedeemCertificate @"Redeem Certificate"
#define zRedeemCertificate @"ကြည့်ရန်ရမှတ်"
#define mRedeemCertificate @"ကြည့်ရန်ရမှတ်"
#define cRedeemCertificate @"获得QUIZ"

//CollectECertificate
#define eCollectECertificate @"Collect E Certificate"
#define zCollectECertificate @"ကြည့်ရန်ရမှတ်"
#define mCollectECertificate @"ကြည့်ရန်ရမှတ်"
#define cCollectECertificate @"获得QUIZ"

//CollectECertificate
#define eCertificate @"Certificate"
#define zCertificate @"ကြည့်ရန်ရမှတ်"
#define mCertificate @"ကြည့်ရန်ရမှတ်"
#define cCertificate @"获得QUIZ"
//You Passed the exam

#define eYouPassed @"You Passed the Examination!"
#define zYouPassed @"ကြည့်ရန်ရမှတ်"
#define mYouPassed @"ကြည့်ရန်ရမှတ်"
#define cYouPassed @"获得QUIZ"

//Congratulations
#define eCongrats @"CONGRATULATIONS!"
#define zCongrats @"ကြည့်ရန်ရမှတ်"
#define mCongrats @"ကြည့်ရန်ရမှတ်"
#define cCongrats @"获得QUIZ"

//Please submit Name and Email
#define ePleaseSubmitNameEmail @"PLEASE SUBMIT YOUR NAME AND EMAIL TO REDEEM YOUR CERTIFICATE"
#define zPleaseSubmitNameEmail @"သင့်ရဲ့လက်မှတ်ကိုရွေးသင့်အမည်နှင့်အီးမေးကိုတင်သွင်းပါ"
#define mPleaseSubmitNameEmail @"PLEASE SUBMIT YOUR NAME AND EMAIL TO REDEEM YOUR CERTIFICATE"
#define cPleaseSubmitNameEmail @"PLEASE SUBMIT YOUR NAME AND EMAIL TO REDEEM YOUR CERTIFICATE"

//Name
#define eName @"Name"
#define zName @"ကြည့်ရန်ရမှတ်"
#define mName @"ကြည့်ရန်ရမှတ်"
#define cName @"获得QUIZ"
//Fee Aplied
#define eFeeApply @"Note:Fee Applied"
#define zFeeApply @"ကြည့်ရန်ရမှတ်"
#define mFeeApply @"ကြည့်ရန်ရမှတ်"
#define cFeeApply @"获得QUIZ"
//Please Enter Name
#define ePleaseEnterName @"Please Enter Name"
#define zPleaseEnterName @"ကြည့်ရန်ရမှတ်"
#define mPleaseEnterName @"ကြည့်ရန်ရမှတ်"
#define cPleaseEnterName @"获得QUIZ"

//Please Enter Email
#define ePleaseEnterEmail @"Please Enter Email"
#define zPleaseEnterEmail @"ကြည့်ရန်ရမှတ်"
#define mPleaseEnterEmail @"ကြည့်ရန်ရမှတ်"
#define cPleaseEnterEmail @"获得QUIZ"
//ForCert80%
#define eForCer80 @"*To Get Certificate You Have To Score Minimum 80%"
#define zForCer80 @"ကြည့်ရန်ရမှတ်"
#define mForCer80 @"ကြည့်ရန်ရမှတ်"
#define cForCer80 @"获得QUIZ"

//AttemptAllQuestions
#define eAttemptAllQuestions @"Please Attempt All Questions"
#define zAttemptAllQuestions @"ကြည့်ရန်ရမှတ်"
#define mAttemptAllQuestions @"ကြည့်ရန်ရမှတ်"
#define cAttemptAllQuestions @"获得QUIZ"



//BankDetails
#define eBankDetails @"Bank Details"
#define zBankDetails @"ကြည့်ရန်ရမှတ်"
#define mBankDetails @"ကြည့်ရန်ရမှတ်"
#define cBankDetails @"获得QUIZ"

//HotLine
#define eHotLine @"HOTLINE : +95 9 970500857"
#define zHotLine @"ကြည့်ရန်ရမှတ်"
#define mHotLine @"ကြည့်ရန်ရမှတ်"
#define cHotLine @"获得QUIZ"

//Call Customer
#define eCallCus @"CALL CUSTOMER SERVICE"
#define zCallCus @"ကြည့်ရန်ရမှတ်"
#define mCallCus @"ကြည့်ရန်ရမှတ်"
#define cCallCus @"获得QUIZ"
//To Collect 500KS
#define eToCollecty500KS @"TO COLLECT E-CERTIFICATE YOU MUST PAY 500KS TO FOLLOWING BANK ACCOUNTS BY BANK TRANSFER"
#define zToCollecty500KS @"ကြည့်ရန်ရမှတ်"
#define mToCollecty500KS @"ကြည့်ရန်ရမှတ်"
#define cToCollecty500KS @"获得QUIZ"


//Less
#define eLess @"Less"
#define zLess @"နည်းသော"
#define mLess @"နည်းသော"
#define cLess @"减"

//.........<<Assessments>>>>>>.//
//Assessments
#define eAssessments @"Assessments"
#define zAssessments @"အကဲဖြတ်"
#define mAssessments @"အကဲဖြတ်"
#define cAssessments @"评估"

//Assessment.
#define eAssesment @"Assessment"
#define zAssesment @"အကဲၿဖတ္ခ်က္"
#define mAssesment @"အကဲဖြတ်"
#define cAssesment @"အကဲဖြတ်"
//No Assessment Available.
#define eNoAssesment @"No Assessment Available"
#define zNoAssesment @"အကဲၿဖတ္ခ်က္ မရွိေသးပါ"
#define mNoAssesment @"ရရှိနိုင်သောအကဲဖြတ်ခြင်းမရှိပါ"
#define cNoAssesment @"ရရှိနိုင်သောအကဲဖြတ်ခြင်းမရှိပါ"

//Assessment Result
#define eAssessmentResult @"Result"
#define zAssessmentResult @"အကဲၿဖတ္ခ်က္ ရလဒ္"
#define mAssessmentResult @"အကဲဖြတ်ရလဒ်"
#define cAssessmentResult @"အကဲဖြတ်ရလဒ်"
//Score
#define eScore @"Score"
#define zScore @"အမွတ္"
#define mScore @"နိုင်ပြီ"
#define cScore @"နိုင်ပြီ"
//Percentage
#define ePercentage @"Percentage"
#define zPercentage @"ရာခိုင္ႏႈန္း"
#define mPercentage @"ရာခိုင်နှုန်း"
#define cPercentage @"ရာခိုင်နှုန်း"
//View Assessment Score
#define eViewAssessmentScore @"View Score"
#define zViewAssessmentScore @"အကဲၿဖတ္ခ်က္ ရလဒ္အား ၾကည့္ရႈပါ"
#define mViewAssessmentScore @"ကြည့်ရန်အကဲဖြတ်ရမှတ်"
#define cViewAssessmentScore @"ကြည့်ရန်အကဲဖြတ်ရမှတ်"
//Answer
#define eAnswer @"Answer"
#define zAnswer @"အဖွေ"
#define mAnswer @"အဖွေ"
#define cAnswer @"အဖွေ"

//SubscriptionPage...
//ApplyPromoCode

#define eApplyPromocodeHere @"Click Here To Apply PromoCode"
#define zApplyPromocodeHere @"အဖွေ"
#define mApplyPromocodeHere @"အဖွေ"
#define cApplyPromocodeHere @"အဖွေ"

//SubscribeToDedaaBox
#define eSubscribeToDedaaBox @"Subscribe To Resource Coach"
#define zSubscribeToDedaaBox @"အဖွေ"
#define mSubscribeToDedaaBox @"အဖွေ"
#define cSubscribeToDedaaBox @"အဖွေ"

//CommingSoon
#define eCommingSoon @"Comming Soon..."
#define zCommingSoon @"အဖွေ"
#define mCommingSoon @"အဖွေ"
#define cCommingSoon @"အဖွေ"
//Enter Coupon Code
#define eEnterCoupon @"Enter CouponCode"
#define zEnterCoupon @"အဖွေ"
#define mEnterCoupon @"အဖွေ"
#define cEnterCoupon @"အဖွေ"

//Apply
#define eApply @"Apply"
#define zApply @"အဖွေ"
#define mApply @"အဖွေ"
#define cApply @"အဖွေ"

//Success
#define eSuccess @"Success"
#define zSuccess @"အဖွေ"
#define mSuccess @"အဖွေ"
#define cSuccess @"အဖွေ"


//..Profile...//
//Email.
#define eEmail @"Email"
#define zEmail @"အီးေမးလ္"
#define mEmail @"အီးမေးလ်ပို့ရန်"
#define cEmail @"电子邮件"
//SelectCompanyName
#define eSelectCompanyName @"Select Company Name"
#define zSelectCompanyName @"ကုမၸဏီအမည္ေရြးခ်ယ္ပါ"
#define mSelectCompanyName @"ကုမၸဏီအမည္ေရြးခ်ယ္ပါ"
#define cSelectCompanyName @"选择公司名称"
//Edit Profile
#define eEditProfile @"Edit Profile"
#define zEditProfile @"သင်တန်းပေးအကြောင်း:"
#define mEditProfile @"သင်တန်းပေးအကြောင်း:"
#define cEditProfile @"Edit Profile"


//Not Verified.
#define eNotVerified @"Not Verified"
#define zNotVerified @"Not Verified"
#define mNotVerified @"စိစစ်ပြီးမဟုတ်"
#define cNotVerified @"未经审核的"

//Verified.
#define eVerified @"Verified"
#define zVerified @"အတည္ၿပဳၿပီးပါၿပီ"
#define mVerified @"မှန်ကန်ကြောင်းအတည်ပြု"
#define cVerified @"Verified"
//Verify Now.
#define eVerifyNow @"Verify Now"
#define zVerifyNow @"ယခုအတည္ၿပဳပါ"
#define mVerifyNow @"အခုတော့ Verify"
#define cVerifyNow @"Verify Now"
//Profile.

#define eProfile @"Profile"
#define zProfile @"Profile"
#define mProfile @"ပရိုဖိုင်းကို"
#define cProfile @"Profile"

//NotAvailable
#define eNotAvailable @"NotAvailable"
#define zNotAvailable @"NotAvailable"
#define mNotAvailable @"မရရှိနိုင်ပါ"
#define cNotAvailable @"NotAvailable"

//Code Expairy Date
#define eYourPromocodeExpaireOn @"Your Promo code expire On : "
#define zYourPromocodeExpaireOn @"သင့်ရဲ့ပရိုမိုကုဒ်တွင်သက်တမ်းကုန်ဆုံး:"
#define mYourPromocodeExpaireOn @"သင့်ရဲ့ပရိုမိုကုဒ်တွင်သက်တမ်းကုန်ဆုံး:"
#define cYourPromocodeExpaireOn @"Your Promo code expire On : "

//PromoCode
#define ePromoCode @"PROMO CODE"
#define zPromoCode @"ကြော်ငြာကုဒ်"
#define mPromoCode @"ကြော်ငြာကုဒ်"
#define cPromoCode @"PROMO CODE"
//ValidFrom
#define eValidFrom @"VALID FROM"
#define zValidFrom @"FROM မှခိုင်လုံသော"
#define mValidFrom @"FROM မှခိုင်လုံသော"
#define cValidFrom @"有效从"

//ValidTill
#define eValidTill @"VALID TILL"
#define zValidTill @"သို့မရောက်မှီတိုင်အောင်သက်တမ်းရှိ"
#define mValidTill @"သို့မရောက်မှီတိုင်အောင်သက်တမ်းရှိ"
#define cValidTill @"有效期至"
// Save Profile
#define eSaveProfile @"Save Profile"
#define zSaveProfile @"သင်တန်းပေးအကြောင်း:"
#define mSaveProfile @"သင်တန်းပေးအကြောင်း:"
#define cSaveProfile @"Save Profile"




//.........<<About Us........>>>>>>.//
//AboutUs

#define eAboutUs @"About Resource Coach"
#define zAboutUs @"ကၽြႏု္ပ္တို႔ အေၾကာင္း"
#define mAboutUs @"ကၽြႏု္ပ္တို႔ အေၾကာင္း"
#define cAboutUs @"关于我们"


//Email us:enquiries@xprienz.com.
#define eEmailUs @"Email us:anderson@biipmi.com"
#define zEmailUs @"Email us:production.dedaabox@gmail.com"
#define mEmailUs @"ကျွန်တော်တို့ကိုအီးမေးလ်ပို့ရန်အထိ:zintunwin@ztkfinancial.com"
#define cEmailUs @"给我们发电子邮件：zintunwin@ztkfinancial.com"

//Copyrights  © 2016.DemoSMILE.
#define eCopyrights @"Copyrights©2017.Biipmi Pte Ltd"
#define zCopyrights @"Copyrights©2017.Biipmi Pte Ltd"
#define mCopyrights @"မူပိုင်ခွင့်©2017.Biipmi Pte Ltd"
#define cCopyrights @"版权所有©2017.Biipmi Pte Ltd"

//All Rights Reserved.
#define eRights @"All Rights Reserved"
#define zRights @"All Rights Reserved"
#define mRights @"မူပိုင်ခွင့်များရယူပြီး။"
#define cRights @"版权所有"

//Terms&Conditions.
#define eTermsConditions @"Terms & Conditions"
#define zTermsConditions @"စည္းကမ္းသတ္မွတ္ခ်က္မ်ား"
#define mTermsConditions @"စည်းမျဉ်းများနဲ့အခြေအနေများ"
#define cTermsConditions @"条款和条件"

//Disclaimer:Design,Concept & Logo are copyright of DedaaBox.
#define eDisclaimer @"Disclaimer:Design, Concept & Logo are copyright of Biipmi Pte Ltd"
#define zDisclaimer @"Disclaimer:Design, Concept & Logo are copyright of Dedaa Box Company Limited"
#define mDisclaimer @"မသက်ဆိုင်ကြောင်းရှင်းလင်းချက်: ဒီဇိုင်း, Concept ကို & Logo Dedaa Box ကိုကုမ္ပဏီလီမိတက်၏မူပိုင်ဖြစ်ကြောင်း"
#define cDisclaimer @"免责声明：Design，Concept＆Logo是Dedaa Box Company Limited的版权"


//SendFeedBack
#define eSendFeedBack @"Send Feedback"
#define zSendFeedBack @"တုံ့ပြန်ချက် Send"
#define mSendFeedBack @"တုံ့ပြန်ချက် Send"
#define cSendFeedBack @"发送反馈"

//Call Us
#define eCallUs @"CALL US"
#define zCallUs @"ငါတို့ကိုခေါ်"
#define mCallUs @"ငါတို့ကိုခေါ်"
#define cCallUs @"致电我们"

//ENter query or feedback
#define eEnterQueryOrFeedBack @"ENTER YOUR QUERY OR FEEDBACK"
#define zEnterQueryOrFeedBack @"သင့်စုံစမ်းမှု OR တုံ့ပြန်ချက် ENTER"
#define mEnterQueryOrFeedBack @"သင့်စုံစမ်းမှု OR တုံ့ပြန်ချက် ENTER"
#define cEnterQueryOrFeedBack @"输入您的查询或反馈"


//Please Enter query or feedback
#define ePleaseEnterQueryOrFeedBack @"Please Enter Yout Query or Feedback"
#define zPleaseEnterQueryOrFeedBack @"Yout Query သို့မဟုတ်တုံ့ပြန်ချက် Enter ကျေးဇူးပြု."
#define mPleaseEnterQueryOrFeedBack @"Yout Query သို့မဟုတ်တုံ့ပြန်ချက် Enter ကျေးဇူးပြု."
#define cPleaseEnterQueryOrFeedBack @"请输入Yout查询或反馈"



//.........>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..........>>>>>>>>>>>>>>>>>>>>............>>>>>>>>>>>>>



//...Extra Options.........//

//SignUpasaSubscriber
#define eSignUpasaSubscriber @"Subscriber"
#define zSignUpasaSubscriber @"Subscriber"
#define mSignUpasaSubscriber @"စာရင်းပေးသွင်းသူ"
#define cSignUpasaSubscriber @"စာရင်းပေးသွင်းသူ"
//Or
#define eOr @"Or"
#define zOr @"သို့မဟုတ်"
#define mOr @"သို့မဟုတ်"
#define cOr @"သို့မဟုတ်"

//SignUpasaContributor
#define eSignUpasaContributor @"Contributor"
#define zSignUpasaContributor @"ပါဝင်ရေးသားသူ"
#define mSignUpasaContributor @"Contributor"
#define cSignUpasaContributor @"Contributor"

//accountNotActivated
#define eaccountNotActivated @"Your Account is not Activated. Please Wait for Admin Approval"
#define zaccountNotActivated @"သင့် အကောင့် Activate မဖြစ်သေးပါ ။ Admin မှခွင့်ပြုချက် စောင့်ဆိုင်းပေးပါ ။"
#define maccountNotActivated @"သင့်အကောင့်ကို activated မပေးပါ။ အဒ်မင်အတည်ပြုချက်အဘို့အစောင့်ပါကျေးဇူးပြုပြီး"

//loading
#define eloading @"loading"
#define zloading @"လုပ္ေဆာင္ေနသည္"
#define mloading @"တင်"


//Registration Page
//SubscriberSignUp
#define eSubscriberSignUp @"Subscriber Sign Up"
#define zSubscriberSignUp @"Subscriber အေကာင့္ျပဳလုပ္ရန္"
#define mSubscriberSignUp @"订阅者注册"
//ContributorSignUp
#define eContributorSignUp @"Contributor Sign Up"
#define zContributorSignUp @"ပါ၀င္ေရးသားသူ အေကာင့္ျပဳလုပ္ရန္"
#define mContributorSignUp @"贡献者注册"
//COMPANYDETAILS
#define eCOMPANYDETAILS @"COMPANY DETAILS"
#define zCOMPANYDETAILS @"ကုမၸဏီအေၾကာင္းအေသးစိတ္"
#define mCOMPANYDETAILS @"公司详细信息"

//SelectDepartment
#define eSelectDepartment @"Select Department"
#define zSelectDepartment @"ဌာနေရြးခ်ယ္ပါ"
#define mSelectDepartment @"选择部门"
//LearnerID Op
#define eLearnerIDOp @"Learner ID(Optional)"
#define zLearnerIDOp @"သင္ယူသူ၏ ID (Optional)"
#define mLearnerIDOp @"သင်ယူသူ ID ကို (Optional)"
//USERDETAILS
#define eUSERDETAILS @"USER DETAILS"
#define zUSERDETAILS @"အသံုးၿပဳသူအေၾကာင္း အေသးစိတ္"
#define mUSERDETAILS @"USER မှအသေးစိတ်"

//PleaseSelectCompanyName
#define ePleaseSelectCompanyName @"Please Select Company Name"
#define zPleaseSelectCompanyName @"ကုမၸဏီ အမည္ေရြးခ်ယ္ပါ"
#define mPleaseSelectCompanyName @"ကုမ္ပဏီအမည်ကို Select လုပ်ပါကျေးဇူးပြုပြီး"
//PleaseSelectDepartment
#define ePleaseSelectDepartment @"Please Select Department"
#define zPleaseSelectDepartment @"ဌာနေရြးခ်ယ္ပါ"
#define mPleaseSelectDepartment @"ဦးစီးဌာနကို Select လုပ်ပါကျေးဇူးပြုပြီး"
//mobileNoAlreadyRegistered
#define emobileNoAlreadyRegistered @"Sorry, This mobile no. is already registered with us, please login"
#define zmobileNoAlreadyRegistered @"Sorry,ဒီဖုန္းနံပါတ္ဟာ စာရင္းသြင္းၿပီး ျဖစ္ပါတယ္ ။ ေက်းဇူးၿပဳ၍ ၀င္ေရာက္ပါ ။"
#define mmobileNoAlreadyRegistered @"ဝမ်းနည်းပါတယ်, ဒီမိုဘိုင်းမရှိ။ ယခုပင်အကြှနျုပျတို့နှငျ့အတူမှတ်ပုံတင်, login ကျေးဇူးပြုပြီး"
//emailAlreadyRegistered
#define eemailAlreadyRegistered @"Sorry, This Email is already registered with us, please login"
#define zemailAlreadyRegistered @"Sorry,ဒီဖုန္းနံပါတ္ဟာ စာရင္းသြင္းၿပီး ျဖစ္ပါတယ္ ။ ေက်းဇူးၿပဳ၍ ၀င္ေရာက္ပါ ။"
#define memailAlreadyRegistered @"ဝမ်းနည်းပါတယ်, ဒီအီးမေးလ်ပြီးသားအကြှနျုပျတို့နှငျ့အတူမှတ်ပုံတင်, login ကျေးဇူးပြုပြီး"
//registrationSuccessfulCheckforOtp
#define eregistrationSuccessfulCheckforOtp @"Registration successful, please check your Message for OTP to verify your Mobile Number"
#define zregistrationSuccessfulCheckforOtp @"စာရင္းေပးသြင္းမႈ ေအာင္ျမင္ပါတယ္ ။ စစ္ေဆးဖို႔ SMS မွ တဆင့္ OTP နံပါတ္အား ၾကည့္ရွဳပါ ။"
#define mregistrationSuccessfulCheckforOtp @", သင့်လက်ကိုင်ဖုန်းနံပါတ်ကိုအတည်ပြုရန် OTP အဘို့သင့်ကို Message မှတ်ပုံတင်ခြင်းအောင်မြင်သောစစ်ဆေးကျေးဇူးပြုပြီး  "

//PleaseenterPassword
#define ePleaseenterPassword @"Please enter Password"
#define zPleaseenterPassword @"Please enter Password"
#define mPleaseenterPassword @"Password ကိုရိုက်ထည့်ပေးပါ"





//CheckyourOTPtoResetYourPassword
#define eCheckyourOTPtoResetYourPassword @"Please Check your Message for OTP to reset your password"
#define zCheckyourOTPtoResetYourPassword @"သင့္ စကား၀ွက္အား Reset ခ်ရန္အတြက္ OTP နံပါတ္အား Message (SMS) မွတဆင့္ ၾကည့္ရွူပါ"
#define mCheckyourOTPtoResetYourPassword @"သင့်ရဲ့ password ကို reset မှ OTP အဘို့သင့်ကို Message ကို Check ပေးပါ	"

//Yourpasswordchangedsuccessfully
#define eYourpasswordchangedsuccessfully @"Your password has been changed successfully"
#define zYourpasswordchangedsuccessfully @"စကား၀ွက္ေျပာင္းလဲမႈ ေအာင္ျမင္ပါတယ္"
#define mYourpasswordchangedsuccessfully @"သင့်ရဲ့စကားဝှက်ကိုအောင်မြင်စွာပြောင်းလဲခဲ့"

//Mobile Verification Page

//PleaseCheckyourMessageforOTP
#define ePleaseCheckyourMessageforOTP @"Please Check your Message for OTP"
#define zPleaseCheckyourMessageforOTP @"OTP ကိုရွာေဖြရန္ Message(SMS) ကို ၾကည့္ရွူပါ"
#define mPleaseCheckyourMessageforOTP @"OTP အဘို့သင့်ကို Message ကို Check ပေးပါ"
//mobileVerifiedSuccessfully
#define emobileVerifiedSuccessfully @"Congratulations!! your mobile has been verified successfully. Please wait for Admin Approval"
#define zmobileVerifiedSuccessfully @"သင့္ဖုန္း စာရင္းသြင္းမႈေအာင္ျမင္ပါတယ္ ။ ေက်းဇူးၿပဳ၍ Admin ရဲ႕ ခြင့္ျပဳမႈကို ေစာင့္ဆိုင္းပါ"
#define mmobileVerifiedSuccessfully @"ဂုဏ်ယူပါတယ် !! သင့်မိုဘိုင်းအောင်မြင်စွာအတည်ပြုလိုက်ပါပြီ။ အဒ်မင်အတည်ပြုချက်စောင့်ဆိုင်းပေးပါ"

//Home Page





//LatestArticles
#define eLatestArticles @"Latest Videos"
#define zLatestArticles @"ေနာက္ဆံုးေဆာင္းပါးမ်ား"
#define mLatestArticles @"နောက်ဆုံးရဆောင်းပါးများ"
//MostViewedArticles
#define eMostViewedArticles @"Most Viewed Videos"
#define zMostViewedArticles @"လူၾကည့္အမ်ားဆံုးေဆာင္းပါးမ်ား"
#define mMostViewedArticles @"အများဆုံးကြည့်ရှုအားပေးဆောင်းပါးများ"
//FavouriteArticles
#define eFavouriteArticles @"Favourite Videos"
#define zFavouriteArticles @"ႏွစ္သက္ေသာ ေဆာင္းပါးမ်ား"
#define mFavouriteArticles @"အကြိုက်ဆုံးဆောင်းပါးများ"
//NoArticlesAvailable
#define eNoArticlesAvailable @"No Lessons Available"
#define zNoArticlesAvailable @"ေဆာင္းပါးမ်ားမေတြ႔ရွိပါ"
#define mNoArticlesAvailable @"ရရှိနိုင်သောအဘယ်သူမျှမဆောင်းပါးများ"

//Articles Page
//Articles
#define eArticles @"Videos"
#define zArticles @"ေဆာင္းပါးမ်ား"
#define mArticles @"ဆောင်းပါးများ"
//ArticlesCategory
#define eArticlesCategory @"Videos Modules"
#define zArticlesCategory @"ေဆာင္းပါးမ်ား၏ Category"
#define mArticlesCategory @"ဆောင်းပါးများ Category:"







//Article Details Page








//Create Article Page
//CreateArticle
#define eCreateArticle @"Create Lessons"
#define zCreateArticle @"ေဆာင္းပါးဖန္တီးရန္"
#define mCreateArticle @"အပိုဒ် Creates"
//PhotoUpload
#define ePhotoUpload @"Photo Upload"
#define zPhotoUpload @"ဓါတ္ပံုတင္ရန္"
#define mPhotoUpload @"ဓာတ်ပုံလွှတ်တင်ခြင်း"
//VideoUpload
#define eVideoUpload @"Video Upload"
#define zVideoUpload @"ဗီဒီယိုတင္ရန္"
#define mVideoUpload @"ဗီဒီယိုလွှတ်တင်ခြင်း"
//UploadPhoto
#define eUploadPhoto @"Upload Photo"
#define zUploadPhoto @"ဓါတ္ပံုတင္ရန္"
#define mUploadPhoto @"လွှတ်တင်ခြင်းဓာတ်ပုံ"
//ArticleTitle
#define eArticleTitle @"Video Title"
#define zArticleTitle @"ေဆာင္းပါးေဆာင္းစဥ္"
#define mArticleTitle @"အပိုဒ်ခေါင်းစဉ်"

//ArticleTitleAlert
#define eArticleTitleAlert @"Input cannot exceed more than 60 characters"
#define zArticleTitleAlert @"Input cannot exceed more than 60 characters"
#define mArticleTitleAlert @"input 60 ကျော်ဇာတ်ကောင်ထက်မပိုနိုင်"

//ShortDescription
#define eShortDescription @"Short Description(Up to 200 Characters)"
#define zShortDescription @"ေဖာ္ျပခ်က္အက်ဥ္းခ်ဳပ္(Up to 200 Characters)"
#define mShortDescription @"Short Description (Up ကိုမှ 200 ဇာတ်ကောင်)"
//AddTag
#define eAddTag @"+Add Tag"
#define zAddTag @"+Add Tag"
#define mAddTag @"+Tag ကို Add"
//AssignedTags
#define eAssignedTags @"Assigned Tags (Max 5 Tags)"
#define zAssignedTags @"Tag မ်ားရိုက္ထည့္ပါ (Max 5 Tags)"
#define mAssignedTags @"တာဝန်ပေးအပ် Tags: (မက်စ် 5 Tags:)"
//SELECTCATEGORY
#define eSELECTCATEGORY @"SELECT CATEGORY"
#define zSELECTCATEGORY @"အမ်ိဳးအစားေရြးခ်ယ္ရန္"
#define mSELECTCATEGORY @"CATEGORY ရှိ SELECT"
//SELECTSUBCATEGORY
#define eSELECTSUBCATEGORY @"SELECT SUB CATEGORY"
#define zSELECTSUBCATEGORY @"ထပ္ဆင့္ အမ်ိဳးအစားေရြးခ်ယ္ရန္"
#define mSELECTSUBCATEGORY @"SUB CATEGORY ရှိ SELECT"
//SELECTSUBSUBCATEGORY
#define eSELECTSUBSUBCATEGORY @"SELECT SUB SUB CATEGORY"
#define zSELECTSUBSUBCATEGORY @"ေနာက္ထပ္ ထပ္ဆင့္ အမ်ိဳးအစားေရြးခ်ယ္ရန္"
#define mSELECTSUBSUBCATEGORY @"SUB SUB CATEGORY ရှိ SELECT"
//SELECTSUBSUBSUBCATEGORY
#define eSELECTSUBSUBSUBCATEGORY @"SELECT SUB SUB SUB CATEGORY"
#define zSELECTSUBSUBSUBCATEGORY @"SELECT SUB SUB SUB CATEGORY"
#define mSELECTSUBSUBSUBCATEGORY @"SUB SUB SUB CATEGORY ရှိ SELECT"
//PleaseChooseArticleImage.
#define ePleaseChooseArticleImage @"Please Choose Lessons Image"
#define zPleaseChooseArticleImage @"ေဆာင္းပါးအတြက္ ဓါတ္ပံုေရြးခ်ယ္ပါ"
#define mPleaseChooseArticleImage @"အပိုဒ် Image ကိုရှေးခယျြပါကျေးဇူးပြုပြီး"
//AddMorePhotos
#define eAddMorePhotos @"Add More Photos"
#define zAddMorePhotos @"ဓါတ္ပံုမ်ားထပ္ထည့္ပါ"
#define mAddMorePhotos @"နောက်ထပ်ဓါတ်ပုံများ Add"
//Image1
#define eImage1 @"Image1"
#define zImage1 @"ရုပ္ပံု(၁)"
#define mImage1 @"image ကို1"
//Image2
#define eImage2 @"Image2"
#define zImage2 @"ရုပ္ပံု(၂)"
#define mImage2 @"image ကို2"
//Image3
#define eImage3 @"Image3"
#define zImage3 @"ရုပ္ပံု(၃)"
#define mImage3 @"image ကို3"
//ImageoneCaption
#define eImageoneCaption @"Enter caption for image 1"
#define zImageoneCaption @"ရုပ္ပံု(၁)အတြက္ Caption ထည့္ပါ"
#define mImageoneCaption @"Image ကိုတဦးတည်းစာတန်းထိုး"
//ImagetwoCaption
#define eImagetwoCaption @"Enter caption for image 2"
#define zImagetwoCaption @"ရုပ္ပံု(၂)အတြက္ Caption ထည့္ပါ"
#define mImagetwoCaption @"Image ကိုနှစ်ဦးစာတန်းထိုး"
//ImagethreeCaption
#define eImagethreeCaption @"Enter caption for image 3"
#define zImagethreeCaption @"ရုပ္ပံု(၃)အတြက္ Caption ထည့္ပါ"
#define mImagethreeCaption @"Image ကိုသုံးစာတန်းထိုး"
//Camera
#define eCamera @"Camera"
#define zCamera @"ကင္မရာ"
#define mCamera @"ကင်မရာ"
//Gallery
#define eGallery @"Gallery"
#define zGallery @"Gallery"
#define mGallery @"ပြခန်း"

//Deletewillclearallthecaptioncontent
#define eDeletewillclearallthecaptioncontent @"Delete will clear all the caption content, are you sure you want to delete this image ?"
#define zDeletewillclearallthecaptioncontent @"ပယ္ဖ်က္ရန္ေသခ်ာၿပီလား?Caption ပ်က္သြားမည္ ျဖစ္သည္"
#define mDeletewillclearallthecaptioncontent @"လူအပေါင်းတို့သည်စာတန်းအကြောင်းအရာရှင်းလင်းလိမ့်မည်ကိုဖျက်ရမလား, သင်သည်ဤပုံရိပ်ကိုသင်ဖျက်လိုသေချာ"
//PleaseEnterArticleTitle
#define ePleaseEnterArticleTitle @"Please Enter Lessons Title"
#define zPleaseEnterArticleTitle @"ေဆာင္းပါးေခါင္းစဥ္ရိုက္ထည့္ပါ"
#define mPleaseEnterArticleTitle @"အပိုဒ်ခေါင်းစဉ်ကိုရိုက်ထည့်ပေးပါ"
//PleaseEnterArticleShortDescription
#define ePleaseEnterArticleShortDescription @"Please Enter Lessons Short Description"
#define zPleaseEnterArticleShortDescription @"ေဆာင္းပါး၏ေဖာ္ျပခ်က္အက်ဥ္းခ်ံဳးရိုက္ထည့္ပါ"
#define mPleaseEnterArticleShortDescription @"အပိုဒ် Short Description Enter ကျေးဇူးပြု"
//PleaseEnterArticleDescription.
#define ePleaseEnterArticleDescription @"Please Enter Lessons Description"
#define zPleaseEnterArticleDescription @"ေဆာင္းပါး၏ ေဖာ္ျပခ်က္ ရိုက္ထည့္ပါ"
#define mPleaseEnterArticleDescription @"အပိုဒ်ဖျေါပွခကျြ Enter ကျေးဇူးပြု"


//PleaseSelectCategory
#define ePleaseSelectCategory @"Please Select Category"
#define zPleaseSelectCategory @"အမ်ိဳးအစားေရြးခ်ယ္ပါ"
#define mPleaseSelectCategory @"Category: Select လုပ်ပါကျေးဇူးပြုပြီး"
//PleaseSelectSubCategory
#define ePleaseSelectSubCategory @"Please Select Sub Category"
#define zPleaseSelectSubCategory @"ထပ္ဆင့္ အမ်ိဳးအစားေရြးခ်ယ္ပါ"
#define mPleaseSelectSubCategory @"Sub အမျိုးအစားကိုရွေးချယ်ပါကျေးဇူးပြုပြီး"
//PleaseSelectSubSubCategory
#define ePleaseSelectSubSubCategory @"Please Select Sub Sub Category"
#define zPleaseSelectSubSubCategory @"ေနာက္ထပ္ ထပ္ဆင့္ အမ်ိဳးအစားေရြးခ်ယ္ပါ"
#define mPleaseSelectSubSubCategory @"Sub Sub အမျိုးအစားကိုရွေးချယ်ပါကျေးဇူးပြုပြီး"
//PleaseSelectSubSubSubCategory
#define ePleaseSelectSubSubSubCategory @"Please Select Sub Sub Sub Category"
#define zPleaseSelectSubSubSubCategory @"Please Select Sub Sub Sub Category"
#define mPleaseSelectSubSubSubCategory @"Sub Sub Sub အမျိုးအစားကိုရွေးချယ်ပါကျေးဇူးပြုပြီး"
//Titlemustbeatleast3characters
#define eTitlemustbeatleast3characters @"The Title field must be at least 3 characters in length"
#define zTitlemustbeatleast3characters @"ေခါင္းစဥ္က႑မွာ အနည္းဆံုး စာလံုး ၃ လံုးပါ၀င္ရမည္"
#define mTitlemustbeatleast3characters @"အဆိုပါခေါင်းစဉ်လယ်ကွင်းအရှည်အတွက်အနည်းဆုံး 3 ဇာတ်ကောင်ဖြစ်ရပါမည်"
//Descriptionmustbeatleast5characters
#define eDescriptionmustbeatleast5characters @"The Description field must be at least 5 characters in length"
#define zDescriptionmustbeatleast5characters @"ေဖာ္ျပခ်က္က႑မွာ အနည္းဆံုးစာလံုး ၅ လံုးပါ၀င္ရမည္"
#define mDescriptionmustbeatleast5characters @"အဆိုပါဖော်ပြချက်အကွက်အရှည်အနည်းဆုံး 5 ဇာတ်ကောင်ဖြစ်ရပါမည်"
// ShortDescriptionmustbeatleast5characters
#define eShortDescriptionmustbeatleast5characters @"The Short Description field must be at least 5 characters in length"
#define zShortDescriptionmustbeatleast5characters @"ေဖာ္ျပခ်က္အက်ဥ္းခ်ဳံဳးက႑မွာအနည္းဆံုး စာလံုး ၅ လံုးပါ၀င္ရမည္"
#define mShortDescriptionmustbeatleast5characters @"အဆိုပါ Short Description လယ်ကွင်းအရှည်အနည်းဆုံး 5 ဇာတ်ကောင်ဖြစ်ရပါမည်"
//Articleuploadedsuccessfully
#define eArticleuploadedsuccessfully @"Your Lesson is uploaded successfully"
#define zArticleuploadedsuccessfully @"သင့္ေဆာင္းပါးအား Upload ျပဳလုပ္မႈေအာင္ျမင္သည္"
#define mArticleuploadedsuccessfully @"သင့်ရဲ့အပိုဒ်ကိုအောင်မြင်စွာ upload ပြုလုပ်"
//UploadVideo
#define eUploadVideo @"Upload Video"
#define zUploadVideo @"ဗီဒီယိုတင္ရန္"
#define mUploadVideo @"လွှတ်တင်ခြင်းဗီဒီယို"
//ChooseVideo
#define eChooseVideo @"Choose Video"
#define zChooseVideo @"ဗီဒီယိုေရြးခ်ယ္ရန္"
#define mChooseVideo @"ဗီဒီယိုကိုရွေးချယ်ပါ"
//RecordVideo
#define eRecordVideo @"Record Video"
#define zRecordVideo @"ဗီဒီယိုျပဳလုပ္ရန္"
#define mRecordVideo @"စံချိန်ဗီဒီယို"
//EnterayoutubevideoURL
#define eEnterayoutubevideoURL @"Enter a youtube video URL"
#define zEnterayoutubevideoURL @"YouTube URL ထည့္သြင္းပါ"
#define mEnterayoutubevideoURL @"တစ် youtube ကဗီဒီယို URL ကိုရိုက်ထည့်"
//ClearVideo
#define eClearVideo @"Clear Video"
#define zClearVideo @"ဗီဒီယိုပယ္ဖ်က္ပါ"
#define mClearVideo @"Clear ကိုဗီဒီယို"
//UPLOADYOUTUBEURL
#define eUPLOADYOUTUBEURL @"UPLOAD YOUTUBE URL"
#define zUPLOADYOUTUBEURL @"YouTube URL တင္ရန္"
#define mUPLOADYOUTUBEURL @"YOUTUBE URL ကို upload"
//EnterYoutubeURL
#define eEnterYoutubeURL @"Enter Youtube URL"
#define zEnterYoutubeURL @"YouTube URL ထည့္သြင္းပါ"
#define mEnterYoutubeURL @"Youtube ကို URL ကိုရိုက်ထည့်"
//VALIDATE
#define eVALIDATE @"VALIDATE"
#define zVALIDATE @"Validate ျပဳလုပ္ပါ"
#define mVALIDATE @"VALIDATE"
//CANCEL
#define eCANCEL @"CANCEL"
#define zCANCEL @"ပယ္ဖ်က္ပါ"
#define mCANCEL @"ပယ်ဖျက်"
//PleaseEnterUrl
#define ePleaseEnterUrl @"Please Enter Url"
#define zPleaseEnterUrl @"URL ထည့္သြင္းပါ"
#define mPleaseEnterUrl @"Url ကိုထည့်သွင်းပါပါ။"
//NotValidate
#define eNotValidate @"Not Validate"
#define zNotValidate @"validate မျဖစ္ပါ/တရားမ၀င္ပါ"
#define mNotValidate @"အတည်ပြုပြီးမဟုတ်"

//We have sent you an Mail with a code to the below Email.
#define eMailsent @"We have sent you an Mail with a code to the below Email"
#define zMailsent @"ေအာက္ပါ email အား Code အားလွမ္းပို႕ပီးပါပီ"
#define mMailsent @"ကျနော်တို့ကိုအောက်တွင်အီးမေးလ်တစ်ခု code တွေနဲ့သင်တစ်ဦးမေးလ်စေလွှတ်ပြီ	"
#define cMailsent @"我们向您发送了一封带有代码的邮件到以下电子邮件"

//To complete your Email verification, please enter the 4-digit verification code.
#define eToComplete @"To complete your Email verification, please enter the 4-digit verification code"
#define zToComplete @"Email အားအတည္ၿပဳမႈၿပီးဆံုးဖို႕ 4 digit vertification codeအားရိုက္ထည့္ပါ"
#define mToComplete @"သင်၏ Email စိစစ်အတည်ပြုဖြည့်စွက်ဖို့, 4-ဂဏန်းစိစစ်အတည်ပြု code ကိုရိုက်ထည့်ပါ"
#define cToComplete @"要完成电子邮件验证，请输入4位验证码"
//Enter Verification Code.
#define eEnterVerification @"Enter Verification Code"
#define zEnterVerification @"Vertification Code ရိုက္ထည့္ပါ"
#define mEnterVerification @"Verification Code ကိုရိုက်ထည့်"
//Not received Verification Code ?.
#define eNotrecieved @"Not received Verification Code ?"
#define zNotrecieved @"Veritication Code မရရွိပါဘူးလား?"
#define mNotrecieved @"Verification Code ကိုလက်ခံရရှိသည်မဟုတ်လော"
#define cNotrecieved @"未收到验证码？"

////RESEND.
//#define eRESEND @"RESEND"
//#define cRESEND @"重发"
//#define bRESEND @"ပြန်ပို့မည်"
////Code.
//#define eCode @"Code"
//#define cCode @"代码"
//#define bCode @"ကုဒ်"





//Company Name.
#define eCompanyName @"Company Name"
#define zCompanyName @"ကုမၸဏီ၏အမည္"
#define mCompanyName @"ကုမ္ပဏီအမည်"
//Department.
#define eDepartment @"Department"
#define zDepartment @"ဌာန"
#define mDepartment @"ဌါန"
//LearnerID.
#define eLearnerID @"LearnerID"
#define zLearnerID @"သင္ယူသူ၏ ID"
#define mLearnerID @"LearnerID"


//Your profile has been Updated successfully.
#define eYouProfile @"Your profile has been Updated successfully"
#define zYouProfile @"သင့္ Profile အားေအာင္ၿမင္စြာ Upload လုပ္ၿပီးပါၿပီ"
#define mYouProfile @"သင့်ရဲ့ပရိုဖိုင်းကိုအောင်မြင်စွာနောက်ဆုံးရေးသားချိန်ခဲ့"



//User Guide.
#define eUserGuide @"User Guide"
#define zUserGuide @"အသံုးျပဳပံု အညႊန္း"
#define mUserGuide @"အသုံးပြုသူလမ်းညွှန်"

//Sequenced Articles.
#define eSequencedArticles @"Sequenced Lessons"
#define zSequencedArticles @"Sequenced Lessons"
#define mSequencedArticles @"Sequenced ဆောင်းပါးများ"
//No Sequence Available.
#define eNoSequence @"No Sequence Available"
#define zNoSequence @"No Sequence Available"
#define mNoSequence @"ရရှိနိုင်အဆက်မပြတ်ဘယ်သူမျှမက"


//View Assessment.
#define eViewAssesment @"View Assessment"
#define zViewAssesment @"အကဲၿဖတ္ခ်က္ ကိုၾကည့္ရႈပါ"
#define mViewAssesment @"ကြည့်ရန်အကဲဖြတ်"

//My Learning Groups.
#define eMylearningGroups @"My Learning Groups"
#define zMylearningGroups @"ကၽြႏု္ပ္၏ Learning Group"
#define mMylearningGroups @"အကြှနျုပျ၏သင်ယူအဖွဲ့များ"
//No Groups Available.
#define eNoGroupsAvailable @"No Groups Available"
#define zNoGroupsAvailable @"No Groups Available"
#define mNoGroupsAvailable @"ရရှိနိုင်သောအဘယ်သူမျှမအဖွဲ့များ"

//Create Quiz.
#define eCreateQuiz @"Create Quiz"
#define zCreateQuiz @"Quiz ဖန္တီးပါ"
#define mCreateQuiz @"ပဟေဠိကိုဖန်တီးပါ။"
//Question.
#define eQuestion @"Question"
#define zQuestion @"ေမးခြန္း"
#define mQuestion @"မေးခွန်း"
//Enter Question Name.
#define eEnterQuestionName @"Enter Question Name"
#define zEnterQuestionName @"ေမးခြန္းထည့္သြင္းပါ"
#define mEnterQuestionName @"မေးခွန်း Name ကိုရိုက်ထည့်ပါ။"
//Answer Option1.
#define eAnswerOption1 @"Answer Option1"
#define zAnswerOption1 @"အေျဖ နည္းလမ္း(၁)"
#define mAnswerOption1 @"Option1 အဖြေ"
//Answer Option2.
#define eAnswerOption2 @"Answer Option2"
#define zAnswerOption2 @"အေျဖ နည္းလမ္း(၂)"
#define mAnswerOption2 @"Option2 အဖြေ"
//Answer Option3.
#define eAnswerOption3 @"Answer Option3"
#define zAnswerOption3 @"အေျဖ နည္းလမ္း(၃)"
#define mAnswerOption3 @"Option3 အဖြေ"
//Answer Option4.
#define eAnswerOption4 @"Answer Option4"
#define zAnswerOption4 @"အေျဖ နည္းလမ္း(၄)"
#define mAnswerOption4 @"Option4 အဖြေ"
//Enter the option answer1.
#define eEntertheoptionanswer1 @"Enter the option answer1"
#define zEntertheoptionanswer1 @"အေျဖ နည္းလမ္း(၁) ထည့္သြင္းပါ"
#define mEntertheoptionanswer1 @"ထို option ကိုအဖြေထည့်သွင်းပါ1"
//Enter the option answer2.
#define eEntertheoptionanswer2 @"Enter the option answer2"
#define zEntertheoptionanswer2 @"အေျဖ နည္းလမ္း(၂)ထည့္သြင္းပါ"
#define mEntertheoptionanswer2 @"ထို option ကိုအဖြေထည့်သွင်းပါ2"
//Enter the option answer3.
#define eEntertheoptionanswer3 @"Enter the option answer3"
#define zEntertheoptionanswer3 @"အေျဖ နည္းလမ္း(၃)ထည့္သြင္းပါ"
#define mEntertheoptionanswer3 @"ထို option ကိုအဖြေထည့်သွင်းပါ3"
//Enter the option answer4.
#define eEntertheoptionanswer4 @"Enter the option answer4"
#define zEntertheoptionanswer4 @"အေျဖ နည္းလမ္း(၄)ထည့္သြင္းပါ"
#define mEntertheoptionanswer4 @"ထို option ကိုအဖြေထည့်သွင်းပါ4"
//Select the correct answer.
#define eSelectthecorrectanswer @"Select the correct answer"
#define zSelectthecorrectanswer @"选择正确的答案"
#define mSelectthecorrectanswer @"မှန်ကန်သောအဖြေကိုရွေးချယ်ပါ"
//SelectAnswer.
#define eSelectAnswer @"Select the Correct Answer"
#define zSelectAnswer @"အေၿဖေရြးခ်ယ္ပါ"
#define mSelectAnswer @"အဖြေကိုရွေးချယ်ပါ"
//Select Option.
#define eSelectOption @"Select Option"
#define zSelectOption @"Option ေရြးခ်ယ္ပါ"
#define mSelectOption @"Option ကို Select လုပ်ပါ"
//Option.
#define eOption @"Option"
#define zOption @"Option"
#define mOption @"option ကို"
//Please enter all the fields.
#define ePleaseenterallthefields @"Please enter all the fields"
#define zPleaseenterallthefields @"Field အားလံုးရိုက္ထည္႕ပါ"
#define mPleaseenterallthefields @"အားလုံးလယ်ရိုက်ထည့်ပေးပါ"
//Please enter Question.
#define ePleaseenterQuestion @"Please enter Question"
#define zPleaseenterQuestion @"ေမးခြန္းရိုက္ထည့္ပါ"
#define mPleaseenterQuestion @"မေးခွန်းရိုက်ထည့်ပေးပါ"
//Please enter option.
#define ePleaseenteroption @"Please enter option"
#define zPleaseenteroption @"Option ရိုက္ထည့္ပါ"
#define mPleaseenteroption @"option ကိုရိုက်ထည့်ပေးပါ"
//Please select correct answer.
#define ePleaseselectcorrectanswer @"Please select correct answer"
#define zPleaseselectcorrectanswer @"အေၿဖေရြးခ်ယ္ပါ"
#define mPleaseselectcorrectanswer @"မှန်ကန်သောအဖြေကိုရွေးချယ်ပါကျေးဇူးပြုပြီး"
//Quiz inserted successfully.
#define eQuizInserted @"Quiz inserted successfully"
#define zQuizInserted @"Quiz အားေအာင္ၿမင္စြာထည္႔ၿပီးပါၿပီ"
#define mQuizInserted @"ပဟေဠိကိုအောင်မြင်စွာဖြည့်စွက်"

//Please Enter OTP.
#define epleaseEnterOTP @"Please Enter OTP"
#define zpleaseEnterOTP @"OTP Enter ကျေးဇူးပြု."
#define mpleaseEnterOTP @"OTP Enter ကျေးဇူးပြု."

//Submit Assessment
#define eSubmitAssessment @"Submit"
#define zSubmitAssessment @"အကဲၿဖတ္ခ်က္ တင္သြင္းပါ"
#define mSubmitAssessment @"အကဲဖြတ် Submit"
#define cSubmitAssessment @"အကဲဖြတ် Submit"

//LearnerID
#define eLearnerID @"LearnerID"
#define zLearnerID @"သင္ယူသူ၏ ID"
#define mLearnerID @"LearnerID"
//Email Verification
#define eEmailVerification @"Email Verification"
#define zEmailVerification @"Email Verification"
#define mEmailVerification @"အီးမေးလ်မှန်ကန်ကြောင်းအတည်ပြု"


//Search
#define eSearch @"Search"
#define zSearch @"ရွာပါ"
#define mSearch @"ရှာဖှေ"

//SubArticles

#define eAddSubArticles @"Add-Sub Lesson"
#define zAddSubArticles @"Sub Lesson ထည့္သြင္းပါ"
#define mAddSubArticles @"Add-Sub အပိုဒ်"

#define eSubArticleTitle @"Sub-Lesson Title"
#define zSubArticleTitle @"Sub Lesson ၏ေခါင္းစဥ္"
#define mSubArticleTitle @"sub-အပိုဒ်ခေါင်းစဉ်"

#define eSubArticleDescription @"Sub-Lesson Description"
#define zSubArticleDescription @"Sub Lesson ၏ရည္ညြန္း"
#define mSubArticleDescription @"sub-အပိုဒ်ဖျေါပွခကျြ"

#define eSubArticleTitlePlaceHolder @"Enter Sub-Lesson Title"
#define zSubArticleTitlePlaceHolder @"Sub Lesson ၏ေခါင္းစဥ္ ရိုက္ထည့္ပါ"
#define mSubArticleTitlePlaceHolder @"Sub-အပိုဒ်ခေါင်းစဉ်ကိုရိုက်ထည့်"

#define eSubArticleDescriptionPlaceHolder @"Enter Sub-Lesson Description"
#define zSubArticleDescriptionPlaceHolder @"Sub Lesson ၏ရည္ညြန္း ရိုက္ထည့္ပါ"
#define mSubArticleDescriptionPlaceHolder @"Sub-အပိုဒ်ဖျေါပွခကျြ Enter"

#define eAdd @"Add"
#define zAdd @"ၿဖည့္စြက္ပါ"
#define mAdd @"ပေါင်း"

#define eMoreSubArticle @"More Sub Lessons"
#define zMoreSubArticle @"More Sub Lessons"
#define mMoreSubArticle @"ပိုများသော Sub ဆောင်းပါးများ"

#define eAddSubArticleMy @"Add Sub Lessons"
#define zAddSubArticleMy @"Sub Lesson ထည့္သြင္းပါ"
#define mAddSubArticleMy @"Sub ဆောင်းပါးများ Add"

#define eMyArticles @"My Created Lessons"
#define zMyArticles @"အကြှနျုပျ၏ဆောင်းပါးများ"
#define mMyArticles @"အကြှနျုပျ၏ဆောင်းပါးများ"

#define ePleaseEnterTitle @"Please Enter Title"
#define zPleaseEnterTitle @"ခေါင်းစဉ်ကိုရိုက်ထည့်ပေးပါ"
#define mPleaseEnterTitle @"ခေါင်းစဉ်ကိုရိုက်ထည့်ပေးပါ"

#define ePleaseEnterDescription @"Please Enter Description"
#define zPleaseEnterDescription @"ဖျေါပွခကျြ Enter ကျေးဇူးပြု."
#define mPleaseEnterDescription @"ဖျေါပွခကျြ Enter ကျေးဇူးပြု."



#define eReportAnalytics @"Reports & Analytics"
#define zReportAnalytics @"အစီရင္ခံစာႏွင့္ေတြ႕ရွိခ်က္မ်ား"
#define mReportAnalytics @"အစီရင်ခံစာများ analytics"

#define eSNO @"S.NO"
#define zSNO @"S.No"
#define mSNO @"S.NO"

#define eUSERNAME @"USER NAME"
#define zUSERNAME @"အသံုးျပဳသူ အမည္"
#define mUSERNAME @"user name"

#define eVIEWCOUNT @"VIEW COUNT"
#define zVIEWCOUNT @"ၾကည့္ရႈသည့္အေရအတြက္"
#define mVIEWCOUNT @"View count"

#define eDURATIONSPENT @"DURATION SPENT"
#define zDURATIONSPENT @"ၾကာခ်ိန္"
#define mDURATIONSPENT @"DURATION တွင်ပါဝငျ"



@implementation Language

//...AppSettings....///

+(NSString *)appSettings{
    if ([language isEqualToString:@"2"]) {
        return zAppSettings;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAppSettings;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAppSettings;
    }
    else{
        return eAppSettings;
    }
}
+(NSString *)PleaseyourNetworkConnection{
    if ([language isEqualToString:@"2"]) {
        return zcheckNet;
    }
    else if ([language isEqualToString:@"3"]) {
        return mcheckNet;
    }
    else if ([language isEqualToString:@"4"]) {
        return ccheckNet;
    }
    else{
        return echeckNet;
    }
}
///...Login....///

+(NSString*)DedaaBox {
    if ([language isEqualToString:@"2"]) {
        return zDedaaBox;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDedaaBox;
    }
    else if ([language isEqualToString:@"4"]){
        return cDedaaBox;
    }
    else{
        return eDedaaBox;
        
    }
}
+(NSString *)MobileNumber{
    if ([language isEqualToString:@"2"]) {
        return zMobileNumber;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMobileNumber;
    }
    else if ([language isEqualToString:@"4"]){
        return cMobileNumber;
    }
    else{
        return eMobileNumber;
    }
}
+(NSString *)Password{
    if ([language isEqualToString:@"2"]) {
        return zPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPassword;
    }
    else if ([language isEqualToString:@"4"]){
        return cPassword;
    }
    else{
        return ePassword;
    }
}
+(NSString *)ForgotPassword{
    if ([language isEqualToString:@"2"]) {
        return zForgotPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mForgotPassword;
    }
    else if ([language isEqualToString:@"4"]){
        return cForgotPassword;
    }
    else{
        return eForgotPassword;
    }
}
+(NSString *)ChangeLanguage{
    if ([language isEqualToString:@"2"]) {
        return zChangeLanguage;
    }
    else if ([language isEqualToString:@"3"]) {
        return mChangeLanguage;
    }
    else if ([language isEqualToString:@"4"]){
        return cChangeLanguage;
    }
    else{
        return eChangeLanguage;
    }
}

+(NSString *)SelectLanguage{
    if ([language isEqualToString:@"2"]) {
        return zSelectLanguage;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectLanguage;
    }
    else if ([language isEqualToString:@"4"]){
        return cSelectLanguage;
    }
    else{
        return eSelectLanguage;
    }
    
}
+(NSString *)Login{
    if ([language isEqualToString:@"2"]) {
        return zLogin;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLogin;
    }
    else if ([language isEqualToString:@"4"]){
        return cLogin;
    }
    else{
        return eLogin;
    }
}
+(NSString *)DontHaveAnAccount{
    if ([language isEqualToString:@"2"]) {
        return zDonthaveanAccount;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDonthaveanAccount;
    }
    else if ([language isEqualToString:@"4"]){
        return cDonthaveanAccount;
    }
    else{
        return eDonthaveanAccount;
    }
}
+(NSString *)SignUp{
    if ([language isEqualToString:@"2"]) {
        return zSignUp;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSignUp;
    }
    else if ([language isEqualToString:@"4"]){
        return cSignUp;
    }
    else{
        return eSignUp;
    }
}
+(NSString *)MobileNumbercannotbeempty{
    if ([language isEqualToString:@"2"]) {
        return zMobileNumbercannotbeempty;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMobileNumbercannotbeempty;
    }
    else if ([language isEqualToString:@"4"]){
        return cMobileNumbercannotbeempty;
    }
    else{
        return eMobileNumbercannotbeempty;
    }
}

+(NSString *)Passwordcannotbeempty{
    if ([language isEqualToString:@"2"]) {
        return zPasswordcannotbeempty;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPasswordcannotbeempty;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPasswordcannotbeempty;
    }
    
    else{
        return ePasswordcannotbeempty;
    }
}
+(NSString *)SelectCountryCode{
    if ([language isEqualToString:@"2"]) {
        return zSelectCountryCode;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectCountryCode;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSelectCountryCode;
    }
    else{
        return eSelectCountryCode;
    }
}


//....Registration....//
+(NSString *)FullName{
    if ([language isEqualToString:@"2"]) {
        return zFullName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFullName;
    }
    else if ([language isEqualToString:@"4"]) {
        return cFullName;
    }
    else{
        return eFullName;
    }
}

+(NSString *)EmailOptional{
    if ([language isEqualToString:@"2"]) {
        return zEmailOptional;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEmailOptional;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEmailOptional;
    }
    else{
        return eEmailOptional;
    }
}

+(NSString *)ReEnterPassword{
    if ([language isEqualToString:@"2"]) {
        return zReEnterPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mReEnterPassword;
    }
    else if ([language isEqualToString:@"4"]) {
        return cReEnterPassword;
    }
    else{
        return eReEnterPassword;
    }
}
+(NSString *)FullNamecannotbeempty{
    if ([language isEqualToString:@"2"]) {
        return zFullNamecannotbeempty;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFullNamecannotbeempty;
    }
    else if ([language isEqualToString:@"4"]) {
        return cFullNamecannotbeempty;
    }
    else{
        return eFullNamecannotbeempty;
    }
}

+(NSString *)ReenterPasswordcannotbeempty{
    if ([language isEqualToString:@"2"]) {
        return zReenterPassEmpty;
    }
    else if ([language isEqualToString:@"3"]) {
        return mReenterPassEmpty;
    }
    else if ([language isEqualToString:@"4"]) {
        return cReenterPassEmpty;
    }
    
    else{
        return eReenterPassEmpty;
    }
}
+(NSString *)PassandReentershouldBeSame{
    if ([language isEqualToString:@"2"]) {
        return zPassandReenterpassSame;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPassandReenterpassSame;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPassandReenterpassSame;
    }
    else{
        return ePassandReenterpassSame;
    }
}


+(NSString *)InvalidEmail{
    if ([language isEqualToString:@"2"]) {
        return zInvalidEmail;
    }
    else if ([language isEqualToString:@"3"]) {
        return mInvalidEmail;
    }
    else if ([language isEqualToString:@"4"]) {
        return cInvalidEmail;
    }
    else{
        return eInvalidEmail;
    }
}

+(NSString *)passwordValidate{
    if ([language isEqualToString:@"2"]) {
        return zpasswordValidate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mpasswordValidate;
    }
    else if ([language isEqualToString:@"4"]) {
        return cpasswordValidate;
    }
    else{
        return epasswordValidate;
    }
}

+(NSString *)camera{
    if ([language isEqualToString:@"2"]) {
        return zcamera;
    }
    else if ([language isEqualToString:@"3"]) {
        return mcamera;
    }
    else if ([language isEqualToString:@"4"]) {
        return ccamera;
    }
    else{
        return ecamera;
    }
}
+(NSString *)gallary{
    if ([language isEqualToString:@"2"]) {
        return zGallery;
    }
    else if ([language isEqualToString:@"3"]) {
        return mGallery;
    }
    else if ([language isEqualToString:@"4"]) {
        return cGallery;
    }
    else{
        return eGallery;
    }
}
+(NSString *)Cancel{
    if ([language isEqualToString:@"2"]) {
        return zCancel;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCancel;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCancel;
    }
    else{
        return eCancel;
    }
}
+(NSString *)Done{
    if ([language isEqualToString:@"2"]) {
        return zDone;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDone;
    }
    else if ([language isEqualToString:@"4"]) {
        return cDone;
    }
    else{
        return eDone;
    }
}

+(NSString *)REGISTER{
    if ([language isEqualToString:@"2"]) {
        return zREGISTER;
    }
    else if ([language isEqualToString:@"3"]) {
        return mREGISTER;
    }
    else if ([language isEqualToString:@"4"]) {
        return cREGISTER;
    }
    else{
        return eREGISTER;
    }
}
//...Mobile Verification...///
+(NSString *)MobileVerification{
    if ([language isEqualToString:@"2"]) {
        return zMobileVerification;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMobileVerification;
    }
    else if ([language isEqualToString:@"4"]) {
        return cMobileVerification;
    }
    
    else{
        return eMobileVerification;
    }
}
+(NSString *)sentSMSverificationcodetothenumberbelow{
    if ([language isEqualToString:@"2"]) {
        return zsentSMSverificationcodetothenumberbelow;
    }
    else if ([language isEqualToString:@"3"]) {
        return msentSMSverificationcodetothenumberbelow;
    }
    else if ([language isEqualToString:@"4"]) {
        return csentSMSverificationcodetothenumberbelow;
    }
    
    else{
        return esentSMSverificationcodetothenumberbelow;
    }
}
+(NSString *)FourdigitVerificationcode{
    if ([language isEqualToString:@"2"]) {
        return zFourdigitVerificationcode;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFourdigitVerificationcode;
    }
    else if ([language isEqualToString:@"4"]) {
        return cFourdigitVerificationcode;
    }
    else{
        return eFourdigitVerificationcode;
    }
}
+(NSString *)EnterVerificationCode{
    if ([language isEqualToString:@"2"]) {
        return zEnterVerificationCode;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterVerificationCode;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEnterVerificationCode;
    }
    else{
        return eEnterVerificationCode;
    }
}
+(NSString *)NotReceivedVerificationCode{
    if ([language isEqualToString:@"2"]) {
        return zNotReceivedVerificationCode;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNotReceivedVerificationCode;
    }
    else if ([language isEqualToString:@"4"]) {
        return cNotReceivedVerificationCode;
    }
    else{
        return eNotReceivedVerificationCode;
    }
}
+(NSString *)RESEND{
    if ([language isEqualToString:@"2"]) {
        return zRESEND;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRESEND;
    }
    else if ([language isEqualToString:@"4"]) {
        return cRESEND;
    }
    else{
        return eRESEND;
    }
}

//.....<<ForgotPassword>>.....////
+(NSString*)ForgotPasswordTitle{
    if ([language isEqualToString:@"2"]) {
        return zForgotPasswordTitle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mForgotPasswordTitle;
    }
    else if ([language isEqualToString:@"4"]) {
        return cForgotPasswordTitle;
    }
    else{
        return eForgotPasswordTitle;
    }
}
+(NSString*)enterRegisteredMobileNumber{
    if ([language isEqualToString:@"2"]) {
        return zenterRegisteredMobileNumber;
    }
    else if ([language isEqualToString:@"3"]) {
        return menterRegisteredMobileNumber;
    }
    else if ([language isEqualToString:@"4"]) {
        return centerRegisteredMobileNumber;
    }
    else{
        return eenterRegisteredMobileNumber;
    }
}
+(NSString *)Code{
    if ([language isEqualToString:@"2"]) {
        return zCode;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCode;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCode;
    }
    else{
        return eCode;
    }
}
+(NSString *)SUBMIT{
    if ([language isEqualToString:@"2"]) {
        return zSUBMIT;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSUBMIT;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSUBMIT;
    }
    else{
        return eSUBMIT;
    }
}
//Forgot Password Page Methods Implementation.

+(NSString *)sentOTPtoYourRegisteredMobileNumber{
    if ([language isEqualToString:@"2"]) {
        return zsentOTPtoYourRegisteredMobileNumber;
    }
    else if ([language isEqualToString:@"3"]) {
        return msentOTPtoYourRegisteredMobileNumber;
    }
    else if ([language isEqualToString:@"4"]) {
        return csentOTPtoYourRegisteredMobileNumber;
    }
    else{
        return esentOTPtoYourRegisteredMobileNumber;
    }
}
+(NSString *)notReceivedOTPPleaseclickonResendOTPButton{
    if ([language isEqualToString:@"2"]) {
        return znotReceivedOTPPleaseclickonResendOTPButton;
    }
    else if ([language isEqualToString:@"3"]) {
        return mnotReceivedOTPPleaseclickonResendOTPButton;
    }
    else if ([language isEqualToString:@"4"]) {
        return cnotReceivedOTPPleaseclickonResendOTPButton;
    }
    else{
        return enotReceivedOTPPleaseclickonResendOTPButton;
    }
}
+(NSString *)EnterOTP{
    if ([language isEqualToString:@"2"]) {
        return zEnterOTP;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterOTP;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEnterOTP;
    }
    else{
        return eEnterOTP;
    }
}
+(NSString *)ResendOTP{
    if ([language isEqualToString:@"2"]) {
        return zResendOTP;
    }
    else if ([language isEqualToString:@"3"]) {
        return mResendOTP;
    }
    else if ([language isEqualToString:@"4"]) {
        return cResendOTP;
    }
    else{
        return eResendOTP;
    }
}
+(NSString *)EnterNewPassword{
    if ([language isEqualToString:@"2"]) {
        return zEnterNewPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterNewPassword;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEnterNewPassword;
    }
    else{
        return eEnterNewPassword;
    }
}
+(NSString *)SAVE{
    if ([language isEqualToString:@"2"]) {
        return zSAVE;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSAVE;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSAVE;
    }
    else{
        return eSAVE;
    }
}

//..MenuList...///
+(NSString *)Home{
    if ([language isEqualToString:@"2"]) {
        return zHome;
    }
    else if ([language isEqualToString:@"3"]) {
        return mHome;
    }
    else if ([language isEqualToString:@"4"]) {
        return cHome;
    }
    else{
        return eHome;
    }
    
}
+(NSString *)Topics{
    if ([language isEqualToString:@"2"]) {
        return zTopics;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTopics;
    }
    else if ([language isEqualToString:@"4"]) {
        return cTopics;
    }
    else{
        return eTopics;
    }
    
}
+(NSString *)Trainers{
    if ([language isEqualToString:@"2"]) {
        return zTrainers;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTrainers;
    }
    else if ([language isEqualToString:@"4"]) {
        return cTrainers;
    }
    else{
        return eTrainers;
    }
    
    
}
+(NSString *)FavouriteVideos{
    if ([language isEqualToString:@"2"]) {
        return zFavouriteVideos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFavouriteVideos;
    }
    else if ([language isEqualToString:@"4"]) {
        return cFavouriteVideos;
    }
    else{
        return eFavouriteVideos;
    }
    
    
}
+(NSString *)Assessments
{
    if ([language isEqualToString:@"2"]) {
        return eAssessments;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAssessments;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAssessments;
    }
    else{
        return eAssessments;
    }
    
}
+(NSString *)Subscribe{
    if ([language isEqualToString:@"2"]) {
        return zSubscribe;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubscribe;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSubscribe;
    }
    else{
        return eSubscribe;
    }
    
    
}

+(NSString *)Download
{
    if ([language isEqualToString:@"2"]) {
        return zDownload;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDownload;
    }
    else if ([language isEqualToString:@"4"]) {
        return cDownload;
    }
    else{
        return eDownload;
    }
}
+(NSString *)Share
{
    if ([language isEqualToString:@"2"]) {
        return zShare;
    }
    else if ([language isEqualToString:@"3"]) {
        return mShare;
    }
    else if ([language isEqualToString:@"4"]) {
        return cShare;
    }
    else{
        return eShare;
    }
}

+(NSString *)Likes
{
    if ([language isEqualToString:@"2"]) {
        return zLikes;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLikes;
    }
    else if ([language isEqualToString:@"4"]) {
        return cLikes;
    }
    else{
        return eLikes;
    }
    
}
+(NSString *)AboutTrainer
{
    if ([language isEqualToString:@"2"]) {
        return zAboutTrainer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAboutTrainer;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAboutTrainer;
    }
    else{
        return eAboutTrainer;
    }
    
}
+(NSString *)MyProfile{
    if ([language isEqualToString:@"2"]) {
        return zMyProfile;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMyProfile;
    }
    else if ([language isEqualToString:@"4"]) {
        return cMyProfile;
    }
    else{
        return eMyProfile;
    }
    
    
}
+(NSString *)UserGuide{
    if ([language isEqualToString:@"2"]) {
        return zUserGuide;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUserGuide;
    }
    else if ([language isEqualToString:@"4"]) {
        return cUserGuide;
    }
    else{
        return eUserGuide;
    }
    
    
}
+(NSString *)Less
{
    if ([language isEqualToString:@"2"]) {
        return zLess;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLess;
    }
    else if ([language isEqualToString:@"4"]) {
        return cLess;
    }
    else{
        return eLess;
    }
    
}
+(NSString *)AboutUs{
    if ([language isEqualToString:@"2"]) {
        return zAboutUs;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAboutUs;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAboutUs;
    }
    else{
        return eAboutUs;
    }
    
    
}
+(NSString *)Logout{
    if ([language isEqualToString:@"2"]) {
        return zLogout;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLogout;
    }
    else if ([language isEqualToString:@"4"]) {
        return cLogout;
    }
    else{
        return eLogout;
    }
    
    
}
//...........Home....///

+(NSString *)LatestVideos{
    if ([language isEqualToString:@"2"]) {
        return zLatestVideos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLatestVideos;
    }
    else if ([language isEqualToString:@"4"]) {
        return cLatestVideos;
    }
    else{
        return eLatestVideos;
    }
    
    
}
+(NSString *)TrendingVideos{
    if ([language isEqualToString:@"2"]) {
        return zTrendingVideos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTrendingVideos;
    }
    else if ([language isEqualToString:@"4"]) {
        return cTrendingVideos;
    }
    else{
        return eTrendingVideos;
    }
    
    
}
+(NSString *)ContinueReading{
    if ([language isEqualToString:@"2"]) {
        return zContinueReading;
    }
    else if ([language isEqualToString:@"3"]) {
        return mContinueReading;
    }
    else if ([language isEqualToString:@"4"]) {
        return cContinueReading;
    }
    else{
        return eContinueReading;
    }
}

///....<<<ArticleDetails...>>>.======

+(NSString *)ArticleDetails{
    if ([language isEqualToString:@"2"]) {
        return zArticleDetails;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticleDetails;
    }
    else if ([language isEqualToString:@"4"]) {
        return cArticleDetails;
    }
    else{
        return eArticleDetails;
    }
}

+(NSString *)By{
    if ([language isEqualToString:@"2"]) {
        return zBy;
    }
    else if ([language isEqualToString:@"3"]) {
        return mBy;
    }
    else if ([language isEqualToString:@"4"]) {
        return cBy;
    }
    else{
        return eBy;
    }
}

+(NSString *)PostedOn{
    if ([language isEqualToString:@"2"]) {
        return zPostedOn;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPostedOn;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPostedOn;
    }
    else{
        return ePostedOn;
    }
}

+(NSString *)Views{
    if ([language isEqualToString:@"2"]) {
        return zViews;
    }
    else if ([language isEqualToString:@"3"]) {
        return mViews;
    }
    else if ([language isEqualToString:@"4"]) {
        return cViews;
    }
    
    else{
        return eViews;
    }
}
//Article Details Page Methods Implementation.

+(NSString *)WriteReview{
    if ([language isEqualToString:@"2"]) {
        return zWriteReview;
    }
    else if ([language isEqualToString:@"3"]) {
        return mWriteReview;
    }
    else if ([language isEqualToString:@"4"]) {
        return cWriteReview;
    }
    else{
        return eWriteReview;
    }
}
+(NSString *)Description{
    if ([language isEqualToString:@"2"]) {
        return zDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDescription;
    }
    else if ([language isEqualToString:@"4"]) {
        return cDescription;
    }
    else{
        return eDescription;
    }
}
+(NSString *)Quiz{
    if ([language isEqualToString:@"2"]) {
        return zQuiz;
    }
    else if ([language isEqualToString:@"3"]) {
        return mQuiz;
    }
    else if ([language isEqualToString:@"4"]) {
        return cQuiz;
    }
    else{
        return eQuiz;
    }
}
+(NSString *)SubmitAnswer{
    if ([language isEqualToString:@"2"]) {
        return zSubmitAnswer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubmitAnswer;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSubmitAnswer;
    }
    else{
        return eSubmitAnswer;
    }
}
+(NSString *)PleaseSelectOption{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectOption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectOption;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPleaseSelectOption;
    }
    else{
        return ePleaseSelectOption;
    }
}
+(NSString *)share
{
    if ([language isEqualToString:@"2"]) {
        return zShare;
    }
    else if ([language isEqualToString:@"3"]) {
        return mShare;
    }
    else if ([language isEqualToString:@"4"]) {
        return cShare;
    }
    else{
        return eShare;
    }

}
+(NSString *)RecommendVideos
{
    if ([language isEqualToString:@"2"]) {
        return zRecommendVideos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRecommendVideos;
    }
    else if ([language isEqualToString:@"4"]) {
        return cRecommendVideos;
    }
    else{
        return eRecommendVideos;
    }
    
    
}

//Review Page Methods Implementation.
+(NSString *)Review{
    if ([language isEqualToString:@"2"]) {
        return zReview;
    }
    else if ([language isEqualToString:@"3"]) {
        return mReview;
    }
    else{
        return eReview;
    }
}
+(NSString *)WriteReviewForArticles{
    if ([language isEqualToString:@"2"]) {
        return zWriteReviewForArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mWriteReviewForArticles;
    }
    else{
        return eWriteReviewForArticles;
    }
}
+(NSString *)Rate{
    if ([language isEqualToString:@"2"]) {
        return zRate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRate;
    }
    else{
        return eRate;
    }
}
+(NSString *)Submit{
    if ([language isEqualToString:@"2"]) {
        return zSubmit;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubmit;
    }
    else{
        return eSubmit;
    }
}
+(NSString *)Addyourcomment;
{
    if ([language isEqualToString:@"2"]) {
        return zAddyourcomment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAddyourcomment;
    }
    else{
        return eAddyourcomment;
    }
}

+(NSString *)rating{
    if ([language isEqualToString:@"2"]) {
        return zRating;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRating;
    }
    else if ([language isEqualToString:@"3"]) {
        return eRating;
    }
    else{
        return cRating;
    }
}
+(NSString *)MyFavourites
{
    if ([language isEqualToString:@"2"]) {
        return zMyFavourites;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMyFavourites;
    }
    else if ([language isEqualToString:@"4"]) {
        return cMyFavourites;
    }
    else{
        return eMyFavourites;
    }
}
+(NSString *)AuthorDetails
{
    if ([language isEqualToString:@"2"]) {
        return zAuthorDetails;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAuthorDetails;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAuthorDetails;
    }
    else{
        return eAuthorDetails;
    }
    
    
}
+(NSString *)Videos
{
    if ([language isEqualToString:@"2"]) {
        return zVideos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVideos;
    }
    else if ([language isEqualToString:@"4"]) {
        return cVideos;
    }
    else{
        return eVideos;
    }
    
}
//....MiniCertification..../////

+(NSString *)MiniCertifications{
    if ([language isEqualToString:@"2"]) {
        return zMiniCertifications;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMiniCertifications;
    }
    else if ([language isEqualToString:@"4"]) {
        return cMiniCertifications;
    }
    else{
        return eMiniCertifications;
    }
    
    
}

+(NSString *)ReadMore
{
    if ([language isEqualToString:@"2"]) {
        return zReadMore;
    }
    else if ([language isEqualToString:@"3"]) {
        return mReadMore;
    }
    else if ([language isEqualToString:@"4"]) {
        return cReadMore;
    }
    else{
        return eReadMore;
    }
}

+(NSString *)COURSES
{
    if ([language isEqualToString:@"2"]) {
        return zCourses;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCourses;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCourses;
    }
    else{
        return eCourses;
    }
}
+(NSString *)CourseName
{
    if ([language isEqualToString:@"2"]) {
        return zCourseName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCourseName;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCourseName;
    }
    else{
        return eCourseName;
    }
    
    
}
+(NSString *)COURSEOVERVIEW
{
    if ([language isEqualToString:@"2"]) {
        return zCourseOverview;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCourseOverview;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCourseOverview;
    }
    else{
        return eCourseOverview;
    }
    
    
}
+(NSString *)Lessons
{
    if ([language isEqualToString:@"2"]) {
        return zLessons;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLessons;
    }
    else if ([language isEqualToString:@"4"]) {
        return cLessons;
    }
    else{
        return eLessons;
    }
    
}
+(NSString *)Duration
{
    if ([language isEqualToString:@"2"]) {
        return zDuration;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDuration;
    }
    else if ([language isEqualToString:@"4"]) {
        return cDuration;
    }
    else{
        return eDuration;
    }
    
}
+(NSString *)TakeTheQuiz
{
    if ([language isEqualToString:@"2"]) {
        return zTakeTheQuiz;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTakeTheQuiz;
    }
    else if ([language isEqualToString:@"4"]) {
        return cTakeTheQuiz;
    }
    else{
        return eTakeTheQuiz;
    }
}


+(NSString *)ViewScore
{
    if ([language isEqualToString:@"2"]) {
        return zViewScore;
    }
    else if ([language isEqualToString:@"3"]) {
        return mViewScore;
    }
    else if ([language isEqualToString:@"4"]) {
        return cViewScore;
    }
    else{
        return eViewScore;
    }
}
+(NSString *)RedeemCertificate
{
    if ([language isEqualToString:@"2"]) {
        return zRedeemCertificate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRedeemCertificate;
    }
    else if ([language isEqualToString:@"4"]) {
        return cRedeemCertificate;
    }
    else{
        return eRedeemCertificate;
    }
}
+(NSString *)collectEcertificate
{
    if ([language isEqualToString:@"2"]) {
        return zCollectECertificate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCollectECertificate;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCollectECertificate;
    }
    else{
        return eCollectECertificate;
    }
}

+(NSString *)toGetCertificate80
{
    if ([language isEqualToString:@"2"]) {
        return zForCer80;
    }
    else if ([language isEqualToString:@"3"]) {
        return mForCer80;
    }
    else if ([language isEqualToString:@"4"]) {
        return cForCer80;
    }
    else{
        return eForCer80;
    }

}
+(NSString *)Certificate
{
    if ([language isEqualToString:@"2"]) {
        return zCertificate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCertificate;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCertificate;
    }
    else{
        return eCertificate;
    }
    
}
+(NSString *)youPassedTheExamination
{
    if ([language isEqualToString:@"2"]) {
        return zYouPassed;
    }
    else if ([language isEqualToString:@"3"]) {
        return mYouPassed;
    }
    else if ([language isEqualToString:@"4"]) {
        return cYouPassed;
    }
    else{
        return eYouPassed;
    }
    
}
+(NSString *)Congratulations
{
    if ([language isEqualToString:@"2"]) {
        return zCongrats;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCongrats;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCongrats;
    }
    else{
        return eCongrats;
    }
    
}
+(NSString *)NoteFeeApplied

{
    if ([language isEqualToString:@"2"]) {
        return zFeeApply;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFeeApply;
    }
    else if ([language isEqualToString:@"4"]) {
        return cFeeApply;
    }
    else{
        return eFeeApply;
    }
    
}

+(NSString *)pleaseSubmitNameAndEmailToRedeeemYourCertificate

{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSubmitNameEmail;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSubmitNameEmail;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPleaseSubmitNameEmail;
    }
    else{
        return ePleaseSubmitNameEmail;
    }
    
}
+(NSString *)PleaseEnterEmail

{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterEmail;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterEmail;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPleaseEnterEmail;
    }
    else{
        return ePleaseEnterEmail;
    }
    
}
+(NSString *)Ban

{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterEmail;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterEmail;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPleaseEnterEmail;
    }
    else{
        return ePleaseEnterEmail;
    }
    
}
//sasa
//...Trainers.....///
//.........>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>...............>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.............>>>>>>>>>>>>>>>>


///...Extra...Optional....///

+(NSString *)SignUpasaSubscriber{
    if ([language isEqualToString:@"2"]) {
        return zSignUpasaSubscriber;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSignUpasaSubscriber;
    }
    else{
        return eSignUpasaSubscriber;
    }
}
+(NSString *)Or{
    if ([language isEqualToString:@"2"]) {
        return zOr;
    }
    else if ([language isEqualToString:@"3"]) {
        return mOr;
    }
    else{
        return eOr;
    }
}
+(NSString *)SignUpasaContributor{
    if ([language isEqualToString:@"2"]) {
        return zSignUpasaContributor;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSignUpasaContributor;
    }
    else{
        return eSignUpasaContributor;
    }
}

+(NSString *)accountNotActivated{
    if ([language isEqualToString:@"2"]) {
        return zaccountNotActivated;
    }
    else if ([language isEqualToString:@"3"]) {
        return maccountNotActivated;
    }
    else{
        return eaccountNotActivated;
    }
}
+(NSString *)loading{
    if ([language isEqualToString:@"2"]) {
        return zloading;
    }
    else if ([language isEqualToString:@"3"]) {
        return mloading;
    }
    else{
        return eloading;
    }
}


+(NSString *)mobileNoAlreadyRegistered{
    if ([language isEqualToString:@"2"]) {
        return zmobileNoAlreadyRegistered;
    }
    else if ([language isEqualToString:@"3"]) {
        return mmobileNoAlreadyRegistered;
    }
    else{
        return emobileNoAlreadyRegistered;
    }
}
+(NSString *)emailAlreadyRegistered{
    if ([language isEqualToString:@"2"]) {
        return zemailAlreadyRegistered;
    }
    else if ([language isEqualToString:@"3"]) {
        return memailAlreadyRegistered;
    }
    else{
        return eemailAlreadyRegistered;
    }
}
+(NSString *)registrationSuccessfulCheckforOtp{
    if ([language isEqualToString:@"2"]) {
        return zregistrationSuccessfulCheckforOtp;
    }
    else if ([language isEqualToString:@"3"]) {
        return mregistrationSuccessfulCheckforOtp;
    }
    else{
        return eregistrationSuccessfulCheckforOtp;
    }
}
//...MobileVerification...///



//////////
+(NSString *)SearchArticles{
    
    if ([language isEqualToString:@"2"]) {
        return zSearch;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSearch;
    }
    else{
        return eSearch;
    }
}
+(NSString *)EmailVerification{
    if ([language isEqualToString:@"2"]) {
        return zEmailVerification;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEmailVerification;
    }
    else{
        return eEmailVerification;
    }
}

+(NSString *)submitAssesment{
    if ([language isEqualToString:@"2"]) {
        return zSubmitAssessment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubmitAssessment;
    }
    else{
        return eSubmitAssessment;
    }
}
+(NSString *)AssesmentResult{
    if ([language isEqualToString:@"2"]) {
        return zAssessmentResult;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAssessmentResult;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAssessmentResult;
    }

    else{
        return eAssessmentResult;
    }
}
+(NSString *)Score{
    if ([language isEqualToString:@"2"]) {
        return zScore;
    }
    else if ([language isEqualToString:@"3"]) {
        return mScore;
    }
    else if ([language isEqualToString:@"4"]) {
        return cScore;
    }
    else{
        return eScore;
    }
}
+(NSString *)LearnerID{
    if ([language isEqualToString:@"2"]) {
        return zLearnerID;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLearnerID;
    }
    else{
        return eLearnerID;
    }
}
+(NSString *)Percentage{
    if ([language isEqualToString:@"2"]) {
        return zPercentage;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPercentage;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPercentage;
    }
    else{
        return ePercentage;
    }
}
+(NSString *)ViewAssScore{
    if ([language isEqualToString:@"2"]) {
        return zViewAssessmentScore;
    }
    else if ([language isEqualToString:@"3"]) {
        return mViewAssessmentScore;
    }
    else if ([language isEqualToString:@"4"]) {
        return cViewAssessmentScore;
    }
    else{
        return eViewAssessmentScore;
    }
}
+(NSString *)Answer{
    if ([language isEqualToString:@"2"]) {
        return zAnswer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAnswer;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAnswer;
    }
    else{
        return eAnswer;
    }
}
+(NSString *)pleaseEnterOTP{
    if ([language isEqualToString:@"2"]) {
        return zpleaseEnterOTP;
    }
    else if ([language isEqualToString:@"3"]) {
        return mpleaseEnterOTP;
    }
//    else if ([language isEqualToString:@"4"]) {
//        return cpleaseEnterOTP;
//    }
    else{
        return epleaseEnterOTP;
    }
}
//Registration Page Methods Implementation.


+(NSString*)SubscriberSignUp{
    if ([language isEqualToString:@"2"]) {
        return zSubscriberSignUp;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubscriberSignUp;
    }
    else{
        return eSubscriberSignUp;
    }
}
+(NSString *)ContributorSignUp{
    if ([language isEqualToString:@"2"]) {
        return zContributorSignUp;
    }
    else if ([language isEqualToString:@"3"]) {
        return mContributorSignUp;
    }
    else{
        return eContributorSignUp;
    }
}
+(NSString *)COMPANYDETAILS{
    if ([language isEqualToString:@"2"]) {
        return zCOMPANYDETAILS;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCOMPANYDETAILS;
    }
    else{
        return eCOMPANYDETAILS;
    }
}
+(NSString *)SelectCompanyName{
    if ([language isEqualToString:@"2"]) {
        return zSelectCompanyName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectCompanyName;
    }
    else{
        return eSelectCompanyName;
    }
}
+(NSString *)SelectDepartment{
    if ([language isEqualToString:@"2"]) {
        return zSelectDepartment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectDepartment;
    }
    else{
        return eSelectDepartment;
    }
}
+(NSString *)LearnerIDOp{
    if ([language isEqualToString:@"2"]) {
        return zLearnerIDOp;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLearnerIDOp;
    }
    else{
        return eLearnerIDOp;
    }
}
+(NSString *)USERDETAILS{
    if ([language isEqualToString:@"2"]) {
        return zUSERDETAILS;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUSERDETAILS;
    }
    else{
        return eUSERDETAILS;
    }
}

+(NSString *)PleaseSelectCompanyName{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectCompanyName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectCompanyName;
    }
    else{
        return ePleaseSelectCompanyName;
    }
}
+(NSString *)PleaseSelectDepartment{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectDepartment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectDepartment;
    }
    else{
        return ePleaseSelectDepartment;
    }
}
+(NSString *)PleaseenterPassword{
    if ([language isEqualToString:@"2"]) {
        return zPleaseenterPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseenterPassword;
    }
    else{
        return ePleaseenterPassword;
    }
}

+(NSString *)CheckyourOTPtoResetYourPassword{
    if ([language isEqualToString:@"2"]) {
        return zCheckyourOTPtoResetYourPassword;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCheckyourOTPtoResetYourPassword;
    }
    else{
        return eCheckyourOTPtoResetYourPassword;
    }
}

+(NSString *)Yourpasswordchangedsuccessfully{
    if ([language isEqualToString:@"2"]) {
        return zYourpasswordchangedsuccessfully;
    }
    else if ([language isEqualToString:@"3"]) {
        return mYourpasswordchangedsuccessfully;
    }
    else{
        return eYourpasswordchangedsuccessfully;
    }
}

//Mobile Verification Page Methods Implementation...ExtraOptions.....
+(NSString *)PleaseCheckyourMessageforOTP{
    if ([language isEqualToString:@"2"]) {
        return zPleaseCheckyourMessageforOTP;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseCheckyourMessageforOTP;
    }
    else{
        return ePleaseCheckyourMessageforOTP;
    }
}
+(NSString *)mobileVerifiedSuccessfully{
    if ([language isEqualToString:@"2"]) {
        return zmobileVerifiedSuccessfully;
    }
    else if ([language isEqualToString:@"3"]) {
        return mmobileVerifiedSuccessfully;
    }
    else{
        return emobileVerifiedSuccessfully;
    }
}

//Home Page Methods Implementation.

+(NSString *)LatestArticles{
    if ([language isEqualToString:@"2"]) {
        return zLatestArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mLatestArticles;
    }
    else{
        return eLatestArticles;
    }
}
+(NSString *)MostViewedArticles{
    if ([language isEqualToString:@"2"]) {
        return zMostViewedArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMostViewedArticles;
    }
    else{
        return eMostViewedArticles;
    }
}
+(NSString *)FavouriteArticles{
    if ([language isEqualToString:@"2"]) {
        return zFavouriteArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mFavouriteArticles;
    }
    else{
        return eFavouriteArticles;
    }
}
+(NSString *)NoArticlesAvailable{
    if ([language isEqualToString:@"2"]) {
        return zNoArticlesAvailable;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNoArticlesAvailable;
    }
    else{
        return eNoArticlesAvailable;
    }
}

//Articles Page Methods Implementation.
+(NSString *)Articles{
    if ([language isEqualToString:@"2"]) {
        return zArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticles;
    }
    else{
        return eArticles;
    }
}
+(NSString *)ArticlesCategory{
    if ([language isEqualToString:@"2"]) {
        return zArticlesCategory;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticlesCategory;
    }
    else{
        return eArticlesCategory;
    }
}
+(NSString *)NoArticlecategoryavailable{
    if ([language isEqualToString:@"2"]) {
        return zNoArticlecategoryavailable;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNoArticlecategoryavailable;
    }
    else{
        return eNoArticlecategoryavailable;
    }
}

//Articles List Page Methods Implementation.
+(NSString *)ArticlesList{
    if ([language isEqualToString:@"2"]) {
        return zArticlesList;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticlesList;
    }
    else{
        return eArticlesList;
    }
}

+(NSString *)removearticlefromFavouriteList{
    if ([language isEqualToString:@"2"]) {
        return zremovearticlefromFavouriteList;
    }
    else if ([language isEqualToString:@"3"]) {
        return mremovearticlefromFavouriteList;
    }
    else{
        return eremovearticlefromFavouriteList;
    }
}
+(NSString *)ok{
    if ([language isEqualToString:@"2"]) {
        return zok;
    }
    else if ([language isEqualToString:@"3"]) {
        return mok;
    }
    else{
        return eok;
    }
}
+(NSString *)cancel{
    if ([language isEqualToString:@"2"]) {
        return zcancel;
    }
    else if ([language isEqualToString:@"3"]) {
        return mcancel;
    }
    else{
        return ecancel;
    }
}



//Create Article Page Methods Implementation.
+(NSString *)CreateArticle{
    if ([language isEqualToString:@"2"]) {
        return zCreateArticle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCreateArticle;
    }
    else{
        return eCreateArticle;
    }
}
+(NSString *)PhotoUpload{
    if ([language isEqualToString:@"2"]) {
        return zPhotoUpload;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPhotoUpload;
    }
    else{
        return ePhotoUpload;
    }
}
+(NSString *)VideoUpload{
    if ([language isEqualToString:@"2"]) {
        return zVideoUpload;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVideoUpload;
    }
    else{
        return eVideoUpload;
    }
}
+(NSString *)UploadPhoto{
    if ([language isEqualToString:@"2"]) {
        return zUploadPhoto;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUploadPhoto;
    }
    else{
        return eUploadPhoto;
    }
}
+(NSString *)ArticleTitle{
    if ([language isEqualToString:@"2"]) {
        return zArticleTitle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticleTitle;
    }
    else{
        return eArticleTitle;
    }
}

+(NSString *)ArticleTitleAlert;
{
    if ([language isEqualToString:@"2"]) {
        return zArticleTitleAlert;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticleTitleAlert;
    }
    else{
        return eArticleTitleAlert;
    }
    
}
+(NSString *)ShortDescription{
    if ([language isEqualToString:@"2"]) {
        return zShortDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mShortDescription;
    }
    else{
        return eShortDescription;
    }
}
+(NSString *)AddTag{
    if ([language isEqualToString:@"2"]) {
        return zAddTag;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAddTag;
    }
    else{
        return eAddTag;
    }
}
+(NSString *)AssignedTags{
    if ([language isEqualToString:@"2"]) {
        return zAssignedTags;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAssignedTags;
    }
    else{
        return eAssignedTags;
    }
}
+(NSString *)SELECTCATEGORY{
    if ([language isEqualToString:@"2"]) {
        return zSELECTCATEGORY;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSELECTCATEGORY;
    }
    else{
        return eSELECTCATEGORY;
    }
}
+(NSString *)SELECTSUBCATEGORY{
    if ([language isEqualToString:@"2"]) {
        return zSELECTSUBCATEGORY;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSELECTSUBCATEGORY;
    }
    else{
        return eSELECTSUBCATEGORY;
    }
}
+(NSString *)SELECTSUBSUBCATEGORY{
    if ([language isEqualToString:@"2"]) {
        return zSELECTSUBSUBCATEGORY;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSELECTSUBSUBCATEGORY;
    }
    else{
        return eSELECTSUBSUBCATEGORY;
    }
}
+(NSString *)SELECTSUBSUBSUBCATEGORY{
    if ([language isEqualToString:@"2"]) {
        return zSELECTSUBSUBSUBCATEGORY;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSELECTSUBSUBSUBCATEGORY;
    }
    else{
        return eSELECTSUBSUBSUBCATEGORY;
    }
}
+(NSString *)PleaseChooseArticleImage{
    if ([language isEqualToString:@"2"]) {
        return zPleaseChooseArticleImage;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseChooseArticleImage;
    }
    else{
        return ePleaseChooseArticleImage;
    }
}
+(NSString *)AddMorePhotos{
    if ([language isEqualToString:@"2"]) {
        return zAddMorePhotos;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAddMorePhotos;
    }
    else{
        return eAddMorePhotos;
    }
}
+(NSString *)Image1{
    if ([language isEqualToString:@"2"]) {
        return zImage1;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImage1;
    }
    else{
        return eImage1;
    }
}
+(NSString *)Image2{
    if ([language isEqualToString:@"2"]) {
        return zImage2;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImage2;
    }
    else{
        return eImage2;
    }
}
+(NSString *)Image3{
    if ([language isEqualToString:@"2"]) {
        return zImage3;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImage3;
    }
    else{
        return eImage3;
    }
}
+(NSString *)ImageoneCaption{
    if ([language isEqualToString:@"2"]) {
        return zImageoneCaption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImageoneCaption;
    }
    else{
        return eImageoneCaption;
    }
}
+(NSString *)ImagetwoCaption{
    if ([language isEqualToString:@"2"]) {
        return zImagetwoCaption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImagetwoCaption;
    }
    else{
        return eImagetwoCaption;
    }
}
+(NSString *)ImagethreeCaption{
    if ([language isEqualToString:@"2"]) {
        return zImagethreeCaption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mImagethreeCaption;
    }
    else{
        return eImagethreeCaption;
    }
}
+(NSString *)Camera{
    if ([language isEqualToString:@"2"]) {
        return zCamera;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCamera;
    }
    else{
        return eCamera;
    }
}
+(NSString *)Gallery{
    if ([language isEqualToString:@"2"]) {
        return zGallery;
    }
    else if ([language isEqualToString:@"3"]) {
        return mGallery;
    }
    else{
        return eGallery;
    }
}
+(NSString *)Deletewillclearallthecaptioncontent{
    if ([language isEqualToString:@"2"]) {
        return zDeletewillclearallthecaptioncontent;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDeletewillclearallthecaptioncontent;
    }
    else{
        return eDeletewillclearallthecaptioncontent;
    }
}
+(NSString *)PleaseEnterArticleTitle{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterArticleTitle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterArticleTitle;
    }
    else{
        return ePleaseEnterArticleTitle;
    }
}
+(NSString *)PleaseEnterArticleShortDescription{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterArticleShortDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterArticleShortDescription;
    }
    else{
        return ePleaseEnterArticleShortDescription;
    }
}
+(NSString *)PleaseEnterArticleDescription{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterArticleDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterArticleDescription;
    }
    else{
        return ePleaseEnterArticleDescription;
    }
}
+(NSString *)PleaseSelectCategory{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectCategory;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectCategory;
    }
    else{
        return ePleaseSelectCategory;
    }
}
+(NSString *)PleaseSelectSubCategory{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectSubCategory;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectSubCategory;
    }
    else{
        return ePleaseSelectSubCategory;
    }
}
+(NSString *)PleaseSelectSubSubCategory{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectSubSubCategory;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectSubSubCategory;
    }
    else{
        return ePleaseSelectSubSubCategory;
    }
}
+(NSString *)PleaseSelectSubSubSubCategory{
    if ([language isEqualToString:@"2"]) {
        return zPleaseSelectSubSubSubCategory;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseSelectSubSubSubCategory;
    }
    else{
        return ePleaseSelectSubSubSubCategory;
    }
}
+(NSString *)Titlemustbeatleast3characters{
    if ([language isEqualToString:@"2"]) {
        return zTitlemustbeatleast3characters;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTitlemustbeatleast3characters;
    }
    else{
        return eTitlemustbeatleast3characters;
    }
}
+(NSString *)Descriptionmustbeatleast5characters{
    if ([language isEqualToString:@"2"]) {
        return zDescriptionmustbeatleast5characters;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDescriptionmustbeatleast5characters;
    }
    else{
        return eDescriptionmustbeatleast5characters;
    }
}
+(NSString *)ShortDescriptionmustbeatleast5characters{
    if ([language isEqualToString:@"2"]) {
        return zShortDescriptionmustbeatleast5characters;
    }
    else if ([language isEqualToString:@"3"]) {
        return mShortDescriptionmustbeatleast5characters;
    }
    else{
        return eShortDescriptionmustbeatleast5characters;
    }
}
+(NSString *)Articleuploadedsuccessfully{
    if ([language isEqualToString:@"2"]) {
        return zArticleuploadedsuccessfully;
    }
    else if ([language isEqualToString:@"3"]) {
        return mArticleuploadedsuccessfully;
    }
    else{
        return eArticleuploadedsuccessfully;
    }
}
+(NSString *)UploadVideo{
    if ([language isEqualToString:@"2"]) {
        return zUploadVideo;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUploadVideo;
    }
    else{
        return eUploadVideo;
    }
}
+(NSString *)ChooseVideo{
    if ([language isEqualToString:@"2"]) {
        return zChooseVideo;
    }
    else if ([language isEqualToString:@"3"]) {
        return mChooseVideo;
    }
    else{
        return eChooseVideo;
    }
}
+(NSString *)RecordVideo{
    if ([language isEqualToString:@"2"]) {
        return zRecordVideo;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRecordVideo;
    }
    else{
        return eRecordVideo;
    }
}
+(NSString *)EnterayoutubevideoURL{
    if ([language isEqualToString:@"2"]) {
        return zEnterayoutubevideoURL;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterayoutubevideoURL;
    }
    else{
        return eEnterayoutubevideoURL;
    }
}
+(NSString *)ClearVideo{
    if ([language isEqualToString:@"2"]) {
        return zClearVideo;
    }
    else if ([language isEqualToString:@"3"]) {
        return mClearVideo;
    }
    else{
        return eClearVideo;
    }
}
+(NSString *)UPLOADYOUTUBEURL{
    if ([language isEqualToString:@"2"]) {
        return zUPLOADYOUTUBEURL;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUPLOADYOUTUBEURL;
    }
    else{
        return eUPLOADYOUTUBEURL;
    }
}
+(NSString *)EnterYoutubeURL{
    if ([language isEqualToString:@"2"]) {
        return zEnterYoutubeURL;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterYoutubeURL;
    }
    else{
        return eEnterYoutubeURL;
    }
}
+(NSString *)VALIDATE{
    if ([language isEqualToString:@"2"]) {
        return zVALIDATE;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVALIDATE;
    }
    else{
        return eVALIDATE;
    }
}
+(NSString *)CANCEL{
    if ([language isEqualToString:@"2"]) {
        return zCANCEL;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCANCEL;
    }
    else{
        return eCANCEL;
    }
}
+(NSString *)PleaseEnterUrl{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterUrl;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterUrl;
    }
    else{
        return ePleaseEnterUrl;
    }
}
+(NSString *)NotValidate{
    if ([language isEqualToString:@"2"]) {
        return zNotValidate;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNotValidate;
    }
    else{
        return eNotValidate;
    }
}

//AboutUs
+(NSString *)aboutUs{
    if ([language isEqualToString:@"2"]) {
        return zAboutUs;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAboutUs;
    }
    else if ([language isEqualToString:@"4"]) {
        return cAboutUs;
    }
    else{
        return eAboutUs;
    }
}
+(NSString*)EmailusAboutUs{
    if ([language isEqualToString:@"2"]) {
        return zEmailUs;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEmailUs;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEmailUs;
    }
    else{
        return eEmailUs;
    }
}
+(NSString*)sendFeedback{
    if ([language isEqualToString:@"2"]) {
        return zSendFeedBack;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSendFeedBack;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSendFeedBack;
    }
    else{
        return eSendFeedBack;
    }
}
+(NSString*)TermsConditions{
    if ([language isEqualToString:@"2"]) {
        return zTermsConditions;
    }
    else if ([language isEqualToString:@"3"]) {
        return mTermsConditions;
    }
    else if ([language isEqualToString:@"4"]) {
        return cTermsConditions;
    }
    else{
        return eTermsConditions;
    }
}
+(NSString *)Copyrights2016xprienzSMILES{
    if ([language isEqualToString:@"2"]) {
        return zCopyrights;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCopyrights;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCopyrights;
    }
    else{
        return eCopyrights;
    }
}
+(NSString *)AllRightsReserved{
    if ([language isEqualToString:@"2"]) {
        return zRights;
    }
    else if ([language isEqualToString:@"3"]) {
        return mRights;
    }
    else if ([language isEqualToString:@"4"]) {
        return cRights;
    }
    else{
        return eRights;
    }
}
+(NSString *)DisclaimerDesignConceptLogoAreCopyrightOfxprienzSMILES{
    if ([language isEqualToString:@"2"]) {
        return zDisclaimer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDisclaimer;
    }
    else if ([language isEqualToString:@"4"]) {
        return cDisclaimer;
    }
    else{
        return eDisclaimer;
    }
}
+(NSString *)CallUs{
    if ([language isEqualToString:@"2"]) {
        return zCallUs;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCallUs;
    }
    else if ([language isEqualToString:@"4"]) {
        return cCallUs;
    }
    else{
        return eCallUs;
    }
}

+(NSString *)enterQueryOrFeedBack{
    if ([language isEqualToString:@"2"]) {
        return zEnterQueryOrFeedBack;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterQueryOrFeedBack;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEnterQueryOrFeedBack;
    }
    else{
        return eEnterQueryOrFeedBack;
    }
}
+(NSString *)pleaseEnterQuery{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterQueryOrFeedBack;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterQueryOrFeedBack;
    }
    else if ([language isEqualToString:@"4"]) {
        return cPleaseEnterQueryOrFeedBack;
    }
    else{
        return ePleaseEnterQueryOrFeedBack;
    }
}

//Email Verification
+(NSString *)WeHaveSentYouAnMailwithCodeToEmail{
    if ([language isEqualToString:@"2"]) {
        return zMailsent;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMailsent;
    }
    else if ([language isEqualToString:@"3"]) {
        return cMailsent;
    }
    else{
        return eMailsent;
    }
}
+(NSString *)ToCompleteYourEmailVerificationPleaseEntertThe4DigitVerificationCode{
    if ([language isEqualToString:@"2"]) {
        return zToComplete;
    }
    else if ([language isEqualToString:@"3"]) {
        return mToComplete;
    }
    else if ([language isEqualToString:@"3"]) {
        return cToComplete;
    }
    else{
        return eToComplete;
    }
}
+(NSString *)NotreceivedVerificationCode{
    if ([language isEqualToString:@"2"]) {
        return zNotrecieved;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNotrecieved;
    }
    else if ([language isEqualToString:@"3"]) {
        return cNotrecieved;
    }
    else{
        return eNotrecieved;
    }
}
+(NSString *)EditProfile
{
    if ([language isEqualToString:@"2"])
    {
        return zEditProfile;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEditProfile;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEditProfile;
    }
    else{
        return eEditProfile;
    }
    
}
+(NSString *)SaveProfile
{
    if ([language isEqualToString:@"2"])
    {
        return zSaveProfile;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSaveProfile;
    }
    else if ([language isEqualToString:@"4"]) {
        return cSaveProfile;
    }
    else{
        return eSaveProfile;
    }
    
}
+(NSString *)Email{
    if ([language isEqualToString:@"2"])
    {
        return zEmail;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEmail;
    }
    else if ([language isEqualToString:@"4"]) {
        return cEmail;
    }
    else{
        return eEmail;
    }
}
+(NSString *)CompanyName{
    if ([language isEqualToString:@"2"]) {
        return zCompanyName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCompanyName;
    }
    else{
        return eCompanyName;
    }
}
+(NSString *)Department{
    if ([language isEqualToString:@"2"]) {
        return zDepartment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDepartment;
    }
    else{
        return eDepartment;
    }
}
+(NSString *)Profile{
    if ([language isEqualToString:@"2"]) {
        return zProfile;
    }
    else if ([language isEqualToString:@"3"]) {
        return mProfile;
    }
    else{
        return eProfile;
    }
}
+(NSString *)NotVerified{
    if ([language isEqualToString:@"2"]) {
        return zNotVerified;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNotVerified;
    }
    else{
        return eNotVerified;
    }
}
+(NSString *)Verified{
    if ([language isEqualToString:@"2"]) {
        return zVerified;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVerified;
    }
    else{
        return eVerified;
    }
}
+(NSString *)VerifyNow{
    if ([language isEqualToString:@"2"]) {
        return zVerifyNow;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVerifyNow;
    }
    else{
        return eVerifyNow;
    }
}
+(NSString *)NotAvailable{
    if ([language isEqualToString:@"2"]) {
        return zNotAvailable;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNotAvailable;
    }
    else if ([language isEqualToString:@"4"]) {
        return cNotAvailable;
    }

    else
    {
        return eNotAvailable;
    }
}
+(NSString *)YourProfileHasBeenUpdatedSuccessfully{
    if ([language isEqualToString:@"2"]) {
        return zYouProfile;
    }
    else if ([language isEqualToString:@"3"]) {
        return mYouProfile;
    }
    else{
        return eYouProfile;
    }
}

+(NSString *)SequencedArticles{
    if ([language isEqualToString:@"2"]) {
        return zSequencedArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSequencedArticles;
    }
    else{
        return eSequencedArticles;
    }
}
+(NSString *)NoSequenceAvailable{
    if ([language isEqualToString:@"2"]) {
        return zNoSequence;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNoSequence;
    }
    else{
        return eNoSequence;
    }
}
+(NSString *)Assessment{
    if ([language isEqualToString:@"2"]) {
        return zAssesment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAssesment;
    }
    else{
        return eAssesment;
    }
}
+(NSString *)NoAssessmentAvailable{
    if ([language isEqualToString:@"2"]) {
        return zNoAssesment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNoAssesment;
    }
    else{
        return eNoAssesment;
    }
}
+(NSString *)ViewAssessment
{
    if ([language isEqualToString:@"2"]) {
        return zViewAssesment;
    }
    else if ([language isEqualToString:@"3"]) {
        return mViewAssesment;
    }
    else{
        return eViewAssesment;
    }
}
+(NSString *)MyLearningGroups{
    if ([language isEqualToString:@"2"]) {
        return zMylearningGroups;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMylearningGroups;
    }
    else{
        return eMylearningGroups;
    }
}
+(NSString *)NoGroupsAvailable{
    if ([language isEqualToString:@"2"]) {
        return zNoGroupsAvailable;
    }
    else if ([language isEqualToString:@"3"]) {
        return mNoGroupsAvailable;
    }
    else{
        return eNoGroupsAvailable;
    }
}
+(NSString *)CreateQuiz{
    if ([language isEqualToString:@"2"]) {
        return zCreateQuiz;
    }
    else if ([language isEqualToString:@"3"]) {
        return mCreateQuiz;
    }
    else{
        return eCreateQuiz;
    }
}
+(NSString *)Question{
    if ([language isEqualToString:@"2"]) {
        return zQuestion;
    }
    else if ([language isEqualToString:@"3"]) {
        return mQuestion;
    }
    else{
        return eQuestion;
    }
}
+(NSString *)EnterQuestionName{
    if ([language isEqualToString:@"2"]) {
        return zEnterQuestionName;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEnterQuestionName;
    }
    else{
        return eEnterQuestionName;
    }
}
+(NSString *)AnswerOption1{
    if ([language isEqualToString:@"2"]) {
        return zAnswerOption1;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAnswerOption1;
    }
    else{
        return eAnswerOption1;
    }
}
+(NSString *)AnswerOption2{
    if ([language isEqualToString:@"2"]) {
        return zAnswerOption2;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAnswerOption2;
    }
    else{
        return eAnswerOption2;
    }
}
+(NSString *)AnswerOption3{
    if ([language isEqualToString:@"2"]) {
        return zAnswerOption3;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAnswerOption3;
    }
    else{
        return eAnswerOption3;
    }
}
+(NSString *)AnswerOption4{
    if ([language isEqualToString:@"2"]) {
        return zAnswerOption4;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAnswerOption4;
    }
    else{
        return eAnswerOption4;
    }
}
+(NSString *)EnterTheOptionAnswer1{
    if ([language isEqualToString:@"2"]) {
        return zEntertheoptionanswer1;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEntertheoptionanswer1;
    }
    else{
        return eEntertheoptionanswer1;
    }
}
+(NSString *)EnterTheOptionAnswer2{
    if ([language isEqualToString:@"2"]) {
        return zEntertheoptionanswer2;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEntertheoptionanswer2;
    }
    else{
        return eEntertheoptionanswer2;
    }
}
+(NSString *)EnterTheOptionAnswer3{
    if ([language isEqualToString:@"2"]) {
        return zEntertheoptionanswer3;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEntertheoptionanswer3;
    }
    else{
        return eEntertheoptionanswer3;
    }
}
+(NSString *)EnterTheOptionAnswer4{
    if ([language isEqualToString:@"2"]) {
        return zEntertheoptionanswer4;
    }
    else if ([language isEqualToString:@"3"]) {
        return mEntertheoptionanswer4;
    }
    else{
        return eEntertheoptionanswer4;
    }
}
+(NSString *)SelectTheCorrectAnswer{
    if ([language isEqualToString:@"2"]) {
        return zSelectthecorrectanswer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectthecorrectanswer;
    }
    else{
        return eSelectthecorrectanswer;
    }
}
+(NSString *)SelectAnswer{
    if ([language isEqualToString:@"2"]) {
        return zSelectAnswer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectAnswer;
    }
    else{
        return eSelectAnswer;
    }
}
+(NSString *)SelectOption{
    if ([language isEqualToString:@"2"]) {
        return zSelectOption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSelectOption;
    }
    else{
        return eSelectOption;
    }
}
+(NSString *)Option{
    if ([language isEqualToString:@"2"]) {
        return zOption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mOption;
    }
    else{
        return eOption;
    }
}
+(NSString *)PleaseEnterAllTheFields{
    if ([language isEqualToString:@"2"]) {
        return zPleaseenterallthefields;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseenterallthefields;
    }
    else{
        return ePleaseenterallthefields;
    }
}
+(NSString *)PleaseEnterQuestion{
    if ([language isEqualToString:@"2"]) {
        return zPleaseenterQuestion;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseenterQuestion;
    }
    else{
        return ePleaseenterQuestion;
    }
}
+(NSString *)PleaseEnterOption{
    if ([language isEqualToString:@"2"]) {
        return zPleaseenteroption;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseenteroption;
    }
    else{
        return ePleaseenteroption;
    }
}
+(NSString *)PleaseSelectCorrectAnswer{
    if ([language isEqualToString:@"2"]) {
        return zPleaseselectcorrectanswer;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseselectcorrectanswer;
    }
    else{
        return ePleaseselectcorrectanswer;
    }
}
+(NSString *)Quizinsertedsuccessfully{
    if ([language isEqualToString:@"2"]) {
        return zQuizInserted;
    }
    else if ([language isEqualToString:@"3"]) {
        return mQuizInserted;
    }
    else{
        return eQuizInserted;
    }
}
//Sub Articles
+(NSString *)SubArticleHeader{
    if ([language isEqualToString:@"2"]) {
        return zAddSubArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAddSubArticles;
    }
    else{
        return eAddSubArticles;
    }
    
}
+(NSString *)SubArticleTitle{
    if ([language isEqualToString:@"2"]) {
        return zSubArticleTitle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubArticleTitle;
    }
    else{
        return eSubArticleTitle;
    }
    
}
+(NSString *)SubArticleDescription{
    if ([language isEqualToString:@"2"]) {
        return zSubArticleDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubArticleDescription;
    }
    else{
        return eSubArticleDescription;
    }
    
}

+(NSString *)SubArticleTitlePlaceHolder{
    if ([language isEqualToString:@"2"]) {
        return zSubArticleTitlePlaceHolder;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubArticleTitlePlaceHolder;
    }
    else{
        return eSubArticleTitlePlaceHolder;
    }
    
    
}
+(NSString *)SubArticleDescriptionPlaceHolder{
    if ([language isEqualToString:@"2"]) {
        return zSubArticleDescriptionPlaceHolder;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSubArticleDescriptionPlaceHolder;
    }
    else{
        return eSubArticleDescriptionPlaceHolder;
    }
    
    
}
+(NSString *)Add{
    if ([language isEqualToString:@"2"]) {
        return zAdd;
    }
    else if ([language isEqualToString:@"3"]) {
        return mAdd;
    }
    else{
        return eAdd;
    }
    
    
}
+(NSString *)MoreSubArticles{
    if ([language isEqualToString:@"2"]) {
        return zMoreSubArticle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMoreSubArticle;
    }
    else{
        return eMoreSubArticle;
    }
    
    
}
+(NSString *)AddSubArticleMy{
    if ([language isEqualToString:@"2"]) {
        return zAddSubArticleMy;
    }
    else if ([language isEqualToString:@"3"])
    {
        return mAddSubArticleMy;
    }
    else{
        return eAddSubArticleMy;
    }
    
}
+(NSString *)MyArticles{
    if ([language isEqualToString:@"2"]) {
        return zMyArticles;
    }
    else if ([language isEqualToString:@"3"]) {
        return mMyArticles;
    }
    else{
        return eMyArticles;
    }
    
}
+(NSString *)PleaseEnterTitle
{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterTitle;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterTitle;
    }
    else{
        return ePleaseEnterTitle;
    }
    
    
}
+(NSString *)PleaseEnterDescription
{
    if ([language isEqualToString:@"2"]) {
        return zPleaseEnterDescription;
    }
    else if ([language isEqualToString:@"3"]) {
        return mPleaseEnterDescription;
    }
    else{
        return ePleaseEnterDescription;
    }
    
}

+(NSString *)ViewAnalytics{
    if ([language isEqualToString:@"2"]) {
        return zViewAnalytics;
    }
    else if ([language isEqualToString:@"3"]) {
        return mViewAnalytics;
    }
    else{
        return eViewAnalytics;
    }
    
    
}
+(NSString *)ReportAnalytics
{
    if ([language isEqualToString:@"2"]) {
        return zReportAnalytics;
    }
    else if ([language isEqualToString:@"3"]) {
        return mReportAnalytics;
    }
    else{
        return eReportAnalytics;
    }
    
}
+(NSString *)SNO;
{
    if ([language isEqualToString:@"2"]) {
        return zSNO;
    }
    else if ([language isEqualToString:@"3"]) {
        return mSNO;
    }
    else{
        return eSNO;
    }
}
+(NSString *)USERNAME;
{
    if ([language isEqualToString:@"2"]) {
        return zUSERNAME;
    }
    else if ([language isEqualToString:@"3"]) {
        return mUSERNAME;
    }
    else{
        return eUSERNAME;
    }
    
}

+(NSString *)VIEWCOUNT;
{
    if ([language isEqualToString:@"2"]) {
        return zVIEWCOUNT;
    }
    else if ([language isEqualToString:@"3"]) {
        return mVIEWCOUNT;
    }
    else{
        return eVIEWCOUNT;
    }
    
}

+(NSString *)DURATIONSPENT;
{
    if ([language isEqualToString:@"2"]) {
        return zDURATIONSPENT;
    }
    else if ([language isEqualToString:@"3"]) {
        return mDURATIONSPENT;
    }
    else{
        return eDURATIONSPENT;
    }
    
}


@end
