import 'package:brainepadia/components/sign_up_bottom.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class ResetpasswordForm extends StatelessWidget {
  const ResetpasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Consumer<Providers>(builder: (context, userState, _) {
              return TextFormField(
                textInputAction: TextInputAction.done,
                cursorColor: kPrimaryColor,
                obscureText: true,
                onChanged: (value) => userState.setOTPCodereset(value),
                decoration: const InputDecoration(
                  hintText: "OTP code",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              );
            }),
          ),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              obscureText: true,
              onChanged: (value) => userState.setPassword(value),
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            );
          }),
          SizedBox(height: defaultPadding),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onChanged: (value) => userState.setConpassword(value),
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            );
          }),
          const SizedBox(height: 15),
          Consumer<Providers>(builder: (context, userState, _) {
            return Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: userState.isLoading
                    ? null
                    : () => userState.resetPassword(context),
                child: userState.isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xFF9739E3),
                      )
                    : Text(
                        "Reset Password",
                      ),
              ),
            );
          }),
          const SizedBox(height: defaultPadding),
          SignupButton(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
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
