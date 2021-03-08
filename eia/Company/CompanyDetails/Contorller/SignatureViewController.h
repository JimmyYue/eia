//
//  SignatureViewController.h
//  eia
//
//  Created by JimmyYue on 2020/9/9.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYDrawView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SignatureViewController : UIViewController

@property (strong, nonatomic) IBOutlet MYDrawView *drawView;

- (IBAction)clearAction:(id)sender;

- (IBAction)cancelBtnAction:(id)sender;

@property (strong, nonatomic) UIImage *image;

- (IBAction)sureBtnAction:(id)sender;

@property (nonatomic,copy)void (^block)(UIImage *image);

@end

NS_ASSUME_NONNULL_END
