import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

export 'widgets/add_to_wallet_button.dart';

class AddToWallet {
  static const MethodChannel _channel = const MethodChannel('add_to_wallet');
}
