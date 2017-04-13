//
//  DistributionChartView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "DistributionChartView.h"

@interface DistributionChartView()



@property (assign, nonatomic)   CGFloat  xLength;

@property (assign , nonatomic)  CGFloat  yLength;

@property (assign, nonatomic)  CGPoint chartOrigin;



@end

@implementation DistributionChartView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];//UIColorFromRGB(0x1c2249);
        self.contentInsets = UIEdgeInsetsMake(20, 50, 20, 50);
        self.valueArr = @[@"100",@"250",@"300",@"350",@"400"];
        
    }
    return self;
}

#pragma mark 开始绘图
-(void)showAnimation{
    [self configChartXAndYLength];//xy 长度
    [self configChartOrigin]; //坐标原点
 
    
    
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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    //最中间的横线
    [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength / 2) andEndPoint:P_M(self.chartOrigin.x + _xLength, self.chartOrigin.y - _yLength / 2 ) andIsDottedLine:NO andColor:[UIColor redColor]];
    
    CGFloat minNum = [_valueArr.firstObject floatValue];
    CGFloat maxNum = [_valueArr.lastObject floatValue];
    CGFloat  maxDifference = maxNum - minNum;
    for (NSInteger i = 0; i < _valueArr.count; i++) {
        
        
        if (i == 0) {
            //最左边的竖线
            [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x , self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength ) andIsDottedLine:NO andColor:[UIColor redColor]];
            


            CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_valueArr.firstObject];
            [self drawText:[NSString stringWithFormat:@"%@",_valueArr.firstObject] andContext:context atPoint:P_M(self.chartOrigin.x - size.width / 2, self.chartOrigin.y - _yLength - size.height) WithColor:[UIColor blackColor] andFontSize:14];
            
            CGSize size1 = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:12 aimString:@"最低消费值"];
            [self drawText:[NSString stringWithFormat:@"%@",@"最低消费值"] andContext:context atPoint:P_M(self.chartOrigin.x - size1.width / 2, self.chartOrigin.y ) WithColor:[UIColor blackColor] andFontSize:12];
            
        } else if (i == _valueArr.count - 1) {
            //最右边的竖线
            [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x + _xLength, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x + _xLength, self.chartOrigin.y - _yLength ) andIsDottedLine:NO andColor:[UIColor redColor]];
            
            CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_valueArr.lastObject];
            [self drawText:[NSString stringWithFormat:@"%@",_valueArr.lastObject] andContext:context atPoint:P_M(self.chartOrigin.x + _xLength - size.width / 2, self.chartOrigin.y - _yLength - size.height) WithColor:[UIColor blackColor] andFontSize:14];
            
            CGSize size1 = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:12 aimString:@"最高消费值"];
            [self drawText:[NSString stringWithFormat:@"%@",@"最高消费值"] andContext:context atPoint:P_M(self.chartOrigin.x + _xLength - size1.width / 2, self.chartOrigin.y ) WithColor:[UIColor blackColor] andFontSize:12];
            
            
            
        } else {
            CGFloat percentage = ([_valueArr[i] floatValue] - minNum)/ maxDifference;
            CGFloat originX = _xLength * percentage;
     
            [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x + originX, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x + originX, self.chartOrigin.y - _yLength ) andIsDottedLine:NO andColor:[UIColor redColor]];
            
            CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:14 aimString:_valueArr[i]];
            [self drawText:[NSString stringWithFormat:@"%@",_valueArr[i]] andContext:context atPoint:P_M(self.chartOrigin.x + originX - size.width / 2, self.chartOrigin.y - _yLength - size.height) WithColor:[UIColor blackColor] andFontSize:14];
        
        
        }
        
    
        
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
