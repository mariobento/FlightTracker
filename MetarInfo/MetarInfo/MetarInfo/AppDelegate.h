//
//  AppDelegate.h
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetarViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    
    MetarViewController *viewController;

}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MetarViewController *viewController;

-(void)GoToWorkArea;

@end
