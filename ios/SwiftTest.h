#import <React/RCTBridgeModule.h>
#import <ReactCommon/RCTTurboModule.h>

// Swift bridge object implementation
@interface SwiftTestImpl : NSObject
+ (NSNumber *)multiply:(double)a b:(double)b;
@end

// Main module - protocols are handled in .mm file
@interface SwiftTest : NSObject <RCTBridgeModule>
// This property is required for TurboModule compatibility
@property(nonatomic, weak, nullable) id<RCTTurboModuleRegistry> turboModuleRegistry;
@end
