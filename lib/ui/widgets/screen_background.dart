import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utills/assets_path.dart';

class ScreenBackground extends StatelessWidget {

  final Widget child;

  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            SvgPicture.asset(
                width: double.maxFinite,
                height: double.maxFinite,
                AssetsPath.backgroundSvg, fit: BoxFit.cover),
            SafeArea(child: child),
          ]
      ),
    );
  }
}
