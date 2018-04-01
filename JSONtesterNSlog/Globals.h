//
//  Globals.h
//  FashionApp
//
//  Created by Vburst on 10/7/15.
//  Copyright (c) 2015 Vburst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AppDelegate.h"


extern NSString * const APIURL;
extern NSString * const APIURL2;

extern NSString* const APP_VERSION;
extern NSString * const PDFURL;
extern NSString * const LOGOURL;
extern NSString * const EMAILURL;
extern NSString * const APP_NAME;
extern NSString * const NO_ITEMS_ERROR;
extern NSString * const GET_LIST_ERROR;
extern NSString * const DELETE_CONFIRMATION;
extern NSString * const NO_INTERNET;

/*
 *
 *
 */

#ifndef IS_DEVELOPMENT
#define IS_DEVELOPMENT 0
#endif

#ifndef IS_DEBUG_ON
#define IS_DEBUG_ON 1
#endif

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
/*
 *
 *
 */

typedef enum{
    ITEM = 1,
    NO_TAG,
    APPROVE,
    REJECT,
    SAVE,
    PENDING_DETAILS,
    UPDATE,
    UPDATEWITHOUTPDF,
    PDFGEN,
    DETAILS,
    SAVE_FAV,
    URL,
    MODEL,
    STATUS,
    COUNTRY,
    EMAIL,
    MAP,
    IMAGE,
    USER,
    USER_CATEGORY,
    UPDATE_STATUS,
    UPLOAD_IMAGES,
    USER_PROFILE,
    PROFILE_PIC_UPLOAD,
    FROM,
    RECEIVE,
    RECEIVED_DETAILS,
    ROLES,
    TO,
    ACTIVATE,
    HASH_TAG,
    REPORT,
    IMAGE_SHARING
} RequestType;



@interface Globals : NSObject{
    
}
+(void) makePostRequestForUrl:(NSString*)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                   showLoader:(BOOL)isShowLoader
                   hudDisplayName:(NSString*)hudDisplayName;


+(void) makePostRequestForUrl:(NSString*)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
               hudDisplayName:(NSString*)hudDisplayName;


+(void) makePostRequestForUrl:(NSString*)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                     userInfo:(NSMutableDictionary *)userInfo
               hudDisplayName:(NSString*)hudDisplayName;


+ (void)makeGetRequestForUrl:(NSString *)path
           filtersDictionary:(id)filter
                    delegate:(id)delegate
             requestFinished:(SEL)finised
               requestFailed:(SEL)failed
                         tag:(int)tag
              hudDisplayName:(NSString*)hudDisplayName;


+ (void) downloadFile:(NSString*)path
               toPath:(NSString*)savePath
             delegate:(id)delegate
      requestFinished:(SEL)finised
        requestFailed:(SEL)failed
                  tag:(int)tag
     withViewProgress:(UIProgressView*)inViewProgress
       hudDisplayName:(NSString*)hudDisplayName;


+(void) uploadFile:(NSString*)path
          filtersDictionary:(id)filter
          fileData:(NSData*)fileData
          fileName:(NSString*)fileName
          delegate:(id)delegate
   requestFinished:(SEL)finised
     requestFailed:(SEL)failed
               tag:(int)tag
    hudDisplayName:(NSString*)hudDisplayName;

+(void) uploadMultipleFile:(NSString*)path
          filtersArray:(NSMutableArray*)filtersArray
          fileData:(NSData*)fileData
          fileName:(NSString*)fileName
          delegate:(id)delegate
   requestFinished:(SEL)finised
     requestFailed:(SEL)failed
               tag:(int)tag
    hudDisplayName:(NSString*)hudDisplayName;

+(void) makePostRequestForUrl:(NSString*)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                     userInfo:(NSMutableDictionary *)userInfo
               timeOutSeconds:(int)timeOutSeconds
               hudDisplayName:(NSString*)hudDisplayName;


+ (Globals*)sharedGlobals;

+ (NSString*) formatDateAndTime:(NSString*)date withValueIfNull:(NSString *)defaultValue;
+ (NSString*) formatDate:(NSString*)date;
+ (NSString*) formatDateToUSFormat:(NSString*)date withValueIfNull:(NSString *)defaultValue;
+ (NSString*) formatDate:(NSString*)date withValueIfNull:(NSString*)defaultValue;
+ (NSString*) formatTime:(NSString*)date;
+ (NSString*) formatTime:(NSString*)date withValueIfNull:(NSString*)defaultValue;
+ (NSString*) formatDateToShort:(NSString*)date withValueIfNull:(NSString *)defaultValue;
+ (NSString*) formatDateUsingTimeStamp:(NSString*)timeStampDate ;

+ (NSString*)ParseNilForQuery:(id)input withValueIfNull:(NSString*)defaultValue;
+ (NSString*)ParseNil:(id)input;
+ (NSString*)ParseNil:(id)input withValueIfNull:(NSString*)defaultValue;

+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point;
@property(nonatomic, retain) NSString* DEVICE_ID;
@property(nonatomic, retain) NSString* LOGIN_USERNAME;
@property(nonatomic, retain) NSString* USER_ID;
@property(nonatomic, retain) NSString* DBID;
@property(nonatomic, retain) NSString* FIRST_NAME;
@property(nonatomic, retain) NSString* LAST_NAME;
@property(nonatomic, retain) NSString* EMAIL;
@property(nonatomic, retain) NSString* USERNAME;
@property(nonatomic, retain) NSString* DBNAME;
@property(nonatomic, retain) NSString* PASSWORD;
@property(nonatomic, retain) NSString* API_URL;

@property(nonatomic, retain) AppDelegate* appDelegate;


@end
