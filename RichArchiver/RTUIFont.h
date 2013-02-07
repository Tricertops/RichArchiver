//
//  RTUIFont.h
//  RichText
//
//  Created by Martin Kiss on 8.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//
/***   OS X   ***/



@interface RTUIFont : NSObject <NSCoding>

#pragma mark NSFont Wrapper
@property (nonatomic, readonly, strong) NSFont *font;
- (id)initWithNSFont:(NSFont *)font;

@end









#pragma mark -

@interface NSFont (UIFont)

#pragma mark Archivation As UIFont
+ (BOOL)shouldArchiveAsUIFont;
+ (void)setShouldArchiveAsUIFont:(BOOL)shouldArchiveAsUIFont;

#pragma mark Keyed Archiving
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver;

@end
