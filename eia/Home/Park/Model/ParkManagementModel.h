//
//  ParkManagementModel.h
//  eia
//
//  Created by JimmyYue on 2020/5/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParkManagementModel : NSObject
@property (nonatomic, strong) NSString *parkName;  // 园区名
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *provinceName;  // 省
@property (nonatomic, strong) NSString *cityName;  // 市
@property (nonatomic, strong) NSString *regionName; // 区
@property (nonatomic, strong) NSString *streetName;  //  街道
@property (nonatomic, strong) NSString *lotTypeName; // 地块类型
@end

NS_ASSUME_NONNULL_END
