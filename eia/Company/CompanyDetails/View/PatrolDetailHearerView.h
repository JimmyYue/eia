//
//  PatrolDetailHearerView.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PatrolDetailHearerView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *patrolPurposeLabel;

@property (strong, nonatomic) IBOutlet UILabel *engageTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *resultsTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *resultsTextLabel;

@property (strong, nonatomic) IBOutlet UILabel *lastUpdateNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *signatureImg;


@end

NS_ASSUME_NONNULL_END
