//
//  MapViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setLocationManager {

    NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:annArray];

    self.location = NO;
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {

        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc]init];
            // 设置距离筛选器
            self.locationManager.distanceFilter = 10;
            // 设置定位精度
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            self.locationManager.delegate = self;

            if ([[[UIDevice currentDevice] systemVersion]floatValue]>= 8.0) {
                if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [self.locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
                }
                [self.locationManager startUpdatingLocation];
            } else {    // 始终允许访问
                [self.locationManager startUpdatingLocation];
            }
        }
        [_locationManager startUpdatingLocation];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请开启定位服务!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                   if ([[UIApplication sharedApplication] canOpenURL:url]) {
                       [[UIApplication sharedApplication] openURL:url];
                   }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    }
}

//  定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currLocation = [locations lastObject];

    // 位置反编码
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:self.currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
            NSLog(@"error:%@", error);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定位失败, 请检查网络与定位权限是否开启!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:YES completion:^{ }];
        }else {

            self.placemark=[placemarks firstObject];

            if (self.location == NO) {

                self.locationCity = self.placemark.locality;  // 定位城市

                self.location = YES;  // 因定位方法重复调用多次 用此字段限制重复请求数据

                CLLocationCoordinate2D coor;
                coor.latitude = self.currLocation.coordinate.latitude;
                coor.longitude = self.currLocation.coordinate.longitude;
                [self.mapView setCenterCoordinate:coor animated:NO];
                
                self.latitudeStr = [NSString stringWithFormat:@"%f", self.currLocation.coordinate.latitude];
                self.longitudeStr = [NSString stringWithFormat:@"%f", self.currLocation.coordinate.longitude];

                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
                annotation.coordinate = coor;
                annotation.title = @"";
                [self.mapView addAnnotation:annotation];
            }
        }
    }];

    if (self.currLocation != nil) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPOISearchResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.totalPageNum = [[NSString stringWithFormat:@"%ld", (long)poiResult.totalPageNum] intValue];

        _baiDuPOIResultView.hidden = NO;
        if (_pageIndex == 0) {
            _resultArray = [NSMutableArray arrayWithArray:poiResult.poiInfoList];
        } else {
            [_resultArray addObjectsFromArray:poiResult.poiInfoList];
        }
        [_baiDuPOIResultView setLoadMoreData:_resultArray];

        NSLog(@"检索结果返回成功：%@", poiResult.poiInfoList);
        
        if (poiResult.poiInfoList.count > 0) {
            NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
            [self.mapView removeAnnotations:annArray];

            CLLocationCoordinate2D coor;
            coor.latitude = poiResult.poiInfoList[0].pt.latitude;
            coor.longitude = poiResult.poiInfoList[0].pt.longitude;
            [self.mapView setCenterCoordinate:coor animated:NO];
            
            self.latitudeStr = [NSString stringWithFormat:@"%f", poiResult.poiInfoList[0].pt.latitude];
            self.longitudeStr = [NSString stringWithFormat:@"%f", poiResult.poiInfoList[0].pt.longitude];

            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = coor;
            annotation.title = @"";
            [self.mapView addAnnotation:annotation];
        }
//        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
//            NSLog(@"名称 : %@------省 : %@------市 : %@------行政区域 : %@------地址信息 : %@------latitude : %f------longitude : %f", poiResult.poiInfoList[i].name, poiResult.poiInfoList[i].province, poiResult.poiInfoList[i].city, poiResult.poiInfoList[i].area, poiResult.poiInfoList[i].address, poiResult.poiInfoList[i].pt.latitude, poiResult.poiInfoList[i].pt.longitude);
//        }
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD) {
        NSLog(@"检索词有歧义");
    } else {
        NSLog(@"其他检索结果错误码相关处理");
    }
}

// Override  坐标点类型 样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        // 设置该标注点动画显示
        newAnnotationView.animatesDrop = NO;
        newAnnotationView.annotation= annotation;
        newAnnotationView.draggable = YES;  // 设置是否可以拖拽
        newAnnotationView.image = [UIImage imageNamed: @"home_mapR"];   // 把大头针换成别的图片
        newAnnotationView.canShowCallout = NO; //  关闭气泡弹出效果
        return newAnnotationView;
    }
    return nil;
}

//大头针显示在视图上时调用，在这里给大头针设置显示动画
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray<BMKAnnotationView *> *)views{
    for (BMKAnnotationView *view in views) {
        [self shakeToShow:view];
    }
}

