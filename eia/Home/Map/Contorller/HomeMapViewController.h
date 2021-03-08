//
//  HomeMapViewController.h
//  eia
//
//  Created by JimmyYue on 2020/11/5.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <CoreLocation/CoreLocation.h>
#import "BaiDuPOIResultView.h"
#import "CommpanySearchViewController.h"
#import "ParkEnterprisesDetailViewController.h"
#import "EnterprisesDetailNoProductionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMapViewController : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate, CLLocationManagerDelegate, BMKPoiSearchDelegate, UITextFieldDelegate, BaiDuPOIResultViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *searchDic;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, assign) BOOL center;

@property (strong, nonatomic) BMKMapView *mapView;
@property (nonatomic, strong) UIView *viewMapTop;
@property (nonatomic, assign) CGFloat centerLongitude; // 地图中心点
@property (nonatomic, assign) CGFloat centerLatitude;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currLocation;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, assign) BOOL location; // 定位放置二次调用判断字段
@property (nonatomic, strong) NSMutableArray *arrayLocation;  // 坐标点数组
@property (nonatomic, strong) NSMutableArray *arrayChooseLocation; // 已看坐标点
@property (nonatomic, strong) NSString *coordinateType;
@property (nonatomic, assign) int annotationTag;
@property (nonatomic, strong) NSString *latitudeStr;
@property (nonatomic, strong) NSString *longitudeStr;

@end

NS_ASSUME_NONNULL_END
