import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileUserModel getuser = Provider.of<UserProvider>(context).getuser;
    WalletModel getWallet = Provider.of<UserProvider>(context).getuserWallet;

    String walletAddress = getWallet.walletAddress!;
    //print("$walletAddress");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding * 3),
        const Text('Menu',
            style: TextStyle(
                color: Banking_TextColorPrimary,
                fontSize: 35,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: defaultPadding),
        Container(
          padding: const EdgeInsets.all(8),
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
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            getuser.imageUrl == null
                ? const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  )
                : CachedNetworkImage(
                    imageUrl: getuser.imageUrl!,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 30,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => const CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Colors.grey, // Placeholder background color
                      child: CircularProgressIndicator(), // Loading indicator
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Colors.grey, // Placeholder background color
                      child: Icon(Icons.error), // Error icon or widget
                    ),
                  ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${getuser.surName} ${getuser.firstName}",
                    style: const TextStyle(
                      color: Banking_TextColorPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${getuser.email}",
                    style: const TextStyle(
                      color: Banking_TextColorSecondary,
                      fontSize: 14,
                      fontFamily: fontMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        _showBottomModal(context, walletAddress);
                      },
                      child: const Text(
                        'Wallet address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }

  void _showBottomModal(BuildContext context, String walletAddress) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      elevation: 10,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wallet address",
                  style: TextStyle(
                      fontSize: 20,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: InkWell(
                    onTap: () {
                      if (walletAddress == "") {
                        print('enter text');
                      } else {
                        print("walletAddress:$walletAddress");
                        FlutterClipboard.copy(walletAddress).then((value) {
                          Fluttertoast.showToast(msg: 'Text copied');
                        });
                      }
                    },
                    child: const Icon(Icons.copy,
                        color: kSecondaryColor, size: 32),
                  ),
                  title: const Text('BPCoin'),
                  subtitle: Text(
                    walletAddress,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "CLOSE",
                        style: TextStyle(
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
