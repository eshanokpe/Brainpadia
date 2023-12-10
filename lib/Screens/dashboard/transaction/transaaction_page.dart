import 'package:brainepadia/Screens/dashboard/profile/components/profile_component.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'components/transaction_details.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({Key? key}) : super(key: key);

  void fetchData(BuildContext context) {
    context.read<FetchBlockchain>().fetchDollarBalance(context);
    context.read<FetchBlockchain>().fetchNairaBalance(context);
    context.read<FetchBlockchain>().fetchTransaction(context);
  }

  @override
  Widget build(BuildContext context) {
    WalletModel getWallet = Provider.of<UserProvider>(context).getuserWallet;
    var walletAddress = getWallet.walletAddress;

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      resizeToAvoidBottomInset: false,
      body: _buildBody(
        walletAddress!,
      ),
    );
  }

  Widget _buildBody(String walletAddress) {
    return Consumer<FetchBlockchain>(
      builder: (context, transactionData, _) {
        final p2pBuyAdsProvider =
            Provider.of<FetchBlockchain>(context, listen: false);
        p2pBuyAdsProvider.fetchTransactionAll(context);
        final transactionList = transactionData.transactionDataAll;

        if (transactionList.isEmpty) {
          if (!transactionData.isLoading) {
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

        return RefreshIndicator(
          onRefresh: () async {
            fetchData(context);
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: transactionList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // final item = transactionList.reversed.toList()[index];
              final item = transactionList[index];
              return _buildTransactionTile(context, item);
            },
          ),
        );
      },
    );
  }

  Widget _buildTransactionTile(
      BuildContext context, Map<String, dynamic> item) {
    final fee = item['fee'];
    final amount = item['amount'];
    final recipient = item['recipient'];
    final timeStamp = item['timeStamp'];
    final hash = item['hash'];
    final sender = item['sender'];
    final walletAddress =
        Provider.of<UserProvider>(context).getuserWallet.walletAddress;

    final isDeposit = walletAddress == recipient;
    final transactionType = isDeposit ? 'Deposit Amount' : 'Withdraw Amount';
    final amountText = isDeposit
        ? '+${amount.toStringAsFixed(2)}'
        : '-${amount.toStringAsFixed(2)}';
    final amountColor =
        isDeposit ? const Color(0xff3B802B) : const Color(0xffFF2A03);

    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetails(
                title: transactionType,
                timeStamp: timeStamp,
                amount: amount.toStringAsFixed(2),
                hash: hash,
                fee: fee,
                sender: sender,
                recipient: recipient,
              ),
            ),
          );
        },
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            border: Border.all(color: const Color(0xff108C4A), width: 1.0),
          ),
          child: CircleAvatar(
            backgroundImage: Image.asset(
              isDeposit
                  ? "assets/images/send_icondown.png"
                  : "assets/images/send_icon.png",
              height: 20,
            ).image,
          ),
        ),
        title: Text(
          transactionType,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${fee.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Text(
                formatDateTime(timeStamp),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  amountText,
                  style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
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
