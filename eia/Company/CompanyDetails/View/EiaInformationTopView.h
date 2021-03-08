//
//  EiaInformationTopView.h
//  eia
//
//  Created by JimmyYue on 2020/4/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EiaInformationTopView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleFLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleSLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleTLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleFrLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleFiLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleSixLabel;

@property (weak, nonatomic) IBOutlet UIButton *dianFBtn;

@property (weak, nonatomic) IBOutlet UIButton *dianSBtn;

@property (weak, nonatomic) IBOutlet UIButton *dianTBtn;

@property (weak, nonatomic) IBOutlet UIButton *dianFrBtn;

@property (strong, nonatomic) IBOutlet UIButton *dianFiBtn;

@property (strong, nonatomic) IBOutlet UIButton *dianSixBtn;

@property (weak, nonatomic) IBOutlet UILabel *lineFLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineSLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineTLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineFrLabel;

@property (strong, nonatomic) IBOutlet UILabel *lineFiLabel;

@property (strong, nonatomic) IBOutlet UILabel *lineSixLabel;

@property (strong, nonatomic) IBOutlet UIButton *fBtn;
@property (strong, nonatomic) IBOutlet UIButton *sBtn;
@property (strong, nonatomic) IBOutlet UIButton *tBtn;
@property (strong, nonatomic) IBOutlet UIButton *frBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiBtn;
@property (strong, nonatomic) IBOutlet UIButton *sixBtn;

- (void)setFirstSelected;
- (void)setSecondSelected;
- (void)setThirdSelected;
- (void)setFourSelected;
- (void)setFiveSelected;
- (void)setSixSelected;


@end

NS_ASSUME_NONNULL_END
