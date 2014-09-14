//
//  MapViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkAreaViewController.h"
#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController<GMSMapViewDelegate/*, CLLocationManagerDelegate*/> {

    GMSMapView * mapView_;
    
}

@property (nonatomic, retain) GMSMapView * mapView_;

@end
