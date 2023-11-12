import 'package:flutter/material.dart';
import 'package:brainepadia/constants.dart';

class ForgetPassword extends StatelessWidget {
  final bool login;
  final Function? press;
  const ForgetPassword({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: press as void Function()?,
          child: const Text(
            "Forget password?",
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
