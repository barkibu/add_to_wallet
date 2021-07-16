import Flutter
import PassKit
import UIKit

import Flutter
import UIKit

class PKAddPassButtonNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PKAddPassButtonNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args as! [String: Any],
            binaryMessenger: messenger)
    }
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class PKAddPassButtonNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _pass: FlutterStandardTypedData
    private var _width: CGFloat
    private var _height: CGFloat

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: [String: Any],
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _pass = args["pass"] as! FlutterStandardTypedData
        _width = args["width"] as? CGFloat ?? 140
        _height = args["height"] as? CGFloat ?? 30
        super.init()
        createAddPassButton()
    }

    func view() -> UIView {
        _view
    }

    func createAddPassButton() {
        let passButton = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.black)
        passButton.frame = CGRect(x: 0, y: 0, width: _width, height: _height)
        passButton.addTarget(self, action: #selector(passButtonAction), for: .touchUpInside)
        _view.addSubview(passButton)
    }

    @objc func passButtonAction() {
        var newPass: PKPass
        do {
            newPass = try PKPass(data: _pass.data)
        } catch {
            print("No valid Pass data passed")
            return
        }
        guard let addPassViewController = PKAddPassesViewController(pass: newPass) else {
            print("View controller messed up")
            return
        }

        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            print("Root VC unavailable")
            return
        }
        rootVC.present(addPassViewController, animated: true)
    }
}

public class SwiftAddToWalletPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "add_to_wallet", binaryMessenger: registrar.messenger())
    let instance = SwiftAddToWalletPlugin()
    let factory = PKAddPassButtonNativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "PKAddPassButton")
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        return result(FlutterMethodNotImplemented)
    }
}
