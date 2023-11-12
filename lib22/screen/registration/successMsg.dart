import 'package:brainepadia/onboarding/size_config.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'verificationOTP.dart';

class SuccessMsg extends StatefulWidget {
  String email;
  SuccessMsg({Key? key, required this.email}) : super(key: key);
  @override
  State<SuccessMsg> createState() => _SuccessMsgState();
}

class _SuccessMsgState extends State<SuccessMsg> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          0.00,
                        ),
                        left: getHorizontalSize(
                          20.00,
                        ),
                      ),
                      child: SizedBox(
                        child: Image.asset(
                          ImageConstant.successimg,
                          fit: BoxFit.contain,
                          height: SizeConfig.blockV! * 30,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Congratulations!',
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: getHorizontalSize(300.00),
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          10.00,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'We’ve sent you a verification code to your email, please check your inbox or spam folder and follow the instructions to verify your account.',
                          style: TextStyle(
                            color: ColorConstant.gray503,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: getHorizontalSize(300.00),
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          20.00,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Thank you for signing up with us!',
                          style: TextStyle(
                            color: ColorConstant.gray503,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerificationOTP(email: widget.email),
                          ));
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: getHorizontalSize(300.00),
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            60.00,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Click here ',
                            style: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: getFontSize(
                                  14,
                                ),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      )),
    );
  }
}
