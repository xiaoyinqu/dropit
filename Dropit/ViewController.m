//
//  ViewController.m
//  Dropit
//
//  Created by QuXiaoyin on 1/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "ViewController.h"
#import "dropit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong,nonatomic)UIDynamicAnimator *animator;
@property (strong,nonatomic)UIGravityBehavior *gravity;
@property (strong,nonatomic)UICollisionBehavior *collider;
@property (strong,nonatomic)dropit *dropitBehavior;

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

-(void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROPSIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width)/DROPSIZE.width;
    frame.origin.x = x * DROPSIZE.width;
    
    UIView *dropView = [[UIView alloc]initWithFrame:frame];
    dropView.backgroundColor =[self randomColor];
    [self.gameView addSubview:dropView];
    
    [self.gravity addItem:dropView];
    [self.collider addItem:dropView];
}
-(UIDynamicAnimator *)animator{
    if (!_animator){
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        
    }return _animator;
}

-(UICollisionBehavior *)collider{
    if (!_collider){_collider = [[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:_collider];
    }
    return _collider;
}

-(dropit *)dropitBehavior{
    if (!_dropitBehavior){
        _dropitBehavior = [[dropit alloc]init];
        [self.animator addBehavior:_dropitBehavior];}
    return _dropitBehavior;
}

-(UIGravityBehavior *)gravity{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 2;
        [self.animator addBehavior:_gravity];
}
    return _gravity;}


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
