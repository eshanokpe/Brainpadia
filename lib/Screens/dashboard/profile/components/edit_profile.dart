import 'dart:io';

import 'package:brainepadia/constants.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'profile_component.dart';

class EditProfile extends StatefulWidget {
  String firstName,
      surName,
      middleName,
      nickName,
      aboutMe,
      address,
      phoneNumber,
      dateOfBirth;
  EditProfile(
      {super.key,
      required this.firstName,
      required this.surName,
      required this.middleName,
      required this.nickName,
      required this.address,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.aboutMe});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool oldImage = true;
  bool newImage = false;
  File? imageURI;
  @override
  Widget build(BuildContext context) {
    ProfileUserModel getuser = Provider.of<UserProvider>(context).getuser;

    final TextEditingController firstNameController =
        TextEditingController(text: widget.firstName);
    final TextEditingController surNameController =
        TextEditingController(text: widget.surName);
    final TextEditingController middleNameController =
        TextEditingController(text: widget.middleName);
    final TextEditingController nickNameController =
        TextEditingController(text: widget.nickName);
    final TextEditingController aboutMeController =
        TextEditingController(text: widget.aboutMe);
    final TextEditingController addressController =
        TextEditingController(text: widget.address);
    final TextEditingController phoneNumberController =
        TextEditingController(text: widget.phoneNumber);
    final TextEditingController dateOfBirthController =
        TextEditingController(text: widget.dateOfBirth);

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Edit Profile'),
      body: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                    child: Text(
                      'Use real name for easy verification. This name will appear on several pages',
                      style: Theme.of(context).textTheme.bodyMedium!,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Stack(
                    children: <Widget>[
                      Visibility(
                        visible: oldImage,
                        child: oldImageWidget(),
                      ),
                      Visibility(
                        visible: newImage,
                        child: newImageChoose(),
                      ),
                      Consumer<UserProvider>(builder: (context, userState, _) {
                        return Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 35,
                              width: 35,
                              child: InkWell(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedImage = await picker.getImage(
                                      source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    setState(() {
                                      imageURI = File(pickedImage.path);
                                      oldImage = false;
                                      newImage = true;
                                    });
                                  }
                                },
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 15.0,
                                  color: Color(0xFFffffff),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ));
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter First name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: surNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Surname",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: middleNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Middle name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: nickNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Nick name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: "Enter address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: "Enter Phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    readOnly: true, // Prevents manual input
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime
                            .now(), // Initial date or the selected date if already available
                        firstDate: DateTime(1900), // Start date for the picker
                        lastDate: DateTime.now(), // End date for the picker
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              // Customize the theme with desired colors
                              primaryColor: Colors.blue, // Change primary color
                              accentColor: Colors.blue, // Change accent color
                              colorScheme: const ColorScheme.light(
                                  primary:
                                      kPrimaryColor), // Change overall color scheme
                              buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme
                                      .primary), // Button text theme
                            ), // Customize the theme as needed
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        dateOfBirthController.text = pickedDate
                            .toString(); // Set the selected date to the TextFormField
                      }
                    },
                    controller: TextEditingController(
                        text: formatDateTime(dateOfBirthController.text)),

                    decoration: const InputDecoration(
                      hintText: "Select Date of Birth",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    cursorColor: kPrimaryColor,
                    controller: aboutMeController,
                    decoration: const InputDecoration(
                      hintText: "Enter name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Consumer<UserProvider>(builder: (context, userState, _) {
                    return Hero(
                      tag: "Save",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the value as needed
                          ),
                        ),
                        onPressed: userState.isLoadingSend
                            ? null
                            : () async {
                                if (firstNameController.text.isEmpty ||
                                    surNameController.text.isEmpty ||
                                    phoneNumberController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'FIll up the empty fields');
                                  return;
                                }
                                File? selectedImage = imageURI;
                                await userState.saveProfile(
                                  context,
                                  firstNameController.text.trim(),
                                  surNameController.text.trim(),
                                  middleNameController.text.trim(),
                                  nickNameController.text.trim(),
                                  addressController.text.trim(),
                                  phoneNumberController.text.trim(),
                                  dateOfBirthController.text.trim(),
                                  aboutMeController.text.trim(),
                                  imageURI != null ? imageURI : null,
                                  //  imageURI == null ? getuser.imageFile : imageURI!,
                                );
                              },
                        child: userState.isLoadingSend
                            ? const CircularProgressIndicator(
                                color: Color(0xFF9739E3),
                              )
                            : const Text(
                                "Save",
                              ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    return formattedDate;
  }

  Widget oldImageWidget() {
    return Consumer<UserProvider>(builder: (context, userState, _) {
      return Container(
        width: 100,
        height: 100,
        child: userState.getuser.imageUrl.toString() == null
            ? const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              )
            : CachedNetworkImage(
                imageUrl: userState.getuser.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const CircleAvatar(
                  radius: 30,
                  backgroundColor: palColor, // Placeholder background color
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ), // Loading indicator
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey, // Placeholder background color
                  child: Icon(
                    Icons.error,
                    color: kPrimaryColor,
                  ), // Error icon or widget
                ),
              ),
      );
    });
  }

  Widget newImageChoose() {
    return Container(
      width: 100,
      height: 100,
      child: imageURI == null
          ? const Text(
              'No Image',
            )
          : CircleAvatar(
              radius: 30,
              backgroundImage: FileImage(imageURI!),
            ),
    );
  }
}
