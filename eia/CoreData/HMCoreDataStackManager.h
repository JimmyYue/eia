//
//  HMCoreDataStackManager.h
//  eia
//
//  Created by JimmyYue on 2020/6/5.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#define KXBCoreManagerInstance [HMCoreDataStackManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface HMCoreDataStackManager : NSObject

// 单例
+(HMCoreDataStackManager*)shareInstance;

// 管理对象上下文
@property(strong,nonatomic)NSManagedObjectContext *managerContenxt;

// 模型对象
@property(strong,nonatomic)NSManagedObjectModel *managerModel;

// 存储调度器
@property(strong,nonatomic)NSPersistentStoreCoordinator *maagerDinator;

// 保存数据的方法
-(void)save;

@end

NS_ASSUME_NONNULL_END
