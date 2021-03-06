//
//  ViewController.m
//  Example
//
//  Created by Stefan Nebel on 16.03.19.
//

#import "Declaration.h"
#import "ViewController.h"
#import "Demo/TableViewController.h"
#import "Demo/CollectionViewController.h"
#import "Demo/PageViewController.h"




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
        self.arrRows = @[@(4), @(4), @(4), @(10), @(20)];
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
    [[cell textLabel] setText:[NSString stringWithFormat:@"S: %2ld -- R: %02ld", (long)[indexPath section], (long)[indexPath row] ]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell contentView] setBackgroundColor:[UIColor darkGrayColor]];
    
    switch ([indexPath section]) {
        case 0:
        case 1:
        case 2:
        {
            switch ([indexPath row]) {
                case 0:
                    [[cell textLabel] setText:@"Present FormSheet"];
                    break;
                case 1:
                    [[cell textLabel] setText:@"Present PageSheet"];
                    break;
                case 2:
                    [[cell textLabel] setText:@"Present FullScreen"];
                    break;
                case 3:
                    [[cell textLabel] setText:@"Push"];
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
                    [self runTableViewController:UIModalPresentationFormSheet];
                    break;
                case 1:
                    [self runTableViewController:UIModalPresentationPageSheet];
                    break;
                case 2:
                    [self runTableViewController:UIModalPresentationFullScreen];
                    break;
                case 3:
                    [self runTableViewController:UIModalPresentationNone];
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch ([indexPath row]) {
                case 0:
                    [self runCollectionViewController:UIModalPresentationFormSheet];
                    break;
                case 1:
                    [self runCollectionViewController:UIModalPresentationPageSheet];
                    break;
                case 2:
                    [self runCollectionViewController:UIModalPresentationFullScreen];
                    break;
                case 3:
                    [self runCollectionViewController:UIModalPresentationNone];
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch ([indexPath row]) {
                case 0:
                    [self runPageViewController:UIModalPresentationFormSheet];
                    break;
                case 1:
                    [self runPageViewController:UIModalPresentationPageSheet];
                    break;
                case 2:
                    [self runPageViewController:UIModalPresentationFullScreen];
                    break;
                case 3:
                    [self runPageViewController:UIModalPresentationNone];
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
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor orangeColor]];
    
    UILabel *label_L = [UILabel new];
    [label_L setTextAlignment:NSTextAlignmentLeft];
    [label_L setFont:[UIFont systemFontOfSize:14.0f weight:UIFontWeightBold]];
    [label_L setNumberOfLines:1];
    [label_L setAdjustsFontSizeToFitWidth:YES];
     switch (section) {
         case 0:
             [label_L setText:@"UITableView"];
             break;
         case 1:
             [label_L setText:@"UICollectionView"];
             break;
         case 2:
             [label_L setText:@"UIPageViewController"];
             break;
         default:
             break;
     }
    
    [label_L setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:label_L];
    
    [NSLayoutConstraint activateConstraints:@[[[label_L topAnchor]      constraintEqualToAnchor:[view topAnchor]],
                                              [[label_L bottomAnchor]   constraintEqualToAnchor:[view bottomAnchor]],
                                              [[label_L leftAnchor]     constraintEqualToAnchor:[view leftAnchor]   constant:kPadding],
                                              [[label_L rightAnchor]    constraintEqualToAnchor:[view rightAnchor]  constant:-kPadding]
                                              ]];
    
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
- (void)runTableViewController:(UIModalPresentationStyle)style
{
    TableViewController *vc = [[TableViewController alloc] initWithPageController:nil];
    
    if (style != UIModalPresentationNone)
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [navigationController setModalPresentationStyle:style];
        [[navigationController navigationBar] setTranslucent:NO];
        [[self navigationController] presentViewController:navigationController animated:YES completion:nil];
    }
    else [[self navigationController] pushViewController:vc animated:YES];
}
- (void)runCollectionViewController:(UIModalPresentationStyle)style
{
    CollectionViewController *vc = [[CollectionViewController alloc] initWithPageController:nil];
    
    if (style != UIModalPresentationNone)
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [navigationController setModalPresentationStyle:style];
        [[navigationController navigationBar] setTranslucent:NO];
        [[self navigationController] presentViewController:navigationController animated:YES completion:nil];
    }
    else [[self navigationController] pushViewController:vc animated:YES];
}
- (void)runPageViewController:(UIModalPresentationStyle)style
{
    PageViewController *vc = [[PageViewController alloc] init];
    
    if (style != UIModalPresentationNone)
    {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [navigationController setModalPresentationStyle:style];
        [[navigationController navigationBar] setTranslucent:NO];
        [[self navigationController] presentViewController:navigationController animated:YES completion:nil];
    }
    else [[self navigationController] pushViewController:vc animated:YES];
}
@end
