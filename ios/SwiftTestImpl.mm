#import "SwiftTest.h"

// Import the Swift-generated header
#if __has_include("SwiftTest-Swift.h")
#import "SwiftTest-Swift.h"
#elif __has_include(<SwiftTest/SwiftTest-Swift.h>)
#import <SwiftTest/SwiftTest-Swift.h>
#endif

@implementation SwiftTestImpl

+ (NSNumber *)multiply:(double)a b:(double)b {
    // Call the Swift implementation
    return [SwiftTestSwift multiply:a b:b];
}

@end
