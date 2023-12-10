import 'dart:io';

import 'package:brainepadia/constants.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'edit_profile.dart';
import 'profile_component.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileUserModel getuser = Provider.of<UserProvider>(context).getuser;

    return Scaffold(
        appBar: const TAppBar(showBackArrow: true, title: 'View Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Consumer<UserProvider>(builder: (context, userSate, _) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<UserProvider>(
                        builder: (context, userState, _) {
                      return Column(
                        children: [
                          //Text(userState.getuser.imageUrl.toString()),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          userState.getuser.imageUrl.toString() == null
                              ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      userSate.getuser.imageUrl.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 30,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        palColor, // Placeholder background color
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ), // Loading indicator
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors
                                        .grey, // Placeholder background color
                                    child: Icon(
                                      Icons.error,
                                      color: kPrimaryColor,
                                    ), // Error icon or widget
                                  ),
                                ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        ],
                      );
                    }),
                  ),

                  //Details
                  const SizedBox(height: 8),
                  const Divider(
                    height: 2,
                    color: Color(0xff777777),
                  ),
                  const SizedBox(height: 16),
                  const TSectionHeading(
                    title: 'Personal Information',
                    showActionButton: false,
                  ),

                  const SizedBox(height: 16),

                  TProfileMenu(
                    title: 'First Name',
                    value: getuser.firstName.toString(),
                  ),
                  TProfileMenu(
                    title: 'Surname',
                    value: getuser.surName.toString(),
                  ),
                  TProfileMenu(
                    title: 'MiddleName',
                    value: getuser.middleName.toString(),
                  ),
                  TProfileMenu(
                    title: 'Nick Name',
                    value: getuser.nickName.toString(),
                  ),
                  TProfileMenu(
                    title: 'Email',
                    email: false,
                    value: getuser.email.toString(),
                  ),
                  TProfileMenu(
                    title: 'About Me',
                    value: getuser.aboutMe.toString(),
                  ),
                  TProfileMenu(
                    title: 'Address',
                    value: getuser.address.toString(),
                  ),
                  TProfileMenu(
                    title: 'Phone Number',
                    value: userSate.getuser.phoneNumber.toString(),
                  ),
                  TProfileMenu(
                    title: 'Date of Birth',
                    value: userSate.getuser.dateOfBirth == null
                        ? ''
                        : formatDateTime(userSate.getuser.dateOfBirth!),
                  ),
                  // const SizedBox(height: 8),
                  // const Divider(
                  //   height: 2,
                  //   color: Color(0xff777777),
                  // ),
                  const SizedBox(height: 16),
                  // const TSectionHeading(
                  //   title: 'Profile Information',
                  //   showActionButton: false,
                  // ),
                  const SizedBox(height: 16),
                  // TProfileMenu(
                  //     title: 'Experience',
                  //     value: getuser.experience.toString(),
                  //     onPressed: () {}),
                  // TProfileMenu(
                  //     title: 'Project Completed',
                  //     value: getuser.projectCompleted == null
                  //         ? '_'
                  //         : getuser.projectCompleted.toString(),
                  //     onPressed: () {}),
                  // TProfileMenu(
                  //     title: 'Project Completed',
                  //     value: getuser.projectCompleted == null
                  //         ? '_'
                  //         : getuser.projectCompleted.toString(),
                  //     onPressed: () {}),
                  // TProfileMenu(
                  //     title: 'Profession',
                  //     value: getuser.profession == null
                  //         ? '_'
                  //         : getuser.profession.toString(),
                  //     onPressed: () {}),
                  // TProfileMenu(
                  //     title: 'freeLance',
                  //     value: getuser.freeLance == null
                  //         ? '_'
                  //         : getuser.freeLance.toString(),
                  //     onPressed: () {}),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                  firstName: getuser.firstName.toString(),
                                  surName: getuser.surName.toString(),
                                  middleName: getuser.middleName.toString(),
                                  nickName: getuser.nickName.toString(),
                                  aboutMe: getuser.aboutMe.toString(),
                                  address: getuser.address.toString(),
                                  phoneNumber: getuser.phoneNumber.toString(),
                                  dateOfBirth: getuser.dateOfBirth.toString()),
                            ));

                        // final picker = ImagePicker();
                        // final pickedImage = await picker.getImage(
                        //     source: ImageSource.gallery);

                        // if (pickedImage != null) {
                        //   File imageFile = File(pickedImage.path);
                        //   userState.uploadImage(
                        //       context, imageFile);
                        // }
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: kPrimaryColor),
                      )),
                  // Center(
                  //   child: TextButton(
                  //       onPressed: () {},
                  //       child: const Text(
                  //         'Close Account',
                  //         style: TextStyle(color: Colors.red),
                  //       )),
                  // )
                ],
              );
            }),
          ),
        ));
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    return formattedDate;
  }
}
