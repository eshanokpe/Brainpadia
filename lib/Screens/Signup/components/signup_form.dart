import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Providers>(context, listen: false);

    return Form(
      child: Column(
        children: [
          Consumer<Providers>(
            builder: (context, userState, _) {
              return TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) => userState.setFirstname(value),
                decoration: const InputDecoration(
                  hintText: "First Name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(Icons.person),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<Providers>(
            builder: (context, userState, _) {
              return TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) => userState.setLastname(value),
                decoration: const InputDecoration(
                  hintText: "Last Name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(Icons.person),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<Providers>(
            builder: (context, userState, _) {
              return TextFormField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) => userState.setPhonenumber(value),
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(Icons.phone_android),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onChanged: (value) => userState.setEmail(value),
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(Icons.email),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: !userState.isPasswordVisible,
              cursorColor: kPrimaryColor,
              onChanged: (value) => userState.setPassword(value),
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    userState.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20,
                  ),
                  onPressed: () => userState.togglePasswordVisibility(),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Consumer<Providers>(builder: (context, userState, _) {
            return TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: !userState.isConPasswordVisible,
              cursorColor: kPrimaryColor,
              onChanged: (value) => userState.setConpassword(value),
              decoration: InputDecoration(
                  hintText: "Confirm password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      userState.isConPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                    ),
                    onPressed: () => userState.toggleConPasswordVisibility(),
                  )),
            );
          }),
          const SizedBox(height: defaultPadding),
          Consumer<Providers>(builder: (context, userState, _) {
            return ElevatedButton(
              onPressed:
                  userState.isLoading ? null : () => userState.signUp(context),
              child: userState.isLoading
                  ? const CircularProgressIndicator(
                      color: Color(0xFF9739E3),
                    )
                  : Text("Sign Up".toUpperCase()),
            );
          }),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
