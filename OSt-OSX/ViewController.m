//
//  ViewController.m
//  OSt-OSX
//
//  Created by GM Test on 9/17/18.
//  Copyright © 2018 com.ost. All rights reserved.
//

#import "ViewController.h"
#import "CurrentAppData.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSLog(@"Initializing Current Application Polling");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                        selector:@selector(appChanged:)
                                                        name:NSWorkspaceDidActivateApplicationNotification
                                                        object:nil];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void) appChanged:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSRunningApplication *app = userInfo[@"NSWorkspaceApplicationKey"];
    NSString *executableUrl = [[app executableURL] absoluteString];
    NSRange range = [executableUrl rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *processName = [executableUrl substringFromIndex:range.location + 1];
    NSLog(@"data == %@", processName);
    
    //Call hook agent executable with 'processName' as it's only argument
    
}


@end
