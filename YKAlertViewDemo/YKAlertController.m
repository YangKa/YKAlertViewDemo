//
//  YKAlertController.m
//  Lunchtime
//
//  Created by qianzhan on 15/12/7.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "YKAlertController.h"
#import "IQKeyboardReturnKeyHandler.h"

@implementation YKAction

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}

+ (YKAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action {
    YKAction *ac = [[YKAction alloc] initWithTitle:title action:action];
    return ac;
}
@end


@interface YKAlertController (){
    
    NSString            *_title;
    NSString            *_message;
    YKAlertStyle        _alertStyle;

    NSMutableArray      *_actions;
    
    
    UIView              *_backView;
    UILabel             *_titleLabel;
    UILabel             *_messageLabel;
    UITextField         *_textField;
    UIButton            *_cancel;
    UIButton            *_send;
    
    UIView              *_hLine;
    UIView              *_vLine;
}
@property (nonatomic , strong) IQKeyboardReturnKeyHandler *returnKeyhandler;
@end

@implementation YKAlertController

- (id)initWithTitle:(NSString *)title  message:(NSString *)message alertStyle:(YKAlertStyle)style{
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _alertStyle = style;
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    //键盘监控
    _returnKeyhandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    _returnKeyhandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    [self initUI];
}

- (void)initUI{
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.translatesAutoresizingMaskIntoConstraints = false;
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = true;
    [self.view addSubview:_backView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _title;
    [_backView addSubview:_titleLabel];
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = false;
    _messageLabel.textColor = [UIColor lightGrayColor];
    _messageLabel.font = [UIFont systemFontOfSize:15];
    _messageLabel.text = _message;
    _messageLabel.numberOfLines = 0;
    [_backView addSubview:_messageLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
   // _textField.translatesAutoresizingMaskIntoConstraints = false;
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _textField.layer.cornerRadius = 2;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_textField];

    _hLine = [[UIView alloc] initWithFrame:CGRectZero];
    _hLine.translatesAutoresizingMaskIntoConstraints = false;
    _hLine.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:_hLine];
    
    _vLine = [[UIView alloc] initWithFrame:CGRectZero];
    _vLine.translatesAutoresizingMaskIntoConstraints = false;
    _vLine.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:_vLine];
    
    _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancel.translatesAutoresizingMaskIntoConstraints = false;
    NSString *cancel = [(YKAction *)_actions[0] title];
    [_cancel setTitle:cancel forState:UIControlStateNormal];
    [_cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancel addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancel.tag = 100;
    [_backView addSubview:_cancel];
    
    _send = [UIButton buttonWithType:UIButtonTypeSystem];
    _send.translatesAutoresizingMaskIntoConstraints = false;
    NSString *send = [(YKAction *)_actions[1] title];
    [_send setTitle:send forState:UIControlStateNormal];
    [_send setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _send.titleLabel.font = [UIFont systemFontOfSize:15];
    [_send addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _send.tag = 200;
    [_backView addSubview:_send];

}

- (void)layoutSubView:(YKAlertStyle)style{
    CGFloat width = self.view.frame.size.width - 80;
    switch (style) {
        case YKAlertStyleDefault:{
            
            _backView.center = self.view.center;
            
            _titleLabel.frame = CGRectMake(0, 5, width, 30);
            _titleLabel.text = _title;
            
            CGFloat height = [self returnStringHeight:_message fontSize:16 maxWidth:width-20 lineSpace:2];
            _messageLabel.frame = CGRectMake(10, 35, width-20, height);
            _messageLabel.text = _message;
            
            _hLine.frame = CGRectMake(0, 45+height-0.5, width, 0.5);
            _vLine.frame = CGRectMake(width/2-0.5, 45+height, 0.5, 35);
            
            _cancel.frame = CGRectMake(0, 45+height, width/2-0.5, 35);
            _send.frame = CGRectMake(width/2, 45+height, width/2-0.5, 35);
            
            _backView.bounds = CGRectMake(0, 0, width, 80+height);
        }break;
        case YKAlertStyleOK:{
            
            _backView.center = self.view.center;
            
            _titleLabel.frame = CGRectMake(0, 5, width, 30);
            _titleLabel.text = _title;
            
            CGFloat height = [self returnStringHeight:_message fontSize:16 maxWidth:width-20 lineSpace:2];
            _messageLabel.frame = CGRectMake(10, 32, width-20, height);
            _messageLabel.text = _message;
            
            _hLine.frame = CGRectMake(0, 45+height-0.5, width, 0.5);
            
            _send.frame = CGRectMake(0, 45+height, width, 35);
            
            _backView.bounds = CGRectMake(0, 0, width, 80+height);
            
        }break;
        case YKAlertStyleInput:{
            _backView.center = self.view.center;
            
            _titleLabel.frame = CGRectMake(0, 5, width, 30);
            _titleLabel.text = _title;
            
            CGFloat height = [self returnStringHeight:_message fontSize:16 maxWidth:width-20 lineSpace:2];
            _messageLabel.frame = CGRectMake(10, 35, width-20, height);
            _messageLabel.text = _message;
            
            _messageLabel.font = [UIFont systemFontOfSize:12];
            _textField.frame = CGRectMake(10, 35+height, width-20, 30);
            
            _hLine.frame = CGRectMake(0, 80+height-0.5, width, 0.5);
            _vLine.frame = CGRectMake(width/2-0.5, 80+height, 0.5, 35);
            
            _cancel.frame = CGRectMake(0, 80+height, width/2-0.5, 35);
            _send.frame = CGRectMake(width/2, 80+height, width/2-0.5, 35);
            
            _backView.bounds = CGRectMake(0, 0, width, 120+height);
        }break;
        case YKAlertStyleDispaly:{
            _backView.center = self.view.center;
            
            _titleLabel.frame = CGRectMake(0, 0, width, 30);
            _titleLabel.text = [NSString stringWithFormat:@"  %@", _title];
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleLabel.backgroundColor = [UIColor orangeColor];
            
            CGFloat height = [self returnStringHeight:_message fontSize:16 maxWidth:width-20 lineSpace:2];
            _messageLabel.frame = CGRectMake(10, 32, width-20, height);
            _messageLabel.text = _message;
            
            _backView.bounds = CGRectMake(0, 0, width, 40+height);
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width-40, 0, 40, 30)];
            [btn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            btn.imageEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 5);
            [_backView addSubview:btn];
        }break;
    }
}

/*返回有间隔字符串高度*/
- (CGFloat)returnStringHeight:(NSString*)str fontSize:(int)size  maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:size],
                          NSParagraphStyleAttributeName:paragraphStyle};
    CGFloat height = [str boundingRectWithSize: CGSizeMake(maxWidth, 1000)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dic
                                       context:nil].size.height;
    
    return height;
}

- (void)addAction:(YKAction *)action {
    [_actions addObject:action];
}

- (void)ClickBtn:(UIButton *)btn {
    
    _inputContent = _textField.text;
    
    if (btn.tag == 100) {
        YKAction *action = _actions[0];
        if (action.action) {
            action.action();
        }
    } else {
        YKAction *action = _actions[1];
        if (action.action) {
            action.action();
        }
    }
    [self dismiss];
}

#pragma mark ----------显示
- (void)show {
    [self layoutSubView:_alertStyle];
    
    UIViewController *result = [self currentController];
    [result addChildViewController:self];
    [result.view addSubview:self.view];
}

#pragma mark -----------取消
- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        _backView.alpha = 0.7;
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}

#pragma mark -----------当前viewController
- (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        result = nestResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
