//
//  AddItemVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCategory.h"

@interface AddItemVC : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *itemTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *resourceTypeSegment;
@property (nonatomic, weak) IBOutlet UISegmentedControl *dealAcceptSegment;
@property (nonatomic, weak) IBOutlet UILabel *resourceTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dealAcceptLabel;
@property (nonatomic, weak) IBOutlet UIButton *resourceInfoButton;
@property (nonatomic, weak) IBOutlet UIButton *dealInfoButton;

@property (nonatomic, strong) ItemCategory *selectedCategory;
@property (nonatomic, assign) BOOL isRequestItem;

- (IBAction)changeCategoryAction:(id)sender;
- (IBAction)saveAddNewAction:(id)sender;
- (IBAction)saveItemAction:(id)sender;
- (IBAction)showResourceTypeInfo:(id)sender;
- (IBAction)showDealAccept:(id)sender;

@end