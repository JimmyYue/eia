//
//  SewageTableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/6/24.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SewageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *typeChooseBtn;

@property (strong, nonatomic) IBOutlet UITextField *contentText;


@end

NS_ASSUME_NONNULL_END
