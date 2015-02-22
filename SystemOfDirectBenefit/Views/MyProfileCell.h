//
//  MyProfileCell.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, assign) NSInteger selecteditemId;

- (IBAction)buttonActon:(id)sender;

@end
