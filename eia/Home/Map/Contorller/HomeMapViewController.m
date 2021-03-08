//
//  HomeMapViewController.m
//  eia
//
//  Created by JimmyYue on 2020/11/5.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "HomeMapViewController.h"

@interface HomeMapViewController ()

@end

@implementation HomeMapViewController

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
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
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

                self.location = YES;  // 因定位方法重复调用多次 用此字段限制重复请求数据

                CLLocationCoordinate2D coor;
                coor.latitude = self.currLocation.coordinate.latitude;
                coor.longitude = self.currLocation.coordinate.longitude;
                [self.mapView setCenterCoordinate:coor animated:NO];
                
                self.latitudeStr = [NSString stringWithFormat:@"%f", self.currLocation.coordinate.latitude];
                self.longitudeStr = [NSString stringWithFormat:@"%f", self.currLocation.coordinate.longitude];

//                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//                annotation.coordinate = coor;
//                annotation.title = @"";
//                [self.mapView addAnnotation:annotation];
            }
        }
    }];

    if (self.currLocation != nil) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusRect, kDeviceWidth, NavRect)];
    self.searchView.backgroundColor = TabbarBlack_S;
    [self.view addSubview:self.searchView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, NavRect - 43, 35, 36);
    [backBtn setImage:IMAGENAMED(@"public_white_back") forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:backBtn];
    
    self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(50, NavRect - 40, kDeviceWidth - 130, 30)];
    self.searchText.textColor = [UIColor blackColor];
    self.searchText.font = [UIFont systemFontOfSize:15];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.searchText.layer setMasksToBounds:YES];
    self.searchText.delegate = self;
    self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchText.placeholder = @"输入企业名称可快速查询";
    _searchText.returnKeyType = UIReturnKeySearch; //变为搜索按钮
    [self.searchText.layer setCornerRadius:8.0];
    [self.searchView addSubview:self.searchText];
    UIView *serviceChargeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    self.searchText.leftView = serviceChargeView;
    self.searchText.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageViewSearch = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 24, 24)];
    imageViewSearch.image = IMAGENAMED(@"search");
    [self.searchText addSubview:imageViewSearch];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, NavRect - 40, 30, 30);
    [btn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:btn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:IMAGENAMED(@"company_search") forState:UIControlStateNormal];
    [searchBtn setTitle:@"筛选" forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(self.searchText.frame.origin.x + self.searchText.frame.size.width + 10, self.searchText.frame.origin.y, 60, 30);
    [searchBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn.layer setCornerRadius:8.0];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn addTarget:self action:@selector(searchBtnSAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:searchBtn];
    
    UIView *mapViewB = [[UIView alloc] initWithFrame:CGRectMake(0, StatusRect + NavRect, kDeviceWidth, kDeviceHeight - NavRect - StatusRect)];
    mapViewB.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mapViewB];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - NavRect - StatusRect)];
    self.mapView.delegate = self;  // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 17.0;
    self.mapView.minZoomLevel = 15.0;
    self.mapView.maxZoomLevel = 21.0;
    [mapViewB addSubview:self.mapView];
    
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
    
    [self setLocationManager];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 80, kDeviceWidth, 80)];
    bottomView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    [self.view addSubview:bottomView];

    for (int i = 0; i < 3; i++) {
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 300) / 4 + (100 + (kDeviceWidth - 300) / 4) * i, 20, 100, 30)];
        locationLabel.backgroundColor = [UIColor whiteColor];
        locationLabel.font = [UIFont systemFontOfSize:15];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 12, 17)];
       
        if (i == 0) {
            locationLabel.text = @"       重大风险";
            locationLabel.textColor = RGBCOLOR(255, 0, 0);
            imageView.image = IMAGENAMED(@"red_L");
        } else if (i == 1) {
            locationLabel.text = @"       需要整改";
            locationLabel.textColor = RGBCOLOR(255, 161, 0);
            imageView.image = IMAGENAMED(@"yellow_L");
        } else if (i == 2) {
            locationLabel.text = @"       合规企业";
            locationLabel.textColor = RGBCOLOR(0, 157, 0);
            imageView.image = IMAGENAMED(@"green_L");
        }
        
        [bottomView addSubview:locationLabel];
        [locationLabel addSubview:imageView];
    }
    
    self.viewMapTop = [[UIView alloc] initWithFrame:CGRectMake(0, StatusRect + NavRect, kDeviceWidth, kDeviceHeight - NavRect - StatusRect)];
    self.viewMapTop.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewMapTop];

    //  防止百度地图偏移时造成视觉冲突
    [UIView animateWithDuration:1.5 animations:^{
        [self.viewMapTop setAlpha:0.0];  // 白色遮罩层 1.5秒透明化
    } completion:^(BOOL finished) {
        self.viewMapTop.hidden = YES;  // 隐藏遮罩层
    }];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [self searchBtnAction];
    [textField resignFirstResponder];
    return YES;
}

