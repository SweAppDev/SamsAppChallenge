//
//  Product.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.productId = [dictionary valueForKey:@"productId"];
        self.productName = [dictionary valueForKey:@"productName"];
        self.shortDesc = [dictionary valueForKey:@"shortDescription"];
        self.longDesc = [dictionary valueForKey:@"longDescription"];
        self.price = [dictionary valueForKey:@"price"];
        self.productImage = [dictionary valueForKey:@"productImage"];
        self.reviewRating = [[dictionary valueForKey:@"reviewRating"] floatValue];
        self.reviewCount = [[dictionary valueForKey:@"reviewCount"] integerValue];
        self.inStock = [[dictionary valueForKey:@"inStock"] boolValue];
    }
    return self;
}

@end