- (void)shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;// 动画时间
    NSMutableArray *values = [NSMutableArray array];[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];// 这三个数字，我只研究了前两个，所以最后一个数字我还是按照它原来写1.0；前两个是控制view的大小的；
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {  // 长按移动坐标

    //  如果newState(新坐标等于4)为拖动后静止状态
    if (newState == 4) {
        // 设置转换的坐标会有一些偏差，具体可以再调节坐标的 (x, y) 值

        CGPoint dropPoint = CGPointMake(view.center.x, CGRectGetMaxY(view.frame));
        CLLocationCoordinate2D newCoordinate = [_mapView convertPoint:dropPoint toCoordinateFromView:view.superview];
        [view.annotation setCoordinate:newCoordinate];

        self.latitudeStr = [NSString stringWithFormat:@"%lf", newCoordinate.latitude];
        self.longitudeStr = [NSString stringWithFormat:@"%lf", newCoordinate.longitude];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, StatusRect, kDeviceWidth, kDeviceHeight - 250 - StatusRect)];
    self.mapView.delegate = self;  // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 17.0;
    self.mapView.minZoomLevel = 17.0;
    self.mapView.maxZoomLevel = 21.0;
    [self.view addSubview:self.mapView];
    
    for (UIView *view in self.mapView.subviews) {
            for (UIImageView *imageView in view.subviews) {
                NSLog(@"%@",imageView);
                static int a = 0;
                a ++;
                if (a == 4) {
                    [imageView removeFromSuperview];
                }
            }
        }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, StatusRect + 10, 60, 35);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    [cancelBtn.layer setCornerRadius:5.0];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:cancelBtn];
    
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame = CGRectMake(kDeviceWidth - 70, StatusRect + 10, 60, 35);
    [userBtn setTitle:@"使用" forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [userBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [userBtn.layer setCornerRadius:5.0];
    userBtn.backgroundColor = RGBCOLOR(24, 186, 77);
    userBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:userBtn];

    UIButton *btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReload.frame = CGRectMake(kDeviceWidth - 70, kDeviceHeight - 310, 50, 50);
    [btnReload setBackgroundImage:IMAGENAMED(@"home_loc") forState:UIControlStateNormal];
    [btnReload addTarget:self action:@selector(setLocationManager) forControlEvents:UIControlEventTouchUpInside];
    [btnReload.layer setCornerRadius:25.0];
    btnReload.backgroundColor = [UIColor whiteColor];
    btnReload.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:btnReload];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 180) / 2, btnReload.frame.origin.y + 10, 180, 40)];
    label.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:10.0];
    label.text = @"长按可拖动坐标位置!";
    [self.view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.hidden = YES;
    });

    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(10, self.mapView.frame.origin.y + self.mapView.frame.size.height + 15, kDeviceWidth - 20, 40)];
    self.searchText.textColor = [UIColor blackColor];
    self.searchText.font = [UIFont systemFontOfSize:14];
    self.searchText.backgroundColor = BackgroundBlack;
    [self.searchText.layer setMasksToBounds:YES];
    self.searchText.delegate = self;
    self.searchText.placeholder = @"搜索地点";
    self.searchText.returnKeyType = UIReturnKeySearch;  //变为搜索按钮
    [self.view addSubview:self.searchText];

    _baiDuPOIResultView = [[BaiDuPOIResultView alloc] initWithFrame:CGRectMake(0, self.searchText.frame.origin.y + self.searchText.frame.size.height + 10, kDeviceWidth, kDeviceHeight - (self.searchText.frame.origin.y + self.searchText.frame.size.height + 10))];
    [_baiDuPOIResultView setAllowBaiDuPOIResultView];
    _baiDuPOIResultView.delegate = self;
    _baiDuPOIResultView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baiDuPOIResultView];

    self.viewMapTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    self.viewMapTop.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewMapTop];

    //  防止百度地图偏移时造成视觉冲突
    [UIView animateWithDuration:1.5 animations:^{
        [self.viewMapTop setAlpha:0.0];  // 白色遮罩层 1.5秒透明化
    } completion:^(BOOL finished) {
        self.viewMapTop.hidden = YES;  // 隐藏遮罩层
    }];

    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    //初始化请求参数类BMKCitySearchOption的实例
    _cityOption = [[BMKPOICitySearchOption alloc] init];
    //区域数据返回限制，可选，为YES时，仅返回city对应区域内数据
    _cityOption.isCityLimit = YES;
    // POI检索结果详细程度
    _cityOption.scope = BMK_POI_SCOPE_BASIC_INFORMATION;
    //单次召回POI数量，默认为10条记录，最大返回20条
    _cityOption.pageSize = 20;
    
    self.searchText.text = self.searchStr;
    [self setAllowBMKPoiSearch];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    self.pageIndex = 0;
    [self setAllowBMKPoiSearch];
    [textField resignFirstResponder];
    return YES;
}

- (void)cancelBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userBtnAction {
    if ([IsBlankString isBlankString:self.latitudeStr] == NO && [IsBlankString isBlankString:self.longitudeStr] == NO) {
        self.block(self.latitudeStr, self.longitudeStr);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择位置坐标后使用!"];
    }
}

- (void)setAllowBMKPoiSearch {
    _cityOption.keyword = self.searchText.text;
    _cityOption.city = self.locationCity;
    //分页页码，默认为0，0代表第一页，1代表第二页，以此类推
    _cityOption.pageIndex = _pageIndex;
//    [_poiSearch poiSearchInCity:_cityOption];
    BOOL flag = [_poiSearch poiSearchInCity:_cityOption];
    if(flag) {
        NSLog(@"POI城市内检索成功");
    } else {
        NSLog(@"POI城市内检索失败");
    }
}

- (void)setLoadMoreData:(BaiDuPOIResultView *_Nonnull)view {
    if (_pageIndex == _totalPageNum) {
        [_baiDuPOIResultView.tableView.mj_footer endRefreshing];
        [SVProgressHUD showInfoWithStatus:@"暂无更多位置信息!"];
//        self.pageIndex = _pageIndex - 1;
    } else {
        self.pageIndex = _pageIndex + 1;
        [self setAllowBMKPoiSearch];
    }
}

- (void)setChooseAddress:(BaiDuPOIResultView *_Nonnull)view index:(NSInteger)index {
    
    BMKPoiInfo *poiInfoList = [[BMKPoiInfo alloc] init];
    poiInfoList = _resultArray[index];
    
    NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:annArray];

    CLLocationCoordinate2D coor;
    coor.latitude = poiInfoList.pt.latitude;
    coor.longitude = poiInfoList.pt.longitude;
    [self.mapView setCenterCoordinate:coor animated:NO];
    
    self.latitudeStr = [NSString stringWithFormat:@"%f", poiInfoList.pt.latitude];
    self.longitudeStr = [NSString stringWithFormat:@"%f", poiInfoList.pt.longitude];

    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    annotation.title = @"";
    [self.mapView addAnnotation:annotation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
