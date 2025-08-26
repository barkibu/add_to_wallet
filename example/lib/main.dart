import 'package:flutter/material.dart';
import 'dart:async';

import 'package:add_to_wallet/add_to_wallet.dart';

import 'pass_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _passLoaded = false;
  List<int> _pkPassData = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final pass = await passProvider();

    if (!mounted) return;

    setState(() {
      _pkPassData = pass;
      _passLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add to Wallet example App'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('A single button app!'),
              if (_passLoaded)
                AddToWalletButton(
                  pkPass: _pkPassData,
                  width: 150,
                  height: 30,
                  unsupportedPlatformChild: Text('Unsupported Platform'),
                  onPressed: () {
                    print("🎊Add to Wallet button Pressed!🎊");
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
