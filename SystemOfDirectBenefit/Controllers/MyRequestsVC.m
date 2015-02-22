//
//  MyRequestsVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "MyRequestsVC.h"
#import "AddItemVC.h"
#import "RequestManager.h"
#import "Item.h"

@interface MyRequestsVC ()

@property (nonatomic, strong) NSArray *items;

@end


@implementation MyRequestsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[RequestManager sharedInstance] receiveUserItems:1 completionHandler:^(BOOL success, NSArray *items) {
        self.items = items;
        
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableViewDelegate

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Item *item = self.items[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.itemDescription;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Actions

- (IBAction)addRequestItem:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddItemVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"Additem"];
    vc.isRequestItem = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
