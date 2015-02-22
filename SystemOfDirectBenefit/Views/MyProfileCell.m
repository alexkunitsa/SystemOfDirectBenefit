//
//  MyProfileCell.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "MyProfileCell.h"

@implementation MyProfileCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonActon:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuItemSelectedNotification" object:@{@"itemId":@(self.selecteditemId)}];
}

@end
