//
//  NewCustomPickerView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/18.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "NewCustomPickerView.h"

@interface NewCustomPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView   *pickerView;

@property (strong, nonatomic) UIButton       *cancelBtn;

@property (strong, nonatomic) UIButton       *DetermineBtn;

@property (strong, nonatomic) UILabel        *addressLb;

@property (strong, nonatomic) UIView         *darkView;

@property (strong, nonatomic) UIView         *backView;

@property (strong, nonatomic) UIBezierPath   *bezierPath;

@property (strong, nonatomic) CAShapeLayer   *shapeLayer;

@property (strong, nonatomic) NSMutableArray *shiArr;

@property (strong, nonatomic) NSMutableArray *xianArr;

@property (strong, nonatomic) NSString       *addressStr;


@end

@implementation NewCustomPickerView
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 300);
        
        [self initGesture];
    }
    return self;
}

- (void)show {
    
    [self initView];
}

- (void)initView {
    
    [self showInView:[[UIApplication sharedApplication].windows lastObject]];
    
    [self addSubview:self.darkView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.DetermineBtn];
    [self.backView addSubview:self.addressLb];
    [self.backView addSubview:self.pickerView];
    
    [self bezierPath];
    [self shapeLayer];
    

}



- (void)initGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}

- (void)showInView:(UIView *)view {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = self.center;
        point.y      -= 250;
        self.center   = point;
        
    } completion:^(BOOL finished) {
    }];
    
    [view addSubview:self];
}

- (void)dismiss {
    
    WS(weakSelf);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = self.center;
        point.y      += 250;
        self.center   = point;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if (weakSelf.statusBlock) {
            weakSelf.statusBlock(NO);
        }
        
    }];
}

// 返回选择器有几列.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// 返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:
            return _dataSource.count;
            break;

    }
    return 0;
}

// 返回第component列第row行的内容（标题）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:
            return _dataSource[row];
            break;
            

    }
    return nil;
}

// 设置row字体，颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel            = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel                 = [[UILabel alloc] init];
        pickerLabel.textAlignment   = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = UIColorFromRGB(0xf5f4f9);
        pickerLabel.font            = [UIFont systemFontOfSize:16.0];
    }
    
    pickerLabel.text                = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    

}


- (id)JsonObject:(NSString *)jsonStr {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData   = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject      = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    return JsonObject;
}

- (UIView *)darkView {
    if (!_darkView) {
        _darkView                 = [[UIView alloc]init];
        _darkView.frame           = self.frame;
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha           = 0.3;
    }
    return _darkView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView                 = [[UIView alloc]init];
        _backView.frame           = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
        _backView.backgroundColor = UIColorFromRGB(0xf5f4f9);
    }
    return _backView;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer          = [[CAShapeLayer alloc] init];
        _shapeLayer.frame    = _backView.bounds;
        _shapeLayer.path     = _bezierPath.CGPath;
        _backView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView                 = [[UIPickerView alloc]init];
        _pickerView.frame           = CGRectMake(0, 50, kScreenWidth, 200);
        _pickerView.delegate        = self;
        _pickerView.dataSource      = self;
        _pickerView.backgroundColor = [Theme colorWhite];
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)DetermineBtn {
    if (!_DetermineBtn) {
        _DetermineBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _DetermineBtn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 50);
        [_DetermineBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_DetermineBtn addTarget:self action:@selector(determineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DetermineBtn;
}

- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb               = [[UILabel alloc]init];
        _addressLb.frame         = CGRectMake(50, 0, kScreenWidth - 100, 50);
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.font          = [UIFont systemFontOfSize:16.0];
        _addressLb.hidden = YES;
    }
    return _addressLb;
}

- (void)determineBtnAction:(UIButton *)button {
    
    NSInteger index = [_pickerView selectedRowInComponent:0];

    
    
    if (self.determineBtnBlock) {
        self.determineBtnBlock(_dataSource[index]);
    }
    

    [self dismiss];
}



@end
