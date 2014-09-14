//
//  MapViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "MapViewController.h"
#import "WorkAreaViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "Constants.h"
#import "WorkAreaViewController.h"
#import "NotamViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) GMSCameraPosition *portugal;
@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, strong) NSString *ICAO;

//CONTINENTE
@property (nonatomic, strong) GMSMarker *LPPR;
@property (nonatomic, strong) GMSMarker *LPOV;
@property (nonatomic, strong) GMSMarker *LPMR;
@property (nonatomic, strong) GMSMarker *LPST;
@property (nonatomic, strong) GMSMarker *LPPT;
@property (nonatomic, strong) GMSMarker *LPMT;
@property (nonatomic, strong) GMSMarker *LPBJ;
@property (nonatomic, strong) GMSMarker *LPFR;

//AÇORES
@property (nonatomic, strong) GMSMarker *LPFL;
@property (nonatomic, strong) GMSMarker *LPHR;
@property (nonatomic, strong) GMSMarker *LPLA;
@property (nonatomic, strong) GMSMarker *LPPD;
@property (nonatomic, strong) GMSMarker *LPAZ;

//MADEIRA
@property (nonatomic, strong) GMSMarker *LPPS;
@property (nonatomic, strong) GMSMarker *LPMA;

@end


@implementation MapViewController{
    
    
    DetailViewController *detailViewController;
    
    WorkAreaViewController *workAreaViewController;
    NotamViewController * notamViewController;
    
  /*  CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    */

}

