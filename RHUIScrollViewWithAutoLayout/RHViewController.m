//
//  RHViewController.m
//  RHUIScrollViewWithAutoLayout
//
//  Created by Roy Hsu on 2014/8/26.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "RHViewController.h"

@interface RHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dynamicTableViewHeight;
@property (strong, nonatomic) NSArray *array;

@end

@implementation RHViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setup];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)setup
{
    [self.tableView reloadData];
}

- (NSInteger)randomCellsCount
{
    return (arc4random() % 6);
}

- (void)viewDidLayoutSubviews
{
    [self relayoutTableView];
}

- (void)relayoutTableView
{
    CGFloat tableViewHeight = MAX(0, self.tableView.contentSize.height);
    self.dynamicTableViewHeight.constant = tableViewHeight;
    [self.view layoutIfNeeded];
}

- (IBAction)reloadTableViewAction:(id)sender {
    [self.tableView reloadData];
    [self relayoutTableView];
}

#pragma mark - UITableView data source.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self randomCellsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    
    return cell;
}


@end
