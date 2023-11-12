import 'package:brainepadia/responsive.dart';
import 'package:flutter/material.dart';

import '../../../components/background.dart';
import 'components/home_content.dart';
import 'components/home_header.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false, body: MobileLoginScreen());
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
        const HomeHeader(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: HomeContent(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
