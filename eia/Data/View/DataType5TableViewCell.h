//
//  DataType5TableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataType5TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *showName;

@property (strong, nonatomic) IBOutlet UILabel *etpCount;

@property (strong, nonatomic) IBOutlet UILabel *etpRate;


@end

NS_ASSUME_NONNULL_END
