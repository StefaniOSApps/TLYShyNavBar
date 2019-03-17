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

@end



@implementation CollectionViewController

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

    [[self view] addSubview:self.collectionView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController) [[self shyNavBarManager] setScrollView:self.collectionView];
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
    [label_L setText:[NSString stringWithFormat:@"%03ld", [indexPath row]]];
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
    return flowLayout;
}

#pragma Dismiss UIViewController
- (void)dismissViewController
{
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}
@end
