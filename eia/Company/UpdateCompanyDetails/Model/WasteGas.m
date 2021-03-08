//
//  WasteGas.m
//  eia
//
//  Created by JimmyYue on 2020/8/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "WasteGas.h"

@implementation WasteGas
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"gasBelong"]){
        self.gasBelong = value;
    }
    if ([key isEqualToString:@"gasAmount"]){
        self.gasAmount = value;
    }
}
@end
