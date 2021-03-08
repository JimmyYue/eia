//
//  WorkModel.m
//  eia
//
//  Created by JimmyYue on 2020/5/14.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "WorkModel.h"

@implementation WorkModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"lastUpdateTime"]){
        self.lastUpdateTime = value;
    }
    if ([key isEqualToString:@"newTourPlanTime"]){
        self.NewTourPlanTime = value;
    }
    if ([key isEqualToString:@"lastUpdateName"]){
           self.lastUpdateName = value;
    }
    if ([key isEqualToString:@"provinceName"]){
        self.provinceName = value;
    }
    if ([key isEqualToString:@"cityName"]){
        self.cityName = value;
    }
    if ([key isEqualToString:@"regionName"]){
        self.regionName = value;
    }
    if ([key isEqualToString:@"streetName"]){
        self.streetName = value;
    }
    if ([key isEqualToString:@"cpyObjAddress"]){
        self.cpyObjAddress = value;
    }
    if ([key isEqualToString:@"parkName"]){
        self.parkName = value;
    }
    if ([key isEqualToString:@"summaryEia"]){
        self.summaryEia = value;
    }
    if ([key isEqualToString:@"id"]){
        self.Id = value;
    }
    if ([key isEqualToString:@"flagMake"]){
        self.flagMake = value;
    }
    if ([key isEqualToString:@"tourPlanId"]){
        self.tourPlanId = value;
    }
    if ([key isEqualToString:@"tourPlanStatus"]){
        self.tourPlanStatus = value;
    }
    if ([key isEqualToString:@"id"]){
        self.planId = value;
    }
}
@end
