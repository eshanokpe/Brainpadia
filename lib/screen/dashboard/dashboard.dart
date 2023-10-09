import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DialogBox dialogBox = DialogBox();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dialogBox.options(
            context, "Log Out", 'Are you sure you want to log out?', yes);
        return false; // Return false to prevent going back
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20),
                    bottomRight: const Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/avatar_image.png'),
                      ),
                      title: Text(
                        'John',
                        style: TextStyle(
                          color: ColorConstant.black900,
                          fontSize: getFontSize(
                            20,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        'johndoe@gmail.com',
                        style: TextStyle(
                          fontSize: getFontSize(
                            14,
                          ),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      trailing: Stack(
                        children: [
                          Image.asset('assets/images/notification_icon.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'Brainepadia Coin',
                        style: TextStyle(
                          color: ColorConstant.gray700,
                          fontSize: getFontSize(
                            20,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Balance',
                            style: TextStyle(
                              color: ColorConstant.gray500,
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+130.62%',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 99, 203, 141),
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '40,059.83',
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(
                                32,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+ \$2,979.23%',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 119, 119, 119),
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                ),
                                child: Image.asset('assets/images/send.png'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Send',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: getFontSize(
                                    20,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                ),
                                child: Image.asset('assets/images/receive.png'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Send',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: getFontSize(
                                    20,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                ),
                                child:
                                    Image.asset('assets/images/transfer.png'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Send',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: getFontSize(
                                    20,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('Log out'),
                        onPressed: () {
                          dialogBox.options(context, "Log Out",
                              'Are you sure you want to log out?', yes);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  yes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenDB', 'logout');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
