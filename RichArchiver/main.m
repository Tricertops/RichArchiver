//
//  main.m
//  RichArchiver
//
//  Created by Martin Kiss on 4.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//
/***   OS X   ***/

#import "RTUIFont.h"
#import "RTUIColor.h"

@interface NSFileHandle (WriteString)
- (void)writeString:(NSString *)format, ...;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *arguments = [[NSProcessInfo processInfo] arguments]; //Fuck C!
        
        NSString *executableName = [[arguments objectAtIndex:0] lastPathComponent];
        NSString *usage = [NSString stringWithFormat:@"%@ [-h][--help] <output> [--] <input> ...", executableName];
        NSMutableArray *paths = [[NSMutableArray alloc] init];
        
        /**********   R E A D   A R G U M E N T S   **********/
        for (NSUInteger index = 1; index < arguments.count; index++) {
            NSString *argument = [arguments objectAtIndex:index];
            
            if ([argument isEqualToString:@"-h"] ||
                [argument isEqualToString:@"--help"]) {
                [[NSFileHandle fileHandleWithStandardOutput] writeString:@"RichArchiver, version 1.0 by iMartin\n\nArchives RTF, HTML or DOC(X) file to NSAttributedString so they can be unarchived on iOS using NSKeyedUnarchiver. Root object of the archive is NSDictionary containing filenames without extension as keys and instances of NSAttributedString as objects.\n\nUsage: %@\n", usage];
                exit(EXIT_SUCCESS);
            }
            if ([argument isEqualToString:@"--"]) {
                continue;
            }
            [paths addObject:argument];
        }
        
        /**********   P R O C E S S   P A T H S   **********/
        if (paths.count < 2) {
            [[NSFileHandle fileHandleWithStandardError] writeString:@"%@: at least two paths are required: output and input\n\nUsage: %@\n", executableName, usage];
            exit(EXIT_FAILURE);
        }
        
        NSString *outputPath = [paths objectAtIndex:0];
        NSArray *inputPaths = [paths subarrayWithRange:NSMakeRange(1, paths.count -1)];
        
        /**********   L O A D   F I L E S   **********/
        NSMutableDictionary *archiveBuilder = [[NSMutableDictionary alloc] initWithCapacity:paths.count -1];
        
        for (NSString *inputPath in inputPaths) {
            
            NSData *fileContent = [[NSData alloc] initWithContentsOfFile:inputPath];
            if ( ! fileContent) {
                [[NSFileHandle fileHandleWithStandardError] writeString:@"%@: '%@': failed to read\n", executableName, inputPath];
                continue;
            }
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:fileContent options:nil documentAttributes:nil error:nil];
            if ( ! attributedString) {
                [[NSFileHandle fileHandleWithStandardError] writeString:@"%@: '%@': unsupported format\n", executableName, inputPath];
                continue;
            }
            
            NSString *fileKey = [[inputPath lastPathComponent] stringByDeletingPathExtension];
            if ([archiveBuilder objectForKey:fileKey]) {
                [[NSFileHandle fileHandleWithStandardError] writeString:@"%@: two files named '%@' were specified, using '%@'\n", executableName, fileKey, inputPath];
            }
            [archiveBuilder setObject:attributedString forKey:fileKey];
            
            [[NSFileHandle fileHandleWithStandardOutput] writeString:@"%@ - '%@'\n", inputPath, fileKey];
        }
        
        NSDictionary *immutableArchive = [[NSDictionary alloc] initWithDictionary:archiveBuilder];
        
        /**********   A R C H I V E   **********/
        [NSFont setShouldArchiveAsUIFont:YES];
        [NSColor setShouldArchiveAsUIColor:YES];
        
        [NSKeyedArchiver setClassName:@"UIFont" forClass:[RTUIFont class]];
        [NSKeyedArchiver setClassName:@"UIColor" forClass:[RTUIColor class]];
        BOOL success = [NSKeyedArchiver archiveRootObject:immutableArchive toFile:outputPath];
        
        [NSFont setShouldArchiveAsUIFont:NO];
        [NSColor setShouldArchiveAsUIColor:NO];
        
        if ( ! success) {
            [[NSFileHandle fileHandleWithStandardError] writeString:@"%@: '%@': could not write archive\n", executableName, outputPath];
            exit(EXIT_FAILURE);
        }
        
        exit(EXIT_SUCCESS);
    }
    return 0;
}





@implementation NSFileHandle (WriteString)

- (void)writeString:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self writeData:[formattedString dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
