import 'package:brainepadia/Screens/dashboard/P2P/p2p_screen.dart';
import 'package:brainepadia/Screens/dashboard/transaction/transaaction_page.dart';
import 'package:brainepadia/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utilis/dialog.dart';
import '../../providers/providers.dart';
import 'PostAds/addpostads_screen.dart';
import 'PostAds/viewpostads_screen.dart';
import 'homepage/home_page.dart';
import 'profile/profile_page.dart';

class Dashboard extends StatefulWidget {
  // final User user;
  const Dashboard({
    Key? key,
    // required this.user
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  pop() async {
    await Provider.of<Providers>(context, listen: false).logout(context);
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
      //const Converter(),
      const P2P(),
      const PostAds(initialTabIndex: 0),

      //const Transactions(),
      const AllTransaction(),
      const Profile(),
      //Account(),
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
      const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          activeIcon: Icon(
            Icons.home,
            color: Color(0xFF9739E3),
          ),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.transform),
          activeIcon: Icon(Icons.transform),
          label: 'P2P'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box,
            size: 40,
          ),
          activeIcon: Icon(
            Icons.add_box,
            size: 40,
          ),
          label: 'Ads'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          activeIcon: Icon(Icons.assignment),
          label: 'Transaction'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
          ),
          activeIcon: Icon(
            Icons.account_circle,
            color: Color(0xFF9739E3),
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
          selectedItemColor: const Color(0xFF9739E3),
          currentIndex: currentTabIndex,
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          unselectedLabelStyle: const TextStyle(),
          selectedLabelStyle: const TextStyle(color: Color(0xFF9739E3)),
          //labelPadding: EdgeInsets.symmetric(vertical: 0.0),
        ),
      ),
    );
  }
}
