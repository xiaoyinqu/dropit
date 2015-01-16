//
//  BezierPathView.m
//  Dropit
//
//  Created by QuXiaoyin on 1/16/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView
-(void)setPath:(UIBezierPath *)path{
    _path = path;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}


@end
