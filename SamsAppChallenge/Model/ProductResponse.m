//
//  ProductResponse.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "ProductResponse.h"

@implementation ProductResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.totalProducts = [[dictionary valueForKey:@"totalProducts"] integerValue];
        self.pageNumber = [[dictionary valueForKey:@"pageNumber"] integerValue];
        self.pageSize = [[dictionary valueForKey:@"pageSize"] integerValue];
       
        //Parse - Products list
        NSArray *prodResponseArr = [dictionary objectForKey:@"products"];
        NSMutableArray *prodsArr = [[NSMutableArray alloc] initWithCapacity:prodResponseArr.count];
        for (NSDictionary *prodItemDict in prodResponseArr) {
            Product *prod = [[Product alloc] initWithDictionary:prodItemDict];
            [prodsArr addObject:prod];
        }
        
        self.productsList = prodsArr;
    }
    return self;
}

@end
