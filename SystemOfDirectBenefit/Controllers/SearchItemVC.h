//
//  SearchItemVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCategory.h"

@interface SearchItemVC : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *titleTextField;
@property (nonatomic, weak) IBOutlet UILabel *categoryNameLabel;
@property (nonatomic, weak) IBOutlet UITextField *cityTextField;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ItemCategory *selectedCategory;

- (IBAction)searchAction;

@end