- (void)searchBtnAction {  // 查找
    if ([IsBlankString isBlankString:self.searchText.text] == NO) {
        self.center = YES;
        self.arrayLocation = [NSMutableArray array];
        [self setClearMapAnnotation];
        [self setMapNet];
    }
}

- (void)searchBtnSAction {  // 筛选
    CommpanySearchViewController *searchVC = [[CommpanySearchViewController alloc] init];
    searchVC.dicSearch = self.searchDic;
    [searchVC setBlock:^(NSMutableDictionary * _Nonnull dic) {
        if (dic.count > 0) {
            self.searchDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            if ([[self.searchDic allKeys] containsObject:@"parkName"]) {
                self.center = YES;
            }
        } else {
            self.searchDic = [NSMutableDictionary dictionary];
            self.center = NO;
        }
        self.arrayLocation = [NSMutableArray array];
        [self setClearMapAnnotation];
        [self setMapNet];
    }];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)setClearMapAnnotation {  // 清除地图坐标点
    NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:annArray];
}

// Override  坐标点类型 样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        // 设置该标注点动画显示
        newAnnotationView.animatesDrop = NO;
        newAnnotationView.tag = self.annotationTag;
        newAnnotationView.annotation= annotation;
        newAnnotationView.draggable = NO;  // 设置是否可以拖拽
        NSString *image;
        if ([self.coordinateType isEqualToString:@"red_L"]) {
            image = @"red_L";
        } else if ([self.coordinateType isEqualToString:@"yellow_L"]) {
            image = @"yellow_L";
        } else if ([self.coordinateType isEqualToString:@"green_L"]) {
            image = @"green_L";
        }
        
        newAnnotationView.image = [UIImage imageNamed:image];   // 把大头针换成别的图片
        newAnnotationView.canShowCallout = NO; //  关闭气泡弹出效果
        return newAnnotationView;
    }
    return  nil;
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

