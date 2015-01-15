//
//  dropit.m
//  Dropit
//
//  Created by QuXiaoyin on 1/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "dropit.h"
@interface dropit()
@property (strong,nonatomic)UIGravityBehavior *gravity;
@property (strong,nonatomic)UICollisionBehavior *collider;
@end


@implementation dropit

-(UICollisionBehavior *)collider{
    if (!_collider){_collider = [[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;

    }
    return _collider;
}


-(UIGravityBehavior *)gravity{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 0.9;
        
    }
    return _gravity;}

-(void)addItem:(id <UIDynamicItem> )item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
}
-(void)removeItem:(id <UIDynamicItem> )item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];

}
-(instancetype) init{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    
    return  self;
}
@end
