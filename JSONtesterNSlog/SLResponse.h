//
//  SLResponse.h
//
//  Created by  G.G.I.U. on 18/09/2015.
//  Copyright (c) 2015 G.G.I.U. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SLResponse : NSObject {
    
}

@property (nonatomic, retain) AFHTTPRequestOperation *operation;
@property (nonatomic, retain) id responseString;
@property (nonatomic, retain) NSData *responseData;
@property (nonatomic, retain) NSError *error;
@property (nonatomic) BOOL responseStatus;
@property (readwrite) int tag;
@property (nonatomic, retain) NSMutableDictionary *userInfo;

@end
