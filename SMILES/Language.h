//
//  Language.h
//  SMILES
//
//  Created by BiipByte Technologies on 10/01/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject
#define language [[NSUserDefaults standardUserDefaults] valueForKey:@"language"]


//AppSettings//
+(NSString *)appSettings;
+(NSString *)PleaseyourNetworkConnection;

//Login Page
+(NSString*)DedaaBox;
+(NSString *)MobileNumber;
+(NSString *)Password;
+(NSString *)ForgotPassword;
+(NSString *)ChangeLanguage;
+(NSString *)SelectLanguage;
+(NSString *)Login;
+(NSString *)DontHaveAnAccount;
+(NSString *)SignUp;
+(NSString *)SelectCountryCode;
+(NSString *)MobileNumbercannotbeempty;
+(NSString *)Passwordcannotbeempty;

//Extra....Optional...
+(NSString *)SignUpasaSubscriber;
+(NSString *)Or;
+(NSString *)SignUpasaContributor;
+(NSString *)loading;
+(NSString *)pleaseEnterOTP;


//Registartion Page
+(NSString *)FullName;
+(NSString *)EmailOptional;
+(NSString *)ReEnterPassword;
+(NSString *)REGISTER;
+(NSString *)FullNamecannotbeempty;
+(NSString *)InvalidEmail;
+(NSString *)passwordValidate;
+(NSString *)ReenterPasswordcannotbeempty;
+(NSString *)PassandReentershouldBeSame;
+(NSString *)Cancel;
+(NSString *)Done;
+(NSString *)camera;
+(NSString *)gallary;
//Extra.....Optional...
+(NSString *)SubscriberSignUp;
+(NSString *)ContributorSignUp;
+(NSString *)COMPANYDETAILS;
+(NSString *)SelectCompanyName;
+(NSString *)SelectDepartment;
+(NSString *)LearnerIDOp;
+(NSString *)USERDETAILS;
+(NSString *)PleaseSelectCompanyName;
+(NSString *)PleaseSelectDepartment;
+(NSString *)PleaseenterPassword;
+(NSString *)mobileNoAlreadyRegistered;
+(NSString *)emailAlreadyRegistered;
+(NSString *)registrationSuccessfulCheckforOtp;
//Mobile Verification Page
+(NSString *)MobileVerification;
+(NSString *)sentSMSverificationcodetothenumberbelow;
+(NSString *)FourdigitVerificationcode;
+(NSString *)EnterVerificationCode;
+(NSString *)NotReceivedVerificationCode;
+(NSString *)RESEND;
//Forgot Password Page
+(NSString*)ForgotPasswordTitle;
+(NSString*)enterRegisteredMobileNumber;
+(NSString *)Code;
+(NSString *)SUBMIT;

//Reset Password//

+(NSString *)sentOTPtoYourRegisteredMobileNumber;
+(NSString *)notReceivedOTPPleaseclickonResendOTPButton;
+(NSString *)EnterOTP;
+(NSString *)ResendOTP;
+(NSString *)CheckyourOTPtoResetYourPassword;
+(NSString *)EnterNewPassword;
+(NSString *)SAVE;
+(NSString *)Yourpasswordchangedsuccessfully;

//..MenuList...///
+(NSString *)Home;
+(NSString *)Topics;
+(NSString *)Trainers;
+(NSString *)FavouriteVideos;
+(NSString *)MiniCertifications;
+(NSString *)Subscribe;
+(NSString *)History;
+(NSString *)MyProfile;
+(NSString *)UserGuide;
+(NSString *)AboutUs;
+(NSString *)Logout;


///....HomePage..///
+(NSString *)LatestVideos;
+(NSString *)TrendingVideos;
+(NSString *)ContinueReading;



//....Topics...///

+(NSString *)noTopicsAvailable;

//Articles List Page
+(NSString *)ArticlesList;
+(NSString *)By;
+(NSString *)Views;
+(NSString *)removearticlefromFavouriteList;
+(NSString *)ok;
+(NSString *)cancel;

//Article Details Page
+(NSString *)ArticleDetails;
+(NSString *)PostedOn;
+(NSString *)WriteReview;
+(NSString *)Description;
+(NSString *)Quiz;
+(NSString *)SubmitAnswer;
+(NSString *)PleaseSelectOption;
+(NSString *)share;
+(NSString *)Recamandedvideos;

