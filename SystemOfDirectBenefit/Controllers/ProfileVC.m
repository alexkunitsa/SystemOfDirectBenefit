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
#import "MyProfileCell.h"


@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"MyProfileCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"MyProfileCell"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
    
    [[RequestManager sharedInstance] receiveUser:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userNameLabel.text = [[[Global sharedInstance] currentUser] name];
        });
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemSelected:) name:@"menuItemSelectedNotification" object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // Don't show separators between empty cells
    return [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];

    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
    
    
    NSString *text = nil;

    if (indexPath.row == 0) {
        text = @"Statistics";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = YES;
    }
    else if (indexPath.row == 1) {
        text = @"Current deals";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = YES;
    }
    else if (indexPath.row == 2) {
        text = @"Notifications";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = YES;
    }
    else if (indexPath.row == 3) {
        text = @"My items";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = NO;
        cell.selecteditemId = 3;
//        [cell.actionButton setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];

    }
    else if (indexPath.row == 4) {
        text = @"My requests";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = NO;
        cell.selecteditemId = 4;
//        [cell.actionButton setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    }
//    else if (indexPath.row == 5) {
//        text = @"Add item";
//        cell.badgeLabel.hidden = YES;
//        cell.actionButton.hidden = YES;
//    }
//    else if (indexPath.row == 6) {
//        text = @"Search item";
//        cell.badgeLabel.hidden = YES;
//        cell.actionButton.hidden = YES;
//    }
    else if (indexPath.row == 5) {
        text = @"Sign out";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = YES;
    }
    
    cell.itemTitleLabel.text = text;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"myItemsSegue" sender:self];
    }
    else if (indexPath.row == 6) {
        [[Global sharedInstance] setSessionId:nil];
        [[Global sharedInstance] setCurrentUser:nil];

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (indexPath.row == 4) {
        [self performSegueWithIdentifier:@"profileToRequestsSegue" sender:self];
    }
}


- (void)itemSelected:(NSNotification *)notification {
    NSDictionary *info = notification.object;
    NSNumber *numberId = info[@"itemId"];
    
    
    if (numberId.integerValue == 3) {
        [self performSegueWithIdentifier:@"addItemSegue" sender:self];
    }
    else if (numberId.integerValue == 4) {
        [self performSegueWithIdentifier:@"searchItemSegue" sender:self];
    }
}

@end
