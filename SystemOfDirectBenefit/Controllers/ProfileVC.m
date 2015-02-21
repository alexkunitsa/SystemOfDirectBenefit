//
//  ProfileVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "ProfileVC.h"

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
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
        cell.textLabel.text = @"Статистика";
        
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Текущие сделки";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"Уведомления";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"Мои ресурсы";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"Мои заявки";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"Добавить услугу";
    }
    else if (indexPath.row == 6) {
        cell.textLabel.text = @"Найти услугу";
    }
    else if (indexPath.row == 7) {
        cell.textLabel.text = @"Выйти";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"addItemSegue" sender:self];
    }
}




@end
