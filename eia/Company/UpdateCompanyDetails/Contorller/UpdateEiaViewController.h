//
//  UpdateEiaViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EiaInformationView.h"
#import "ChooseIndustryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateEiaViewController : InheritanceViewController

@property(nonatomic, strong) NSMutableDictionary *dicDetail;
@property(nonatomic, strong) EiaInformationView *eiaInformationView;
@property (nonatomic,copy)void (^reloadBlock)(NSString *type);
@end

NS_ASSUME_NONNULL_END
