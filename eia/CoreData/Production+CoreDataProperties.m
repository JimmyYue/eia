//
//  Production+CoreDataProperties.m
//  
//
//  Created by JimmyYue on 2020/6/5.
//
//

#import "Production+CoreDataProperties.h"

@implementation Production (CoreDataProperties)

+ (NSFetchRequest<Production *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Production"];
}

@dynamic data;

@end
