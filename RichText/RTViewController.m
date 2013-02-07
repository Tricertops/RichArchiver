//
//  RTViewController.m
//  RichText
//
//  Created by Martin Kiss on 4.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//

#import "RTViewController.h"



@interface RTViewController ()

@end









@implementation RTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *richPath = @"/Users/Martin/Desktop/Project/Strings.rich";
    NSDictionary *richArchive = [NSKeyedUnarchiver unarchiveObjectWithFile:richPath];
        
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.attributedText = [richArchive objectForKey:@"Text-Article"];
    label.numberOfLines = 0;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:label];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}



@end
