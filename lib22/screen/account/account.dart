import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile.dart';
import 'resetPassword.dart';

class Account extends StatelessWidget {
  Account({super.key});
  DialogBox dialogBox = DialogBox();

  @override
  Widget build(BuildContext context) {
    yes() async {
      dialogBox.waiting(context, 'Loading...');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tokenDB', 'logout');
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back arrow icon
          centerTitle: true,
          title: const Text('Account')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  elevation:
                      4, // Adjust the elevation to control the shadow intensity
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Customize the border radius of the card
                  ),
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    leading: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18, // Customize the font size
                        fontWeight:
                            FontWeight.bold, // Customize the font weight
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right,
                      color: Colors.grey, // Customize the icon color
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  elevation:
                      4, // Adjust the elevation to control the shadow intensity
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Customize the border radius of the card
                  ),
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                    },
                    leading: const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18, // Customize the font size
                        fontWeight:
                            FontWeight.bold, // Customize the font weight
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right,
                      color: Colors.grey, // Customize the icon color
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  elevation:
                      4, // Adjust the elevation to control the shadow intensity
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Customize the border radius of the card
                  ),
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      dialogBox.options(context, "Log Out",
                          'Are you sure you want to log out?', yes);
                    },
                    leading: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18, // Customize the font size
                        fontWeight:
                            FontWeight.bold, // Customize the font weight
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right,
                      color: Colors.grey, // Customize the icon color
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
