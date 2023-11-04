import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/screen/registration/signup.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'onboarding_contents.dart';
import 'size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [
    const Color(0xffDAD3C8),
    const Color(0xffFFE5DE),
    const Color(0xffDCF6E6),
    const Color(0xffDCF6E6),
    const Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: _currentPage == index
          ? const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colors.white,
            )
          : const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              color: Colors.white30),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 10 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    //double height = SizeConfig.screenH!;
    //double blockH = SizeConfig.blockH!;
    //double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          color: const Color.fromARGB(255, 150, 57, 227),
          child: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: getHorizontalSize(0.50)),
                                child: Image.asset(
                                  ImageConstant.bg,
                                  fit: BoxFit.fill,
                                  width: SizeConfig.screenW!,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(100.50)),
                                child: Image.asset(
                                  contents[i].imagescreen,
                                  height: SizeConfig.blockV! * 35,
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    width: getHorizontalSize(375.00),
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(220.00),
                                    ),
                                    child: Image.asset(ImageConstant.onboardbg,
                                        fit: BoxFit.fill))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    width: getHorizontalSize(375.00),
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(230.00),
                                    ),
                                    child: Image.asset(
                                        ImageConstant.onboardbottombg,
                                        fit: BoxFit.fill))),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: getVerticalSize(700.00),
                                  width: getHorizontalSize(375.00),
                                  margin: EdgeInsets.only(
                                      left: getHorizontalSize(27.00),
                                      top: getVerticalSize(405.00),
                                      right: getHorizontalSize(27.00),
                                      bottom: getVerticalSize(27.00)),
                                  child: Text(
                                    contents[i].title,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        height: 1.2),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: getVerticalSize(700.00),
                                  width: getHorizontalSize(375.00),
                                  margin: EdgeInsets.only(
                                      left: getHorizontalSize(27.00),
                                      top: getVerticalSize(470.00),
                                      right: getHorizontalSize(27.00),
                                      bottom: getVerticalSize(2.00)),
                                  child: Text(
                                    contents[i].desc,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        letterSpacing:
                                            1 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1.2),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: getVerticalSize(580.00),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        contents.length,
                                        (int index) => _buildDots(index: index),
                                      ),
                                    ),
                                    _currentPage + 1 == contents.length
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 30,
                                                right: 30,
                                                top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Login()));
                                                  },
                                                  child: const Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 150, 57, 227),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 17,
                                                        letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  ),
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(
                                                      (width <= 550)
                                                          ? const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 45,
                                                              vertical: 15)
                                                          : const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 55,
                                                              vertical: 25),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) {
                                                        return states.contains(
                                                                MaterialState
                                                                    .pressed)
                                                            ? Colors.black26
                                                            : null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const SignUp()));
                                                  },
                                                  child: const Text(
                                                    "Sign up",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 150, 57, 227),
                                                        fontFamily: 'Arial',
                                                        fontSize: 17,
                                                        letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  ),
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty
                                                        .all(const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 150, 57, 227),
                                                    )),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(
                                                      (width <= 550)
                                                          ? const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 45,
                                                              vertical: 15)
                                                          : const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 55,
                                                              vertical: 25),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Colors.white,
                                                    ),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) {
                                                        return states.contains(
                                                                MaterialState
                                                                    .pressed)
                                                            ? Colors.black26
                                                            : null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 30,
                                                right: 30,
                                                top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Login()));
                                                  },
                                                  child: const Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 150, 57, 227),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 17,
                                                        letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  ),
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(
                                                      (width <= 550)
                                                          ? const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 50,
                                                              vertical: 15)
                                                          : const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 60,
                                                              vertical: 25),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      Colors.white,
                                                    ),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) {
                                                        return states.contains(
                                                                MaterialState
                                                                    .pressed)
                                                            ? Colors.black26
                                                            : null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
