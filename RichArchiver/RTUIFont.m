//
//  RTUIFont.m
//  RichText
//
//  Created by Martin Kiss on 8.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//
/***   OS X   ***/

#import "RTUIFont.h"



@interface RTUIFont ()

#pragma mark NSFont Wrapper
@property (nonatomic, readwrite, strong) NSFont *font;

@end







#pragma mark -

@implementation RTUIFont



#pragma mark NSFont Wrapper

- (id)initWithNSFont:(NSFont *)font {
    self = [super init];
    if (self) {
        self.font = font;
    }
    return self;
}



#pragma mark Coding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        NSString *fontName = [decoder decodeObjectForKey:@"UIFontName"];
        CGFloat fontPointSize = [decoder decodeFloatForKey:@"UIFontPointSize"];
        self.font = [NSFont fontWithName:fontName size:fontPointSize];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.font.fontName forKey:@"UIFontName"];
    [coder encodeFloat:self.font.pointSize forKey:@"UIFontPointSize"];
    [coder encodeInteger:0 forKey:@"UIFontTraits"];
    [coder encodeBool:NO forKey:@"UISystemFont"];
}



@end









#pragma mark -

@implementation NSFont (UIFont)



#pragma mark Archivation As UIFont

static BOOL _shouldArchiveAsUIFont = NO;

+ (BOOL)shouldArchiveAsUIFont {
    return _shouldArchiveAsUIFont;
}

+ (void)setShouldArchiveAsUIFont:(BOOL)shouldArchiveAsUIFont {
    _shouldArchiveAsUIFont = shouldArchiveAsUIFont;
}



#pragma mark Keyed Archiving

- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver {
    if ([[self class] shouldArchiveAsUIFont]) {
        return [[RTUIFont alloc] initWithNSFont:self];
    }
    else {
        return nil;
    }
}



@end
