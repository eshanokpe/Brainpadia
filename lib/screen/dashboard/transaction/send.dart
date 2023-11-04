import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/utils/authValiator.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/formFieldconstant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
} 

class _SendState extends State<Send> {
  DialogBox dialogBox = DialogBox();
  @override
  Widget build(BuildContext context) {
    var getWallet = context.watch<Providers>().walletDetails;
    //print(getWallet.walletAddress);
    TextEditingController _senderaddress =
        TextEditingController(text: getWallet.walletAddress);
    TextEditingController _recipientaddress = TextEditingController();
    TextEditingController _amount = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Send',
          style: TextStyle(
            color: ColorConstant.black902,
            fontSize: getFontSize(
              22,
            ),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: size.height / 25,
            ),
            SizedBox(
              width: 164,
              height: 168,
              child: Image.asset(
                'assets/icons/send_img.png',
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  20.00,
                ),
                right: getHorizontalSize(
                  20.00,
                ),
              ),
              child: Text(
                'Recipient Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getFontSize(
                    20,
                  ),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  20.00,
                ),
                right: getHorizontalSize(
                  20.00,
                ),
              ),
              child: FormFieldConstant(
                hintText: 'Enter recipient address',
                controller: _recipientaddress,
                keyboardType: TextInputType.name,
                validateText: AuthValidator.validateName,
                // focusNode: pnode,
                onSaved: null,
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  20.00,
                ),
                right: getHorizontalSize(
                  20.00,
                ),
              ),
              child: Text(
                'Sender Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getFontSize(
                    20,
                  ),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  20.00,
                ),
                right: getHorizontalSize(
                  20.00,
                ),
              ),
              child: FormFieldConstant(
                hintText: 'Enter sender address',
                controller: _senderaddress,
                disable: false,
                keyboardType: TextInputType.name,
                validateText: AuthValidator.validateName,
                // focusNode: pnode,
                onSaved: null,
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getHorizontalSize(
                    20.00,
                  ),
                  right: getHorizontalSize(
                    20.00,
                  )),
              child: Text(
                'Transfer Amount',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getFontSize(
                    20,
                  ),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getHorizontalSize(
                    20.00,
                  ),
                  right: getHorizontalSize(
                    20.00,
                  )),
              child: FormFieldConstant(
                hintText: 'Enter amount',
                controller: _amount,
                keyboardType: TextInputType.number,
                validateText: AuthValidator.validateNumber,
                // focusNode: pnode,
                onSaved: null,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  20.00,
                ),
                right: getHorizontalSize(
                  20.00,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fee',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getFontSize(
                        20,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '0.02',
                    style: TextStyle(
                      color: ColorConstant.gray503,
                      fontSize: getFontSize(
                        20,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getHorizontalSize(
                    20.00,
                  ),
                  right: getHorizontalSize(20)),
              child: ElevatedButton(
                onPressed: () async {
                  if (_recipientaddress.text.isEmpty ||
                      _senderaddress.text.isEmpty ||
                      _amount.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'FIll up all fields');
                    return;
                  }
                  sendData(
                    _recipientaddress.text.trim(),
                    _senderaddress.text.trim(),
                    _amount.text.trim(),
                  );
                },
                child: const Text(
                  "send",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 18),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstant.primaryColor),
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return states.contains(MaterialState.pressed)
                          ? Colors.black26
                          : null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendData(String trim, String? sender, String? amount) async {
    //var url = Uri.parse( "$baseUrl/BPCoin/send_coin?recipientAddress=$trim&senderAddress=$trim2&amount=$trim3&fee=0.05");
    print('amount:$amount');
    print('sender:$sender');
    var url = Uri.parse(
        "$baseUrl/BPCoin/send_coin?recipientAddress=BPCAVeGRcvhaw9vNH7LGdSPuDH3dmqPdMCyEj8FCnjhasvC&senderAddress=$sender&amount=$amount&fee=0.05");

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenDB');
    dialogBox.waiting(context, 'Loading...');
    var timer = Timer(const Duration(milliseconds: 30000), () {
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Service timed out');
      return;
    });
    var response =
        await http.get(url, headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = jsonDecode(response.body);
      //Map<String, dynamic> data = userData['data'];
      print(userData);
      Fluttertoast.showToast(msg: 'Success');
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(
          context, '${userData['status']}', '${userData['message']}');
    } else if (response.statusCode == 500) {
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(
          context, 'Status', 'Server error, please try again later');
    } else if (response.statusCode == 400) {
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Bad Request');
    } else if (response.statusCode == 404) {
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Status', 'Request Not Found');
    } else {
      //Map userError = jsonDecode(response.body);
      print(response.statusCode);
      timer.cancel();
      Navigator.pop(context);
      dialogBox.information(context, 'Error', 'Something went wrong');
    }
  }
}
