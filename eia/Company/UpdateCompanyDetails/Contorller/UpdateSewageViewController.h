//
//  UpdateSewageViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SewageTableViewCell.h"
#import "BlowdownCircumstanceView.h"
#import "ChooseSewageViewController.h"
#import "ChooseSolidWasteViewController.h"
#import "WasteGas.h"
#import "WasteWater.h"
#import "SolidWaste.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateSewageViewController : InheritanceViewController< UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, XBTextViewDelegate>

@property (nonatomic,copy)void (^reloadBlock)(NSString *type);
@property(nonatomic, strong) NSMutableDictionary *dicDetail;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) BlowdownCircumstanceView *blowdownCircumstanceView;

@property (nonatomic, strong) NSMutableArray *arrayWasteGas;
@property (nonatomic, strong) NSMutableArray *arrayWasteWater;
@property (nonatomic, strong) NSMutableArray *arraySolidWaste;

@property (nonatomic, strong) NSMutableArray *arrayWasteGasResult;
@property (nonatomic, strong) NSMutableArray *arrayWasteWaterResult;
@property (nonatomic, strong) NSMutableArray *arraySolidWasteResult;
@property (nonatomic, strong) NSString *gasEffect;
@property (nonatomic, strong) NSString *waterEffect;
@property (nonatomic, strong) NSString *dangerEffect;

@property(nonatomic, strong) XBTextView *wasteGasText;
@property(nonatomic, strong) XBTextView *wasteWaterText;
@property(nonatomic, strong) XBTextView *wasteText;

@end

NS_ASSUME_NONNULL_END
