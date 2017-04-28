//
//  LineChartView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/11.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "LineChartView.h"



#define FoldLineColor [UIColor colorWithRed:0 green:255 blue:254 alpha:1]

@interface LineChartView ()

@property (assign, nonatomic)   CGFloat  xLength;
@property (assign , nonatomic)  CGFloat  yLength;
@property (assign , nonatomic)  CGFloat  perXLen ;
@property (assign , nonatomic)  CGFloat  perYlen ;

@property (nonatomic,strong)    NSMutableArray * drawDataArr;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (assign , nonatomic) BOOL  isEndAnimation ;

@property (nonatomic, strong)  CAShapeLayer *markLayerX;

@property (nonatomic, strong)  CAShapeLayer *markLayerY;

@property (assign , nonatomic)  CGFloat  maxValue ;

@property (assign , nonatomic)  CGFloat  maxYValue ;

@end

@implementation LineChartView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0x1c2249);

    }
    return self;
}


#pragma mark 开始绘图
-(void)showAnimation{
    
    NSDate *checkIndate = [NSDate at_dateFromString: self.checkInDateStr];
    NSDate *checkOutdate = [NSDate at_dateFromString: self.checkOutDateStr];
    NSInteger days = [checkIndate daysBetween:checkOutdate];
    NSComparisonResult result = [checkIndate compare:checkOutdate];
    if (result == NSOrderedSame) {
        _lineChartViewType = LineChartViewType24Hours;
        _xLineDataArr = @[@"0:00",@"4:00",@"8:00",@"12:00",@"16:00",@"20:00",@"24:00"];
        
    } else {
       _lineChartViewType = LineChartViewTypeDays;
    
        if (days <= 7) {
            NSMutableArray *mutableDays = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days; i++) {
                
                [mutableDays addObject: [checkIndate stringForMonthDay]];
                
                NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:checkIndate];
                checkIndate = nextDate;
                
            }
            _xLineDataArr = mutableDays;
            
            
        }
        
        
        if ((days > 7) && (days <= 14)  ) {
            NSMutableArray *mutableDays = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days / 2; i++) {
                
                [mutableDays addObject: [checkIndate stringForMonthDay]];
                
                NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 * 2 sinceDate:checkIndate];
                checkIndate = nextDate;
                
            }
            _xLineDataArr = mutableDays;
            
            NSMutableArray *mutableValues = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days; i++) {
              
                [mutableValues addObject:_valueArr[i]];
            
                i++;
                if (mutableValues.count == _xLineDataArr.count) {
                    break;
                }
            }
            
            _valueArr = mutableValues;
            
            
        }
        
        
        if ((days > 14) && (days <= 21)  ) {
            
            NSMutableArray *mutableDays = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days / 3; i++) {
                
                [mutableDays addObject: [checkIndate stringForMonthDay]];
                
                NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 * 3 sinceDate:checkIndate];
                checkIndate = nextDate;
                
            }
            _xLineDataArr = mutableDays;
            
            
            NSMutableArray *mutableValues = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days; i++) {
                
                [mutableValues addObject:_valueArr[i]];
                i = i + 2;
                
                if (mutableValues.count == _xLineDataArr.count) {
                    break;
                }
            }
            
            _valueArr = mutableValues;

            
        }
        
        if ((days > 21) && (days <= 31)  ) {
            
            NSMutableArray *mutableDays = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days / 4; i++) {
                
                [mutableDays addObject: [checkIndate stringForMonthDay]];
                
                NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 * 4 sinceDate:checkIndate];
                checkIndate = nextDate;
                
                
            }
            _xLineDataArr = mutableDays;
            
            
            NSMutableArray *mutableValues = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < days; i++) {
                
                [mutableValues addObject:_valueArr[i]];
                i = i + 3;
                
                if (mutableValues.count == _xLineDataArr.count) {
                    break;
                }
            }
            
            _valueArr = mutableValues;
            
        }

    
    }
    
   
  //配置y坐标
    _maxValue = [[self.valueArr valueForKeyPath:@"@max.floatValue"] floatValue];
    if (_maxValue <= 1000) {
        self.yLineDataArr = @[@250,@500,@750,@1000];
    }
    if ((_maxValue <= 4000) && (_maxValue > 1000)) {
        self.yLineDataArr = @[@1000,@2000,@3000,@4000];
    }
    if ((_maxValue <= 10000) && (_maxValue > 4000)) {
        self.yLineDataArr = @[@2500,@5000,@7500,@10000];
    }
    
    if ((_maxValue <= 100000) && (_maxValue > 10000)) {
        self.yLineDataArr = @[@25000,@50000,@75000,@100000];
    }
    if (_maxValue > 100000) {
        self.yLineDataArr = @[@100000,@200000,@300000,@400000];
    }

    
    [self configChartXAndYLength];//xy 长度
    [self configChartOrigin]; //坐标原点
    [self configPerXAndPerY];//xy间隔
    [self configValueDataArray]; //将数据转换为点坐标
    
}


