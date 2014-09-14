//
//  LocationViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 09/01/14.
//  Copyright (c) 2014 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "GADBannerView.h"

@class GADBannerView, GADRequest;


@interface LocationViewController : UIViewController<GMSMapViewDelegate, CLLocationManagerDelegate, GADBannerViewDelegate, UINavigationControllerDelegate>{

    GMSMapView * mapView_;

    GADBannerView *bannerView_;
    
    GADBannerView *bannerViewTop;
    
    CLLocationManager * locationManager;
}

@property (nonatomic, retain) GMSMapView * mapView_;

@property (nonatomic, retain) CLLocationManager * locationManager;

@property (nonatomic, strong) GADBannerView* bannerView;
@property (nonatomic, strong) GADBannerView* bannerViewTop;

-(GADRequest *)createRequest;


@end
