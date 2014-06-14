//
//  MoneySprite.m
//  RainingMoney
//
//  Created by Lapin, Andy (KBB) on 6/13/14.
//  Copyright (c) 2014 Kelley Blue Book. All rights reserved.
//

#import "MoneySpriteNode.h"

@implementation MoneySpriteNode

- (void)startMoving
{
    double moveDuration = (double)(arc4random() % 3) + 3.0;
    double rotateSpeed = (double)(arc4random() % 5) + 3.0;
    int numberOfRotations = (int)ceil(moveDuration / rotateSpeed);
    
    CGPoint moveToPosition = [self randomizeOffScreenCoordinates];
    SKAction *moveAction = [SKAction moveTo:moveToPosition duration:moveDuration];
    SKAction *oneRevolution = [SKAction rotateByAngle:-M_PI*2 duration:rotateSpeed];
    SKAction *rotateAction = [SKAction repeatAction:oneRevolution count:numberOfRotations];
    SKAction *rotateAndMove = [SKAction group:@[moveAction, rotateAction]];
    SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        //NSLog(@"Animation Completed");
        self.hidden = YES;
    }];
    
    SKAction *moveBillActionWithDone = [SKAction sequence:@[rotateAndMove, doneAction ]];
    [self runAction:moveBillActionWithDone];
}

- (CGPoint)randomizeOffScreenCoordinates
{
    int xOrY = arc4random() % 4;
    CGFloat xCoordinate;
    CGFloat yCoordinate;
    SKScene *currentScene = self.scene;
    CGFloat width = 177.0f;
    NSLog(@"Sprite width: %f", width);
    
    switch (xOrY) {
        case 0:
            // Left side
            xCoordinate = width * -1.0f;
            yCoordinate = (CGFloat)(arc4random() % (int)currentScene.frame.size.height);
            break;
            
        case 1:
            // Top
            xCoordinate = (CGFloat)(arc4random() % (int)currentScene.frame.size.width);
            yCoordinate = currentScene.frame.size.height + width;
            break;
            
        case 2:
            // Right side
            xCoordinate = currentScene.frame.size.width + width;
            yCoordinate = (CGFloat)(arc4random() % (int)currentScene.frame.size.height);
            break;
            
        case 3:
            // Bottom
            xCoordinate = (CGFloat)(arc4random() % (int)currentScene.frame.size.width);
            yCoordinate = width * -1.0f;
            break;
            
        default:
            break;
    }
    
    return CGPointMake(xCoordinate, yCoordinate);
}

@end
