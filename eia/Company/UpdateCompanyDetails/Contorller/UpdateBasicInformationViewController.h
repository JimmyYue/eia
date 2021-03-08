//
//  UpdateBasicInformationViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicTopChooseEnterpriseView.h"
#import "NoProductionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateBasicInformationViewController : InheritanceViewController

@property(nonatomic, strong) NSMutableDictionary *dicDetail;
@property(nonatomic, strong) BasicTopChooseEnterpriseView *basicTopChooseEnterpriseView;
@property(nonatomic, strong) NoProductionView *noProductionView;
@property (nonatomic,copy)void (^reloadBlock)(NSString *type);
@end

NS_ASSUME_NONNULL_END
