//
//  AddItemVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "AddItemVC.h"
#import "Item.h"
#import "RequestManager.h"

@interface AddItemVC ()

@end

@implementation AddItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)changeCategoryAction:(id)sender {
    
}


- (IBAction)saveAddNewAction:(id)sender {
    [self saveItem];
}


- (IBAction)saveItemAction:(id)sender {
    [self saveItem];
}

- (IBAction)showResourceTypeInfo:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                        message:@"Put message text here"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)showDealAccept:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                        message:@"Put message text here"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)saveItem {
//    if (self.selectedCategory.itemCategoryId.length == 0) {
//        return;
//    }
    
    Item *item = [[Item alloc] init];
    item.name = self.itemTitleLabel.text;
    item.itemDescription = self.descriptionTextView.text;
    item.categoryId = @"1";//self.selectedCategory.itemCategoryId;
    item.dealAccept = self.dealAcceptSegment.selectedSegmentIndex;
    item.resourceType = self.resourceTypeSegment.selectedSegmentIndex;

    [[RequestManager sharedInstance] addItem:item completionHandler:^(BOOL success) {
        
    }];
}

@end
