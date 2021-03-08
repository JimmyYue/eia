//
//  SolidWaste.m
//  eia
//
//  Created by JimmyYue on 2020/8/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "SolidWaste.h"

@implementation SolidWaste
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"dangerBelong"]){
        self.dangerBelong = value;
    }
    if ([key isEqualToString:@"dangerCode"]){
        self.dangerCode = value;
    }
}
@end
