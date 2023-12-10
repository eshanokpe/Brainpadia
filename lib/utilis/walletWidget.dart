import 'package:brainepadia/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class WalletOption extends StatelessWidget {
  //final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const WalletOption({
    Key? key,
    //required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title,
          style:
              const TextStyle(color: Banking_TextColorPrimary, fontSize: 15)),
      trailing: const Icon(Icons.keyboard_arrow_right,
          color: Banking_TextColorSecondary),
    );
  }
}

Widget walletOptions(var icon, var heading, Color color, VoidCallback? onTap) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 1),
    child: ListTile(
      // leading: Image.asset(icon, color: color, height: 20, width: 20),
      title: Text(heading,
          style:
              const TextStyle(color: Banking_TextColorPrimary, fontSize: 18)),
      trailing: const Icon(Icons.keyboard_arrow_right,
          color: Banking_TextColorSecondary),
      onTap: onTap,
    ),
  );
}

class TopCard extends StatelessWidget {
  final String amount;
  final String bal;

  TopCard({Key? key, required this.amount, required this.bal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 8),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: Text(
                    amount.toString(),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 15),
              //   child: Icon(
              //     Icons.remove_red_eye,
              //     color: greyColor,
              //     size: 20,
              //   ),
              // ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 0),
            child: Text(bal.toString(),
                style: const TextStyle(color: Colors.green, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
