//
//  ViewController.m
//  Dropit
//
//  Created by QuXiaoyin on 1/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "ViewController.h"
#import "dropit.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong,nonatomic)UIDynamicAnimator *animator;

//@property (strong,nonatomic)UIGravityBehavior *gravity;
//@property (strong,nonatomic)UICollisionBehavior *collider;
@property (strong,nonatomic)dropit *dropitBehavior;
@property (strong,nonatomic)UIAttachmentBehavior *attachment;
@property (strong,nonatomic) UIView *droppingView;

@end

@implementation ViewController

static const CGSize DROPSIZE = {40,40};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    //tell where we pan
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if (sender.state == UIGestureRecognizerStateBegan){
        [self attachDroppingViewToPoint:gesturePoint];
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
        self.attachment.anchorPoint = gesturePoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachment];
    }
}

-(void)attachDroppingViewToPoint:(CGPoint)anchorPoint{
    if (self.droppingView){
        self.attachment = [[UIAttachmentBehavior alloc]initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        self.attachment.action = ^{UIBezierPath *path = [[UIBezierPath alloc]init];
            [path moveToPoint:self.attachment.anchorPoint];
            [path addLineToPoint:self.droppingView.center];
            self.gameView.path = path;};
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
    }
    
}

-(void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROPSIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width)/DROPSIZE.width;
    frame.origin.x = x * DROPSIZE.width;
    
    UIView *dropView = [[UIView alloc]initWithFrame:frame];
    dropView.backgroundColor =[self randomColor];
    [self.gameView addSubview:dropView];
    self.droppingView = dropView;
    
    //[self.gravity addItem:dropView];
    //[self.collider addItem:dropView];
    [self.dropitBehavior addItem:dropView];
}
-(UIDynamicAnimator *)animator{
    if (!_animator){
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        _animator.delegate =self;
    }return _animator;
}

//-(UICollisionBehavior *)collider{
    //if (!_collider){_collider = [[UICollisionBehavior alloc]init];
       // _collider.translatesReferenceBoundsIntoBoundary = YES;
        //[self.animator addBehavior:_collider];
   // }
   // return _collider;
//}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompletedRow];
}

-(BOOL)removeCompletedRow{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc]init];
    for (CGFloat y=self.gameView.bounds.size.height- DROPSIZE.height/2; y>0; y-= DROPSIZE.height){
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc]init];
        for (CGFloat x = DROPSIZE.width/2; x<=self.gameView.bounds.size.width-DROPSIZE.width/2; x+=DROPSIZE.width){
            UIView *hitView = [self.gameView hitTest:CGPointMake(x,y) withEvent:NULL];
            if ([hitView superview] ==self.gameView){
                [dropsFound addObject:hitView];
            }
            else{
                rowIsComplete = NO;
                break;}
            if (![dropsFound count]) break;
            if(rowIsComplete)[dropsToRemove addObjectsFromArray:dropsFound];
        }
        if ([dropsToRemove count]){
            for (UIView *drop in dropsToRemove){
                [self.dropitBehavior removeItem:drop];
            }[self animateRemovingDrops:dropsToRemove];
        }
    }
    return NO;
}

-(void)animateRemovingDrops:(NSArray *)drops{
    [UIView animateWithDuration:1.0 animations:^{
        for (UIView *drop in drops){
            int x = (arc4random() % (int)(self.gameView.bounds.size.width*5))-(int)self.gameView.bounds.size.width*2;
            int y = self.gameView.bounds.size.height;
            drop.center = CGPointMake(x, -y);
        }
    }completion:^(BOOL finished){
    [drops makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}
-(dropit *)dropitBehavior{
    if (!_dropitBehavior){
        _dropitBehavior = [[dropit alloc]init];
        [self.animator addBehavior:_dropitBehavior];}
    return _dropitBehavior;
}

//-(UIGravityBehavior *)gravity{
   // if (!_gravity) {
       // _gravity = [[UIGravityBehavior alloc]init];
       // _gravity.magnitude = 2;
       // [self.animator addBehavior:_gravity];
//}
    //return _gravity;}


-(UIColor *)randomColor{
    switch (arc4random()%5) {
        case 0:
            return [UIColor greenColor];
        case 1:
            return [UIColor redColor];
        case 2:
            return [UIColor blueColor];
        case 3:
            return [UIColor orangeColor];
        case 4:
            return [UIColor yellowColor];
    }
    return [UIColor blackColor];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
