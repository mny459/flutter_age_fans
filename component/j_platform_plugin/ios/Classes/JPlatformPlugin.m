#import "JPlatformPlugin.h"
#if __has_include(<j_platform_plugin/j_platform_plugin-Swift.h>)
#import <j_platform_plugin/j_platform_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "j_platform_plugin-Swift.h"
#endif

@implementation JPlatformPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJPlatformPlugin registerWithRegistrar:registrar];
}
@end
