import 'package:brainepadia/responsive.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import 'components/resetpassword_form.dart';
import 'components/resetpassword_screen_top_image.dart';

class ResetpasswordScreen extends StatelessWidget {
  const ResetpasswordScreen({Key? key}) : super(key: key);

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
        const LoginScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: ResetpasswordForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
