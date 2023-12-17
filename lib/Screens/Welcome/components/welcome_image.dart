import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "WELCOME TO BRAINPADIA Wallet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding * 3),
        Row(
          children: [
            const Spacer(),
            // Expanded(
            //   flex: 8,
            //   child: SvgPicture.asset(
            //     "assets/icons/chat.svg",
            //   ),
            // ),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/welcome.png",
                height: 250,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 3),
      ],
    );
  }
}
