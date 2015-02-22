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

@interface MyDealsVC ()

@property (nonatomic, strong) NSMutableDictionary *items;
@property (nonatomic, assign) NSInteger stateToChange;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end


@implementation MyDealsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [[RequestManager sharedInstance] receiveDeals:^(BOOL success, NSMutableDictionary *items) {
        self.items = items;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



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
    
    cell.textLabel.text = deal.dealId;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    self.currentIndexPath = indexPath;
    
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

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:title, nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
//        NSString *identifier = [NSString stringWithFormat:@"%li",(long)self.currentIndexPath.section];
//        NSArray *items = self.items[identifier];
//        Deal *deal = items[self.currentIndexPath.row];
//
//        [[RequestManager sharedInstance] changeDealStatus:deal.dealId status:@(self.stateToChange) completionHandler:^(BOOL success) {
//            
//        }];
        
        NSLog(@"change status %ld", (long)self.stateToChange);
    }
}

@end
