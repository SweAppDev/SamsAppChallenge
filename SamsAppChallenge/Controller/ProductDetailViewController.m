//
//  ProductDetailViewController.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/16/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "ProductDetailViewController.h"

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
    // Do any additional setup after loading the view.
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
    
    NSString *imgUrlStr = [NSString stringWithFormat:@"https://mobile-tha-server.appspot.com%@", _product.productImage];
    NSURL *url = [NSURL URLWithString:imgUrlStr];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    self.productImgView.image = [UIImage imageWithData:imageData];
}


@end
