import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:add_to_wallet/add_to_wallet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

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
                  unsupportedPlatformChild: DownloadPass(pkPass: _pkPassData),
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

class DownloadPass extends StatelessWidget {
  final List<int> pkPass;

  const DownloadPass({Key? key, required this.pkPass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _onPressed, child: Text('🧷 pkpass'));
  }

  void _onPressed() async {
    print("The button was pressed, we could let the user download the pass for instance!");
    File passFile = await writePassFile();
    Share.shareFiles([passFile.path], text: "Here is your pkPass!");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localPassFile async {
    final path = await _localPath;
    return File('$path/pass.pkpass');
  }

  Future<File> writePassFile() async {
    final file = await _localPassFile;
    return file.writeAsBytes(pkPass);
  }
}
