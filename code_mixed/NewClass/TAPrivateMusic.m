//
//  TAPrivateMusic.m
//  JLGP
//
//   9/17.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAPrivateMusic.h"

@implementation TAPrivateMusic

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
