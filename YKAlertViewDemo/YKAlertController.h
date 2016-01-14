//
//  YKAlertController.h
//  Lunchtime
//
//  Created by qianzhan on 15/12/7.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAction : NSObject

@property (nonatomic, readonly, copy) NSString            *title;
@property (nonatomic, readonly, copy) dispatch_block_t    action;

+ (YKAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;
- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end


typedef NS_ENUM(NSInteger, YKAlertStyle) {
    YKAlertStyleDefault = 0,
    YKAlertStyleInput,
    YKAlertStyleOK,
    YKAlertStyleDispaly
};

@interface YKAlertController : UIViewController

@property (nonatomic, strong, readonly) NSString *inputContent;

- (id)initWithTitle:(NSString *)title  message:(NSString *)message alertStyle:(YKAlertStyle)style;
- (void)addAction:(YKAction *)action;
- (void)show;

@end
