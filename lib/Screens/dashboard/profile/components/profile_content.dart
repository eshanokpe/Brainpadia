import 'package:brainepadia/Screens/dashboard/profile/bankDetails/getBank.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:brainepadia/utilis/walletImage.dart';
import 'package:brainepadia/utilis/walletWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../bankDetails/addBank.dart';
import 'changepassword.dart';
import 'view_profile.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: defaultPadding),
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              WalletOption(
                title: 'View Profile',
                color: kPrimaryColor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewProfile(),
                      ));
                },
              ),
              // Divider(
              //   color: Colors.grey.shade300,
              //   thickness: 1.5,
              //   endIndent: 20,
              //   indent: 20,
              // ),
              // WalletOption(
              //   title: 'Edit Profile',
              //   color: walletpinkColor,
              //   onTap: () {
              //     // Perform the desired action when the ListTile is tapped
              //     print('ListTile tapped!');
              //   },
              // ),
            ],
          ),
        ),
        const SizedBox(height: defaultPadding),
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              WalletOption(
                title: 'Bank account details',
                color: kPrimaryColor,
                onTap: () {
                  final bankDetails =
                      Provider.of<UserProvider>(context, listen: false);
                  bankDetails.fetchBankDetails();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetBankDetails(),
                      ));
                },
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1.5,
                endIndent: 20,
                indent: 20,
              ),
              WalletOption(
                title: 'Change Password',
                color: walletpinkColor,
                onTap: () {
                  // Perform the desired action when the ListTile is tapped
                  print('Change Password!');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ));
                },
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1.5,
                endIndent: 20,
                indent: 20,
              ),
              // Consumer<Providers>(builder: (context, userState, _) {
              //   return WalletOption(
              //     onTap: () {
              //       print('logout');
              //       userState.isLoading
              //           ? null
              //           : () => userState.logout(context);
              //     },
              //     color: walletpinkColor,
              //     title: 'Logout',
              //   );
              // }),
              SizedBox(height: 50),
              Consumer<Providers>(builder: (context, userState, _) {
                return InkWell(
                    onTap: userState.isLoading
                        ? null
                        : () => userState.logout(context),
                    child: const Text('Logout',
                        style: TextStyle(color: Colors.red)));
              })
            ],
          ),
        ),
      ],
    );
  }
}
