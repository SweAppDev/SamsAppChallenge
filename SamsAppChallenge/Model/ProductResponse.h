//
//  ProductResponse.h
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductResponse : NSObject

@property (nonatomic, strong) NSArray *productsList;
@property (nonatomic, assign) NSInteger totalProducts;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
