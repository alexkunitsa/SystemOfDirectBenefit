//
//  SearchCategoryVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "SearchCategoryVC.h"
#import "RequestManager.h"
#import "ItemCategory.h"
#import "AddItemVC.h"

@interface SearchCategoryVC ()

@property (nonatomic, strong) NSArray *items;

@end


@implementation SearchCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.searchBar.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] < 3) {
        return;
    }
    
    [[RequestManager sharedInstance] searchCategory:searchText completionHandler:^(BOOL success) {
        
    }];
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
    
    
    cell.textLabel.text = @"Category";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ItemCategory *itemCategory = self.items[indexPath.row];
    
    AddItemVC *vc = (AddItemVC *)[self backViewController];
    vc.selectedCategory = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIViewController *)backViewController {
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2) {
        return nil;
    }
    else {
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
    }
}

@end
