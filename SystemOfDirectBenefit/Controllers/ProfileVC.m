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
        User *user = [[Global sharedInstance] currentUser];
        
        // TODO - move to requestManager 
        if (user.profilePictureId.length > 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.profilePictureId]];
                UIImage* image = [[UIImage alloc] initWithData:imageData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.profilePictureImageView.image = image;
                    });
                }
            });
        }
        
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
}


#pragma mark - TableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
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
        text = @"My items";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = NO;
        cell.selecteditemId = 3;
    }
    else if (indexPath.row == 3) {
        text = @"My requests";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = NO;
        cell.selecteditemId = 4;
    }
    else if (indexPath.row == 4) {
        text = @"Sign out";
        cell.badgeLabel.hidden = YES;
        cell.actionButton.hidden = YES;
    }
    
    cell.itemTitleLabel.text = text;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"myItemsSegue" sender:self];
    }
    else if (indexPath.row == 4) {
        [[Global sharedInstance] setSessionId:nil];
        [[Global sharedInstance] setCurrentUser:nil];

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"profileToRequestsSegue" sender:self];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"myDealsSegue" sender:self];
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
