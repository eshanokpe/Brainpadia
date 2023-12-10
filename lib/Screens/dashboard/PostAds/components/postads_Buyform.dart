import 'dart:async';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:brainepadia/providers/user_provider.dart';

class PostadsBuyForm extends StatefulWidget {
  const PostadsBuyForm({Key? key}) : super(key: key);

  @override
  State<PostadsBuyForm> createState() => _PostadsBuyFormState();
}

class _PostadsBuyFormState extends State<PostadsBuyForm> {
  List<String> asset = ['BPCoin'];
  String selectedAsset = 'BPCoin';
  List<String> currencies = ['USD', 'NGN'];
  String selectedCurrency = 'USD';
  String? getbankId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController limitFromController = TextEditingController();
  final TextEditingController limitToController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  void _onAmountChanged(String value) {
    //_debounceTimer?.cancel();
    //_debounceTimer = Timer(const Duration(milliseconds: 100), _fetchProfileFee);
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Center(
              child: Text(
                'Create a Buy Ads', // Replace SizedBox.shrink() with Text widget
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Asset', // Replace SizedBox.shrink() with Text widget
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12,
                        ),
                        child: DropdownButton<String>(
                          value: selectedAsset,
                          items: asset.map((asset) {
                            return DropdownMenuItem<String>(
                              value: asset,
                              child: Text(
                                asset, // Replace SizedBox.shrink() with Text widget
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAsset = value!;
                            });
                            print('Selected asset: $selectedAsset');
                          },
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Currency', // Replace SizedBox.shrink() with Text widget
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12,
                        ),
                        child: DropdownButton<String>(
                          value: selectedCurrency,
                          items: currencies.map((currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCurrency = value!;
                            });
                            print('Selected currency: $selectedCurrency');
                          },
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          underline: const SizedBox(),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child:
                  Consumer<UserProvider>(builder: (context, userProvider, _) {
                return userProvider.getBankData.isEmpty
                    ? Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: height * .01,
                            left: width * .08,
                          ),
                          child: const Text("Please put your bank details",
                              style: TextStyle(color: Colors.red)),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 196, 196, 196),
                            )),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: getbankId,
                            hint: const Text('Select bank'),
                            items: userProvider.getBankData.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                    '${item['bankName']}(${item['accountName']})'),
                                value: item['bankDetailsId'].toString(),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                getbankId = value as String;
                                print('bankDetailsId:$getbankId');
                              });
                            },
                          ),
                        ),
                      );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount', // Replace SizedBox.shrink() with Text widget
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    controller: amountController,
                    onChanged: _onAmountChanged,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your amount';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price', // Replace SizedBox.shrink() with Text widget
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    controller: priceController,
                    onChanged: _onAmountChanged,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your price';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Limit From', // Replace SizedBox.shrink() with Text widget
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    controller: limitFromController,
                    onChanged: _onAmountChanged,
                    decoration: const InputDecoration(
                      hintText: "Enter LimitFrom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your limitfrom';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Limit To', // Replace SizedBox.shrink() with Text widget
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    controller: limitToController,
                    onChanged: _onAmountChanged,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your limitTo';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter LimitTo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: defaultPadding),
              child:
                  Consumer<FetchBlockchain>(builder: (context, userState, _) {
                return Hero(
                  tag: "login_btn",
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: userState.isLoadingSend
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              await userState.sendBuyPostAds(
                                context,
                                getbankId!,
                                selectedAsset,
                                selectedCurrency,
                                amountController.text,
                                priceController.text,
                                limitFromController.text,
                                limitToController.text,
                              );
                            }
                          },
                    child: userState.isLoadingSend
                        ? const CircularProgressIndicator(
                            color: Color(0xFF9739E3),
                          )
                        : Text(
                            "Buy".toUpperCase(),
                          ),
                  ),
                );
              }),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
