//
//  PatrolRecordTableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PatrolRecordTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *engageTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *resultsTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *resultsTextLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@end

NS_ASSUME_NONNULL_END
