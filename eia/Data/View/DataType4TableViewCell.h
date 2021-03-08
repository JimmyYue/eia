//
//  DataType4TableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataType4TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *showName;

@property (strong, nonatomic) IBOutlet UILabel *over;

@property (strong, nonatomic) IBOutlet UILabel *notYet;

@property (strong, nonatomic) IBOutlet UILabel *process;

@property (strong, nonatomic) IBOutlet UILabel *notNeed;

@end

NS_ASSUME_NONNULL_END