#pragma mark  绘制xy轴
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawXAndYLineWithContext:context];
    
    [self drawXYLineAtMaxPointWithDataArr:_drawDataArr WithContext:context];
}


#pragma mark  获取 坐标原点
- (void)configChartOrigin{

    self.chartOrigin = CGPointMake(self.contentInsets.left, self.frame.size.height-self.contentInsets.bottom);
    
}

#pragma mark  获取 xy的长度
- (void)configChartXAndYLength{
    _xLength = CGRectGetWidth(self.frame)-self.contentInsets.left-self.contentInsets.right;
    _yLength = CGRectGetHeight(self.frame)-self.contentInsets.top-self.contentInsets.bottom;
}

#pragma mark 获取xy上的间隔
- (void)configPerXAndPerY{
    _perXLen = _xLength/(_xLineDataArr.count-1);
    _perYlen = _yLength/_yLineDataArr.count;
}

#pragma mark  将坐标 转换为数据
-(void)ponitToData:(CGPoint) p{
    
    
    _maxYValue = [[_yLineDataArr valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGFloat x  =  p.x - self.contentInsets.left;
     CGFloat y = p.y - self.contentInsets.bottom;
    
    CGFloat kDate;
    CGFloat kMoney;
    if (_lineChartViewType == LineChartViewType24Hours) {

        kDate = (x / _xLength) * 24;
        kMoney = _maxYValue - (y / _yLength) * _maxYValue;
        
        NSString *dataStr = [NSString stringWithFormat:@"%.0f:00", round(kDate)];
        NSString *moneyStr = [NSString stringWithFormat:@"%.2f", roundf(kMoney*100)/100];
        self.didSelectPointBlock(dataStr, moneyStr);
        
        
    } else {
        kDate = (x / _xLength) * (self.xLineDataArr.count - 1);
        kMoney = _maxYValue - (y / _yLength) * _maxYValue;
         NSInteger index = (NSInteger)round(kDate);
       
        
        NSString *dataStr = [NSString stringWithFormat:@"%@", self.xLineDataArr[index]];
        NSString *moneyStr = [NSString stringWithFormat:@"%.2f", roundf(kMoney*100)/100];
        self.didSelectPointBlock(dataStr, moneyStr);
    }

}

#pragma mark  将数据 转换为坐标
- (void)configValueDataArray{
    _drawDataArr = [[NSMutableArray alloc] init];
   
        for (NSInteger i = 0; i<_valueArr.count; i++) {
            
            CGPoint p = P_M(i*_perXLen+self.chartOrigin.x,
                            
                            self.contentInsets.top + _yLength - [_valueArr[i] floatValue] / [_yLineDataArr.lastObject floatValue] * _yLength);
            
            NSValue *value = [NSValue valueWithCGPoint:p];
            [_drawDataArr addObject:value];
        }

        
    
    
    
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = [CAShapeLayer layer];
    if (_drawDataArr.count==0) {
        return;
    }
    
//开始画折线
 [self drawPathWithDataArr:_drawDataArr andIndex:0];


}

#pragma mark  找到最高点 画十字线
- (void)drawXYLineAtMaxPointWithDataArr:(NSArray *)dataArr WithContext:(CGContextRef)contex {

    
    CGFloat markMaxL = CGFLOAT_MAX;
    CGFloat markMaxX = CGFLOAT_MAX;
    for (NSInteger i = 0; i<dataArr.count; i++) {
        
        NSValue *value = dataArr[i];
        CGPoint p = value.CGPointValue;
        
        if (p.y < markMaxL) {
            markMaxL = p.y;
            markMaxX = p.x;
        }

    }
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:P_M(self.chartOrigin.x,markMaxL)];
    // 其它点
    [linePath addLineToPoint:P_M(self.contentInsets.left +_xLength, markMaxL)];

    
    _markLayerX = [CAShapeLayer layer];
    _markLayerX.path = linePath.CGPath;
    _markLayerX.strokeColor = UIColorFromRGB(0xff9900).CGColor;
    _markLayerX.lineWidth = 0.5;

    [self.layer addSublayer:_markLayerX];
    
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    // 起点
    [linePath1 moveToPoint:P_M(markMaxX,self.chartOrigin.y)];
    // 其它点
    [linePath1 addLineToPoint:P_M(markMaxX, 10)];
    
    _markLayerY = [CAShapeLayer layer];
    _markLayerY.path = linePath1.CGPath;
    _markLayerY.strokeColor = UIColorFromRGB(0xff9900).CGColor;
    _markLayerY.lineWidth = 0.5;
    
    [self.layer addSublayer:_markLayerY];

}

#pragma mark 开始画图
- (void)drawPathWithDataArr:(NSArray *)dataArr andIndex:(NSInteger )colorIndex{
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    

    for (NSInteger i = 0; i<dataArr.count; i++) {

        NSValue *value = dataArr[i];
        CGPoint p = value.CGPointValue;
       
        if (i==0) {
            [secondPath moveToPoint:P_M(p.x, self.chartOrigin.y)];
            [secondPath addLineToPoint:p];
             [firstPath moveToPoint:p];
        } else {
            [firstPath addLineToPoint:p];
            [secondPath addLineToPoint:p];
        }
        
        if (i==dataArr.count-1) {
            
            [secondPath addLineToPoint:P_M(p.x, self.chartOrigin.y)];
            
        }
        
      WS(weakSelf);
        //添加光点
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(p.x - 7.5, p.y - 7.5, 15, 15)];
     
        imageView.image = [UIImage imageNamed:@"point"];
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            
             NSLog(@"点击 (x, y) is (%f, %f)", imageView.frame.origin.x + 7.5, imageView.frame.origin.y + 7.5);
            
            [weakSelf ponitToData:CGPointMake(imageView.frame.origin.x + 7.5, imageView.frame.origin.y + 7.5)];
            
            
            UIBezierPath *linePath = [UIBezierPath bezierPath];

            [linePath moveToPoint:P_M(weakSelf.chartOrigin.x,imageView.frame.origin.y + 7.5)];
         
            [linePath addLineToPoint:P_M(weakSelf.contentInsets.left +_xLength, imageView.frame.origin.y + 7.5)];
            
            weakSelf.markLayerX.path = linePath.CGPath;
            
            
            UIBezierPath *linePath1 = [UIBezierPath bezierPath];
          
            [linePath1 moveToPoint:P_M(imageView.frame.origin.x + 7.5,weakSelf.chartOrigin.y)];
          
            [linePath1 addLineToPoint:P_M(imageView.frame.origin.x + 7.5, 10)];
            weakSelf.markLayerY.path = linePath1.CGPath;
            
            
        }];
        
        [self addSubview:imageView];
        
    }
    
  [secondPath closePath];
    //第二、UIBezierPath和CAShapeLayer关联
     
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = firstPath.CGPath;
    UIColor *color = UIColorFromRGB(0x1aa5e5);
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 0.5;
    
    //第三，动画
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    
    ani.fromValue = @0;
    
    ani.toValue = @1;
    
    ani.duration = 0.5;
    
    [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [self.layer addSublayer:shapeLayer];
    
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ani.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CAShapeLayer *shaperLay = [CAShapeLayer layer];
        shaperLay.frame = weakSelf.bounds;
        shaperLay.path = secondPath.CGPath;
        shaperLay.fillColor = UIColorFromAlphaRGB(0x1b3fa6, 0.4).CGColor;
        
        [weakSelf.layer addSublayer:shaperLay];
        
      
    });

    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    return;
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    CGFloat x = point.x;
    CGFloat y = point.y;
    NSLog(@"touch (x, y) is (%f, %f)", x, y);
    
    
    NSLog(@"%@", _drawDataArr);
    for (NSInteger i = 0; i < _drawDataArr.count; i++) {
        if (i + 1 >= _drawDataArr.count) {
            break;
        }
        NSLog(@"A  %@", _drawDataArr[i]);
        
        NSLog(@"  B   %@", _drawDataArr[i + 1]);
        
        NSValue *valueA = _drawDataArr[i];
        CGPoint A = valueA.CGPointValue;
        

        
        NSValue *valueB = _drawDataArr[i + 1];
        
        CGPoint B = valueB.CGPointValue;
        
     CGPoint p = [self twoLineWithFistLine:A :B withSecondLine:P_M(x, 0) :P_M(x, y - 10)];
        NSLog(@"交点%f   %f", p.x, p.y);
        
    }
    
    
    
    
    
    
    [self ponitToData:CGPointMake(x, y)];
    
    //横线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint:P_M(self.chartOrigin.x,y)];
    
    [linePath addLineToPoint:P_M(self.contentInsets.left +_xLength, y)];
    
    self.markLayerX.path = linePath.CGPath;
    
    
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    
    [linePath1 moveToPoint:P_M(x ,self.chartOrigin.y)];
    
    [linePath1 addLineToPoint:P_M(x, 10)];
    self.markLayerY.path = linePath1.CGPath;
    

}


