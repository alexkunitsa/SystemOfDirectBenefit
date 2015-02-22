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
#import "UITextField+Validation.h"

@interface AddItemVC ()

@end

@implementation AddItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.descriptionTextView.delegate = self;
    self.itemTitleLabel.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isRequestItem) {
        self.resourceTypeSegment.hidden = YES;
        self.dealAcceptSegment.hidden = YES;
        
        self.resourceTypeLabel.hidden = YES;
        self.dealAcceptLabel.hidden = YES;
        self.resourceInfoButton.hidden = YES;
        self.dealInfoButton.hidden = YES;
    }
    else {
        self.resourceTypeSegment.hidden = NO;
        self.dealAcceptSegment.hidden = NO;
        
        self.resourceTypeLabel.hidden = NO;
        self.dealAcceptLabel.hidden = NO;
        self.resourceInfoButton.hidden = NO;
        self.dealInfoButton.hidden = NO;
    }
    
    if (self.selectedCategory) {
        self.categoryLabel.text = self.selectedCategory.categoryDescription;
    }
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
    if (self.selectedCategory.itemCategoryId.length == 0) {
        self.categoryLabel.textColor = [UIColor redColor];
        return;
    }
    else {
        self.categoryLabel.textColor = [UIColor blackColor];
    }
    
    Item *item = [[Item alloc] init];
    item.name = self.itemTitleLabel.text;
    item.itemDescription = self.descriptionTextView.text;
    item.categoryId = self.selectedCategory.itemCategoryId;
    item.dealAccept = self.dealAcceptSegment.selectedSegmentIndex;
    item.resourceType = self.resourceTypeSegment.selectedSegmentIndex;
    item.isRequestItem =  self.isRequestItem;

    [[RequestManager sharedInstance] addItem:item completionHandler:^(BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}


- (BOOL)areFieldsValid {
    BOOL valid = YES;
    NSArray *fields = @[self.itemTitleLabel];
    
    for (UITextField *field in fields) {
        
        if ([field isEmpty]) {
            valid = NO;
            [field makeHightlighted];
        }
        else {
            [field makeNormal];
        }
    }
    
    return valid;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}

@end
