import 'package:brainepadia/Screens/Otp/otp_verification.dart';
import 'package:brainepadia/components/click_here.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class VerificationUi extends StatelessWidget {
  
  const VerificationUi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Congratulations!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: defaultPadding * 1),
          const Text(
            'We’ve sent you a verification code to your email, please check your inbox or spam folder and follow the instructions to verify your account.',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 14, height: 002, color: Color(0xff667085)),
          ),
          const Text(
            'Thank you for signing up with us!',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 14, height: 002, color: Color(0xff667085)),
          ),
          const SizedBox(height: defaultPadding),
          Clickhere(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OTPVerificationScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
