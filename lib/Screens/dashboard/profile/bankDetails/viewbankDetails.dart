import 'package:brainepadia/Screens/dashboard/profile/bankDetails/addBank.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/profile_component.dart';
import 'editBank.dart';

class ViewBankDetails extends StatelessWidget {
  final bankName;
  final bankDetailsId;
  final accountNo;
  final accountName;
  final profileId;
  final dateCreated;
  ViewBankDetails(
      {Key? key,
      this.bankName,
      this.bankDetailsId,
      this.accountNo,
      this.profileId,
      this.dateCreated,
      this.accountName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Bank details'),
      body: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 30,
            ),
            const Text('Your bank account details',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: palColor.withOpacity(0.3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your bank name',
                            style: TextStyle(
                              color: palColor,
                              fontSize: 16,
                            )),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditBank(
                                          bankDetailsId: bankDetailsId,
                                          bankName: bankName,
                                          accountNo: accountNo,
                                          accountName: accountName,
                                          profileId: profileId),
                                    ));
                              },
                              icon: const Icon(Icons.edit),
                              color: kPrimaryColor,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to delete this data?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: kPrimaryColor)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Consumer<UserProvider>(
                                            builder: (context, userState, _) {
                                          return TextButton(
                                            onPressed: userState.isLoadingSend
                                                ? null
                                                : () async {
                                                    userState.deleteBankDetails(
                                                      context,
                                                      bankDetailsId,
                                                    );
                                                  },
                                            child: userState.isLoadingSend
                                                ? const CircularProgressIndicator(
                                                    color: Color(0xFF9739E3),
                                                  )
                                                : const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                          );
                                        }),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(bankName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Your account number',
                        style: TextStyle(
                          color: palColor,
                          fontSize: 16,
                        )),
                    Text(accountNo,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Account owner',
                        style: TextStyle(
                          color: palColor,
                          fontSize: 16,
                        )),
                    Text(accountName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }
}
