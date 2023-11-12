import 'package:brainepadia/responsive.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import 'components/otpcode_form.dart';
import 'components/screen_top_image.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: MobileLoginScreen(),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: OTPCodeForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