- (CGPoint)twoLineWithFistLine:(CGPoint)a :(CGPoint)b withSecondLine:(CGPoint)c :(CGPoint)d {
    
    CGFloat x0 = a.x;
    CGFloat x1 = b.x;
    CGFloat x2 = c.x;
    CGFloat x3 = d.x;
    CGFloat y0 = a.y;
    CGFloat y1 = b.y;
    CGFloat y2 = c.y;
    CGFloat y3 = d.y;
    
   CGFloat  y = ( (y0-y1)*(y3-y2)*x0 + (y3-y2)*(x1-x0)*y0 + (y1-y0)*(y3-y2)*x2 + (x2-x3)*(y1-y0)*y2 ) / ( (x1-x0)*(y3-y2) + (y0-y1)*(x3-x2) );
    
    
    
   CGFloat x = x2 + (x3-x2)*(y-y2) / (y3-y2);
    
    NSLog(@"交点 (x, y) is (%f, %f)", x, y);
    
    return P_M(x, y);
}

#pragma mark  绘制xy轴 方法
- (void)drawXAndYLineWithContext:(CGContextRef)context{
    
    //x 轴
    [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.contentInsets.left +_xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:UIColorFromRGB(0x313d80)];

    if (_showYLine) {
        //Y轴
        [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:[UIColor blackColor]];
    }
    
    if (_xLineDataArr.count>0) {
        CGFloat xPace = _perXLen;
        
        for (NSInteger i = 0; i<_xLineDataArr.count;i++ ) {
            CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
            CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:10 aimString:_xLineDataArr[i]].width;
            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:[UIColor blackColor]];
            
            
            UIColor *xTextColor = self.xTextColor?self.xTextColor:UIColorFromRGB(0xc5cae9);
            
            [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:xTextColor andFontSize:10];
            
        }
        
        
        
    }
    
    if (_yLineDataArr.count>0) {
        CGFloat yPace = _perYlen;
        for (NSInteger i = 0; i<_yLineDataArr.count; i++) {
            CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
            
            CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:10 aimString:_yLineDataArr[i]].width;
            CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:10 aimString:_yLineDataArr[i]].height;
           
            if (_showYLevelLine) {
                [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:NO andColor:UIColorFromRGB(0x313d80)];
            
                
            }else{
                [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:[UIColor blueColor]];
            }
            
            UIColor *yTextColor = self.yTextColor?self.yTextColor:UIColorFromRGB(0xc5cae9);
            [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:yTextColor andFontSize:10];
        }
    }

    
}

