//
//  AddItemVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCategory.h"

@interface AddItemVC : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *itemTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *resourceTypeSegment;
@property (nonatomic, weak) IBOutlet UISegmentedControl *dealAcceptSegment;
@property (nonatomic, strong) ItemCategory *selectedCategory;

- (IBAction)changeCategoryAction:(id)sender;
- (IBAction)saveAddNewAction:(id)sender;
- (IBAction)saveItemAction:(id)sender;

@end
