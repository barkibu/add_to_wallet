import 'dart:async';

import 'package:flutter/services.dart';

export 'widgets/add_to_wallet_button.dart';

class AddToWallet {
  static const MethodChannel _channel = const MethodChannel('add_to_wallet');

  static final AddToWallet _instance = AddToWallet._internal();

  /// Associate each rendered Widget to its `onPressed` event handler
  static final Map<String, FutureOr<dynamic> Function(MethodCall)> _handlers = Map();

  factory AddToWallet() {
    return _instance;
  }

  AddToWallet._internal() {
    _initMethodCallHandler();
  }

  void _initMethodCallHandler() => _channel.setMethodCallHandler(_handleCalls);

  Future<dynamic> _handleCalls(MethodCall call) async {
    var handler = _handlers[call.arguments['key']];
    return handler != null ? await handler(call) : null;
  }

  Future<void> addHandler<T>(String key, FutureOr<T> Function(MethodCall) handler) async {
    _handlers[key] = handler;
  }

  void removeHandler(String key) {
    _handlers.remove(key);
  }
}
