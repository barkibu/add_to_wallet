# AddToWallet Flutter plugin

A flutter plugin exposing the native `Add To Wallet` iOS button.

## How

This plugin registers a native view factory and exposes it as a stateful widget into any flutter ecosystem. The intended use is for iOS mobile platform but the plugin should be safely usable in any other if you provide the widget with a `unsupportedPlatformChild` child widget.

## References

- How this works under the carpet: https://flutter.dev/docs/development/platform-integration/platform-views
