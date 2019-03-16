//
//  ViewController.m
//  Example
//
//  Created by Stefan Nebel on 16.03.19.
//

#import "Declaration.h"
#import "ViewController.h"
#import "FirstDemo/FirstDemoViewController.h"



@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
@property NSArray *arrRows;
@end



@implementation ViewController

#pragma instancetype
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.arrRows = @[@(5), @(10), @(20)];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"Framework Example"];
    
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
    
    switch ([indexPath section]) {
        case 0:
        {
            switch ([indexPath row]) {
                case 0:
                    [[cell textLabel] setText:@"Present UIViewController"];
                    break;
                case 1:
                    [[cell textLabel] setText:@"Push UIViewController"];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([indexPath section]) {
        case 0:
        {
            switch ([indexPath row]) {
                case 0:
                    [self goToFirstDemo];
                    break;
                case 1:
                    [self goToSecondDemo];
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
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

#pragma FirstDemo
- (void)goToFirstDemo
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[FirstDemoViewController alloc] init]];
    [[self navigationController] presentViewController:navigationController animated:true completion:nil];
}
- (void)goToSecondDemo
{
    [[self navigationController] pushViewController:[[FirstDemoViewController alloc] init] animated:true];
}
@end
