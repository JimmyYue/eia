//
//  MapViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <CoreLocation/CoreLocation.h>
#import "BaiDuPOIResultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKSuggestionSearchDelegate, CLLocationManagerDelegate, BMKPoiSearchDelegate, UITextFieldDelegate, BaiDuPOIResultViewDelegate>
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currLocation;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, strong) NSString *locationCity;
@property (strong, nonatomic) BMKMapView *mapView;
@property (nonatomic, strong) BMKPOICitySearchOption *cityOption;
@property (nonatomic, strong) BMKPoiSearch *poiSearch;
@property (nonatomic, strong) BaiDuPOIResultView *baiDuPOIResultView;
@property (nonatomic, assign) BOOL location;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSString *latitudeStr;
@property (nonatomic, strong) NSString *longitudeStr;
@property (nonatomic, strong) NSString *locationAlias; // 地址别名
@property (nonatomic, strong) NSString *detailAddress; // 详细地址
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *regionName;
@property (nonatomic, assign) int totalPageNum;
@property (nonatomic, strong) UIView *viewMapTop;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic,copy)void (^block)(NSString *latitude, NSString *longitude);
@end

NS_ASSUME_NONNULL_END
