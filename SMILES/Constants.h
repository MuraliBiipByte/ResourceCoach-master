//
//  Constants.h
//
//  Created by Biipmi on 23/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#import <Foundation/Foundation.h>

#define USER_DATA @"USER_DATA"
#define MIME_TYPE_JPEG      @"image/jpeg"
#define CURRENT_LOCATION    @"current_location"
#define LIMIT               @"20"
#define AES256_KEY          @"FOOD-APPLICATION-HOANG-LE-HUY-15"

//#define STRIPE_PUBLISHABLE_KEY  @"pk_test_IfbA9ZG3EqM9npHKfnUoO6pr"
//#define BACKEND_CHARGE_URLString @"https://powerful-beyond-9630.herokuapp.com"

#define FORMAT_DATE_01 @"HH:mm"
#define FORMAT_DATE_02 @"yyyy-MM-dd HH:mm:ss"
#define FORMAT_DATE_03 @"yyyy-MM-dd"

//new workspace
#define WORKSAPCE_DATA @"WORKSAPCE_DATA"
#define ZWWS (@"\u200b")

typedef void (^CompletionHandler)(BOOL success, id result);

typedef enum
{
    BLACK_COLOR     = 1,
    BLUE_COLOR      = 2,
    GREEN_COLOR     = 3,
    GREY_COLOR      = 4,
    ORANGE_COLOR    = 5,
    TAN_COLOR       = 6,
    WHITE_COLOR     = 7
    
} BUTTON_COLOR;

typedef enum
{
    FOR_SELLER     = 1,
    FOR_BUYER      = 2,
} PERSON_TYPE;


typedef enum
{
   
    LIVE = 1,
    OUTOFSTOCK = 2,
    
}PRODUCT_AVAILABLE_TYPE;


typedef enum
{
    
    BAKER = 1,
    TIPPER = 2,
    
}STEPS_TYPE;



typedef enum
{
    UPLOAD_PHOTO_USER           = 1,
    UPLOAD_PHOTO_PRODUCT        = 2,
    UPLOAD_PHOTO_WORKSPACE      = 3,
} UPLOAD_TYPE;

typedef enum
{
    NEAREST_LOCATION     = 1,
    FOOD_TYPE            = 2,
    CITY                 = 2
} SEARCH_TYPE;

typedef enum
{
    WAITING     = 1,
    COMPLETE    = 2,
    APPROVE     = 3,
    REJECT      = 4,
    ACCEPT      = 5
} STATUS_TYPE;
