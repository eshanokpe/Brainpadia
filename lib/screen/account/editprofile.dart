import 'dart:async';
import 'dart:convert';

import 'package:brainepadia/utils/dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:brainepadia/utils/authValiator.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/formFieldconstant.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var getProfile = context.watch<Providers>().profileDetails;

    DialogBox dialogBox = DialogBox();
    TextEditingController firstNameController =
        TextEditingController(text: getProfile.firstName!);
    TextEditingController surNameController =
        TextEditingController(text: getProfile.surName!);
    String initialmiddleName = getProfile.middleName ?? '';
    TextEditingController middleNameController =
        TextEditingController(text: initialmiddleName);
    TextEditingController emailController =
        TextEditingController(text: getProfile.email ?? '');
    TextEditingController phoneController =
        TextEditingController(text: getProfile.phoneNumber ?? '');
    TextEditingController nickNameController =
        TextEditingController(text: getProfile.nickName ?? '');

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
                      'Edit Profile',
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
                alignment: Alignment.topLeft,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: size.height / 40,
                            ),
                            FormFieldConstant(
                              hintText: 'FirstName',
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                              // focusNode: pnode,
                              onSaved: null,
                              validateText: AuthValidator.validateName,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Surname',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: size.height / 40,
                            ),
                            FormFieldConstant(
                              hintText: 'Enter Surname',
                              controller: surNameController,
                              keyboardType: TextInputType.text,
                              // focusNode: pnode,
                              validateText: AuthValidator.validateName,
                              onSaved: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: size.height / 40,
                            ),
                            FormFieldConstant(
                              hintText: 'Enter Middle Name',
                              controller: middleNameController,
                              keyboardType: TextInputType.text,
                              // focusNode: pnode,
                              onSaved: null, validateText: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: size.height / 40,
                            ),
                            FormFieldConstant(
                              hintText: 'Enter Email Name',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              // focusNode: pnode,
                              disable: false,
                              onSaved: null, validateText: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: size.height / 40,
                            ),
                            FormFieldConstant(
                              hintText: 'Enter Phone Number',
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              onSaved: null,
                              validateText: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: 10,
                            ),
                            FormFieldConstant(
                              hintText: 'Enter Nick Name',
                              controller: nickNameController,
                              keyboardType: TextInputType.name,
                              onSaved: null,
                              validateText: null,
                            ),
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
                    1100.00,
                  ),
                  left: getHorizontalSize(
                    60.00,
                  ),
                  right: getHorizontalSize(
                    60.00,
                  ),
                  bottom: getHorizontalSize(
                    30.00,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
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
                          const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(ColorConstant.gray900Cc),
                        overlayColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.black26
                                : null;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        updateProfile(
                          getProfile.profileId,
                          firstNameController.text.trim(),
                          surNameController.text.trim(),
                          middleNameController.text.trim(),
                          phoneController.text.trim(),
                          nickNameController.text.trim(),
                        );
                      },
                      child: const Text(
                        "Save Change",
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
                          const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  DialogBox dialogBox = DialogBox();
  void updateProfile(int? profileId, String? firstName, String? surName,
      String? middleName, String? phone, String? nickName) async {
    print('profileId:$profileId');

    dialogBox.waiting(context, 'Loading ...');
    var timer = Timer(const Duration(milliseconds: 30000), () {
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Service timed out');
      return;
    });
    var urlgetprofile = Uri.parse("$baseUrl/Profiles/edit/$profileId");
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenDB');
    // var response = await http .get(urlgetprofile, headers: {"Authorization": 'Bearer $token'});
    final headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      "ProfileId": "$profileId",
      "FirstName": "tobi",
      "SurName": "sarah",
      "MiddleName": "joy",
      "NickName": "nick",
      "AboutMe": "AboutMe",
      "Address": "Address",
      "PhoneNumber": "090",
      "Experience": 0,
    });
    final response = await http.post(
      urlgetprofile,
      headers: headers,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      timer.cancel();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Updated Successful!');
    } else {
      timer.cancel();
      //Map<String, dynamic> userError = jsonDecode(response.body);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Error!');
      //dialogBox.information(context, 'Error', '${userError['message']}');
    }
  }
}
