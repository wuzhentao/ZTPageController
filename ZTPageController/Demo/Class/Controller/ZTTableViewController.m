//
//  ZTTableViewController.m
//  ZTTableViewController
//
//  Created by 武镇涛 on 15/7/28.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "ZTTableViewController.h"
#import "NoLimitScorllview.h"
@interface ZTTableViewController ()<NoLimitScorllviewDelegate>

@end

@implementation ZTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    NSArray *images = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg"];
    NSArray *titlles = @[@"01-影流之主",@"02-影流之主",@"03-影流之主",@"04-影流之主",@"05-影流之主"];
    NoLimitScorllview *view = [[NoLimitScorllview alloc]initWithShowImages:images AndTitals:titlles];
    view.delegate = self;
    self.tableView.tableHeaderView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:ID ];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"00"];
    cell.textLabel.text = @"demo demo";
    cell.detailTextLabel.text = @"Accept what was and what is, and you’ll have more positive energy to pursue what will be";
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)NoLimitScorllview:(NoLimitScorllview *)scorllview ImageDidSelectedWithIndex:(int)index {
   
}
@end
