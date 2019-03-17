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
    
    UIView *view = viewController.view;
    CGRect frame = [view.superview convertRect:view.frame toView:view.window];
    
    return (frame.origin.y > 0) ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;
}


@implementation TLYShyStatusBarController

- (CGFloat)_statusBarHeight
{
    return AACStatusBarHeight(self.viewController);
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

