//
//  IDPRCStyleKit.m
//  ProjectName
//
//  Created by Kaname Noto on 2016/01/20.
//  Copyright (c) 2016 Irimasu Densan Planning. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "IDPRCStyleKit.h"


@implementation IDPRCStyleKit

#pragma mark Cache

static UIColor* _arrowColor = nil;

static UIImage* _imageOfArrow = nil;

#pragma mark Initialization

+ (void)initialize
{
    // Colors Initialization
    _arrowColor = [UIColor colorWithRed: 0.133 green: 0.561 blue: 0.996 alpha: 1];

}

#pragma mark Colors

+ (UIColor*)arrowColor { return _arrowColor; }

#pragma mark Drawing Methods

+ (void)drawArrow
{

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(1, 3.4)];
    [bezierPath addLineToPoint: CGPointMake(3.5, 1)];
    [bezierPath addLineToPoint: CGPointMake(6, 3.4)];
    [bezierPath addLineToPoint: CGPointMake(6, 3.4)];
    [bezierPath addLineToPoint: CGPointMake(6, 3.4)];
    [bezierPath addLineToPoint: CGPointMake(6, 3.4)];
    bezierPath.lineCapStyle = kCGLineCapRound;

    bezierPath.lineJoinStyle = kCGLineJoinRound;

    [IDPRCStyleKit.arrowColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];


    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(3.5, 1.5)];
    [bezier2Path addLineToPoint: CGPointMake(3.5, 7)];
    [bezier2Path addLineToPoint: CGPointMake(3.5, 7)];
    bezier2Path.lineCapStyle = kCGLineCapRound;

    [IDPRCStyleKit.arrowColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
}

#pragma mark Generated Images

+ (UIImage*)imageOfArrow
{
    if (_imageOfArrow)
        return _imageOfArrow;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(8, 8), NO, 0.0f);
    [IDPRCStyleKit drawArrow];

    _imageOfArrow = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfArrow;
}

#pragma mark Customization Infrastructure

- (void)setArrowTargets: (NSArray*)arrowTargets
{
    _arrowTargets = arrowTargets;

    for (id target in self.arrowTargets)
        [target performSelector: @selector(setImage:) withObject: IDPRCStyleKit.imageOfArrow];
}


@end
