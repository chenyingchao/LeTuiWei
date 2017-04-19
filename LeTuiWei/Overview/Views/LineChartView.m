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
@property (assign , nonatomic)  CGFloat  perValue ;
@property (nonatomic,strong)    NSMutableArray * drawDataArr;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (assign , nonatomic) BOOL  isEndAnimation ;

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
    [self configChartXAndYLength];//xy 长度
    [self configChartOrigin]; //坐标原点
    [self configPerXAndPerY];//xy间隔
    [self configValueDataArray]; //将数据转换为点坐标
    
}


#pragma mark  绘制xy轴
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawXAndYLineWithContext:context];
    
    for (NSInteger i = 0;i<_drawDataArr.count;i++) {

        NSArray *dataArr = _drawDataArr[i];


        [self drawXYLineAtMaxPointWithDataArr:dataArr WithContext:context];

    }
    
    
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

#pragma mark  将数据 转换为坐标
- (void)configValueDataArray{
    _perValue = _perYlen/_yLineDataArr.count;
    _drawDataArr = [[NSMutableArray alloc] init];
    for (NSArray *valueArr in _valueArr) {
        NSMutableArray *dataMArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i<valueArr.count; i++) {
            
            CGPoint p = P_M(i*_perXLen+self.chartOrigin.x,self.contentInsets.top + _yLength - [valueArr[i] floatValue] / [_yLineDataArr.lastObject floatValue] * _yLength);
            
            NSValue *value = [NSValue valueWithCGPoint:p];
            [dataMArr addObject:value];
        }
        [_drawDataArr addObject:[dataMArr copy]];
        
    }
    
    
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = [CAShapeLayer layer];
    if (_drawDataArr.count==0) {
        return;
    }
    
//开始画折线
    for (NSInteger i = 0;i<_drawDataArr.count;i++) {
        
        NSArray *dataArr = _drawDataArr[i];
        
        [self drawPathWithDataArr:dataArr andIndex:i];
        
        
    }


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
    
    [self drawLineWithContext:contex andStarPoint:P_M(self.chartOrigin.x,markMaxL) andEndPoint:P_M(self.contentInsets.left +_xLength, markMaxL) andIsDottedLine:NO andColor:UIColorFromRGB(0xff9900)];
    
    [self drawLineWithContext:contex andStarPoint:P_M(markMaxX,self.chartOrigin.y) andEndPoint:P_M(markMaxX, markMaxL - 15) andIsDottedLine:NO andColor:UIColorFromRGB(0xff9900)];

}

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
        
        
       [self creatLittleCircleView:CGRectMake(p.x - 7.5, p.y - 7.5, 15, 15) ];
  
        
        
    }
    
  [secondPath closePath];
    //第二、UIBezierPath和CAShapeLayer关联
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = firstPath.CGPath;
    UIColor *color = (_valueLineColorArr.count==_drawDataArr.count?(_valueLineColorArr[colorIndex]):(UIColorFromRGB(0x1aa5e5)));
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
            
            [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:UIColorFromRGB(0xc5cae9) andFontSize:10];
            
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
            [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:UIColorFromRGB(0xc5cae9) andFontSize:10];
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

- (void)creatLittleCircleView:(CGRect)frame {

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"point"];
    
    [self addSubview:imageView];
    return;
    
    
    //创建CGContextRef
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGRect rect = frame;
    
    CGPathAddEllipseInRect(path, nil, rect);
    CGPathCloseSubpath(path);
    

    //绘制渐变
    [self drawRadialGradient:gc path:path startColor:[UIColor colorWithRed:0 green:255 blue:254 alpha:1].CGColor endColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    

    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
  
    [self addSubview:imgView];

}

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