@synthesize mapView_;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"HELOOOOOOOOOOOOOOOOOOOOOO MAPS");
    
 /*  /////////////

    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    /////////// */
    
    
    // CREATE CAMERA POSITION PORTUGAL
    _portugal = [GMSCameraPosition cameraWithLatitude:39.55799468673596 longitude:-8.09417724609375 zoom:6.55];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, kDeviceWidth, (IS_WIDESCREEN? (kDeviceHeight+88):kDeviceHeight)) camera:_portugal];
    
    
    
    [self.view addSubview:mapView_];
    mapView_.accessibilityElementsHidden = YES;
    mapView_.delegate = self;
    
    //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    [mapView_ addSubview:button];
    
    //BTN PT
    UIButton *buttonPT = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPT.frame = CGRectMake(222, (IS_WIDESCREEN? (433+88):433), 48, 48);
    [buttonPT setImage:[UIImage imageNamed:kLockPT] forState:UIControlStateNormal];
    [buttonPT setImage:[UIImage imageNamed:kLockPT] forState:UIControlStateHighlighted];
    [buttonPT addTarget:self action:@selector(reloadPT) forControlEvents:UIControlEventTouchUpInside];
    [mapView_ addSubview:buttonPT];
    
    //BTN NOTAM
    UIButton *buttonNO = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonNO.frame = CGRectMake(170, (IS_WIDESCREEN? (433+88):433), 48, 48);
    [buttonNO setImage:[UIImage imageNamed:@"warn_48.png"] forState:UIControlStateNormal];
    [buttonNO setImage:[UIImage imageNamed:@"warn_48.png"] forState:UIControlStateHighlighted];
    [buttonNO addTarget:self action:@selector(notam) forControlEvents:UIControlEventTouchUpInside];
    [mapView_ addSubview:buttonNO];


    // ENABLE LOCALIZATION
    mapView_.myLocationEnabled = YES;
    
    // COMPASS
    mapView_.settings.compassButton = YES;
    
    
    // VIEW ANGLE 5
    [mapView_ animateToViewingAngle:5];
  
    // BLOCK/ALLOW TOUCHES
    mapView_.settings.scrollGestures = YES;
    mapView_.settings.zoomGestures = YES;
    mapView_.settings.rotateGestures = YES;
    
    // MAX ZOOM
    [mapView_ setMinZoom:6.55 maxZoom:9];

    
    // DEGREES ICON
    CLLocationDegrees degrees = kIconDegrees;
    
    //CONTINENTE
    // LPPR/OPO MARKER
    _LPPR = [[GMSMarker alloc] init];
    _LPPR.position = CLLocationCoordinate2DMake(41.247876052019656, -8.681130409240723);
    _LPPR.groundAnchor = CGPointMake(0.5, 0.5);
    _LPPR.rotation = degrees;
    _LPPR.title = @"LPPR";
    _LPPR.snippet = kMoreInfo @" ABOUT OPORTO";
    _LPPR.icon = [UIImage imageNamed:kInfoImage];
    _LPPR.map = mapView_;
    
    // LPOV/OVAR MARKER
    _LPOV = [[GMSMarker alloc] init];
    _LPOV.position = CLLocationCoordinate2DMake(40.91442368062171, -8.645789623260498);
    _LPOV.groundAnchor = CGPointMake(0.5, 0.5);
    _LPOV.rotation = degrees;
    _LPOV.title = @"LPOV";
    _LPOV.snippet = kMoreInfo @" ABOUT OVAR";
    _LPOV.icon = [UIImage imageNamed:kInfoImage];
    _LPOV.map = mapView_;
    
    // LPMR/MONTE REAL MARKER
    _LPMR = [[GMSMarker alloc] init];
    _LPMR.position = CLLocationCoordinate2DMake(39.83003338287204, -8.887295722961426);
    _LPMR.groundAnchor = CGPointMake(0.5, 0.5);
    _LPMR.rotation = degrees;
    _LPMR.title = @"LPMR";
    _LPMR.snippet = kMoreInfo @" ABOUT MONTE REAL";
    _LPMR.icon = [UIImage imageNamed:kInfoImage];
    _LPMR.map = mapView_;
    
    // LPST/SINTRA MARKER
    _LPST = [[GMSMarker alloc] init];
    _LPST.position = CLLocationCoordinate2DMake(38.830143087159975, -9.338778555393219);
    _LPST.groundAnchor = CGPointMake(0.5, 0.5);
    _LPST.rotation = degrees;
    _LPST.title = @"LPST";
    _LPST.snippet = kMoreInfo @" ABOUT SINTRA";
    _LPST.icon = [UIImage imageNamed:kInfoImage];
    _LPST.map = mapView_;
    
    // LPPT/LIS MARKER
    _LPPT = [[GMSMarker alloc] init];
    _LPPT.position = CLLocationCoordinate2DMake(38.776314514821486, -9.13538932800293);
    _LPPT.groundAnchor = CGPointMake(0.5, 0.5);
    _LPPT.rotation = degrees;
    _LPPT.title = @"LPPT";
    _LPPT.snippet = kMoreInfo @" ABOUT LISBOA";
    _LPPT.icon = [UIImage imageNamed:kInfoImage];
    _LPPT.map = mapView_;
    
    // LPMT/MONTIJO MARKER
    _LPMT = [[GMSMarker alloc] init];
    _LPMT.position = CLLocationCoordinate2DMake(38.707851823694746, -9.037102460861206);
    _LPMT.groundAnchor = CGPointMake(0.5, 0.5);
    _LPMT.rotation = degrees;
    _LPMT.title = @"LPMT";
    _LPMT.snippet = kMoreInfo @" ABOUT MONTIJO";
    _LPMT.icon = [UIImage imageNamed:kInfoImage];
    _LPMT.map = mapView_;
    
    // LPBJ/BEJA MARKER
    _LPBJ = [[GMSMarker alloc] init];
    _LPBJ.position = CLLocationCoordinate2DMake(38.07878948204652, -7.9312169551849365);
    _LPBJ.groundAnchor = CGPointMake(0.5, 0.5);
    _LPBJ.rotation = degrees;
    _LPBJ.title = @"LPBJ";
    _LPBJ.snippet = kMoreInfo @" ABOUT BEJA";
    _LPBJ.icon = [UIImage imageNamed:kInfoImage];
    _LPBJ.map = mapView_;
    
    // LPFR/FRO MARKER
    _LPFR = [[GMSMarker alloc] init];
    _LPFR.position = CLLocationCoordinate2DMake(37.01514840349742, -7.972007989883423);
    _LPFR.groundAnchor = CGPointMake(0.5, 0.5);
    _LPFR.rotation = degrees;
    _LPFR.title = @"LPFR";
    _LPFR.snippet = kMoreInfo @" ABOUT FARO";
    _LPFR.icon = [UIImage imageNamed:kInfoImage];
    _LPFR.map = mapView_;
    
    //ILHAS AÇORES
    // LPFL/FLORES MARKER ???
    _LPFL = [[GMSMarker alloc] init];
    _LPFL.position = CLLocationCoordinate2DMake(39.45600294234457, -31.131506860256195);
    _LPFL.groundAnchor = CGPointMake(0.5, 0.5);
    _LPFL.rotation = degrees;
    _LPFL.title = @"LPFL";
    _LPFL.snippet = kMoreInfo @" ABOUT FLORES";
    _LPFL.icon = [UIImage imageNamed:kInfoImage];
    _LPFL.map = mapView_;
    
    // LPHR/HORTA MARKER ???
    _LPHR = [[GMSMarker alloc] init];
    _LPHR.position = CLLocationCoordinate2DMake(38.51999258595457, -28.716099858283997);
    _LPHR.groundAnchor = CGPointMake(0.5, 0.5);
    _LPHR.rotation = degrees;
    _LPHR.title = @"LPHR";
    _LPHR.snippet = kMoreInfo @" ABOUT HORTA";
    _LPHR.icon = [UIImage imageNamed:kInfoImage];
    _LPHR.map = mapView_;
    
    // LPLA/TERCEIRA MARKER ???
    _LPLA = [[GMSMarker alloc] init];
    _LPLA.position = CLLocationCoordinate2DMake(38.770617243598046, -27.099902629852295);
    _LPLA.groundAnchor = CGPointMake(0.5, 0.5);
    _LPLA.rotation = degrees;
    _LPLA.title = @"LPLA";
    _LPLA.snippet = kMoreInfo @" ABOUT TERCEIRA";
    _LPLA.icon = [UIImage imageNamed:kInfoImage];
    _LPLA.map = mapView_;
    
    // LPPD/PONTA DELGADA MARKER ???
    _LPPD = [[GMSMarker alloc] init];
    _LPPD.position = CLLocationCoordinate2DMake(37.74225086628369, -25.698587894439697);
    _LPPD.groundAnchor = CGPointMake(0.5, 0.5);
    _LPPD.rotation = degrees;
    _LPPD.title = @"LPPD";
    _LPPD.snippet = kMoreInfo @" ABOUT PONTA DELGADA";
    _LPPD.icon = [UIImage imageNamed:kInfoImage];
    _LPPD.map = mapView_;
    
    // LPAZ/LAGES MARKER ???
    _LPAZ = [[GMSMarker alloc] init];
    _LPAZ.position = CLLocationCoordinate2DMake(36.97180557169191, -25.1706326007843);
    _LPAZ.groundAnchor = CGPointMake(0.5, 0.5);
    _LPAZ.rotation = degrees;
    _LPAZ.title = @"LPAZ";
    _LPAZ.snippet = kMoreInfo @" ABOUT LAGES";
    _LPAZ.icon = [UIImage imageNamed:kInfoImage];
    _LPAZ.map = mapView_;
    
    //ILHAS MADEIRA
    // LPPS/PORTO SANTO DELGADA MARKER ???
    _LPPS = [[GMSMarker alloc] init];
    _LPPS.position = CLLocationCoordinate2DMake(33.07518243930151, -16.350027322769165);
    _LPPS.groundAnchor = CGPointMake(0.5, 0.5);
    _LPPS.rotation = degrees;
    _LPPS.title = @"LPPS";
    _LPPS.snippet = kMoreInfo @" ABOUT PORTO SANTO";
    _LPPS.icon = [UIImage imageNamed:kInfoImage];
    _LPPS.map = mapView_;
    
    // LPMA/FUNCHAL SANTO DELGADA MARKER ???
    _LPMA = [[GMSMarker alloc] init];
    _LPMA.position = CLLocationCoordinate2DMake(32.69286322131424, -16.779459714889526);
    _LPMA.groundAnchor = CGPointMake(0.5, 0.5);
    _LPMA.rotation = degrees;
    _LPMA.title = @"LPMA";
    _LPMA.snippet = kMoreInfo @" ABOUT FUNCHAL";
    _LPMA.icon = [UIImage imageNamed:kInfoImage];
    _LPMA.map = mapView_;
    
  /*  //PATH MADEIRA
    GMSMutablePath *pathMadeira = [GMSMutablePath path];
    [pathMadeira addCoordinate:CLLocationCoordinate2DMake(38.69344902828285, -9.20565515756607)];
    [pathMadeira addCoordinate:CLLocationCoordinate2DMake(33.211547336980104, -16.16363525390625)];
    
    GMSPolyline *wayMadeira = [GMSPolyline polylineWithPath:pathMadeira];
    wayMadeira.strokeColor = [UIColor redColor];
    wayMadeira.strokeWidth = 5;
    wayMadeira.geodesic = YES;
    wayMadeira.map = mapView_;
    
    //RECTANGLE MADEIRA
    GMSMutablePath *rectMadeira = [GMSMutablePath path];
    [rectMadeira addCoordinate:CLLocationCoordinate2DMake(33.211547336980104, -16.16363525390625)];
    [rectMadeira addCoordinate:CLLocationCoordinate2DMake(32.27827991674521, -16.16363525390625)];
    [rectMadeira addCoordinate:CLLocationCoordinate2DMake(32.27827991674521, -17.50396728515625)];
    [rectMadeira addCoordinate:CLLocationCoordinate2DMake(33.211547336980104, -17.50396728515625)];
    
    // Create the polygon, and assign it to the map.
    GMSPolygon *polyMadeira = [GMSPolygon polygonWithPath:rectMadeira];
    polyMadeira.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    polyMadeira.strokeColor = [UIColor redColor];
    polyMadeira.strokeWidth = 5;
    polyMadeira.map = mapView_;
   */
    
    
  /*  //PATH AÇORES
    GMSMutablePath *pathAcores = [GMSMutablePath path];
    [pathAcores addCoordinate:CLLocationCoordinate2DMake(38.69344902828285, -9.20565515756607)];
    [pathAcores addCoordinate:CLLocationCoordinate2DMake(39.40383605302325, -23.411865234375)];
    
    GMSPolyline *wayAcores = [GMSPolyline polylineWithPath:pathAcores];
    wayAcores.strokeColor = [UIColor greenColor];
    wayAcores.strokeWidth = 5;
    wayAcores.geodesic = YES;
    wayAcores.map = mapView_;
    
    //RECTANGLE AÇORES
    //RECTANGLE MADEIRA
    GMSMutablePath *rectAcores = [GMSMutablePath path];
    [rectAcores addCoordinate:CLLocationCoordinate2DMake(39.40383605302325, -23.411865234375)];
    [rectAcores addCoordinate:CLLocationCoordinate2DMake(36.80529889676483, -23.411865234375)];
    [rectAcores addCoordinate:CLLocationCoordinate2DMake(36.80529889676483, -31.959228515625)];
    [rectAcores addCoordinate:CLLocationCoordinate2DMake(40.046014541872594, -31.959228515625)];
    
    // Create the polygon, and assign it to the map.
    GMSPolygon *polyAcores = [GMSPolygon polygonWithPath:rectAcores];
    polyAcores.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    polyAcores.strokeColor = [UIColor greenColor];
    polyAcores.strokeWidth = 5;
    polyAcores.map = mapView_; */
    
    //AJUSTES
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(blockScroll) userInfo:nil repeats:YES];
    
    
 

}

/*- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString*TEST = [NSString stringWithFormat:@"%@",placemark.country];
            NSLog(@"%@",TEST);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    
    
} */


-(void) blockScroll{
    
    //[mapView_ animateToCameraPosition:portugal];
    //[mapView_ animateToZoom:6.8];
    
    
}

-(void) notam {

    notamViewController = [[NotamViewController alloc] init];
    
    
    notamViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        notamViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:notamViewController.view];

}

-(void) reloadPT{
    [mapView_ animateToCameraPosition:_portugal];
    
}
-(void) backToWork{

    //[mapView_ removeFromSuperview];
    
    [UIView animateWithDuration:0.4
                     animations:^{mapView_.alpha = 0.0;}
                     completion:^(BOOL finished){ [mapView_ removeFromSuperview]; }];
    
    [UIView animateWithDuration:0.4
                     animations:^{self.view.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view removeFromSuperview]; }];
    
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    _ICAO = marker.title;
    NSLog(@"%@", _ICAO);
    
   detailViewController = [[DetailViewController alloc] init];
    
    detailViewController.ICAO = marker.title;
  
    detailViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        detailViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:detailViewController.view];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
