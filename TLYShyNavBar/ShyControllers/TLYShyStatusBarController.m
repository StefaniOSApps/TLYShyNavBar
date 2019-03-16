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
    if ([UIApplication sharedApplication].statusBarHidden) return 0.f;
    
    CGSize  statusBarSize   = [UIApplication sharedApplication].statusBarFrame.size;
    CGFloat statusBarHeight = statusBarSize.height;
    
    UIView *view = viewController.view;
    CGRect frame = [view.superview convertRect:view.frame toView:UIApplication.sharedApplication.delegate.window];
    
    return MAX(0, statusBarHeight - frame.origin.y);
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

