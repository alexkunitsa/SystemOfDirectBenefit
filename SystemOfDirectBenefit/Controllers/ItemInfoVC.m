//
//  ItemInfoVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "ItemInfoVC.h"
#import "RequestManager.h"

@interface ItemInfoVC ()

@end

@implementation ItemInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.titleLabel.text = self.item.name;
    self.descriptionLabel.text = self.item.itemDescription;
    
    NSString *type = @"Use";
    if (self.item.resourceType) {
        type = @"Utilize";
    }
    
    NSString *deal = @"Auto";
    if (self.item.dealAccept) {
        deal = @"Manual";
    }
    
    self.typeLabel.text = type;
    self.dealLabel.text = deal;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

- (IBAction)startDealAction:(id)sender {
    [[RequestManager sharedInstance] addDeal:self.item.itemId completionHandler:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
