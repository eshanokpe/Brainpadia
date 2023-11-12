import 'package:brainepadia/components/forget_password.dart';
import 'package:brainepadia/components/sign_up_bottom.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onChanged: (value) => userState.setEmail(value),
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            );
          }),
          const SizedBox(height: 30),
          Consumer<Providers>(builder: (context, userState, _) {
            return Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: userState.isLoading
                    ? null
                    : () => userState.forgetpasswordReset(context),
                child: userState.isLoading 
                    ? const CircularProgressIndicator(
                        color: Color(0xFF9739E3),
                      )
                    : Text(
                        "Password Reset",
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
