//
//  Product.h
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *shortDesc;
@property (nonatomic, strong) NSString *longDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic, assign) float reviewRating;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, assign) BOOL inStock;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
