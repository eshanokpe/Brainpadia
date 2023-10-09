import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/screen/authentication/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:brainepadia/onboarding/size_config.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getStarted.dart';

class VerificationOTP extends StatefulWidget {
  String email;
  VerificationOTP({Key? key, required this.email}) : super(key: key);
  @override
  State<VerificationOTP> createState() => _VerificationOTPState();
}

class _VerificationOTPState extends State<VerificationOTP> {
  TextEditingController otpcode = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  DialogBox dialogBox = DialogBox();
  Dio dio = new Dio();
  @override
  void initSate() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    // Handle back button press (if needed)
    // You can add custom behavior here or simply return true to allow navigation.
    return Future.value(true);
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: getVerticalSize(
                      50.00,
                    ),
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Image.asset(
                      ImageConstant.bg2,
                      //'assets/images/splashscreen_bg.png'
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            30.00,
                          ),
                          left: getHorizontalSize(
                            20.00,
                          ),
                        ),
                        child: SizedBox(
                          height: getVerticalSize(
                            60.00,
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
                            40.00,
                          ),
                          left: getHorizontalSize(
                            20.00,
                          ),
                        ),
                        child: Text(
                          'Enter OTP',
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              26,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: getHorizontalSize(300.00),
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            10.00,
                          ),
                          left: getHorizontalSize(
                            20.00,
                          ),
                        ),
                        child: Text(
                          'Enter the OTP code we just sent you on \nyour on your registered Phone number ',
                          style: TextStyle(
                            color: ColorConstant.gray503,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                      height: 60,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 30,
                        ),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          controller: otpcode,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 6) {
                              return "Complete the OTP Code";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            activeColor: const Color(0xFFEAEFF5),
                            disabledColor: const Color(0xFFEAEFF5),
                            inactiveFillColor:
                                const Color.fromARGB(255, 245, 249, 254),
                            inactiveColor: const Color.fromARGB(255, 245, 249, 254),
                            selectedColor: Colors.purple[200],
                            selectedFillColor: const Color(0x9739E3),
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (val) async {
                            debugPrint("Completed");

                            try {
                              dialogBox.waiting(context, 'Loading..');
                              var timer = Timer(
                                  const Duration(milliseconds: 30000), () {
                                Navigator.pop(context);
                                dialogBox.information(
                                    context, 'Status', 'Service timed out');
                                return;
                              });
                              final prefs =
                                  await SharedPreferences.getInstance();
                              String? token = prefs.getString('tokenDB');
                              final getpasscode =
                                  Uri.parse("$baseUrl/Account/post_otp");
                              final headers = {
                                'Content-Type': 'application/json'
                              };

                              final body = jsonEncode(
                                  {"email": widget.email, "otp": val});

                              final response = await http.post(
                                getpasscode,
                                headers: headers,
                                body: body,
                              );

                              if (response.statusCode == 200) {
                                timer.cancel();
                                Navigator.pop(context);
                                otpcode.clear();
                                Fluttertoast.showToast(
                                    msg: 'OTP verification was successful.');
                                // signIn();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GetStarted(),
                                    ));
                              } else if (response.statusCode == 401) {
                                timer.cancel();
                                 Navigator.pop(context);
                                otpcode.clear();
                                dialogBox.information(
                                    context, 'Error', 'Incorrect code');
                              } else {
                                dialogBox.information(
                                    context, 'Error', 'Error');
                              }
                            } catch (e) {
                              // print(e);
                              otpcode.clear();
                              Navigator.pop(context);
                              if (e is DioError) {
                                if (e.type == DioErrorType.connectionTimeout) {
                                  dialogBox.information(context, 'ErrorTimeout',
                                      'Connection took too long to respond');
                                } else if (e.type == DioErrorType.cancel) {
                                  dialogBox.information(
                                      context, 'Error', 'Connection Canclled');
                                } else if (e.type ==
                                    DioErrorType.receiveTimeout) {
                                  dialogBox.information(context, 'Error',
                                      'Connection took too long to respond.');
                                } else if (e.type == DioErrorType.badResponse) {
                                  switch (e.response!.statusCode) {
                                    case 400:
                                      dialogBox.information(context, 'Error',
                                          'Incorrect Details');
                                      break;
                                    case 401:
                                      dialogBox.information(context, 'Error',
                                          'You are Unauthorized');
                                      break;
                                    case 405:
                                      dialogBox.information(context, 'Error',
                                          'Wrong method used.');
                                      break;
                                    case 404:
                                      dialogBox.information(context, 'Error',
                                          'Url/Data not found');
                                      break;
                                    case 422:
                                      dialogBox.information(context, 'Error',
                                          '422: Critical error');
                                      break;
                                    case 500:
                                      dialogBox.information(
                                          context, 'Error', 'Server Error');
                                      break;
                                    default:
                                      dialogBox.information(
                                          context, 'Error', 'An error occured');
                                  }
                                } else if (e.type == DioErrorType.cancel) {
                                  dialogBox.information(
                                      context, 'Error', 'Connecton Canclled');
                                }
                              }
                            }
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible:isButtonVisible,
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: Align(
                    //       alignment: Alignment.topCenter,
                    //       child: Container(
                    //         width: double.infinity,
                    //         margin: EdgeInsets.only(
                    //           bottom: getVerticalSize(
                    //             10.00,
                    //           ),
                    //           left: getHorizontalSize(
                    //             20.00,
                    //           ),
                    //           right: getHorizontalSize(
                    //             20.00,
                    //           ),
                    //         ),
                    //         padding: EdgeInsets.only(
                    //           top: getVerticalSize(
                    //             60.00,
                    //           ),
                    //         ),
                    //         child: ElevatedButton(
                    //           onPressed: () async {},
                    //           child: const Text(
                    //             "Continue",
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontFamily: 'Poppins',
                    //                 fontSize: 17,
                    //                 letterSpacing:
                    //                     0 /*percentages not used in flutter. defaulting to zero*/,
                    //                 fontWeight: FontWeight.normal,
                    //                 height: 1),
                    //           ),
                    //           style: ButtonStyle(
                    //             shape: MaterialStateProperty.all(
                    //               RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //             ),
                    //             padding: MaterialStateProperty.all(
                    //               const EdgeInsets.symmetric(vertical: 18),
                    //             ),
                    //             backgroundColor: MaterialStateProperty.all(
                    //                 ColorConstant.primaryColor),
                    //             overlayColor: MaterialStateProperty.resolveWith(
                    //               (states) {
                    //                 return states.contains(MaterialState.pressed)
                    //                     ? Colors.black26
                    //                     : null;
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: getHorizontalSize(300.00),
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            20.00,
                          ),
                          left: getHorizontalSize(
                            20.00,
                          ),
                        ),
                        child: Text(
                          '${widget.email}',
                          style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        )),
      ),
    );
  }

  void signIn() async {
    var url = Uri.parse("$baseUrl/user");
    final prefs = await SharedPreferences.getInstance();
    var finalToken = prefs.getString('tokenDB');
    final response =
        await http.get(url, headers: {"Authorization": 'Bearer $finalToken'});
    //Loginusermodel loginusermodel =
    //  Loginusermodel.fromJson(jsonDecode(response.body));
  }
}
