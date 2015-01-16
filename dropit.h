//
//  dropit.h
//  Dropit
//
//  Created by QuXiaoyin on 1/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dropit : UIDynamicBehavior
-(void)addItem:(id <UIDynamicItem> )item;
-(void)removeItem:(id <UIDynamicItem> )item;

@end
