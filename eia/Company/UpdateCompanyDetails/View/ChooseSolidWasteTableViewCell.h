//
//  ChooseSolidWasteTableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/7/1.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseSolidWasteTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *chooseImageBtn;

@property (strong, nonatomic) IBOutlet UILabel *classLabel;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;


@end

NS_ASSUME_NONNULL_END
