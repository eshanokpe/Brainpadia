import 'package:brainepadia/onboarding/size_config.dart';
import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
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
                          ImageConstant.getstarted,
                          fit: BoxFit.contain,
                          height: SizeConfig.blockV! * 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Your account has been successfully created!',
                      style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: getFontSize(
                          26,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
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
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          60.00,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ));
                        },
                        child: const Text(
                          "Get Started",
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 18),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              ColorConstant.primaryColor),
                          overlayColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return states.contains(MaterialState.pressed)
                                  ? Colors.black26
                                  : null;
                            },
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
