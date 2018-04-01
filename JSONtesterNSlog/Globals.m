//
//  Globals.m
//  FashionApp
//
//  Created by Vburst on 10/7/15.
//  Copyright (c) 2015 G.G.I.U.G All rights reserved.
//

#import "Globals.h"

NSString * const APIURL = @"http://www.ezcim.com/FashionUser/";
NSString * const APIURL2 = @"http://www.ezcim.com/FashionEvents/";
NSString *const PDFURL = @"reports_ipad/";
NSString * const APP_VERSION = @"2.6.6" ;
//app store
//NSString * const APP_VERSION = @"2.4.6" ;

NSString *const LOGOURL = @"http://t/";
NSString *const EMAILURL =@"http://ojij";
NSString *const APP_NAME = @"Fashion";
NSString *const NO_ITEMS_ERROR = @"No items available.";
NSString *const GET_LIST_ERROR = @"Error on getting list.";
NSString *const DELETE_CONFIRMATION = @"Delete this item?";
NSString *const NO_INTERNET = @"NO_INTERNET";

static Globals *_sharedGlobals;

@implementation Globals{
}

@synthesize DEVICE_ID, USER_ID, API_URL,
FIRST_NAME, LAST_NAME, EMAIL, USERNAME, DBNAME, PASSWORD, LOGIN_USERNAME, DBID,appDelegate;

+ (Globals *)sharedGlobals {
    @synchronized(self) {
        if (_sharedGlobals == nil) {
            _sharedGlobals = [[super allocWithZone:NULL] init];
        }
    }
    return _sharedGlobals;
}

+ (void)makePostRequestForUrl:(NSString *)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                   showLoader:(BOOL)isShowLoader
               hudDisplayName:(NSString *)hudDisplayName {
    
    [Globals makePostRequestForUrl:path
                 filtersDictionary:filter
                          delegate:delegate
                   requestFinished:finised
                     requestFailed:failed
                               tag:tag
                    hudDisplayName:hudDisplayName];
    
    
}

+ (void)makePostRequestForUrl:(NSString *)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
               hudDisplayName:(NSString *)hudDisplayName {
    
    SBJson4Writer *json=[SBJson4Writer new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    AFHTTPRequestOperation *operation=[manager POST:path parameters:filter success:nil failure:nil];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Request URL ================\n%@\n", path);
#endif
    
    if (filter != nil) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Request Body ================\n%@\n",
              filter);
#endif
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  
                  [json stringWithObject:responseObject]);
            
#endif
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setResponseString:responseObject];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        
        NSInteger statusCode = error.code;
        //error codes add here
        if(statusCode == -1009) {
    
            return ;
        }
        
        
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:response];
        }
    }];
    
    [operation start];
}


+ (void)makeGetRequestForUrl:(NSString *)path
           filtersDictionary:(id)filter
                    delegate:(id)delegate
             requestFinished:(SEL)finised
               requestFailed:(SEL)failed
                         tag:(int)tag
              hudDisplayName:(NSString *)hudDisplayName {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    AFHTTPRequestOperation *operation=[manager GET:path parameters:filter success:nil failure:nil];
    SBJson4Writer *json=[SBJson4Writer new];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Request URL ================\n%@\n", path);
#endif
    
    if (filter != nil) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Request Body ================\n%@\n",
              [json stringWithObject:filter]);
#endif
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setResponseString:responseObject];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:response];
        }
    }];
    
    [operation start];
}
+ (void)makePostRequestForUrl:(NSString *)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                     userInfo:(NSMutableDictionary *)userInfo
               timeOutSeconds:(int)timeOutSeconds
               hudDisplayName:(NSString *)hudDisplayName {
    
    
    SBJson4Writer *json = [SBJson4Writer new];
    
    NSString *basePath = path;
 
    NSString *URLString = basePath;
    
    NSMutableURLRequest *afrequest  = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil];

    [afrequest setTimeoutInterval:timeOutSeconds];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Request URL ================\n%@\n", path);
#endif
    
    if (filter != nil) {
        [afrequest setHTTPBody:[[json stringWithObject:filter]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Request Body ================\n%@\n",
              [json stringWithObject:filter]);
#endif
    }
    
    
    AFHTTPRequestOperation *operation =
    [[AFHTTPRequestOperation alloc] initWithRequest:afrequest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setUserInfo:userInfo];
            [response setResponseString:[[NSString alloc]
                                         initWithData:responseObject
                                         encoding:NSUTF8StringEncoding]];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              error);
