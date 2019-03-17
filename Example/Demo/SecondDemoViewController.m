//
//  SecondDemoViewController.m
//  Example
//
//  Created by Stefan Nebel on 17.03.19.
//

#import "Declaration.h"
#import "SecondDemoViewController.h"

@interface SecondDemoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property UICollectionView *collectionView;

@end



@implementation SecondDemoViewController

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
    [[self shyNavBarManager] setScrollView:self.collectionView];
}


#pragma UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor darkGrayColor]];
    
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
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}
@end
