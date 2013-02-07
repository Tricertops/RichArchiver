//
//  RTUIColor.m
//  RichText
//
//  Created by Martin Kiss on 8.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//
/***   OS X   ***/

#import "RTUIColor.h"



@interface RTUIColor ()

#pragma mark NSColor
@property (nonatomic, readwrite, strong) NSColor *color;

@end









#pragma mark -

@implementation RTUIColor



#pragma mark NSColor Wrapper

- (id)initWithNSColor:(NSColor *)color {
    self = [super init];
    if (self) {
        self.color = color;
    }
    return self;
}



#pragma mark Coding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        CGFloat red = [decoder decodeFloatForKey:@"UIRed"];;
        CGFloat green = [decoder decodeFloatForKey:@"UIGreen"];
        CGFloat blue = [decoder decodeFloatForKey:@"UIBlue"];
        CGFloat alpha = [decoder decodeFloatForKey:@"UIAlpha"];
        self.color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if ([self.color.colorSpaceName isEqualToString:NSCalibratedRGBColorSpace] ||
        [self.color.colorSpaceName isEqualToString:NSDeviceRGBColorSpace]) {
        [coder encodeFloat:self.color.redComponent forKey:@"UIRed"];
        [coder encodeFloat:self.color.greenComponent forKey:@"UIGreen"];
        [coder encodeFloat:self.color.blueComponent forKey:@"UIBlue"];
        [coder encodeFloat:self.color.alphaComponent forKey:@"UIAlpha"];
        [coder encodeInteger:4 forKey:@"UIColorComponentCount"];
    }
    else if ([self.color.colorSpaceName isEqualToString:NSDeviceWhiteColorSpace]) {
        [coder encodeFloat:self.color.whiteComponent forKey:@"UIRed"];
        [coder encodeFloat:self.color.whiteComponent forKey:@"UIGreen"];
        [coder encodeFloat:self.color.whiteComponent forKey:@"UIBlue"];
        [coder encodeFloat:self.color.alphaComponent forKey:@"UIAlpha"];
        [coder encodeInteger:4 forKey:@"UIColorComponentCount"];
    }
}



@end









#pragma mark -

@implementation NSColor (UIColor)



#pragma mark Archivation As UIColor

static BOOL _shouldArchiveAsUIColor = NO;

+ (BOOL)shouldArchiveAsUIColor {
    return _shouldArchiveAsUIColor;
}

+ (void)setShouldArchiveAsUIColor:(BOOL)shouldArchiveAsUIColor {
    _shouldArchiveAsUIColor = shouldArchiveAsUIColor;
}



#pragma mark Keyed Archiving

- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver {
    if ([[self class] shouldArchiveAsUIColor]) {
        return [[RTUIColor alloc] initWithNSColor:self];
    }
    else {
        return nil;
    }
}



@end
