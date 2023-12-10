import 'package:brainepadia/components/forget_password.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Forgetpassword/forgetpassword_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Consumer<Providers>(builder: (context, userState, _) {
              return TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: _obscureText,
                cursorColor: kPrimaryColor,
                onChanged: (value) => userState.setPassword(value),
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              );
            }),
          ),
          ForgetPassword(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ForgetPasswordScreen();
                  },
                ),
              );
            },
          ), 
          const SizedBox(height: 10),
          Consumer<Providers>(builder: (context, userState, _) {
            return Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed:
                    userState.isLoading ? null : () => userState.login(context),
                child: userState.isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xFF9739E3),
                      )
                    : Text(
                        "Login".toUpperCase(),
                      ),
              ),
            );
          }),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
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
