//
//  FirstDemoViewController.m
//  Example
//
//  Created by Stefan Nebel on 16.03.19.
//

#import "Declaration.h"
#import "FirstDemoViewController.h"

@interface FirstDemoViewController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
@property NSArray *arrRows;

@end

@implementation FirstDemoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrRows = @[@(5), @(10), @(20)];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    BOOL isPresented = self.navigationController.isBeingPresented;
    [[self navigationItem] setTitle:(isPresented ? @"Present UIViewController" : @"Push UIViewController")];
    [[self navigationItem] setLeftBarButtonItem:(isPresented) ? [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                              target:self
                                                                                                              action:@selector(dismissViewController)] : nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:[[self view] bounds] style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCellIdentifier"];
    [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.tableView setSeparatorColor:[UIColor whiteColor]];
    
    if(@available(iOS 11.0, *)) [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    
    [[self view] addSubview:self.tableView];
    [[self shyNavBarManager] setScrollView:self.tableView];
}

#pragma UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableViewCellIdentifier";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell == nil)            cell = [UITableViewCell new];
    
    
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    [[cell textLabel] setText:[NSString stringWithFormat:@"S: %2ld -- R: %02ld", [indexPath section], [indexPath row] ]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell contentView] setBackgroundColor:[UIColor darkGrayColor]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor orangeColor]];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrRows[section] integerValue];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrRows count];
}

#pragma dismiss UIViewController
- (void)dismissViewController
{
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}
@end