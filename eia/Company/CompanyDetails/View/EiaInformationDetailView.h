//
//  EiaInformationDetailView.h
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EiaInformationDetailView : UIView

@property (strong, nonatomic) IBOutlet UILabel *industryNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *eiaSortTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *eiaPaperTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *checkPaperTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *solidTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *dirtyNatureTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *dirtyLicenseTypeNameLabel;

- (void)setAllowEiaInformationDetailView:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
