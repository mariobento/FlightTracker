//
//  UIViewController+Advanced.m
//  FiH
//
//  Created by Jose Teixeira on 9/5/13.
//
//

#import "UIViewController+Advanced.h"

@implementation UIViewController (Advanced)

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
    
}


@end
