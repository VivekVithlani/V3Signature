//
//  V3SignatureView.m
//  V3SignatureView
//
//  Created by Vivek Vithlani on 31/07/14.
//  Copyright (c) 2014 com.v3Signature. All rights reserved.
//

#import "V3SignatureView.h"

@implementation V3SignatureView
{
    UIBezierPath *path;
}

@synthesize arrPoints;
@synthesize previousPoint;
@synthesize erazerMode;
@synthesize strockColor;
@synthesize strockWidth;
@synthesize erazerStrockWidth;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initialize];

    }
    return self;
}

- (void)_initialize {
    self.userInteractionEnabled = YES;
    [self setErazerMode:false];
    strockWidth = 2.0;
    erazerStrockWidth = 10.0;
    strockColor = [UIColor blackColor];
    path = [[UIBezierPath alloc] init];
}
#pragma mark - Tough Delegate
/*------------------------------------------------------------------
 Procedure/Function Name: touchesBegan
 Purpose: Tough Began
 ------------------------------------------------------------------*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //fPoint = [touches.anyObject locationInView:self.view];
    self.previousPoint = [touches.anyObject locationInView:self];
    [self.arrPoints addObject:NSStringFromCGPoint(self.previousPoint)];
    
    [path moveToPoint:self.previousPoint];
}
/*------------------------------------------------------------------
 Procedure/Function Name: touchesMoved
 Purpose: Tough Moved
 ------------------------------------------------------------------*/
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [touches.anyObject locationInView:self];
    if (self.erazerMode) {
        [self removeDrawLine:self.previousPoint toPoint:currentPoint];
    }
    else
    {
        [self drawLine:self.previousPoint toPoint:currentPoint lineColor:strockColor];
    }
    self.previousPoint = currentPoint;
    [self.arrPoints addObject:NSStringFromCGPoint(currentPoint)];
}

#pragma mark - DrawLine
/*------------------------------------------------------------------
 Procedure/Function Name: drawLine
 Purpose: Draw Line on ImageView
 ------------------------------------------------------------------*/
-(void)drawLine:(CGPoint)fromPoint toPoint:(CGPoint)toPoint lineColor:(UIColor*)color  {
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1.0);
    // Pass 1: Draw the original image as the background
    [self.image drawAtPoint:CGPointMake(0, 0)];
    
    // Pass 2: Draw the line on top of original image
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.strockWidth);
    
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextMoveToPoint(context, fromPoint.x,fromPoint.y);
    
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    CGContextStrokePath(context);
    
    // Create new image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newImage;
}

#pragma mark - Remove Draw Line
/*------------------------------------------------------------------
 Procedure/Function Name: removeDrawLine
 Purpose: Remove Draw Line
 ------------------------------------------------------------------*/
-(void)removeDrawLine:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
    //    UIGraphicsBeginImageContext(self.view.frame.size);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1.0);
    
    // Pass 1: Draw the original image as the background
    [self.image drawAtPoint:CGPointMake(0,0)];
    
    // Pass 2: Draw the line on top of original image
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.erazerStrockWidth);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    CGContextMoveToPoint(context, fromPoint.x,fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    
    CGContextStrokePath(context);
    
    // Create new image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
