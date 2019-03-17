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
    if (viewController.presentingViewController.presentedViewController == viewController) return 0;
    
    UIView *view = viewController.view;
    CGFloat diff = [view.superview convertPoint:CGPointZero toView:view.window].y;
    /*
    NSLog(@"%.2f -- %.2f -- %.2f -- %.2f",
          diff,
          [view.superview convertRect:view.frame toView:view.window].origin.y,
          view.frame.origin.y,
          [view.superview convertRect:view.frame toView:UIApplication.sharedApplication.delegate.window].origin.y
          );
     */
    return diff > 0 ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;
}


@implementation TLYShyStatusBarController

- (CGFloat)_statusBarHeight
{
    CGFloat statusBarHeight = AACStatusBarHeight(self.viewController);
    if (statusBarHeight > 30)
    {
//        statusBarHeight -= 20;
    }
    
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