// 移动地图 获取中心点  地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self setMapNet];
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {  // 点击坐标
    if ([[NSString stringWithFormat:@"%@", self.arrayLocation[view.tag][@"flagMake"]] isEqualToString:@"make"]) {
        ParkEnterprisesDetailViewController *detailVC = [[ParkEnterprisesDetailViewController alloc] init];
        detailVC.Id = [NSString stringWithFormat:@"%@", self.arrayLocation[view.tag][@"id"]];
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        EnterprisesDetailNoProductionViewController *detailVC = [[EnterprisesDetailNoProductionViewController alloc] init];
        detailVC.Id = [NSString stringWithFormat:@"%@", self.arrayLocation[view.tag][@"id"]];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)setMapNet {
    
    //当前屏幕中心点的经纬度
    _centerLongitude = self.mapView.region.center.longitude;
    _centerLatitude = self.mapView.region.center.latitude;
    
    //当前屏幕显示范围的经纬度
    CLLocationDegrees pointssLongitudeDelta = self.mapView.region.span.longitudeDelta;
    CLLocationDegrees pointssLatitudeDelta = self.mapView.region.span.latitudeDelta;
    //  左上角
    NSString *leftUpLong = [NSString stringWithFormat:@"%f", _centerLongitude - pointssLongitudeDelta/2.0];
    NSString *leftUpLati = [NSString stringWithFormat:@"%f", _centerLatitude - pointssLatitudeDelta/2.0];
    //  右下角
    NSString *rightDownLong = [NSString stringWithFormat:@"%f",_centerLongitude + pointssLongitudeDelta/2.0];
    NSString *rightDownLati = [NSString stringWithFormat:@"%f",_centerLatitude + pointssLatitudeDelta/2.0];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.searchDic];
    NSMutableDictionary *dicS = [[NSMutableDictionary alloc] init];
    if ([IsBlankString isBlankString:self.searchText.text] == NO) {
        [dicS setObject:[XYCommon isCorrectNumber:self.searchText.text] forKey:@"keyword"];
    }
    
    [dicS setObject:dic forKey:@"entity"];
    [dicS setObject:@{@"longitude":leftUpLong, @"latitude":leftUpLati} forKey:@"leftDown"];
    [dicS setObject:@{@"longitude":rightDownLong, @"latitude":rightDownLati} forKey:@"rightUp"];
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/queryList") parameters:dicS view:nil completion:^(id result) {
    
        if ([result[@"isSuccess"] integerValue] == 1) {
            
            if (self.center == YES) {
                if ([result[@"result"] count] > 0) {
                    self.center = NO;
                    CLLocationCoordinate2D coor;
                    coor.latitude = [result[@"result"][0][@"latitude"] doubleValue];
                    coor.longitude = [result[@"result"][0][@"longitude"] doubleValue];
                    [self.mapView setCenterCoordinate:coor animated:NO];
                }
            }
            
            if (self.arrayLocation.count > 2000) {
                self.arrayLocation = [NSMutableArray array];
                [self setClearMapAnnotation];
            }  // 如果数据量大于2000个时 清除地图现有坐标点与数据 防止卡顿
            
            NSMutableArray *arrayLocationResult = [[NSMutableArray alloc] init];
            arrayLocationResult = result[@"result"];
            
            NSInteger tag = self.arrayLocation.count;  // 新增坐标点的tag起始值
            
            NSMutableArray *arrayAddLocation = [[NSMutableArray alloc] init];
            for (int i = 0; i < arrayLocationResult.count; i++) {
                BOOL isbool = [self.arrayLocation containsObject:arrayLocationResult[i]];
                if (isbool == NO) {  // 去除重复坐标点数据
                    [self.arrayLocation addObject:arrayLocationResult[i]];  // 向原有数据数组添加新数据
                    [arrayAddLocation addObject:arrayLocationResult[i]];  // 添加新数据到数组中
                }
            }
            
            for (int i = 0; i < arrayAddLocation.count; i++) {
                CLLocationCoordinate2D coor;
                coor.latitude = [arrayAddLocation[i][@"latitude"] doubleValue];
                coor.longitude = [arrayAddLocation[i][@"longitude"] doubleValue];
                self.annotationTag = i + [[NSString stringWithFormat:@"%ld", (long)tag] intValue];
                if ([[NSString stringWithFormat:@"%@", arrayAddLocation[i][@"resultsType"]] isEqualToString:@"normal"]) {
                    self.coordinateType = @"green_L";
                } else if ([[NSString stringWithFormat:@"%@", arrayAddLocation[i][@"resultsType"]] isEqualToString:@"focusEdit"]) {
                    self.coordinateType = @"yellow_L";
                } else {
                    self.coordinateType = @"red_L";
                }
                
                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];  // 创建坐标点
                annotation.coordinate = coor;
                annotation.title = @"";
                [self.mapView addAnnotation:annotation];
            }
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
