//
//  ProductionProcessDetailView.h
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductionProcessDetailView : UIView

- (void)setAllowProductionProcessDetailView:(NSDictionary *)dic;

@property (nonatomic, strong) NSString *productStr;
@property (nonatomic, strong) NSString *processStr;
@property (nonatomic, strong) NSString *pollutionStr;

@end

NS_ASSUME_NONNULL_END
