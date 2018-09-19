//
//  CurrentAppData.h
//  OSt-OSX
//
//  Created by GM Test on 9/17/18.
//  Copyright © 2018 com.ost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentAppData : NSObject {
    NSString* _title;
    AXUIElementRef _systemWide;
    AXUIElementRef _app;
    AXUIElementRef _window;
}
+ (id) valueOfExistingAttribute:(CFStringRef)attribute ofUIElement:(AXUIElementRef)element;
+ (NSString *)descriptionOfValue:(CFTypeRef)theValue beingVerbose:(BOOL)beVerbose;
+ (NSString *)stringDescriptionOfAXValue:(CFTypeRef)valueRef beingVerbose:(BOOL)beVerbose;
@end
