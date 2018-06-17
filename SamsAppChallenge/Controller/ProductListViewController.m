//
//  ViewController.m
//  SamsAppChallenge
//
//  Created by Swetha Pendyala on 6/15/18.
//  Copyright © 2018 Swetha Pendyala. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductDetailViewController.h"

#define DEFAULT_PAGE_SIZE 20

@interface ProductListViewController()
@property (weak, nonatomic) IBOutlet UITableView *productListTableView;
@property (nonatomic, strong) NSMutableArray *totalProductArray;
@property (nonatomic, assign) NSInteger requestedPage;
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Load data
    self.requestedPage = 1;
    [self fetchProductsDataForPage:self.requestedPage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.totalProductArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productDescriptionCell" forIndexPath:indexPath];
    if([_totalProductArray objectAtIndex:indexPath.row] != [NSNull null]) {
        cell.textLabel.text = [[_totalProductArray objectAtIndex:indexPath.row] productName];
        cell.detailTextLabel.text = [[_totalProductArray objectAtIndex:indexPath.row] price];
    } else {
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_productListTableView deselectRowAtIndexPath:indexPath animated:YES];
    if([_totalProductArray objectAtIndex:indexPath.row] != [NSNull null]) {
        Product *selectedProd = [_totalProductArray objectAtIndex:indexPath.row];
        ProductDetailViewController *prodDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
        prodDetailVC.product = selectedProd;
        [self.navigationController pushViewController:prodDetailVC animated:YES];
    }
}


#pragma mark - Pagination
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self checkNewPageRequestInfo];
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.totalProductArray objectAtIndex:indexPath.row] == [NSNull null]) {
        [self checkNewPageRequestInfo];
    }
}


#pragma mark - Table data fetching
- (void)checkNewPageRequestInfo
{
    for (UITableViewCell *baseCell in self.productListTableView.visibleCells) {
        NSIndexPath *index = [self.productListTableView indexPathForCell:baseCell];
        //Change the total array according to the top segment selected
        Product *product = [self.totalProductArray objectAtIndex:index.row];
        if ([product isEqual:[NSNull null]]) {
            NSInteger requestedPageNumber = index.row/DEFAULT_PAGE_SIZE;
            requestedPageNumber++;
            //check and avoid continuous request for same page.
            if (self.requestedPage != requestedPageNumber) {
                self.requestedPage = requestedPageNumber;
                [self fetchProductsDataForPage:requestedPageNumber];
                break;
            }
        }
    }
}

- (void)fetchProductsDataForPage:(NSInteger)pageIndex
{
    SamsProductDownloadUtility *downloadUtility = [[SamsProductDownloadUtility alloc] init];
    [downloadUtility getProductListForPageNumber:self.requestedPage pageSize:DEFAULT_PAGE_SIZE withCompletionBlock:^(ProductResponse *productResponse, NSError *error) {
        if (!error) {
            //NSLog(@"%@", productResponse.productsList);
            if (!self.totalProductArray) {
                self.totalProductArray = [NSMutableArray arrayWithCapacity:productResponse.totalProducts];
                for (int i = 0; i < productResponse.totalProducts; i++) {
                    [self.totalProductArray addObject:[NSNull null]];
                }
            }
            
            NSInteger pageLocationToSave = (self.requestedPage-1)*DEFAULT_PAGE_SIZE;
            [self.totalProductArray replaceObjectsAtIndexes:[NSIndexSet
                                                             indexSetWithIndexesInRange:NSMakeRange(pageLocationToSave, productResponse.productsList.count)] withObjects: productResponse.productsList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.productListTableView reloadData];
            });
        }
        else {
            NSLog(@"Error loading product list %@ -- %ld", [error domain], (long)error.code);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showErrorAlert];
            });
        }
    }];
}

- (void)showErrorAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to load product details at this time" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
