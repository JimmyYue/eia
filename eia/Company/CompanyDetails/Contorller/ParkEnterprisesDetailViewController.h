//
//  ParkEnterprisesDetailViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EiaInformationTopView.h"
#import "ParkEnterprisesDetailBottomView.h"
#import "BasicInformationDetailView.h"
#import "EiaInformationDetailView.h"
#import "ProductionProcessDetailView.h"
#import "PollutionDetailView.h"
#import "ImageDetailHeaderView.h"
#import "PatrolRecordTableViewCell.h"
#import "PatrolDetailViewController.h"
#import "UpdateBasicInformationViewController.h"
#import "UpdateEiaViewController.h"
#import "UpdateSewageViewController.h"
#import "UpdateProductionViewController.h"
#import "UpdateImageViewController.h"
#import "AddPatrolViewController.h"
#import "PatrolRecordView.h"
#import "ImageInformationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParkEnterprisesDetailViewController : PageViewController<UIScrollViewDelegate>


@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) EiaInformationTopView *eiaInformationTopView;
@property (nonatomic, strong) UIScrollView *scrollViewAll;
@property (nonatomic, assign) int index;

@property (nonatomic, strong) UIScrollView *basicScrollView;
@property (nonatomic, strong) BasicInformationDetailView *basicInformationDetailView;

@property (nonatomic, strong) UIScrollView *eiaScrollView;
@property (nonatomic, strong) EiaInformationDetailView *eiaInformationDetailView;

@property (nonatomic, strong) ProductionProcessDetailView *productionProcessDetailView;

@property (nonatomic, strong) PollutionDetailView *pollutionDetailView;

@property (nonatomic, strong) ImageInformationView *imageInformationView;

@property (nonatomic, strong) PatrolRecordView *patrolRecordView;

@property(nonatomic, strong) NSMutableDictionary *dicDetail;

@end

NS_ASSUME_NONNULL_END
