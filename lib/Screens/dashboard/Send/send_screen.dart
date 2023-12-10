
import 'package:flutter/material.dart';

import 'components/send_form.dart';
import 'components/send_screen_top_image.dart';

class Send extends StatelessWidget {
  const Send({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Send',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          )),
      body: const MobileLoginScreen(),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SendScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: SendForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
