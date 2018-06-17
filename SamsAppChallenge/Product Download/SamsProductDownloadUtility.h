//
//  SamsProductDownloadUtility.h
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductResponse.h"

@interface SamsProductDownloadUtility : NSObject

typedef void (^GetProductListCompletionBlock) (ProductResponse *prodResponse, NSError *error);

- (void)getProductListForPageNumber:(NSInteger)pageNumber pageSize:(int)pageSize withCompletionBlock:(GetProductListCompletionBlock)completionBlock ;

@end