//Review Page
+(NSString *)Review;
+(NSString *)WriteReviewForArticles;
+(NSString *)Rate;
+(NSString *)Submit;
+(NSString *)rating;
+(NSString *)Addyourcomment;


//...Trainers...///
+(NSString *)MyFavouriteTrainers;
+(NSString *)TrainersDetails;
+(NSString *)NodataAvailable;
+(NSString *)VIDEOS;
+(NSString *)Videos;
+(NSString *)Likes;
+(NSString *)AboutTrainer;
+(NSString *)Less;
+(NSString *)SaveProfile;
+(NSString *)MyFavourites;

//...MyFavouriteVideos...///
+(NSString *)noFavVideosAvailable;

//...MiniCertifications...//
+(NSString *)readMore;
+(NSString *)Courses;
+(NSString *)CourseOverView;
+(NSString *)lessons;
+(NSString *)TakeTheQuiz;
+(NSString *)ViewScore;
+(NSString *)RedeemCertificate;
+(NSString *)collectEcertificate;
+(NSString *)Certificate;
+(NSString *)youPassedTheExamination;
+(NSString *)Congratulations;
+(NSString *)pleaseSubmitNameAndEmailToRedeeemYourCertificate;
+(NSString *)Name;
+(NSString *)NoteFeeApplied;
+(NSString *)PleaseEnterName;
+(NSString *)PleaseEnterEmail;
+(NSString *)toGetCertificate80;
+(NSString *)pleaseAttemptAllQuestions;
+(NSString *)BankDetails;
+(NSString *)HotLine;
+(NSString *)CallCustomerService;
+(NSString *)ToCollectCer500KS;


//Assesment
+(NSString *)Assessment;
+(NSString *)NoAssessmentAvailable;
+(NSString *)ViewAssessment;
+(NSString *)submitAssesment;
+(NSString *)AssesmentResult;
+(NSString *)Score;
+(NSString *)Percentage;
+(NSString *)ViewAssScore;
+(NSString *)Answer;

//SubscriptionPage...
+(NSString *)ApplyPromoCodeHere;
+(NSString *)SubscribeToDedaaBox;
+(NSString *)ComingSoon;
+(NSString *)enterCouponCode;
+(NSString *)Apply;
+(NSString *)Success;


//Profile Details///
+(NSString *)Email;
+(NSString *)CompanyName;
+(NSString *)Department;
+(NSString *)LearnerID;
+(NSString *)EditProfile;
+(NSString *)NotVerified;
+(NSString *)Verified;
+(NSString *)VerifyNow;
+(NSString *)Profile;
+(NSString *)NotAvailable;
+(NSString *)youCodeExpiryDateis;
+(NSString *)PromoCode;
+(NSString *)ValidFrom;
+(NSString *)ValidTill;
//Email Verification
+(NSString *)WeHaveSentYouAnMailwithCodeToEmail;
+(NSString *)ToCompleteYourEmailVerificationPleaseEntertThe4DigitVerificationCode;
+(NSString *)NotreceivedVerificationCode;
+(NSString *)EmailVerification;

//AboutUs
+(NSString *)aboutUs;
+(NSString*)EmailusAboutUs;
+(NSString *)sendFeedback;
+(NSString *)Copyrights2016xprienzSMILES;
+(NSString *)AllRightsReserved;
+(NSString *)DisclaimerDesignConceptLogoAreCopyrightOfxprienzSMILES;
+(NSString *)TermsConditions;
+(NSString *)CallUs;
+(NSString *)enterQueryOrFeedBack;
+(NSString *)pleaseEnterQuery;




//.............>>>>>>>>>>>>>............>>>>>>>>>>>>>>...........>>>>>>>>>>>..........>>>>>>>>>>.....>

//...Extra Options...//
+(NSString *)PleaseCheckyourMessageforOTP;
+(NSString *)mobileVerifiedSuccessfully;
//Home Page
//+(NSString *)Home;
+(NSString *)LatestArticles;
+(NSString *)MostViewedArticles;
+(NSString *)FavouriteArticles;
+(NSString *)NoArticlesAvailable;

