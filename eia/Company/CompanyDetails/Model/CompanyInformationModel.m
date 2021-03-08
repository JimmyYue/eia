//
//  CompanyInformationModel.m
//  eia
//
//  Created by JimmyYue on 2020/5/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "CompanyInformationModel.h"

@implementation CompanyInformationModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"createName"]){
        self.createName = value;
    }
    if ([key isEqualToString:@"createTime"]){
        self.createTime = value;
    }
    if ([key isEqualToString:@"newValue"]){
        self.content = value;
    }
}
@end
