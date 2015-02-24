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
    
    // TODO - move to requestManager
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.item.pictureId]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pictureImageView.image = image;
            });
        }
    });
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
