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
    
    if ([UIApplication sharedApplication].statusBarHidden) return 0.f;
    if (viewController.presentingViewController.presentedViewController == viewController) return 0;
    if (view.window.frame.size.height == 0) return [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat diff                = [view.superview convertPoint:CGPointZero toView:view.window].y;
    CGFloat statusBarHeight     = diff > 0 ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;

    return statusBarHeight;
}


@implementation TLYShyStatusBarController

- (CGFloat)_statusBarHeight
{
    CGFloat statusBarHeight = AACStatusBarHeight(self.viewController);
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

