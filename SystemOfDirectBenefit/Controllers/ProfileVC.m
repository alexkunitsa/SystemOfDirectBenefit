//
//  ProfileVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "ProfileVC.h"
#import "RequestManager.h"
#import "Global.h"

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
    
    [[RequestManager sharedInstance] receiveUser:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userNameLabel.text = [[[Global sharedInstance] currentUser] name];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // Don't show separators between empty cells
    return [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = nil;

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Statistics";
        
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Current deals";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"Notifications";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"My items";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"My requests";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"Add item";
    }
    else if (indexPath.row == 6) {
        cell.textLabel.text = @"Search item";
    }
    else if (indexPath.row == 7) {
        cell.textLabel.text = @"Sign out";
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"addItemSegue" sender:self];
    }
    
    else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"myItemsSegue" sender:self];
    }
    
    else if (indexPath.row == 6) {
        [self performSegueWithIdentifier:@"searchItemSegue" sender:self];
    }
    else if (indexPath.row == 7) {
        [[Global sharedInstance] setSessionId:nil];
        [[Global sharedInstance] setCurrentUser:nil];

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
