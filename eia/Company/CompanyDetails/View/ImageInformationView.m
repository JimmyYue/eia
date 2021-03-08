//
//  ImageInformationView.m
//  eia
//
//  Created by JimmyYue on 2020/7/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ImageInformationView.h"

@implementation ImageInformationView

- (void)setUpdateImageInformationView:(NSDictionary *)dic {
    self.imageArray = [[NSMutableArray alloc] init];
    
    if ([[dic allKeys] containsObject:@"licenseFileList"]) {
        [self.imageArray addObject:dic[@"licenseFileList"]];
    } else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"eiaFileList"]) {
        [self.imageArray addObject:dic[@"eiaFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"checkFileList"]) {
        [self.imageArray addObject:dic[@"checkFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"planFileList"]) {
        [self.imageArray addObject:dic[@"planFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"emissionFileList"]) {
        [self.imageArray addObject:dic[@"emissionFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"workRoomFileList"]) {
        [self.imageArray addObject:dic[@"workRoomFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"processFileList"]) {
        [self.imageArray addObject:dic[@"processFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"otherLiveFileList"]) {
        [self.imageArray addObject:dic[@"otherLiveFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    [self.photoCollectionView reloadData];
}

- (void)setAllowImageInformationView:(NSDictionary *)dic {
    
    self.titleArray = @[@"营业执照类", @"环评", @"验收", @"应急预案", @"排污 (水) 许可证", @"危废车间照片", @"生产工艺及流程", @"其他现场照片"];
    self.imageArray = [[NSMutableArray alloc] init];
    
    if ([[dic allKeys] containsObject:@"licenseFileList"]) {
        [self.imageArray addObject:dic[@"licenseFileList"]];
    } else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"eiaFileList"]) {
        [self.imageArray addObject:dic[@"eiaFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"checkFileList"]) {
        [self.imageArray addObject:dic[@"checkFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"planFileList"]) {
        [self.imageArray addObject:dic[@"planFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"emissionFileList"]) {
        [self.imageArray addObject:dic[@"emissionFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"workRoomFileList"]) {
        [self.imageArray addObject:dic[@"workRoomFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"processFileList"]) {
        [self.imageArray addObject:dic[@"processFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    if ([[dic allKeys] containsObject:@"otherLiveFileList"]) {
        [self.imageArray addObject:dic[@"otherLiveFileList"]];
    }else {
        [self.imageArray addObject:@[]];
    }
    
    //默认打开第一个section
    _sectionStatus = [NSMutableArray arrayWithObjects:@1,@2,@2,@2,@2,@2,@2,@2, nil];
    //  UICollectionView 的使用
    UICollectionViewFlowLayout *flowlayoutS = [[UICollectionViewFlowLayout alloc] init];
    flowlayoutS.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayoutS.itemSize = CGSizeMake((self.frame.size.width - 50) / 4, (self.frame.size.width - 50) / 4);
    flowlayoutS.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowlayoutS];
    self.photoCollectionView.backgroundColor = BackgroundBlack;
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self addSubview: self.photoCollectionView];
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotographCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotographCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.imageArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_sectionStatus[section] isEqualToNumber:@3] || [_sectionStatus[section] isEqualToNumber:@2]) {
        return 0;
    }else {
        return [self.imageArray[section] count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indtifer = @"PhotographCollectionViewCell";
    PhotographCollectionViewCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:indtifer forIndexPath:indexPath];
    
    cell.chooseBtn.hidden = YES;
    [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?zoom=1.0", ImagePdfVideoFileUrl, _imageArray[indexPath.section][indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width - 50) / 4, (self.frame.size.width - 50) / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImagePreview *imagePreview = [[ImagePreview alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [imagePreview setImagePreview];
    [imagePreview setFileCode:[NSString stringWithFormat:@"%@", _imageArray[indexPath.section][indexPath.row]]];
}

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    return size;
}
 
// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
       UICollectionReusableView *reusableView = nil;
    
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
             [collectionView registerNib:[UINib nibWithNibName:@"ImageDetailHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ImageDetailHeaderView"];
            
            ImageDetailHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ImageDetailHeaderView" forIndexPath:indexPath];
            [headerView setAddUITapGestureRecognizer];
            headerView.backgroundColor = [UIColor lightTextColor];
            headerView.takingPicturesBtn.hidden = YES;
            headerView.titleLabel.text = self.titleArray[indexPath.section];
            headerView.countLabel.text = [NSString stringWithFormat:@"%lu张", (unsigned long)[self.imageArray[indexPath.section] count]];
            int status = [_sectionStatus[indexPath.section] intValue];
            [headerView updateWithStatus:status];
            __weak typeof (self)blockSelf = self;
            headerView.block =^{
                for (int i = 0; i < blockSelf.sectionStatus.count; i ++) {
                    if (i != indexPath.section ) {
                        if ([blockSelf.sectionStatus[i] isEqualToNumber:@1]) {
                            [blockSelf.sectionStatus replaceObjectAtIndex:i withObject:@2];//close others
                            [blockSelf.photoCollectionView reloadSections:[NSIndexSet indexSetWithIndex:i]];
                            break;
                        }
                    }
                }
                int status = [blockSelf.sectionStatus[indexPath.section] intValue];
                NSNumber *num = (status == 3 || status == 2 )? @1 :@2;
                [blockSelf.sectionStatus replaceObjectAtIndex:indexPath.section withObject:num];
                //重新加载当前区
                [blockSelf.photoCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            };
            
            reusableView = headerView;
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            // 底部视图
        }
        return reusableView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