#endif
        //        [Globals ShowHideOverlay:NO];
        
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setUserInfo:userInfo];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:response];
        }
    }];
    
    [operation start];
}
+ (void)makePostRequestForUrl1:(NSString *)path
             filtersDictionary:(id)filter
                      delegate:(id)delegate
               requestFinished:(SEL)finised
                 requestFailed:(SEL)failed
                           tag:(int)tag
                hudDisplayName:(NSString *)hudDisplayName {
    
    SBJson4Writer *json=[SBJson4Writer new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    AFHTTPRequestOperation *operation=[manager POST:path parameters:filter success:nil failure:nil];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Request URL ================\n%@\n", path);
#endif
    
    if (filter != nil) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Request Body ================\n%@\n",
              filter);
#endif
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setResponseString:responseObject];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:response];
        }
    }];
    
    [operation start];
}

+ (void)makePostRequestForUrl:(NSString *)path
            filtersDictionary:(id)filter
                     delegate:(id)delegate
              requestFinished:(SEL)finised
                requestFailed:(SEL)failed
                          tag:(int)tag
                     userInfo:(NSMutableDictionary *)userInfo
               hudDisplayName:(NSString *)hudDisplayName {
    
    [Globals makePostRequestForUrl:path
                 filtersDictionary:filter
                          delegate:delegate
                   requestFinished:finised
                     requestFailed:failed
                               tag:tag
                          userInfo:userInfo
                    timeOutSeconds:20
                    hudDisplayName:hudDisplayName];
}

+ (void)downloadFile:(NSString *)path
              toPath:(NSString *)savePath
            delegate:(id)delegate
     requestFinished:(SEL)finised
       requestFailed:(SEL)failed
                 tag:(int)tag
    withViewProgress:(UIProgressView *)inViewProgress
      hudDisplayName:(NSString *)hudDisplayName {
    
    SBJson4Writer *json=[SBJson4Writer new];
    UIProgressView *progress = nil;
    if (inViewProgress == nil) {
    }
    
    progress.alpha = 1;
    progress = inViewProgress;
    progress.progress = 0.0;
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Request URL ================\n%@\n", path);
    NSLog(@"==================  Save URL ================\n%@\n", savePath);
#endif
    
    NSURLRequest *request = [NSURLRequest
                             requestWithURL:
                             [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:
                                                   NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation =
    [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.outputStream =
    [NSOutputStream outputStreamToFileAtPath:savePath append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        if (inViewProgress == nil) {
            //            [Globals ShowHideOverlayWithProgress:NO];
        } else {
            //[progress removeFromSuperview];
            progress.alpha=0;
            
        }
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        if (inViewProgress == nil) {
            //  [Globals ShowHideOverlayWithProgress:NO];
        } else {
            //  [progress removeFromSuperview];
            progress.alpha=0;
        }
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:response];
        }
    }];
    [operation
     setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead,
                                long long totalBytesExpectedToRead) {
         
         if (totalBytesExpectedToRead < 0) {
             totalBytesExpectedToRead = 500000;
         }
         progress.progress = (float)totalBytesRead / totalBytesExpectedToRead;
         
     }];
    [operation start];
}

+ (void)uploadFile:(NSString *)path
 filtersDictionary:(id)filter
          fileData:(NSData *)fileData
          fileName:(NSString *)fileName
          delegate:(id)delegate
   requestFinished:(SEL)finised
     requestFailed:(SEL)failed
               tag:(int)tag
    hudDisplayName:(NSString *)hudDisplayName {

    SBJson4Writer *json=[SBJson4Writer new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:60];
    AFHTTPRequestOperation *operation=[manager POST:path parameters:filter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData name:@"name" fileName:@"filenameIOs" mimeType:@"image/jpeg"];
        
    } success:nil failure:nil];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Upload URL ================\n%@\n", path);
#endif
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        CGFloat pVal = ((CGFloat)totalBytesWritten) / totalBytesExpectedToWrite;
  
        
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setResponseString:responseObject];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:operation];
        }
    }];
    
    [operation start];
}

