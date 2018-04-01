//
//  ViewController.m
//  JSONtesterNSlog
//
//  Created by Vburst on 2/12/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = [NSString stringWithFormat:@"%s","http://192.168.1.116:9955/CarUser/ViewMyProfile"];
    
    NSMutableDictionary *prop = [[NSMutableDictionary alloc] init];
    [prop setObject:@"0715546888" forKey:@"MobileNo"];
    [prop setObject:@"66566520" forKey:@"Password"];
    [prop setObject:@"Adam" forKey:@"Name"];

//MobileNo,Name,Password
    [Globals makePostRequestForUrl:url filtersDictionary:prop delegate:self requestFinished:@selector(requestFinished:) requestFailed:@selector(requestFailed:) tag:NO_TAG hudDisplayName:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-AFnetworking
- (void)requestFinished:(SLResponse *)request1
{
    NSString *responseString = [request1 responseString];
    

    
    return;
}

- (void)requestFailed:(SLResponse *)request1
{
  
}
@end
