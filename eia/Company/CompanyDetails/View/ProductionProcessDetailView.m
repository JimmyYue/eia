//
//  ProductionProcessDetailView.m
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ProductionProcessDetailView.h"

@implementation ProductionProcessDetailView

- (void)setAllowProductionProcessDetailView:(NSDictionary *)dic {
    
    NSString *productStr = [NSString stringWithFormat:@"%@", dic[@"sortExplain"]];
    NSDictionary *dicP = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect pRect = [productStr boundingRectWithSize:CGSizeMake(kDeviceWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicP context:nil];
    
    NSString *craftStr = [NSString stringWithFormat:@"%@", dic[@"craftExplain"]];
    CGRect cRect = [craftStr boundingRectWithSize:CGSizeMake(kDeviceWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicP context:nil];
    
    NSString *mainStr = [NSString stringWithFormat:@"%@", dic[@"mainDirt"]];
    CGRect mRect = [mainStr boundingRectWithSize:CGSizeMake(kDeviceWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicP context:nil];
    
    UIScrollView *productionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    productionScrollView.backgroundColor = BackgroundBlack;
    productionScrollView.contentSize = CGSizeMake(0, 150 + pRect.size.height + cRect.size.height + mRect.size.height);
    productionScrollView.bounces = NO;
    [self addSubview:productionScrollView];
    
    UILabel *titleFLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth - 10, 35)];
    titleFLabel.text = @"产品种类及规模";
    titleFLabel.textColor = [UIColor lightGrayColor];
    titleFLabel.textAlignment = NSTextAlignmentLeft;
    titleFLabel.font = [UIFont systemFontOfSize:16];
    [productionScrollView addSubview:titleFLabel];
    
    UILabel *lineF = [[UILabel alloc] initWithFrame:CGRectMake(0, titleFLabel.frame.origin.y + titleFLabel.frame.size.height + 10, kDeviceWidth, 1)];
    lineF.backgroundColor = RGBCOLOR(249, 249, 249);
    [productionScrollView addSubview:lineF];
    
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineF.frame.origin.y + lineF.frame.size.height + 10, kDeviceWidth - 20, pRect.size.height)];
    productLabel.numberOfLines = 0;
    if ([IsBlankString isBlankString:productStr] == NO) {
        productLabel.text = productStr;
    } else {
        productLabel.text = @"待补全";
    }
    productLabel.font = [UIFont systemFontOfSize:15];
    [productionScrollView addSubview:productLabel];
    
    
    
    
    UILabel *lineFs = [[UILabel alloc] initWithFrame:CGRectMake(0, productLabel.frame.origin.y + productLabel.frame.size.height + 10, kDeviceWidth, 10)];
    lineFs.backgroundColor = RGBCOLOR(249, 249, 249);
    [productionScrollView addSubview:lineFs];
    
    UILabel *titleSLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineFs.frame.origin.y + lineFs.frame.size.height + 10, kDeviceWidth - 10, 35)];
    titleSLabel.text = @"生产工艺流程";
    titleSLabel.textColor = [UIColor lightGrayColor];
    titleSLabel.textAlignment = NSTextAlignmentLeft;
    titleSLabel.font = [UIFont systemFontOfSize:16];
    [productionScrollView addSubview:titleSLabel];
    
    UILabel *lineS = [[UILabel alloc] initWithFrame:CGRectMake(0, titleSLabel.frame.origin.y + titleSLabel.frame.size.height + 10, kDeviceWidth, 1)];
    lineS.backgroundColor = RGBCOLOR(249, 249, 249);
    [productionScrollView addSubview:lineS];
    
    UILabel *processLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineS.frame.origin.y + lineS.frame.size.height + 10, kDeviceWidth - 20, cRect.size.height)];
    processLabel.numberOfLines = 0;
    if ([IsBlankString isBlankString:craftStr] == NO) {
        processLabel.text = craftStr;
    } else {
        processLabel.text = @"待补全";
    }
    processLabel.font = [UIFont systemFontOfSize:15];
    [productionScrollView addSubview:processLabel];
    
    
    
    
    UILabel *lineSs = [[UILabel alloc] initWithFrame:CGRectMake(0, processLabel.frame.origin.y + processLabel.frame.size.height + 10, kDeviceWidth, 10)];
    lineSs.backgroundColor = RGBCOLOR(249, 249, 249);
    [productionScrollView addSubview:lineSs];
    
    UILabel *titleTLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineSs.frame.origin.y + lineSs.frame.size.height + 10, kDeviceWidth - 10, 35)];
    titleTLabel.text = @"主要污染环节";
    titleTLabel.textColor = [UIColor lightGrayColor];
    titleTLabel.textAlignment = NSTextAlignmentLeft;
    titleTLabel.font = [UIFont systemFontOfSize:16];
    [productionScrollView addSubview:titleTLabel];
    
    UILabel *lineT = [[UILabel alloc] initWithFrame:CGRectMake(0, titleTLabel.frame.origin.y + titleTLabel.frame.size.height + 10, kDeviceWidth, 1)];
    lineT.backgroundColor = RGBCOLOR(249, 249, 249);
    [productionScrollView addSubview:lineT];
    
    UILabel *pollutionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineT.frame.origin.y + lineT.frame.size.height + 10, kDeviceWidth - 20, mRect.size.height)];
    pollutionLabel.numberOfLines = 0;
    if ([IsBlankString isBlankString:craftStr] == NO) {
        pollutionLabel.text = mainStr;
    } else {
        pollutionLabel.text = @"待补全";
    }
    pollutionLabel.font = [UIFont systemFontOfSize:15];
    [productionScrollView addSubview:pollutionLabel];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
