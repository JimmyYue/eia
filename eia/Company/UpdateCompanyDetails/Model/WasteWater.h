//
//  WasteWater.h
//  eia
//
//  Created by JimmyYue on 2020/8/6.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WasteWater : NSObject
@property (nonatomic, strong) NSString *waterBelong;  // 名称
@property (nonatomic, strong) NSString *waterAmount;  // 含量
@end

NS_ASSUME_NONNULL_END
