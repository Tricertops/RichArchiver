//
//  RTUIColor.h
//  RichText
//
//  Created by Martin Kiss on 8.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//
/***   OS X   ***/



@interface RTUIColor : NSObject <NSCoding>

#pragma mark NSColor Wrapper
@property (nonatomic, readonly, strong) NSColor *color;
- (id)initWithNSColor:(NSColor *)color;

@end









#pragma mark -

@interface NSColor (UIColor)

#pragma mark Archivation As UIColor
+ (BOOL)shouldArchiveAsUIColor;
+ (void)setShouldArchiveAsUIColor:(BOOL)shouldArchiveAsUIColor;

#pragma mark Keyed Archiving
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver;

@end
