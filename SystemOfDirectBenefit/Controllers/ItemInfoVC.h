//
//  ItemInfoVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemInfoVC : UIViewController

@property (nonatomic, strong) Item *item;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *typeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dealLabel;

- (IBAction)startDealAction:(id)sender;

@end
