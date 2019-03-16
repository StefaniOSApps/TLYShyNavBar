//
//  TLYShyStatusBarController.m
//  TLYShyNavBarDemo
//
//  Created by Mazyad Alabduljaleel on 11/13/15.
//  Copyright © 2015 Telly, Inc. All rights reserved.
//

#import "TLYShyStatusBarController.h"


// Thanks to SO user, MattDiPasquale
// http://stackoverflow.com/questions/12991935/how-to-programmatically-get-ios-status-bar-height/16598350#16598350

static inline CGFloat AACStatusBarHeight(UIViewController *viewController)
{
    if ([UIApplication sharedApplication].statusBarHidden)
    {
        return 0.f;
    }
    
    // Modal views do not overlap the status bar, so no allowance need be made for it
   
    CGSize  statusBarSize   = [UIApplication sharedApplication].statusBarFrame.size;
    CGFloat statusBarHeight = statusBarSize.height;
    
    UIView *view = viewController.view;
    CGRect frame = [view.superview convertRect:view.frame toView:view.window];
    
//    NSLog(@"frame %.2f", frame.origin.y);
    
    BOOL viewOverlapsStatusBar = frame.origin.y < statusBarHeight;
    
    if (!viewOverlapsStatusBar)
    {
        return 0.f;
    }
    
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

