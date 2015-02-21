//
//  ProfileVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profilePictureImageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
