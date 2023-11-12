import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ForgetPasswordScreenTopImage extends StatelessWidget {
  const ForgetPasswordScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding * 1),
        Text(
          "Forget Password?",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset(
                "assets/images/forgetpassword.png",
                height: 200,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
        Text(
          "Enter your email address to get the",
          style: TextStyle(fontSize: 14, color: Color(0xff667085)),
        ),
        SizedBox(height: 8),
        Text(
          "password reset link",
          style: TextStyle(fontSize: 14, color: Color(0xff667085)),
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
