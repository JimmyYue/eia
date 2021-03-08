//
//  WorkModel.h
//  eia
//
//  Created by JimmyYue on 2020/5/14.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkModel : NSObject
@property (nonatomic, strong) NSString *enterpriseName;  // 企业名称
@property (nonatomic, strong) NSString *provinceName;  // 省
@property (nonatomic, strong) NSString *cityName;  // 市
@property (nonatomic, strong) NSString *regionName;  // 区
@property (nonatomic, strong) NSString *streetName;  // 街道
@property (nonatomic, strong) NSString *lastUpdateName;  // 最后更新人
@property (nonatomic, strong) NSString *lastUpdateTime;
@property (nonatomic, strong) NSString *NewTourPlanTime; // 最近巡查时间
@property (nonatomic, strong) NSString *cpyObjAddress;  
@property (nonatomic, strong) NSString *parkName;  // 园区
@property (nonatomic, strong) NSString *summaryEia;
@property (nonatomic, strong) NSString *Id; // id
@property (nonatomic, strong) NSString *flagMake;

@property (nonatomic, strong) NSString *tourPlanId; // tourPlanId
@property (nonatomic, strong) NSString *tourPlanStatus;

@property (nonatomic, strong) NSString *planId; // 计划编辑修改id
@end

NS_ASSUME_NONNULL_END
