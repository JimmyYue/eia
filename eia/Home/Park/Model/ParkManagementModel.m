//
//  ParkManagementModel.m
//  eia
//
//  Created by JimmyYue on 2020/5/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ParkManagementModel.h"

@implementation ParkManagementModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"parkName"]){
        self.parkName = value;
    }
    if ([key isEqualToString:@"id"]){
        self.Id = value;
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
    if ([key isEqualToString:@"lotTypeName"]){
        self.lotTypeName = value;
    }
}
@end
