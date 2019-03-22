//
//  TLYShyStatusBarController.m
//  TLYShyNavBarDemo
//
//  Created by Mazyad Alabduljaleel on 11/13/15.
//  Copyright © 2015 Telly, Inc. All rights reserved.
//

#import "TLYShyStatusBarController.h"

static inline CGFloat AACStatusBarHeight(UIViewController *viewController)
{
    UIView *view    = viewController.view;
    BOOL isiPad     = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    if ([UIApplication sharedApplication].statusBarHidden) return 0.f;
    if (viewController.presentingViewController.presentedViewController == viewController) return 0;
    if (view.window.frame.size.height == 0) return [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat diff                = [view.superview convertPoint:CGPointZero toView:view.window].y;
    CGFloat extendedStatusBar   = view.window.frame.size.height - view.bounds.size.height;
    CGFloat statusBarHeight     = diff > 0 ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if (@available(iOS 11.0, *)) {
//        extendedStatusBar -= MAX(0, extendedStatusBar - UIApplication.sharedApplication.delegate.window.safeAreaInsets.top);
    }
    
    statusBarHeight += (diff > extendedStatusBar) ? extendedStatusBar : (isiPad ? 0 : extendedStatusBar);
//    NSLog(@"%.2f, %.2f, %.2f, %.2f", diff, extendedStatusBar, view.window.frame.size.height, view.bounds.size.height);
    
    return statusBarHeight;
}


@implementation TLYShyStatusBarController

- (CGFloat)_statusBarHeight
{
    CGFloat statusBarHeight = AACStatusBarHeight(self.viewController);
    NSLog(@"%.2f", statusBarHeight);
    
    return statusBarHeight;
}

- (CGFloat)maxYRelativeToView:(UIView *)superview
{
    return [self _statusBarHeight];
}

- (CGFloat)calculateTotalHeightRecursively
{
    return [self _statusBarHeight];
}

@end

