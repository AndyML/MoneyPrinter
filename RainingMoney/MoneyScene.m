//
//  MoneyScene.m
//  RainingMoney
//
//  Created by Lapin, Andy (KBB) on 6/13/14.
//  Copyright (c) 2014 Kelley Blue Book. All rights reserved.
//

#import "MoneyScene.h"
#import "MoneySpriteNode.h"

@interface MoneyScene ()

@property (nonatomic, retain) NSArray *billImages;
@property (nonatomic, assign) NSTimeInterval lastBillTime;
@property (nonatomic, assign) double maxDurationBetweenBills;
@property (nonatomic, assign) CGPoint currentTouchPoint;

@end

@implementation MoneyScene

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        self.billImages = [NSArray arrayWithObjects:@"dollah", @"twenty", @"hundred", nil];
        self.maxDurationBetweenBills = 0.05;
    }
    
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self createSceneContents];
    self.backgroundColor = [UIColor clearColor];
    NSLog(@"SKScene:initWithSize %f x %f", self.size.width, self.size.height);
}

- (void)createSceneContents
{
    // create SKSpriteNodes here and general layout for the scene
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    self.currentTouchPoint = positionInScene;
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    self.currentTouchPoint = positionInScene;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentTouchPoint = CGPointZero;
}

- (void)update:(NSTimeInterval)currentTime
{
    if (!CGPointEqualToPoint(self.currentTouchPoint, CGPointZero) && currentTime >= self.lastBillTime + self.maxDurationBetweenBills)
    {
        int r = arc4random() % self.billImages.count;
        
        MoneySpriteNode *bill = [MoneySpriteNode spriteNodeWithImageNamed:self.billImages[r]];
        bill.position = self.currentTouchPoint;
        int initialRotation = (double)(arc4random() % 360);
        bill.zRotation = (initialRotation) / 180.0 * M_PI;
        [self addChild:bill];
        self.lastBillTime = currentTime;
        NSLog(@"Bill added at %f", currentTime);
        
        [bill startMoving];
    }
}

- (void)createRandomBillAtPosition:(CGPoint)point
{
    
}

@end
