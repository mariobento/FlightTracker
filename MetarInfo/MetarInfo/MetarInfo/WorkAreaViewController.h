//
//  WorkAreaViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlaneViewController.h"

@interface WorkAreaViewController : UIViewController <UINavigationControllerDelegate>{

   // MapViewController* mapViewController;
   // NSString *mapStatus;
   // NSString * setType;

}

//@property (nonatomic, retain) MapViewController* mapViewController;
//@property (nonatomic, retain) NSString* mapStatus;
//@property (nonatomic, retain) NSString* setType;

-(void)GoToCloud;

@end
