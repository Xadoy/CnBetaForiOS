//
//  TriangleView.m
//  MyCNbeta
//
//  Created by Adoy on 6/20/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
//    //draw rect
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, width, 0);
//    CGContextAddLineToPoint(context, width, 3);
//    CGContextAddLineToPoint(context, 0, 3);
//    CGContextClosePath(context);
//    [_triangleColor setFill];
//    //draw triangles
//    CGContextDrawPath(context, kCGPathFill);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 15, 0);
//    CGContextAddLineToPoint(context, 0, 15);
//    CGContextClosePath(context);
//    
//    [_triangleColor setFill];
//    CGContextDrawPath(context, kCGPathFill);
//    CGContextMoveToPoint(context,width , 0);
//    CGContextAddLineToPoint(context, width- 15, 0);
//    CGContextAddLineToPoint(context, width, 15);
//    CGContextClosePath(context);
//    [_triangleColor setFill];
    
//    CGContextDrawPath(context, kCGPathFill);
    


    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 5;
    CGFloat widthSP = sqrtf(lineWidth*lineWidth*2);
    
    
    // test

    
    CGContextMoveToPoint(context, 0, 15-widthSP);
    CGContextAddLineToPoint(context, 15-widthSP, 0);
    CGContextAddLineToPoint(context, width-(15-widthSP), 0);
    CGContextAddLineToPoint(context, width, 15-widthSP);
    CGContextAddLineToPoint(context, width, 15);
    CGContextAddLineToPoint(context, width-(15-lineWidth), lineWidth);
    CGContextAddLineToPoint(context, 15-lineWidth, lineWidth);
    CGContextAddLineToPoint(context, 0, 15);
    CGContextClosePath(context);
    [_triangleColor setFill];
    

    
    CGContextMoveToPoint(context, 0, height-(15-widthSP));
    CGContextAddLineToPoint(context, 15-widthSP, height-0);
    CGContextAddLineToPoint(context, width-(15-widthSP), height-0);
    CGContextAddLineToPoint(context, width, height-(15-widthSP));
    CGContextAddLineToPoint(context, width, height-15);
    CGContextAddLineToPoint(context, width-(15-lineWidth), height-lineWidth);
    CGContextAddLineToPoint(context, 15-lineWidth, height-lineWidth);
    CGContextAddLineToPoint(context, 0, height-15);
    CGContextClosePath(context);
    [_triangleColor setFill];
    
//    CGContextMoveToPoint(context, 0, 15-widthSP);
//    CGContextAddLineToPoint(context, lineWidth, 15-widthSP);
//    CGContextAddLineToPoint(context, lineWidth, height-(15-widthSP));
//    CGContextAddLineToPoint(context, 0, height-(15-widthSP));
//    CGContextClosePath(context);
//    [_triangleColor setFill];
    
//    CGContextMoveToPoint(context, width, 15-widthSP);
//    CGContextAddLineToPoint(context, width-lineWidth, 15-widthSP);
//    CGContextAddLineToPoint(context, width-lineWidth, height-(15-widthSP));
//    CGContextAddLineToPoint(context, width, height-(15-widthSP));
//    CGContextClosePath(context);
//    [_triangleColor setFill];

//    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextDrawPath(context, kCGPathFill);


}
@end
