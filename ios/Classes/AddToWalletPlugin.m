#import "AddToWalletPlugin.h"
#if __has_include(<add_to_wallet/add_to_wallet-Swift.h>)
#import <add_to_wallet/add_to_wallet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "add_to_wallet-Swift.h"
#endif

@implementation AddToWalletPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAddToWalletPlugin registerWithRegistrar:registrar];
}
@end
