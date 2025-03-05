#import "SwiftTest.h"

// Import C++ spec in implementation file only
#ifdef __cplusplus
#import "generated/RNSwiftTestSpec/RNSwiftTestSpec.h"
#endif

@implementation SwiftTest
RCT_EXPORT_MODULE()

// Explicitly declare conformance to the protocol
@synthesize turboModuleRegistry = _turboModuleRegistry;

- (NSNumber *)multiply:(double)a b:(double)b {
    // Call the Swift implementation
    return [SwiftTestImpl multiply:a b:b];
}

#ifdef __cplusplus
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSwiftTestSpecJSI>(params);
}
#endif

@end
