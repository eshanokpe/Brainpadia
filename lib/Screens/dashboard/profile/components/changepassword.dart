import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'profile_component.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmNewPassword = '';

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Change Password'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(
                        Icons.lock,
                        size: 20,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        userState.iscurrentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () =>
                          userState.toggleCurrentPasswordVisibility(),
                    ),
                  ),
                  obscureText: !userState.iscurrentPasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password';
                    }
                    // Add any additional validation logic here
                    return null;
                  },
                  onSaved: (value) {
                    _currentPassword = value!;
                  },
                );
              }),
              const SizedBox(height: 16.0),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(
                        Icons.lock,
                        size: 20,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        userState.isnewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () => userState.toggleNewPasswordVisibility(),
                    ),
                  ),
                  obscureText: !userState.isnewPasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a new password';
                    }
                    // Add any additional validation logic here
                    return null;
                  },
                  onSaved: (value) {
                    _newPassword = value!;
                  },
                );
              }),
              const SizedBox(height: 16.0),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(
                        Icons.lock,
                        size: 20,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        userState.isconPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () => userState.toggleConPasswordVisibility(),
                    ),
                  ),
                  obscureText: !userState.isconPasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your new password';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _confirmNewPassword = value!;
                  },
                );
              }),
              const SizedBox(height: 24.0),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return Hero(
                  tag: "Changed Password",
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: kPrimaryColor,
                      padding: EdgeInsets.all(defaultPadding),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the value as needed
                      ),
                    ),
                    onPressed: userState.isLoadingSend
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              print('Change Password!');
                              if (_newPassword != _newPassword) {
                                Fluttertoast.showToast(
                                    msg: 'Passwords do not match');
                                return;
                              }
                              await userState.saveChangePassword(
                                context,
                                _currentPassword,
                                _newPassword,
                                _confirmNewPassword,
                              );
                            }
                          },
                    child: userState.isLoadingSend
                        ? const CircularProgressIndicator(
                            color: Color(0xFF9739E3),
                          )
                        : const Text('Change Password'),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
