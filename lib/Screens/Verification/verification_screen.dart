import 'package:brainepadia/responsive.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import 'components/verification_ui.dart';
import 'components/screen_top_image.dart';

class VerificationScreen extends StatelessWidget {
  

  const VerificationScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: MobileLoginScreen(),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: VerificationUi(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
