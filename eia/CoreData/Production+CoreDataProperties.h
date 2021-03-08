//
//  Production+CoreDataProperties.h
//  
//
//  Created by JimmyYue on 2020/6/5.
//
//

#import "Production+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Production (CoreDataProperties)

+ (NSFetchRequest<Production *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *data;

@end

NS_ASSUME_NONNULL_END
