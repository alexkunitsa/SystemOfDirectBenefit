//
//  MyRequestsVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRequestsVC : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (IBAction)addRequestItem:(id)sender;

@end