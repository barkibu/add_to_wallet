import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddToWalletButton extends StatelessWidget {
  final List<int> pkPass;
  final double width;
  final double height;
  final Widget? unsupportedPlatformChild;

  AddToWalletButton(
      {Key? key,
      required this.pkPass,
      required this.width,
      required this.height,
      this.unsupportedPlatformChild})
      : super(key: key);

  static const viewType = 'PKAddPassButton';

  get uiKitCreationParams => {'width': width, 'height': height, 'pass': pkPass};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: platformWidget(context),
    );
  }

  Widget platformWidget(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: Directionality.of(context),
          creationParams: uiKitCreationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        if (unsupportedPlatformChild == null)
          throw UnsupportedError('Unsupported platform view');
        return unsupportedPlatformChild!;
    }
  }
}
