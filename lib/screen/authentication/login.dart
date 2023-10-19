import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/screen/dashboard/dashboard.dart';
import 'package:brainepadia/screen/registration/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:brainepadia/models/loginusermodel.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                                          'Sign in to',
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
                                          'If you don`t have an account register',
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
                                                      const SignUp()));
                                        },
                                        child: Text(
                                          "Register here !",
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
                                        280.00,
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
                                        360.00,
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
                                      440.00,
                                    ),
                                    left: getHorizontalSize(
                                      10.00,
                                    ),
                                    right: getHorizontalSize(
                                      20.00,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                      Text('Remember me',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: size.width * .033,
                                          )),
                                      SizedBox(
                                        width: getHorizontalSize(
                                          105.00,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ForgotPassword(),
                                                ));
                                          },
                                          child: Text("Forgot Password?",
                                              style: TextStyle(
                                                color: Colors.black,
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
                                      250.00,
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
                                      if (_email.text.isEmpty ||
                                          _password.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'FIll up all fields');
                                        return;
                                      }
                                      if (!check) {
                                        Fluttertoast.showToast(
                                            msg: 'Click on remember me');
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        try {
                                          final String email =
                                              _email.text.trim();
                                          final String password =
                                              _password.text.trim();
                                          // Fluttertoast.showToast(
                                          //   msg: 'ok SUCCESS');

                                          await signin(
                                            email,
                                            password,
                                          );
                                        } catch (e) {
                                          //Navigator.pop(context);
                                          dialogBox.information(context,
                                              'Status', 'Unable to sign in');
                                        }
                                      } else {
                                        // Fluttertoast.showToast(
                                        //   msg: 'No SUCCESS');
                                      }
                                    },
                                    child: const Text(
                                      "Login",
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

  signin(String email, String password) async {
    var url = Uri.parse("$baseUrl/Account/auth_login");

    //var url = Uri.parse("https://api.brainepedia.com/api/Account/register");

    dialogBox.waiting(context, 'Signing In');
    var timer = Timer(const Duration(milliseconds: 30000), () {
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Service timed out');
      return;
    });
    final headers = {'Content-Type': 'application/json'};

    //print("email:$email");
    //print("Password:$password");
    final body =
        jsonEncode({"email": email, "password": password, "rememberMe": true});
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> userProfile = jsonDecode(response.body);
      Token token = Token.fromJSON(jsonDecode(response.body));
      String ttoken = token.toString().substring(3);
      String method(String str) {
        String result = '';

        if (str != null && str.length > 0) {
          result = str.substring(0, str.length - 3);
        }
        return result;
      }

      final finalToken = method(ttoken).trim();

      //print(finalToken);
      int profileId = userProfile['userProfile']['profileId'];
      //print("userProfile:${userProfile['userProfile']['profileId']}");

      var urlgetprofile = Uri.parse("$baseUrl/Profiles/get_profile/$profileId");

      var response2 = await http
          .get(urlgetprofile, headers: {"Authorization": 'Bearer $finalToken'});
      Map<String, dynamic> getProfile = jsonDecode(response2.body);
      print(getProfile);
      ProfileUserModel profileUserModel = ProfileUserModel.fromJson(getProfile);
      context.read<Providers>().setProfile(profileUserModel);
      //context.read<Providers>().setProfile(getProfile);
      Loginusermodel loginusermodel =
          Loginusermodel.fromJson(userProfile['userProfile']);
      context.read<Providers>().setLoginDetails(loginusermodel);
      context.read<Providers>().seToken(finalToken);
      Fluttertoast.showToast(msg: 'Sign in successful!');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
      timer.cancel();
      // Navigator.pop(context);
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

class Token {
  String token;
  Token(this.token);

  factory Token.fromJSON(dynamic json) {
    return Token(json['userProfile']['token'] as String);
  }

  @override
  String toString() {
    return ' { ${this.token} } ';
  }
}