+ (void)uploadMultipleFile:(NSString *)path
              filtersArray:(NSMutableArray *)filtersArray
                  fileData:(NSData *)fileData
                  fileName:(NSString *)fileName
                  delegate:(id)delegate
           requestFinished:(SEL)finised
             requestFailed:(SEL)failed
                       tag:(int)tag
            hudDisplayName:(NSString *)hudDisplayName {
    

    SBJson4Writer *json=[SBJson4Writer new];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation=[manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for(int i=0;i<[filtersArray count];i++)
        {
            UIImage *eachFile  = [filtersArray objectAtIndex:i];
            NSData *fileData = UIImageJPEGRepresentation(eachFile,0.1);
            [formData appendPartWithFileData:fileData name:[NSString stringWithFormat:@"file%d",i] fileName:[NSString stringWithFormat:@"abc%d.png",i] mimeType:@"image/png"];
        }
        
        
    } success:nil failure:nil];
    
#if IS_DEBUG_ON == 1
    NSLog(@"==================  Upload URL ================\n%@\n", path);
#endif
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        CGFloat pVal = ((CGFloat)totalBytesWritten) / totalBytesExpectedToWrite;
        //    progress.progress = pVal;
        NSLog(@"upload precentatge : %f",pVal);
        }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                               id responseObject) {
        
        
        //  [Globals ShowHideOverlayWithUploadProgress:NO];
        if (delegate &&
            [delegate respondsToSelector:@selector(requestFinished:)]) {
            
            
#if IS_DEBUG_ON == 1
            NSLog(@"==================  Response ================\n%@\n",
                  [json stringWithObject:responseObject]);
#endif
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setResponseData:responseObject];
            [response setOperation:operation];
            [response setTag:tag];
            [response setResponseStatus:YES];
            [response setResponseString:responseObject];
            
            [delegate performSelector:@selector(requestFinished:)
                           withObject:response];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if IS_DEBUG_ON == 1
        NSLog(@"==================  Response Error ================\n%@\n",
              [json stringWithObject:error]);
#endif
        if (delegate && [delegate respondsToSelector:@selector(requestFailed:)]) {
            
            SLResponse *response = [[SLResponse alloc] init];
            [response setOperation:operation];
            [response setResponseStatus:NO];
            [response setError:error];
            [response setTag:tag];
            
            [delegate performSelector:@selector(requestFailed:)
                           withObject:operation];
        }
    }];
    
    [operation start];
}


+ (NSString *)formatDate:(NSString *)date {
    
    return [Globals formatDate:date withValueIfNull:@""];
}

+ (NSString *)formatTime:(NSString *)date {
    
    return [Globals formatTime:date withValueIfNull:@""];
}

