//
//  CollectionViewController.m
//  Example
//
//  Created by Stefan Nebel on 17.03.19.
//

#import "Declaration.h"
#import "CollectionViewController.h"

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property UIPageViewController *pageController;
@property UIRefreshControl *refresh;

@end



@implementation CollectionViewController

- (instancetype)initWithPageController:(UIPageViewController *)page
{
    self = [super init];
    if(self) {
        self.pageController = page;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    BOOL isPresented = self.navigationController.isBeingPresented;
    [[self navigationItem] setTitle:(isPresented ? @"Present UICollectionView" : @"Push UICollectionView")];
    [[self navigationItem] setLeftBarButtonItem:(isPresented) ? [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                              target:self
                                                                                                              action:@selector(dismissViewController)] : nil];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[[self view] bounds] collectionViewLayout:[self getLayout]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
    [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.collectionView setUserInteractionEnabled:YES];
    [self.collectionView setMultipleTouchEnabled:NO];
    [self.collectionView setAllowsMultipleSelection:NO];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    if (@available(iOS 11.0, *)) [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAlways];

    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 10.0, *)) {
        [self.collectionView setRefreshControl:self.refresh];
    }else{
        [self.collectionView addSubview:self.refresh];
    }
    [[self view] addSubview:self.collectionView];
    
    [self setShyNavBarManager:[[TLYShyNavBarManager alloc] init] viewController:(self.pageController ? self.pageController  : self)];
    [[self shyNavBarManager] setScrollView:self.collectionView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self shyNavBarManager] setExtensionView:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 20)];
    [view setBackgroundColor:[UIColor orangeColor]];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [[self shyNavBarManager] setExtensionView:view];
    [[self shyNavBarManager] setStickyExtensionView:YES];
}

#pragma UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    for (UIView * v in [cell contentView].subviews) [v removeFromSuperview];

    [cell setBackgroundColor:[UIColor darkGrayColor]];
    
    
    UILabel *label_L = [UILabel new];
    [label_L setTextAlignment:NSTextAlignmentCenter];
    [label_L setTextColor:[UIColor whiteColor]];
    [label_L setFont:[UIFont systemFontOfSize:14.0f weight:UIFontWeightBold]];
    [label_L setAdjustsFontSizeToFitWidth:YES];
    [label_L setText:[NSString stringWithFormat:@"%03ld", (long)[indexPath row]]];
    [label_L setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[cell contentView] addSubview:label_L];
    
    [NSLayoutConstraint activateConstraints:@[[[label_L topAnchor]      constraintEqualToAnchor:[[cell contentView] topAnchor]],
                                              [[label_L bottomAnchor]   constraintEqualToAnchor:[[cell contentView] bottomAnchor]],
                                              [[label_L leftAnchor]     constraintEqualToAnchor:[[cell contentView] leftAnchor]],
                                              [[label_L rightAnchor]    constraintEqualToAnchor:[[cell contentView] rightAnchor]]
                                              ]];
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 500;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewFlowLayout *)getLayout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:kPadding];
    [flowLayout setMinimumInteritemSpacing:kPadding];
    [flowLayout setSectionInset:UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding)];
//    [flowLayout setEstimatedItemSize:(!UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation) ? CGSizeMake(40, 40) : CGSizeMake(50, 50))];
    return flowLayout;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation) ? CGSizeMake(40, 40) : CGSizeMake(50, 50);
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:nil
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         [self.collectionView performBatchUpdates:^{
             [self.collectionView setCollectionViewLayout:self.collectionView.collectionViewLayout animated:YES];
         } completion:nil];
     }];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
}


#pragma Dismiss UIViewController
- (void)dismissViewController
{
    [self.refresh endRefreshing];
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

@end
