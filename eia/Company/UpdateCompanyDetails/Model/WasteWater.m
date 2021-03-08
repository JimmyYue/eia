//
//  WasteWater.m
//  eia
//
//  Created by JimmyYue on 2020/8/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "WasteWater.h"

@implementation WasteWater
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"waterBelong"]){
        self.waterBelong = value;
    }
    if ([key isEqualToString:@"waterAmount"]){
        self.waterAmount = value;
    }
}
@end
