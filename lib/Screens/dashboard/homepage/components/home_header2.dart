import 'package:brainepadia/models/loginusermodel.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:brainepadia/utilis/math_utils.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class HomeHeader2 extends StatelessWidget {
  const HomeHeader2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Loginusermodel? user = Provider.of<Providers>(context).loginDetails;
    User user = Provider.of<UserProvider>(context).user;
    ProfileUserModel getuser = Provider.of<UserProvider>(context).getuser;
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 1),
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(getuser.imageUrl == null ? '' : ''),
              Text(getuser.imageFile == null ? '' : ''),
              ListTile(
                leading: getuser.imageUrl == null
                    ? const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(getuser.imageUrl!),
                      ),
                title: Text(
                  '${getuser.fullName}',
                  style: TextStyle(
                    //color: ColorConstant.black900,
                    fontSize: getFontSize(
                      20,
                    ),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  getuser.email!,
                  style: TextStyle(
                    fontSize: getFontSize(
                      14,
                    ),
                    color: const Color(0xff777777),
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
              Consumer<Providers>(builder: (context, userState, _) {
                return InkWell(
                    onTap: userState.isLoading
                        ? null
                        : () => userState.logout(context),
                    child: const Text('Logout'));
              })
            ],
          ),
        ),
        const SizedBox(height: defaultPadding * 1),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
