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
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    
//    ItemCategory *itemCategory = self.items[indexPath.row];
//
//    AddItemVC *vc = (AddItemVC *)[self backViewController];
//    vc.selectedCategory = itemCategory;
    
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
