import 'dart:async';
import 'dart:convert';

import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/utils/authValiator.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/formFieldconstant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../privacy/tnc.dart';
import 'successMsg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode enode, fnode, lnode, phonenode, pnode, pcnode;
  bool check = false;
  DialogBox dialogBox = DialogBox();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enode = FocusNode();
    fnode = FocusNode();
    lnode = FocusNode();
    pnode = FocusNode();
    phonenode = FocusNode();
    pcnode = FocusNode();
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
                              // Align(
                              //   alignment: Alignment.topCenter,
                              //   child: SizedBox(
                              //     width: size.width,
                              //     height: size.height,
                              //     child: Image.asset(
                              //       ImageConstant.signupbg,
                              //       fit: BoxFit.fill,
                              //     ),
                              //   ),
                              // ),
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
                                          'Sign up to',
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
                                          'Lorem Ipsum is simply',
                                          style: TextStyle(
                                            color: ColorConstant.black901,
                                            fontSize: getFontSize(
                                              21,
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
                                      200.00,
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
                                          'If you already have an account register',
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
                                      220.00,
                                    ),
                                    left: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "You can ",
                                        style: TextStyle(
                                          color: ColorConstant.gray503,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login()));
                                        },
                                        child: Text(
                                          "Login here !",
                                          style: TextStyle(
                                            color: ColorConstant.primaryColor,
                                            fontSize: getFontSize(
                                              14,
                                            ),
                                            fontFamily: 'Arial',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        270.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Enter First Name',
                                      controller: _firstname,
                                      keyboardType: TextInputType.name,
                                      obscureText: false,
                                      validateText: AuthValidator.validateName,
                                      // focusNode: fnode,
                                      onSaved: null,
                                    )),
                              ),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        340.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Enter Last Name',
                                      controller: _lastname,
                                      obscureText: false,
                                      keyboardType: TextInputType.name,
                                      validateText: AuthValidator.validateName,
                                      // focusNode: lnode,
                                      onSaved: null,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        410.00,
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
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        480.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Contact number',
                                      controller: _phone,
                                      obscureText: false,
                                      keyboardType: TextInputType.phone,
                                      validateText: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a phone number';
                                        }
                                        // Add any additional phone number validation logic here
                                        return null;
                                      },
                                      //validateText:AuthValidator.validateNumber,
                                      // validateText: AuthValidator.validateNumber,
                                      // focusNode: phonenode,
                                      onSaved: null,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        550.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Password',
                                      controller: _password,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validateText:
                                          AuthValidator.validatePassword,
                                      // focusNode: pnode,
                                      onSaved: null,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        630.00,
                                      ),
                                      left: getHorizontalSize(
                                        20.00,
                                      ),
                                      right: getHorizontalSize(
                                        20.00,
                                      ),
                                    ),
                                    child: FormFieldConstant(
                                      hintText: 'Comfirm Password',
                                      controller: _conpassword,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validateText:
                                          AuthValidator.validatePassword,
                                      // focusNode: pcnode,
                                      onSaved: null,
                                    )),
                              ),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(
                                      710.00,
                                    ),
                                    left: getHorizontalSize(
                                      10.00,
                                    ),
                                    right: getHorizontalSize(
                                      10.00,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: check,
                                          onChanged: (bool? val) {
                                            setState(() {
                                              check = val ?? false;
                                            });
                                          }),
                                      Text('I accept the ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: size.width * .033,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Tnc(
                                                    tnc: true,
                                                  ),
                                                ));
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           SuccessMsg(),
                                            //     ));
                                          },
                                          child: Text("Terms & Condition ",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontWeight: FontWeight.w500,
                                                fontSize: size.width * .033,
                                              ))),
                                      Text('and ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: size.width * .033,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Tnc(
                                                    tnc: false,
                                                  ),
                                                ));
                                          },
                                          child: Text("Privacy Policy ",
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontWeight: FontWeight.w500,
                                                fontSize: size.width * .033,
                                              )))
                                    ],
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    bottom: getVerticalSize(
                                      10.00,
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
                                      if (_firstname.text.isEmpty ||
                                          _lastname.text.isEmpty ||
                                          _email.text.isEmpty ||
                                          _phone.text.isEmpty ||
                                          _password.text.isEmpty ||
                                          _conpassword.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'FIll up all fields');
                                        return;
                                      }
                                      if (!check) {
                                        Fluttertoast.showToast(
                                            msg: 'Accept the privacy policy');
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        try {
                                          final String firstName =
                                              _firstname.text.trim();
                                          final String lastName =
                                              _lastname.text.trim();
                                          final String email =
                                              _email.text.trim();
                                          final String phoneNumber =
                                              _phone.text.trim();
                                          final String password =
                                              _password.text.trim();
                                          final String confirmPassword =
                                              _conpassword.text.trim();
                                          // Fluttertoast.showToast(
                                          //     msg: 'ok SUCCESS');

                                          await createUser(
                                              firstName,
                                              lastName,
                                              email,
                                              phoneNumber,
                                              password,
                                              confirmPassword);
                                        } catch (e) {
                                          Navigator.pop(context);
                                          dialogBox.information(context,
                                              'Status', 'Unable to signup');
                                        }
                                      } else {
                                        // Fluttertoast.showToast(
                                        //     msg: 'No SUCCESS');
                                      }
                                    },
                                    child: const Text(
                                      "Register",
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

  Future<void> createUser(String firstName, String lastName, String email,
      String phoneNumber, String password, String confirmPassword) async {
    final url = Uri.parse("$baseUrl/Account/register");

    dialogBox.waiting(context, 'Signing Up');
    var timer = Timer(const Duration(milliseconds: 40000), () {
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Service timed out');
      return;
    });
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    });
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      timer.cancel();
      Navigator.pop(context);
      //dialogBox.information(context, 'Success',
      //  'Registeration Successful. Verification OTP sent to your email ');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessMsg(email: email),
          ));
    } else if (response.statusCode == 201) {
      timer.cancel();
      Navigator.pop(context);
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
