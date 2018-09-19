//
//  CurrentAppData.m
//  OSt-OSX
//
//  Created by GM Test on 9/17/18.
//  Copyright © 2018 com.ost. All rights reserved.
//

#import "CurrentAppData.h"
#import "UIElementUtilities.h"

@implementation CurrentAppData
+ (id) valueOfExistingAttribute:(CFStringRef)attribute ofUIElement:(AXUIElementRef)element
{
    id result = nil;
    NSArray *attrNames;
    
    AXUIElementCopyAttributeNames(element, (void *)&attrNames);
    
    return result;
}

+ (NSString *)descriptionOfValue:(CFTypeRef)theValue beingVerbose:(BOOL)beVerbose
{
    NSString *  theValueDescString  = NULL;
    
    if (theValue) {
        
        if (AXValueGetType(theValue) != kAXValueIllegalType) {
            theValueDescString = [self stringDescriptionOfAXValue:theValue beingVerbose:beVerbose];
        }
        else if (CFGetTypeID(theValue) == CFArrayGetTypeID()) {
            theValueDescString = [NSString stringWithFormat:@"<array of size %lu>", (unsigned long)[(__bridge NSArray *)theValue count]];
        }
        else if (CFGetTypeID(theValue) == AXUIElementGetTypeID()) {
            
            NSString *  uiElementRole   = NULL;
            
            if (AXUIElementCopyAttributeValue( (AXUIElementRef)theValue, kAXRoleAttribute, (void *)&uiElementRole ) == kAXErrorSuccess) {
                NSString *  uiElementTitle  = NULL;
                
                uiElementTitle = [self valueOfAttribute:NSAccessibilityTitleAttribute ofUIElement:(AXUIElementRef)theValue];
                
                #if 0
                // hack to work around cocoa app objects not having titles yet
                if (uiElementTitle == nil && [uiElementRole isEqualToString:(NSString *)kAXApplicationRole]) {
                    pid_t               theAppPID = 0;
                    ProcessSerialNumber theAppPSN = {0,0};
                    NSString *          theAppName = NULL;
                    
                    if (AXUIElementGetPid( (AXUIElementRef)theValue, &theAppPID ) == kAXErrorSuccess
                        && GetProcessForPID( theAppPID, &theAppPSN ) == noErr
                        && CopyProcessName( &theAppPSN, (CFStringRef *)&theAppName ) == noErr ) {
                        uiElementTitle = theAppName;
                    }
                }
                #endif
                
                if (uiElementTitle != nil) {
                    theValueDescString = [NSString stringWithFormat:@"<%@: “%@”>", uiElementRole, uiElementTitle];
                }
                else {
                    theValueDescString = [NSString stringWithFormat:@"<%@>", uiElementRole];
                }
            }
            else {
                theValueDescString = [(__bridge id)theValue description];
            }
        }
        else {
            theValueDescString = [(__bridge id)theValue description];
        }
    }
    
    return theValueDescString;
}

+ (NSString *)stringDescriptionOfAXValue:(CFTypeRef)valueRef beingVerbose:(BOOL)beVerbose
{
    NSString *result = @"AXValue???";
    
    switch (AXValueGetType(valueRef)) {
        case kAXValueCGPointType: {
            CGPoint point;
            if (AXValueGetValue(valueRef, kAXValueCGPointType, &point)) {
                if (beVerbose)
                    result = [NSString stringWithFormat:@"<AXPointValue x=%g y=%g>", point.x, point.y];
                else
                    result = [NSString stringWithFormat:@"x=%g y=%g", point.x, point.y];
            }
            break;
        }
        case kAXValueCGSizeType: {
            CGSize size;
            if (AXValueGetValue(valueRef, kAXValueCGSizeType, &size)) {
                if (beVerbose)
                    result = [NSString stringWithFormat:@"<AXSizeValue w=%g h=%g>", size.width, size.height];
                else
                    result = [NSString stringWithFormat:@"w=%g h=%g", size.width, size.height];
            }
            break;
        }
        case kAXValueCGRectType: {
            CGRect rect;
            if (AXValueGetValue(valueRef, kAXValueCGRectType, &rect)) {
                if (beVerbose)
                    result = [NSString stringWithFormat:@"<AXRectValue  x=%g y=%g w=%g h=%g>", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
                else
                    result = [NSString stringWithFormat:@"x=%g y=%g w=%g h=%g", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
            }
            break;
        }
        case kAXValueCFRangeType: {
            CFRange range;
            if (AXValueGetValue(valueRef, kAXValueCFRangeType, &range)) {
                if (beVerbose)
                    result = [NSString stringWithFormat:@"<AXRangeValue pos=%ld len=%ld>", range.location, range.length];
                else
                    result = [NSString stringWithFormat:@"pos=%ld len=%ld", range.location, range.length];
            }
            break;
        }
        default:
            break;
    }
    return result;
}

+ (id)valueOfAttribute:(NSString *)attribute ofUIElement:(AXUIElementRef)element
{
    id result = nil;
    NSArray *attributeNames = [UIElementUtilities attributeNamesOfUIElement:element];
    if (attributeNames) {
        AXUIElementCopyAttributeValue(element, (CFStringRef)attribute, (void *)&result);
    }
    return result;
}
@end
