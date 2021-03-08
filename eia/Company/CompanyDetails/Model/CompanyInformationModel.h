//
//  CompanyInformationModel.h
//  eia
//
//  Created by JimmyYue on 2020/5/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyInformationModel : NSObject
@property (nonatomic, strong) NSString *createName;  // 创建人
@property (nonatomic, strong) NSString *createTime;  // 时间
@property (nonatomic, strong) NSString *content;  // 检查
@end

NS_ASSUME_NONNULL_END
