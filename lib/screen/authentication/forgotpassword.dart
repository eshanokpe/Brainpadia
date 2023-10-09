import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/screen/dashboard/dashboard.dart';
import 'package:brainepadia/screen/registration/signup.dart';
import 'package:provider/provider.dart';
import 'package:brainepadia/utils/authValiator.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/formFieldconstant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../privacy/tnc.dart';
import 'forgotpassword.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode enode, pnode;
  bool check = false;
  DialogBox dialogBox = DialogBox();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enode = FocusNode();
    pnode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Image.asset(
                  ImageConstant.signupbg,
                  fit: BoxFit.fill,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: size.width,
                          height: size.height,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      20.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(
                                      70.00,
                                    ),
                                    child: Image.asset(
                                      ImageConstant.logoimg,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      100.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(
                                      70.00,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontSize: getFontSize(
                                              26,
                                            ),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      150.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(
                                      70.00,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Enter your email address to get the',
                                          style: TextStyle(
                                            color: ColorConstant.gray503,
                                            fontSize: getFontSize(
                                              14,
                                            ),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      170.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(
                                      70.00,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'password reset link',
                                          style: TextStyle(
                                            color: ColorConstant.gray503,
                                            fontSize: getFontSize(
                                              14,
                                            ),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        260.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Enter Email',
                                      controller: _email,
                                      obscureText: false,
                                      keyboardType: TextInputType.name,
                                      validateText: AuthValidator.validateEmail,
                                      //focusNode: enode,
                                      onSaved: null,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    bottom: getVerticalSize(
                                      350.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                    right: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_email.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'FIll up all fields');
                                        return;
                                      }

                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        try {
                                          final String email =
                                              _email.text.trim();
                                          // Fluttertoast.showToast(
                                          //   msg: 'ok SUCCESS');

                                          await passwordreset(
                                            email,
                                          );
                                        } catch (e) {
                                          Navigator.pop(context);
                                          dialogBox.information(context,
                                              'Status', 'Unable to signup');
                                        }
                                      } else {
                                        // Fluttertoast.showToast(
                                        //   msg: 'No SUCCESS');
                                      }
                                    },
                                    child: const Text(
                                      "Password Reset",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 18),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorConstant.primaryColor),
                                      overlayColor:
                                          MaterialStateProperty.resolveWith(
                                        (states) {
                                          return states.contains(
                                                  MaterialState.pressed)
                                              ? Colors.black26
                                              : null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: getVerticalSize(
                                      180.00,
                                    ),
                                    left: getHorizontalSize(
                                      0.00,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(
                                      70.00,
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login(),
                                                ));
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 64, 84),
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  passwordreset(String email) async {
    var url = Uri.parse(
        "https://api.brainepedia.com/api/Account/forgot_password?email=$email");
    dialogBox.waiting(context, 'Loading ...');
    var timer = Timer(const Duration(milliseconds: 30000), () {
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Service timed out');
      return;
    });
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      timer.cancel();
      Navigator.pop(context);
      Map<String, dynamic> userProfile = jsonDecode(response.body);
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(
          context, '${userProfile['status']}', '${userProfile['message']}');
    } else if (response.statusCode == 400) {
      Map<String, dynamic> userError = jsonDecode(response.body);
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Error', '${userError['message']}');
    } else if (response.statusCode == 401) {
      Map<String, dynamic> userError = jsonDecode(response.body);
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Error', '${userError['message']}');
    } else if (response.statusCode == 500) {
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(
          context, 'Status', 'Server error, please try again later');
    } else {
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Status',
          'Server error, ${response.statusCode} try again later');
    }
  }
}
