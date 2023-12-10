  // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const Text(
    //               'Transactions',
    //               style: TextStyle(
    //                 color: Color(0xff2B2D80),
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 22,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 0, left: 100),
    //               child: InkWell(
    //                 onTap: () {
    //                   context
    //                       .read<FetchBlockchain>()
    //                       .fetchTransactionAll(context);
    //                   // Navigator.push(
    //                   //     context,
    //                   //     MaterialPageRoute(
    //                   //       builder: (context) => SuccessTransactionScreen(
    //                   //           amount: 39,
    //                   //           transactionDate:'2023-10-17T23:59:56+01:00',
    //                   //           walletId:
    //                   //               'BPC9jkRMuCQEoNKWj4YGT2tMTWayhkUiVepJ9APnhD5KutK'),
    //                   //     ));
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => const AllTransaction(),
    //                       ));
    //                   // final userProvider =
    //                   //     Provider.of<UserProvider>(context, listen: false);
    //                   Provider.of<FetchBlockchain>(context, listen: false)
    //                       .fetchTransactionAll(context);
    //                 },
    //                 child: const Text(
    //                   'View All',
    //                   style: TextStyle(
    //                     color: Color(0xff2B2D80),
    //                     decoration: TextDecoration.underline,
    //                     fontSize: 14,
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       transactionData.isEmpty
    //           ? const Center(
    //               child: CircularProgressIndicator(
    //               color: Color(0xFF9739E3),
    //             )) // Show loading indicator
    //           : ListView.builder(
    //               shrinkWrap: true,
    //               physics: const BouncingScrollPhysics(),
    //               itemCount: transactionData.length,
    //               itemBuilder: (BuildContext context, int index) {
    //                 if (transactionData.isEmpty) {
    //                   return const Center(child: Text('No data available'));
    //                 }
    //                 Map<String, dynamic> item = transactionData[index];
    //                 return Column(
    //                   children: [
    //                     
    //                     
    //                     walletAddress == item['recipient']
    //                         ? Card(
    //                             child: ListTile(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           TransactionDetails(
    //                                               title: 'Deposit Amount',
    //                                               timeStamp: item['timeStamp'],
    //                                               amount: item['amount']
    //                                                   .toStringAsFixed(2),
    //                                               hash: item['hash'],
    //                                               transactionDate:
    //                                                   '2023-10-17T23:59:56+01:00',
    //                                               fee: item['fee'],
    //                                               sender: item['sender'],
    //                                               recipient: item['recipient']),
    //                                     ));
    //                               },
    //                               leading: Container(
    //                                 decoration: BoxDecoration(
    //                                     borderRadius: const BorderRadius.all(
    //                                         Radius.circular(30.0)),
    //                                     border: Border.all(
    //                                         color: const Color(0xff108C4A),
    //                                         width: 1.0)),
    //                                 child: CircleAvatar(
    //                                   backgroundImage: Image.asset(
    //                                     "assets/images/send_icondown.png",
    //                                     // width: 30, // Adjust the width as needed
    //                                     height:
    //                                         20, // Adjust the height as needed
    //                                   ).image,
    //                                 ),
    //                               ),
    //                               title: const Text('Deposit Amount',
    //                                   style: TextStyle(
    //                                     //color: const Color(0xff2B2D80),
    //                                     fontWeight: FontWeight.bold,
    //                                   )),
    //                               subtitle: Text(
    //                                 '${item['fee'].toStringAsFixed(2)}',
    //                                 style: const TextStyle(
    //                                   color: Colors.red,
    //                                 ),
    //                               ),
    //                               trailing: Padding(
    //                                 padding: const EdgeInsets.only(top: 10.0),
    //                                 child: Column(children: [
    //                                   Text(
    //                                     formatDateTime(item['timeStamp']),
    //                                     style: const TextStyle(
    //                                         color: Colors.grey,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                   Padding(
    //                                     padding:
    //                                         const EdgeInsets.only(top: 5.0),
    //                                     child: Text(
    //                                       "+${item['amount'].toStringAsFixed(2)}",
    //                                       style: const TextStyle(
    //                                           color: Color(0xff3B802B),
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ),
    //                                 ]),
    //                               ),
    //                             ),
    //                           )
    //                         : Card(
    //                             child: ListTile(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           TransactionDetails(
    //                                               title: 'Withdraw Amount',
    //                                               timeStamp: item['timeStamp'],
    //                                               hash: item['hash'],
    //                                               amount: item['amount']
    //                                                   .toStringAsFixed(2),
    //                                               transactionDate:
    //                                                   '2023-10-17T23:59:56+01:00',
    //                                               fee: item['fee'],
    //                                               sender: item['sender'],
    //                                               recipient: item['recipient']),
    //                                     ));
    //                               },
    //                               leading: Container(
    //                                 decoration: BoxDecoration(
    //                                     borderRadius: const BorderRadius.all(
    //                                         Radius.circular(30.0)),
    //                                     border: Border.all(
    //                                         color: const Color(0xff108C4A),
    //                                         width: 1.0)),
    //                                 child: CircleAvatar(
    //                                   backgroundImage: Image.asset(
    //                                     "assets/images/send_icon.png",
    //                                     // width: 30, // Adjust the width as needed
    //                                     height:
    //                                         20, // Adjust the height as needed
    //                                   ).image,
    //                                 ),
    //                               ),
    //                               title: const Text('Withdraw Amount',
    //                                   style: TextStyle(
    //                                     // color: Color(0xff2B2D80),
    //                                     fontWeight: FontWeight.bold,
    //                                   )),
    //                               subtitle: Text(
    //                                 '${item['fee'].toStringAsFixed(2)}',
    //                                 style: const TextStyle(
    //                                   color: Colors.red,
    //                                 ),
    //                               ),
    //                               trailing: Padding(
    //                                 padding: const EdgeInsets.only(top: 10.0),
    //                                 child: Column(children: [
    //                                   Text(
    //                                     formatDateTime(item['timeStamp']),
    //                                     style: const TextStyle(
    //                                         color: Colors.grey,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                   Padding(
    //                                     padding:
    //                                         const EdgeInsets.only(top: 5.0),
    //                                     child: Text(
    //                                       "-${item['amount'].toStringAsFixed(2)}",
    //                                       style: const TextStyle(
    //                                           color: const Color(0xffFF2A03),
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ),
    //                                 ]),
    //                               ),
    //                             ),
    //                           ),
    //                   ],
    //                 );
    //               },
    //             ),
    //     ],
    //   ),
    // );
  