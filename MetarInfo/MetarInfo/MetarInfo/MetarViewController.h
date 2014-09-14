//
//  ViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "WorkAreaViewController.h"


@interface MetarViewController : UIViewController {
    
    IntroViewController *introViewController;
	WorkAreaViewController *workAreaViewController;

}

@property (nonatomic, retain) IntroViewController *introViewController;
@property (nonatomic, retain) WorkAreaViewController *workAreaViewController;

-(void)GoToWorkArea;

@end
