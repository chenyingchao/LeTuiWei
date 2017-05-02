//
//  ColumnChartView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ColumnChartView.h"

@interface ColumnChartView()



@property (assign, nonatomic)   CGFloat  xLength;

@property (assign , nonatomic)  CGFloat  yLength;

@property (assign , nonatomic)  CGFloat  perXLen ;

@property (assign , nonatomic)  CGFloat  perYlen ;

@property (assign, nonatomic)  CGPoint chartOrigin;

@end


@implementation ColumnChartView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        

    }
    return self;
}

#pragma mark 开始绘图
-(void)showAnimation{
    [self configChartXAndYLength];//xy 长度
    [self configChartOrigin]; //坐标原点
    [self configPerXAndPerY];//xy间隔
    
    
  
    
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

#pragma mark  绘制xy轴
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画竖行
    for (NSInteger i =0; i < self.xLineDataArr.count; i++) {
        
        UIColor *ylineColor = self.yLineColor ? self.yLineColor : UIColorFromRGB(0x313d80);
        
        [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x + i * _perXLen, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x + i * _perXLen, 0) andIsDottedLine:NO andColor:ylineColor];
        
        CGPoint p = P_M(self.chartOrigin.x + i * _perXLen, self.chartOrigin.y);
        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_xLineDataArr[i]].width;
        
        UIColor *textColor = self.xTextColor ? self.xTextColor : UIColorFromRGB(0xc5cae9);
        [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:textColor andFontSize:12];
    }
  
    //画Y轴的字
    for (NSInteger i =0; i < self.yLineDataArr.count; i++) {
        
        CGPoint p = P_M(self.chartOrigin.x , self.chartOrigin.y - (i + 1)* _perYlen);
        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_yLineDataArr[i]].width;
        CGFloat height = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_yLineDataArr[i]].height;
        UIColor *textColor = self.xTextColor ? self.xTextColor : UIColorFromRGB(0xc5cae9);
        
        [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[self.yLineDataArr.count - 1 - i]] andContext:context atPoint:P_M(p.x-len -10, p.y - height/2) WithColor:textColor andFontSize:14];
    }
    
    
    //条状图
    CGFloat maxNum = [_xLineDataArr.lastObject floatValue];
    
    for (NSInteger i =0; i < self.valueArr.count; i++) {
     
      CGFloat percentage = [_valueArr[self.valueArr.count - i - 1] floatValue]/maxNum;
      CGFloat columnLength = _xLength * percentage;
        
      UIBezierPath *firstPath = [UIBezierPath bezierPath];
      [firstPath moveToPoint:P_M(self.chartOrigin.x,self.chartOrigin.y - (i + 1)* _perYlen)];
      [firstPath addLineToPoint:P_M(self.chartOrigin.x+ columnLength, self.chartOrigin.y - (i+ 1)* _perYlen)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.path = firstPath.CGPath;
        UIColor *color = (_columnColorArr.count==_valueArr.count?(_columnColorArr[i]):([UIColor orangeColor]));
        shapeLayer.strokeColor = color.CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = [Theme paddingWithSize:36];
        
        //第三，动画
        
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        
        ani.fromValue = @0;
        
        ani.toValue = @1;
        
        ani.duration = 0.5;
        
        [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
        
        [self.layer addSublayer:shapeLayer];
  
        
        CGFloat height = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:self.valueArr[self.valueArr.count - 1 - i]].height;
        
        UIColor *columnTextColor = self.columnTextColor ? self.columnTextColor : UIColorFromRGB(0xc5cae9);
        
        [self drawText:[NSString stringWithFormat:@"%@",self.valueArr[self.valueArr.count - 1 - i]] andContext:context atPoint:P_M(self.chartOrigin.x+ columnLength + 5, self.chartOrigin.y - (i+ 1)* _perYlen - height/2) WithColor:columnTextColor andFontSize:14];
        
    }
    
    
    
    
    
    
    
    
    
    
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

#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

@end
