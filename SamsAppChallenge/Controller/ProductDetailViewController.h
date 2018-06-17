//
//  ProductDetailViewController.h
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailViewController : UIViewController

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) NSArray *productList;
@property (nonatomic, assign) NSInteger index;

@end
