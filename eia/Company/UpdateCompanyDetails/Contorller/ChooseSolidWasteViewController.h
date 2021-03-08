//
//  ChooseSolidWasteViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/1.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseSolidWasteTableViewCell.h"
#import "ChooseIndustryClassificationView.h"
#import "SolidWaste.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseSolidWasteViewController : InheritanceViewController< UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *chooseText;
@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;
- (IBAction)chooseAction:(id)sender;

@property (nonatomic,copy)void (^block)(NSMutableArray *array);

@property (nonatomic, strong) NSMutableArray *arraySelected;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *arrayResult;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayChoose;

@end

NS_ASSUME_NONNULL_END
