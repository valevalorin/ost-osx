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

AXUIElementRef _systemWide;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSLog(@"Yoooooo");
    _systemWide = AXUIElementCreateSystemWide();
    
    // Shpue, we need to run this VVVVVV every 30ms 
    [self updateCurrentApplication];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void) updateCurrentApplication {
    // get the currently active application
    AXUIElementRef _app = (__bridge AXUIElementRef) [CurrentAppData
                                   valueOfExistingAttribute:kAXFocusedApplicationAttribute
                                   ofUIElement:_systemWide];
    
    // Get the window that has focus for this application
    AXUIElementRef _window = (__bridge AXUIElementRef)[CurrentAppData
                                     valueOfExistingAttribute:kAXFocusedWindowAttribute
                                     ofUIElement:_app];
    
    NSString* appName = [CurrentAppData descriptionOfValue:_window
                                              beingVerbose:TRUE];
    NSLog(@"%@", appName);
}


@end
