//
//  WhatColourIsItView.m
//  WhatColourIsIt
//
//  Created by Tuncay Kınalı on 17/12/14.
//  Copyright (c) 2014 Tuncay Kınalı. All rights reserved.
//

#import "WhatColourIsItView.h"

@implementation WhatColourIsItView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
