import 'package:brainepadia/Screens/dashboard/profile/bankDetails/addBank.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/profile_component.dart';
import 'viewbankDetails.dart';

class GetBankDetails extends StatelessWidget {
  GetBankDetails({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: ' Bank details'),
      body: _buildData(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        elevation: 2,
        onPressed: () {
          // Add your action here
          // For example, navigate to another screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBank()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildData() {
    return Consumer<UserProvider>( 
      builder: (context, userProvider, _) {
        final transactionList = userProvider.getBankData; 

        if (transactionList.isEmpty) {
          if (!userProvider.isLoadingSend) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF9739E3),
            ));
          } else {
            return Center(
                child: Image.asset(
              'assets/icons/nodata.png',
              height: 120,
            ));
          }
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: transactionList.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            // final item = transactionList.reversed.toList()[index];
            final item = transactionList.reversed.toList()[index];
            final bankDetailsId = item['bankDetailsId'];
            final bankName = item['bankName'];
            final accountNo = item['accountNo'];
            final accountName = item['accountName'];
            final dateCreated = item['dateCreated'];
            final profileId = item['profileId'];
            return Container(
              margin: const EdgeInsets.all(8),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewBankDetails(
                              bankName: bankName,
                              bankDetailsId: bankDetailsId,
                              accountNo: accountNo,
                              accountName: accountName,
                              profileId: profileId,
                              dateCreated: dateCreated),
                        ));
                  },
                  leading: Container(
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.account_balance_outlined,
                        size: 24,
                        color: kPrimaryBlack,
                      ),
                    ),
                  ),
                  title: Text(bankName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                    accountName,
                    style: const TextStyle(
                      color: palColor,
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      accountNo,
                      style: const TextStyle(
                          color: palColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }
}
