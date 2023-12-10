import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:brainepadia/providers/user_provider.dart';

class SendForm extends StatefulWidget {
  const SendForm({Key? key}) : super(key: key);

  @override
  State<SendForm> createState() => _SendFormState();
}

class _SendFormState extends State<SendForm> {
  final TextEditingController recipientController = TextEditingController();


 

  void _showOTPDialog(BuildContext context, String email, String recipient,
      String walletAddress, String amount, String feeValue) {
    String otpCode = '';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        title: const Text('Enter OTP Code'),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "An OTP code has been sent to your email",
                  style: TextStyle(fontSize: 14, color: Color(0xff667085)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: OtpTextField(
                    textStyle: const TextStyle(fontSize: 17),
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    obscureText: true,
                    borderWidth: 1,
                    clearText: true,
                    borderRadius: BorderRadius.circular(5),
                    borderColor: Colors.black,
                    focusedBorderColor: const Color(0xff9739E3),
                    onSubmit: (code) {
                      otpCode = code;
                    },
                  ),
                ),
                Consumer<UserProvider>(builder: (context, userState, _) {
                  return TextButton(
                    onPressed: userState.getLoading
                        ? null
                        : () async {
                            print('sentOTP');
                            //final getuser =
                            //Provider.of<UserProvider>(context).getuser;
                            //await userState.sendOTP(getuser.email!, context);
                            await userState.sendGetOTP();
                          },
                    child: userState.getLoading
                        ? const CircularProgressIndicator(
                            color: Color(0xFF9739E3))
                        : const Text(
                            "Get OTP",
                            style: TextStyle(color: kSecondaryColor),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextButton(
                  onPressed: userState.sendgetLoading
                      ? null
                      : () async {
                          print('otpCode:$otpCode');
                          await userState.oTPVerification(context, otpCode,
                              recipient, walletAddress, amount, feeValue);
                          otpCode = '';
                        },
                  child: userState.sendgetLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF9739E3))
                      : const Text(
                          "Send",
                          style: TextStyle(color: kSecondaryColor),
                        ),
                );
              }),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: kSecondaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final userState = Provider.of<Providers>(context);
    final getuser = Provider.of<UserProvider>(context).getuser;
    final feeValue = Provider.of<UserProvider>(context).profileFee;
    final getWallet = Provider.of<UserProvider>(context).getuserWallet;
    final walletAddress = getWallet.walletAddress!;

    return Form(
      child: Column(
        children: [
          Consumer<UserProvider>(builder: (context, userState, _) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              //cursorColor: kPrimaryColor,
              //controller: recipientController,
              onChanged: (value) => userState.setRecipient(value),
              decoration: const InputDecoration(
                hintText: "Recipient Account",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Consumer<UserProvider>(builder: (context, userState, _) {
              return TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  userState.setAmount(value);
                  
                },
                decoration: const InputDecoration(
                  hintText: "Enter Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Fee: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Consumer<UserProvider>(builder: (context, userState, _) {
                  UserProvider userProvider = Provider.of<UserProvider>(context);

                  final feeAmount = userState.feeAmount;
                  return Text(
                    '${feeAmount ?? '0.0'}',
                    //'${feeAmount ?? '0.0'}',
                    style: const TextStyle(
                      color: walletpinkColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: kPrimaryColor,
                padding: const EdgeInsets.all(defaultPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: userState.isLoading
                  ? null
                  : () async {
                      // if (recipientController.text.isEmpty ||
                      //     amountController.text.isEmpty) {
                      //   Fluttertoast.showToast(msg: 'Fill up all fields');
                      //   return;
                      // }

                      // _showOTPDialog(
                      //     context,
                      //     getuser.email!,
                      //     recipientController.text,
                      //     walletAddress,
                      //     amountController.text,
                      //     feeValue.toString());
                    },
              child: userState.isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF9739E3))
                  : const Text("Send"),
            ),
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
