import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 2),
        const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        const SizedBox(height: defaultPadding * 1),
        Row(
          children: [
            const Spacer(),
            // Expanded(
            //   flex: 5,
            //   child: SvgPicture.asset("assets/icons/login.svg"),
            // ),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/login_img.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