//Articles Page
+(NSString *)Articles;
+(NSString *)ArticlesCategory;
+(NSString *)NoArticlecategoryavailable;
//Create Article Page
+(NSString *)CreateArticle;
+(NSString *)PhotoUpload;
+(NSString *)VideoUpload;
+(NSString *)UploadPhoto;
+(NSString *)ArticleTitle;
+(NSString *)ArticleTitleAlert;
+(NSString *)ShortDescription;
+(NSString *)AddTag;
+(NSString *)AssignedTags;
+(NSString *)SELECTCATEGORY;
+(NSString *)SELECTSUBCATEGORY;
+(NSString *)SELECTSUBSUBCATEGORY;
+(NSString *)SELECTSUBSUBSUBCATEGORY;
+(NSString *)PleaseChooseArticleImage;
+(NSString *)AddMorePhotos;
+(NSString *)Image1;
+(NSString *)Image2;
+(NSString *)Image3;
+(NSString *)ImageoneCaption;
+(NSString *)ImagetwoCaption;
+(NSString *)ImagethreeCaption;
+(NSString *)Camera;
+(NSString *)Gallery;
+(NSString *)Deletewillclearallthecaptioncontent;
+(NSString *)PleaseEnterArticleTitle;
+(NSString *)PleaseEnterArticleShortDescription;
+(NSString *)PleaseEnterArticleDescription;
+(NSString *)PleaseSelectCategory;
+(NSString *)PleaseSelectSubCategory;
+(NSString *)PleaseSelectSubSubCategory;
+(NSString *)PleaseSelectSubSubSubCategory;
+(NSString *)Titlemustbeatleast3characters;
+(NSString *)Descriptionmustbeatleast5characters;
+(NSString *)ShortDescriptionmustbeatleast5characters;
+(NSString *)Articleuploadedsuccessfully;
+(NSString *)UploadVideo;
+(NSString *)ChooseVideo;
+(NSString *)RecordVideo;
+(NSString *)EnterayoutubevideoURL;
+(NSString *)ClearVideo;
+(NSString *)UPLOADYOUTUBEURL;
+(NSString *)EnterYoutubeURL;
+(NSString *)VALIDATE;
+(NSString *)CANCEL;
+(NSString *)PleaseEnterUrl;
+(NSString *)NotValidate;


+(NSString *)YourProfileHasBeenUpdatedSuccessfully;
//+(NSString *)UserGuide;



//Sequenced Articles
+(NSString *)SequencedArticles;
+(NSString *)NoSequenceAvailable;



//My Learning Groups
+(NSString *)MyLearningGroups;
+(NSString *)NoGroupsAvailable;

//Create Quiz
+(NSString *)CreateQuiz;
+(NSString *)Question;
+(NSString *)EnterQuestionName;
+(NSString *)AnswerOption1;
+(NSString *)AnswerOption2;
+(NSString *)AnswerOption3;
+(NSString *)AnswerOption4;
+(NSString *)EnterTheOptionAnswer1;
+(NSString *)EnterTheOptionAnswer2;
+(NSString *)EnterTheOptionAnswer3;
+(NSString *)EnterTheOptionAnswer4;
+(NSString *)SelectTheCorrectAnswer;
+(NSString *)SelectAnswer;
+(NSString *)SelectOption;
+(NSString *)Option;
+(NSString *)PleaseEnterAllTheFields;
+(NSString *)PleaseEnterQuestion;
+(NSString *)PleaseEnterOption;
+(NSString *)PleaseSelectCorrectAnswer;
+(NSString *)Quizinsertedsuccessfully;

+(NSString *)SearchArticles;

//Sub Articles
+(NSString *)SubArticleHeader;
+(NSString *)SubArticleTitle;
+(NSString *)SubArticleDescription;

+(NSString *)SubArticleTitlePlaceHolder;
+(NSString *)SubArticleDescriptionPlaceHolder;
+(NSString *)Add;
+(NSString *)MoreSubArticles;
+(NSString *)AddSubArticleMy;
+(NSString *)MyArticles;


+(NSString *)PleaseEnterTitle;
+(NSString *)PleaseEnterDescription;


+(NSString *)ViewAnalytics;
+(NSString *)ReportAnalytics;

+(NSString *)SNO;
+(NSString *)USERNAME;
+(NSString *)VIEWCOUNT;
+(NSString *)DURATIONSPENT;




@end
