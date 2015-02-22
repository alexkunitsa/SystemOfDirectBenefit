//
//  SearchItemVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "SearchItemVC.h"
#import "RequestManager.h"
#import "Item.h"
#import "ItemInfoVC.h"

@interface SearchItemVC ()

@property (nonatomic, strong) NSArray *items;

@end


@implementation SearchItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)searchAction {
    NSString *searchText = self.titleTextField.text;
    
    [[RequestManager sharedInstance] searchItem:searchText completionHandler:^(BOOL success, NSArray *items) {
        self.items = items;
        [self.tableView reloadData];
    }];
}


#pragma mark - TableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // Don't show separators between empty cells
    return [UIView new];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
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
    
    Item *item = self.items[indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = self.items[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemInfoVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"itemInfo"];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
