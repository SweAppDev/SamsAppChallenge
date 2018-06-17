//
//  SamsProductDownloadUtility.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "SamsProductDownloadUtility.h"

#define PRODUCT_LIST_URL @"https://mobile-tha-server.appspot.com/walmartproducts/"

@implementation SamsProductDownloadUtility

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)getProductListForPageNumber:(NSInteger)pageNumber pageSize:(int)pageSize withCompletionBlock:(GetProductListCompletionBlock)completionBlock {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:config];
    NSString *urlString = [NSString stringWithFormat:@"%@%ld/%d", PRODUCT_LIST_URL, (long)pageNumber, pageSize];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionBlock(nil,error);
            return;
        }
        
        NSError *serializationError = nil;
        NSInteger statusCode = 0;
        // Parse the JSON response
        NSDictionary *prodResponseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
        if (serializationError) {
            //Handle Error
            NSError *error = [[NSError alloc] initWithDomain:@"ProductServiceErrorDomain" code:serializationError.code userInfo:serializationError.userInfo];
            completionBlock(nil,error);
            return;
        }
        
        statusCode = [[prodResponseDict objectForKey:@"statusCode"] integerValue];
        if(statusCode == 200 ) {
            //Success - Handle resonse
            ProductResponse *prodResponse = [[ProductResponse alloc] initWithDictionary:prodResponseDict];
            completionBlock(prodResponse, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"ProductServiceErrorDomain" code:statusCode userInfo:nil];
            //Failure - Handle Error
            completionBlock(nil,error);
        }
        
    }];
    [task resume];
}

@end
