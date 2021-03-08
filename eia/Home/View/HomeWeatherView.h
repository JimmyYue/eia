//
//  HomeWeatherView.h
//  eia
//
//  Created by JimmyYue on 2020/9/17.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeWeatherView : UIView

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (strong, nonatomic) IBOutlet UILabel *nowTemperatureLabel;

@property (strong, nonatomic) IBOutlet UILabel *windLabel;

@property (strong, nonatomic) IBOutlet UILabel *adviceLabel;


@end

NS_ASSUME_NONNULL_END