#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}



/**
 *  绘制线段
 *
 *  @param context  图形绘制上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否是虚线
 *  @param color    线段颜色
 */
- (void)drawLineWithContext:(CGContextRef )context andStarPoint:(CGPoint )start andEndPoint:(CGPoint)end andIsDottedLine:(BOOL)isDotted andColor:(UIColor *)color{


    //    移动到点
    CGContextMoveToPoint(context, start.x, start.y);
    //    连接到
    CGContextAddLineToPoint(context, end.x, end.y);
    
    
    CGContextSetLineWidth(context, 0.5);
    
    
    [color setStroke];
    
    if (isDotted) {
        CGFloat ss[] = {1.5,2};
        
        CGContextSetLineDash(context, 0, ss, 2);
        
    } else {
        CGFloat ss[] = {1.5,0};
        
        CGContextSetLineDash(context, 0, ss, 2);
    
    }
    CGContextMoveToPoint(context, end.x, end.y);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  绘制文字
 *
 *  @param text    文字内容
 *  @param context 图形绘制上下文
 *  @param rect    绘制点
 *  @param color   绘制颜色
 */
- (void)drawText:(NSString *)text andContext:(CGContextRef )context atPoint:(CGPoint )rect WithColor:(UIColor *)color andFontSize:(CGFloat)fontSize{
    
    [[NSString stringWithFormat:@"%@",text] drawAtPoint:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    
    [color setFill];
    
    CGContextDrawPath(context, kCGPathFill);
    
}

//- (void)creatLittleCircleView:(CGRect)frame {
//
//    
//
//    return;
//    
//    
//    //创建CGContextRef
//    UIGraphicsBeginImageContext(self.bounds.size);
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
//    //创建CGMutablePathRef
//    CGMutablePathRef path = CGPathCreateMutable();
//    
//    //绘制Path
//    CGRect rect = frame;
//    
//    CGPathAddEllipseInRect(path, nil, rect);
//    CGPathCloseSubpath(path);
//    
//
//    //绘制渐变
//    [self drawRadialGradient:gc path:path startColor:[UIColor colorWithRed:0 green:255 blue:254 alpha:1].CGColor endColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor];
//    
//    //注意释放CGMutablePathRef
//    CGPathRelease(path);
//    
//
//    //从Context中获取图像，并显示在界面上
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//  
//    [self addSubview:imgView];
//
//}
//
 //绘制渐变
- (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.1, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
