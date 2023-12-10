import 'package:brainepadia/constants.dart';
import 'package:brainepadia/responsive.dart';
import 'package:flutter/material.dart';

import '../../../components/background.dart';
import 'components/profile_content.dart';
import 'components/profile_header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Banking_app_Background,
        resizeToAvoidBottomInset: false,
        body: ProfileScreen());
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const MenuHeader(),
          Row(
            children: const [
              Expanded(
                flex: 8,
                child: ProfileContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
