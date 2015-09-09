//
//  ZViewController.m
//  ZCharts
//
//  Created by renxin on 04/18/2015.
//  Copyright (c) 2014 renxin. All rights reserved.
//

#import "ZViewController.h"

@implementation ZViewController {
   
    NSArray *dataArray;
}

static NSString *reuseIdetify = @"Cell";

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    dataArray = @[
                  @{
                      @"title":@"ZChars",
                      @"list": @[
                              @{
                                  @"name": @"Line",
                                  @"Class": @"ZCharsLineViewController",
                                  },
                              ]
                      },
                  ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdetify];
    [self.view addSubview:tableView];

}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray[section][@"list"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return dataArray[section][@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    cell.textLabel.text = dataArray[indexPath.section][@"list"][indexPath.row][@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    NSString *className = dataArray[indexPath.section][@"list"][indexPath.row][@"Class"];
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}



@end
