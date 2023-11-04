import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editprofile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var getProfile = context.watch<Providers>().profileDetails;
    print(getProfile.fullName);

    //ProfileUserModel profile = ProfileUserModel.fromJson(getProfile);

    return SafeArea(
      child: Scaffold(

          //backgroundColor: Colors.white,
          body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 5,
              child: Image.asset(
                ImageConstant.profileimg,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Add your back button functionality here
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 2.9,
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(
                    90.00,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      ///width: size.width,
                      height: 120,
                      child: Image.asset(
                        'assets/images/avatar_image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: size.height / 50),
                    Text(
                      getProfile.fullName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getVerticalSize(
                      300.00,
                    ),
                    left: getVerticalSize(
                      10.00,
                    ),
                    right: getVerticalSize(
                      10.00,
                    ),
                  ),
                  child: Card(
                      //margin: EdgeInsets.all(10),
                      child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.firstName!,
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.surName!,
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Middle Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.middleName ?? 'N/A',
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.email ?? 'N/A',
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.phoneNumber ?? 'N/A',
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Nick Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getProfile.nickName ?? 'N/A',
                              style: TextStyle(
                                color: ColorConstant.gray503,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: getVerticalSize(
                    700.00,
                  ),
                  left: getHorizontalSize(
                    90.00,
                  ),
                  right: getHorizontalSize(
                    90.00,
                  ),
                  bottom: getHorizontalSize(
                    30.00,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfile(),
                        ));
                  },
                  child: const Text(
                    "Edit Profile",
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
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstant.primaryColor),
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
          ],
        ),
      )),
    );
  }
}
