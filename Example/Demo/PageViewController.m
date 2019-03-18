//
//  PageViewController.m
//  Example
//
//  Created by Stefan Nebel on 17.03.19.
//

#import "PageViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface PageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property NSArray<UIViewController *> *arrVC;
@property (assign) BOOL pageIsAnimating;

@end



@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isPresented = self.navigationController.isBeingPresented;
    [[self navigationItem] setTitle:(isPresented ? @"Present UIViewController" : @"Push UIViewController")];
    [[self navigationItem] setLeftBarButtonItem:(isPresented) ? [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                              target:self
                                                                                                              action:@selector(dismissViewController)] : nil];
    
    self.pageIsAnimating    = NO;
    self.arrVC              = @[[[TableViewController alloc] initWithPageController:self], [[CollectionViewController alloc] initWithPageController:self]];
    
    [self setDelegate:self];
    [self setDataSource:self];
    [self setViewControllers:@[self.arrVC.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma UIPageViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if([self.arrVC count] == 1 || self.pageIsAnimating) return nil;
    NSInteger index = MAX(0, MIN([self.arrVC count] - 1, [self.arrVC indexOfObject:viewController]));
    return self.arrVC[MAX(0, MIN([self.arrVC count] - 1, ((index == [self.arrVC count] - 1) ? 0 : (index + 1))))];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if([self.arrVC count] == 1 || self.pageIsAnimating) return nil;
    NSInteger index = MAX(0, MIN([self.arrVC count] - 1, [self.arrVC indexOfObject:viewController]));
    return self.arrVC[MAX(0, MIN([self.arrVC count] - 1, ((index == 0) ? ([self.arrVC count] - 1) : (index - 1))))];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrVC count];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    self.pageIsAnimating = YES;
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed || finished)   self.pageIsAnimating = NO;
}


#pragma Dismiss UIViewController
- (void)dismissViewController
{
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}
@end
