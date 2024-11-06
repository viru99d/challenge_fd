import 'package:challenge_fd/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenPage extends StatelessWidget {
  const ScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          Constants.assets.logo,
        ),
      ),
    );
  }
}
