import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ScreenTopImage extends StatelessWidget {
  const ScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: defaultPadding * 3),
        Text(
          "OTP Verification",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        SizedBox(height: defaultPadding * 4),
        Text(
          "Enter OTP",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
        SizedBox(height: defaultPadding * 2),
        Text(
          "Enter the OTP code we just sent you on",
          style: TextStyle(fontSize: 14, color: Color(0xff667085)),
        ),
        SizedBox(height: 8),
        Text(
          "your on your registered email",
          style: TextStyle(fontSize: 14, color: Color(0xff667085)),
        ),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }
}
