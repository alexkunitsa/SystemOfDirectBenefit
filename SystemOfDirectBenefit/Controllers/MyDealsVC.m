//
//  MyDealsVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "MyDealsVC.h"
#import "RequestManager.h"
#import "Deal.h"
#import "Global.h"

@interface MyDealsVC ()

@property (nonatomic, strong) NSMutableDictionary *items;
@property (nonatomic, assign) NSInteger stateToChange;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end


@implementation MyDealsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self receiveDetails];
}


- (void)receiveDetails {
    [[RequestManager sharedInstance] receiveDeals:^(BOOL success, NSMutableDictionary *items) {
        self.items = items;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - TableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    
    if (section == 0) {
        title = @"Order";
    }
    else if (section == 1) {
        title = @"Confirm order";
    }
    else if (section == 2) {
        title = @"Took";
    }
    else if (section == 3) {
        title = @"Return";
    }
    else if (section == 4) {
        title = @"Confirm return";
    }
    
    return title;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // Don't show separators between empty cells
    return [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *identifier = [NSString stringWithFormat:@"%li",(long)section];
    NSArray *items = self.items[identifier];
    
    return items.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *identifier = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *items = self.items[identifier];
    Deal *deal = items[indexPath.row];
    Item *item = deal.relatedItem;
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.itemDescription;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    self.currentIndexPath = indexPath;
    
    NSString *identifier = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *items = self.items[identifier];
    Deal *deal = items[indexPath.row];
    
    NSString *currentUserId = [[[Global sharedInstance] currentUser] userId];
    
    BOOL isSenderUser = [deal.userId isEqualToString:currentUserId];
    if (isSenderUser) {
        if (indexPath.section == 0) {
            title = nil;
        }
        else if (indexPath.section == 1) {
            title = @"Took";
            self.stateToChange = 2;
        }
        else if (indexPath.section == 2) {
            title = @"Return";
            self.stateToChange = 3;
        }
        else if (indexPath.section == 3) {
            title = nil;
        }
        else if (indexPath.section == 4 || indexPath.section == 5) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
      
    }
    else {
        if (indexPath.section == 0) {
            title = @"Confirm order";
            self.stateToChange = 1;
        }
        else if (indexPath.section == 1) {
            title = nil;
        }
        else if (indexPath.section == 2) {
            title = nil;
        }
        else if (indexPath.section == 3) {
            title = @"Confirm return";
            self.stateToChange = 4;

        }
        else if (indexPath.section == 4 || indexPath.section == 5) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
    }
    
    
    if ([currentUserId isEqualToString:deal.userId] && [currentUserId isEqualToString:deal.ownerId]) {
        if (indexPath.section == 0) {
            title = @"Confirm order";
            self.stateToChange = 1;
        }
        else if (indexPath.section == 1) {
            title = @"Took";
            self.stateToChange = 2;
        }
        else if (indexPath.section == 2) {
            title = @"Return";
            self.stateToChange = 3;
        }
        else if (indexPath.section == 3) {
            title = @"Confirm return";
            self.stateToChange = 4;
        }
        else if (indexPath.section == 4 || indexPath.section == 5) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
    }
    
    
    UIActionSheet *actionSheet = nil;
    if (title.length > 0) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove deal" otherButtonTitles:title, nil];
        [actionSheet showInView:self.view];

    }
    else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove deal" otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];
    }
  }


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *identifier = [NSString stringWithFormat:@"%li",(long)self.currentIndexPath.section];
    NSArray *items = self.items[identifier];
    Deal *deal = items[self.currentIndexPath.row];

    
    if (buttonIndex == 0) {
        
        [[RequestManager sharedInstance] changeDealStatus:deal.dealId status:@(5) completionHandler:^(BOOL success) {
            if (success) {
                [self receiveDetails];
            }
        }];
        NSLog(@"delete status");
        
    } else if (buttonIndex == 1) {
        [[RequestManager sharedInstance] changeDealStatus:deal.dealId status:@(self.stateToChange) completionHandler:^(BOOL success) {
            if (success) {
                [self receiveDetails];
            }
        }];

        
        NSLog(@"change status %ld", (long)self.stateToChange);
    }
}

@end