+ (NSString *)formatDate:(NSString *)date
         withValueIfNull:(NSString *)defaultValue {
    
    if ([[Globals ParseNil:date withValueIfNull:@""] isEqualToString:@""]) {
        return defaultValue;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dString = [formatter stringFromDate:tDate];
    
    NSString *fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    dString = [formatter stringFromDate:tDate];
    
    fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    
    return defaultValue;
}

+ (NSString *)formatDateToShort:(NSString *)date
                withValueIfNull:(NSString *)defaultValue {
    
    if ([[Globals ParseNil:date withValueIfNull:@""] isEqualToString:@""]) {
        return defaultValue;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yy"];
    NSString *dString = [formatter stringFromDate:tDate];
    
    NSString *fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yy"];
    dString = [formatter stringFromDate:tDate];
    
    fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    
    return defaultValue;
}

+ (NSString *)formatDateToUSFormat:(NSString *)date
                   withValueIfNull:(NSString *)defaultValue {
    
    if ([[Globals ParseNil:date withValueIfNull:@""] isEqualToString:@""]) {
        return defaultValue;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dString = [formatter stringFromDate:tDate];
    
    NSString *fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        
        NSArray *arr = [fString componentsSeparatedByString:@"-"];
        
        return [NSString stringWithFormat:@"%@-%@-%@", arr[2], arr[1], arr[0]];
    }
    
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    dString = [formatter stringFromDate:tDate];
    
    fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        NSArray *arr = [fString componentsSeparatedByString:@"-"];
        return [NSString stringWithFormat:@"%@-%@-%@", arr[2], arr[1], arr[0]];
    }
    
    return defaultValue;
}

+ (NSString *)formatDateAndTime:(NSString *)date
                withValueIfNull:(NSString *)defaultValue {
    
    if ([[Globals ParseNil:date withValueIfNull:@""] isEqualToString:@""]) {
        return defaultValue;
    }
    
    NSArray *items = [date componentsSeparatedByString:@" "];
    
    if ([items count] != 2) {
        return defaultValue;
    }
    
    return [NSString stringWithFormat:@"%@ %@",
            [Globals formatDate:[items objectAtIndex:0]
                withValueIfNull:@""],
            [Globals formatTime:[items objectAtIndex:1]
                withValueIfNull:@""]];
}

+ (NSString *)reverseDateFormat:(NSString *)date {
    NSArray *items = [date componentsSeparatedByString:@"-"];
    NSString *result = @"";
    if (items.count == 3) {
        result = [NSString stringWithFormat:@"%@-%@-%@", [items objectAtIndex:2],
                  [items objectAtIndex:1],
                  [items objectAtIndex:0]];
    }
    return result;
}

+ (NSString *)formatTime:(NSString *)date
         withValueIfNull:(NSString *)defaultValue {
    
    if ([[Globals ParseNil:date withValueIfNull:@""] isEqualToString:@""]) {
        return defaultValue;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *dString = [formatter stringFromDate:tDate];
    
    NSString *fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    
    [formatter setDateFormat:@"ç"];
    
    tDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"hh:mm a"];
    dString = [formatter stringFromDate:tDate];
    
    fString = [Globals ParseNil:dString withValueIfNull:@""];
    
    if (![fString isEqualToString:@""]) {
        return fString;
    }
    return defaultValue;
}
+ (NSString*) formatDateUsingTimeStamp:(NSString*)timeStampDate {
    NSString *dateAsString=timeStampDate;
    dateAsString = [dateAsString stringByReplacingOccurrencesOfString:@"/Date("
                                                           withString:@""];
    dateAsString = [dateAsString stringByReplacingOccurrencesOfString:@"000)/"
                                                           withString:@""];
    
    unsigned long long milliseconds = [dateAsString longLongValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:milliseconds];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd-MM-yyyy"];
    return  [dateformate stringFromDate:date];
}

+ (NSString *)ParseNil:(NSString *)input {
    return [input class] == [NSNull class] ? @"" : input;
}

+ (NSString *)ParseNil:(id)input withValueIfNull:(NSString *)defaultValue {
    if ([input class] == [NSNull class] || input == nil) {
        return defaultValue;
    }
//    else if ([input superclass] == [NSNumber class]) {
//        return input;
//    } else if (!([input superclass] == [NSMutableString class] ||
//                 [input superclass] == NSClassFromString(@"__NSCFString"))) {
//        return defaultValue;
//    } else if ([input isEqualToString:@""]) {
//        return defaultValue;
//    }
    return input;
//    if(input.length==0 || [input isKindOfClass:[NSNull class]] || [input isEqualToString:@""]||[input  isEqualToString:NULL]||[input isEqualToString:@"(null)"]||str==nil || [str isEqualToString:@"<null>"]){
//        return YES;
//    }
//    return NO;
}
+ (NSString *)ParseNilForQuery:(id)input
               withValueIfNull:(NSString *)defaultValue {
    if ([input class] == [NSNull class] || input == nil) {
        return [defaultValue stringByReplacingOccurrencesOfString:@"'"
                                                       withString:@"\\'"];
    } else if ([input superclass] == [NSNumber class]) {
        return [input stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    } else if (!([input superclass] == [NSMutableString class] ||
                 [input superclass] == NSClassFromString(@"__NSCFString"))) {
        return [defaultValue stringByReplacingOccurrencesOfString:@"'"
                                                       withString:@"\\'"];
    } else if ([input isEqualToString:@""]) {
        return [defaultValue stringByReplacingOccurrencesOfString:@"'"
                                                       withString:@"\\'"];
    }
    return [input stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
}


+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    NSMutableAttributedString *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    
    // text color
    [textStyle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStyle.length)];
    
    // text font
    [textStyle addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:40.0] range:NSMakeRange(0, textStyle.length)];
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,40,40)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    // add text onto the image
    [textStyle drawInRect:CGRectIntegral(rect)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
