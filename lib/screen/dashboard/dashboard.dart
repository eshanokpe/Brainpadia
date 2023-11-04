import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/screen/profile/profile.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'transaction/transactions.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  pop() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenDB', 'logout');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  DialogBox dialogBox = DialogBox();
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    currentTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final height = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    final width = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    final pages = <Widget>[
      const Homepage(),
      const Text('width'),
      const Transactions(),
      const Profile(),
    ];

    // AppBar? appBar() {
    //   switch (currentTabIndex) {
    //     case 0:
    //       return AppBar(
    //         title:
    //             const Text('GAPhub', style: TextStyle(fontWeight: FontWeight.bold)),
    //         centerTitle: true,
    //         automaticallyImplyLeading: false,
    //       );
    //       break;
    //     case 1:
    //       break;
    //     case 2:
    //       return AppBar(
    //         title: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Text('Asset Acquisition',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: width * .03,
    //                     fontWeight: FontWeight.w600)),
    //             Text('The only path that leads to financial independence',
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.w400,
    //                   fontSize: width * .023,
    //                 )),
    //           ],
    //         ),
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.all(15.0),
    //             child: Image.asset(
    //               'assets/images/tracking.png',
    //               color: Colors.black,
    //             ),
    //           ),
    //         ],
    //         elevation: 5,
    //         leading: const Icon(
    //           Icons.ac_unit,
    //           color: Colors.white,
    //         ),
    //         backgroundColor: Colors.white,
    //       );

    //       break;
    //     case 3:
    //       break;
    //     case 4:
    //       break;
    //     default:
    //       return null;
    //   }
    //   return null;
    // }

    PageStorageBucket bucket = PageStorageBucket();

    final bottomItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/home_inactive.png',
            height: height * .03,
          ),
          activeIcon: Image.asset(
            'assets/icons/home_active.png',
            height: height * .04,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/converter_inactive.png',
            height: height * .03,
          ),
          activeIcon: Image.asset(
            'assets/icons/converter_active.png',
            height: height * .04,
          ),
          label: 'Converter'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/transaction_inactive.png',
            height: height * .03,
          ),
          activeIcon: Image.asset(
            'assets/icons/transaction_inactive.png',
            height: height * .04,
          ),
          label: 'Transaction'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile_inactive.png',
            height: height * .03,
          ),
          activeIcon: Image.asset(
            'assets/icons/profile_active.png',
            height: height * .04,
          ),
          label: 'Profile')
    ];

    return WillPopScope(
      onWillPop: () {
        return dialogBox.options(
            context, 'Exit', 'Are you sure you want to exit?', pop);
      },
      child: Scaffold(
        // appBar: appBar(),
        body: PageStorage(
          child: pages[currentTabIndex],
          bucket: bucket,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: width * .04,
          unselectedFontSize: width * .03,
          items: bottomItems,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTabIndex,
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
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
