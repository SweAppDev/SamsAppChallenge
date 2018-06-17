//
//  ProductDetailViewController.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "ProductDetailViewController.h"

#define IMAGE_URL @"https://mobile-tha-server.appspot.com"

@interface ProductDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UILabel *productDescLbl;
@property (weak, nonatomic) IBOutlet UILabel *productIDLbl;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *inStockLbl;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Swipe Gestures
    [self initializeGestures];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //UI
    [self populateProductDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UI Helpers
- (void) populateProductDetails {
    self.productNameLbl.text = _product.productName;
    self.productPriceLbl.text = [NSString stringWithFormat:@"Price: %@", _product.price];
    self.productIDLbl.text = [NSString stringWithFormat:@"Product ID: %@", _product.productId];
    self.inStockLbl.text = _product.inStock ? @"Item available in stock." : @"Item unavailable at this time.";
    
    //NSString *aboutThisStr = [@"<b>More about this Item: </b><br />" stringByAppendingString:_product.longDesc];
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [_product.longDesc dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    self.productDescLbl.attributedText = attributedString;
    
    NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@", IMAGE_URL, _product.productImage];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlStr]];
    self.productImgView.image = [UIImage imageWithData:imageData];
}

- (void)initializeGestures {
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandler:)];
    [leftGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHandler:)];
    [rightGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:rightGesture];
}

- (void)swipeRightHandler:(UISwipeGestureRecognizer*)gesture {
    
    if (_index > 1 && [_productList objectAtIndex:_index-1] != [NSNull null]) {
        _product = [_productList objectAtIndex:_index-1];
        _index--;
        
        [self populateProductDetails];
    }
}

- (void)swipeLeftHandler:(UISwipeGestureRecognizer*)gesture {
    
    if (_index < _productList.count-1 && [_productList objectAtIndex:_index+1] != [NSNull null]) {
        _product = [_productList objectAtIndex:_index+1];
        _index++;
        
        [self populateProductDetails];
    }
}
@end
