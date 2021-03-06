//
//  RingChartView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/11.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "RingChartView.h"
#define k_COLOR_STOCK @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]]


@interface RingChartView()

@property (nonatomic,assign) CGFloat totolCount;

@property (assign, nonatomic)  CGPoint chartOrigin;

//环图间隔 单位为π
@property (nonatomic,assign)CGFloat itemsSpace;


@end

@implementation RingChartView


-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.chartOrigin = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2);
    

    }
    return self;
}

-(void)setValueDataArr:(NSArray *)valueDataArr{
    
    
    _valueDataArr = valueDataArr;
    
    [self configBaseData];
    
}

- (void)configBaseData{
    
    _totolCount = 0;
    _itemsSpace =  (M_PI * 2.0 * 10 / 360)/_valueDataArr.count ;

    for (id obj in _valueDataArr) {
        
        _totolCount += [obj floatValue];
        
    }
    
}


- (void)orderTotalMoney {
    
    WS(weakSelf);
    UILabel *totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    totalMoneyLabel.font = [Theme fontWithSize24];
    totalMoneyLabel.textColor = UIColorFromRGB(0xc5cae9);
    totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
    totalMoneyLabel.numberOfLines = 0;
    [self addSubview:totalMoneyLabel];
    [totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf);
      
    }];
    
    NSString *str = [NSString stringWithFormat:@"订单金额\n%@",@"9999"];
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf9d542) range:NSMakeRange(4, str.length - 4)];
    
    totalMoneyLabel.attributedText = attrStr;
    
}

//开始动画
- (void)showAnimation{
    
    /*        动画开始前，应当移除之前的layer         */
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    [self orderTotalMoney];
    
    if (_valueDataArr.count == 0) {
        CAShapeLayer *layer = [CAShapeLayer layer] ;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = UIColorFromRGB(0x222b59).CGColor;
      
        
        [path addArcWithCenter:self.chartOrigin radius:_redius startAngle:0  endAngle: 2 * M_PI clockwise:YES];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        layer.lineWidth = _ringWidth;


        return;
    }
    
    CGFloat lastBegin = 0 * M_PI;
    
    CGFloat totloL = 0;
    NSInteger  i = 0;
    for (id obj in _valueDataArr) {
        
        CAShapeLayer *layer = [CAShapeLayer layer] ;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        layer.fillColor = [UIColor clearColor].CGColor;
        
        if (i<_fillColorArray.count) {
            layer.strokeColor =[_fillColorArray[i] CGColor];
        }else{
            layer.strokeColor =[k_COLOR_STOCK[i%k_COLOR_STOCK.count] CGColor];
        }
        CGFloat cuttentpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);
        totloL += [obj floatValue] / _totolCount;
        
        [path addArcWithCenter:self.chartOrigin radius:_redius startAngle:lastBegin  endAngle:lastBegin  + cuttentpace clockwise:YES];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        layer.lineWidth = _ringWidth;
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basic.fromValue = @(0);
        basic.toValue = @(1);
        basic.duration = 0.5;
        basic.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:basic forKey:@"basic"];
        lastBegin += (cuttentpace+_itemsSpace);
        i++;
        
    }
    
}



@end
