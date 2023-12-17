import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _fetchProfileFee() {
    final amount = int.tryParse(amountController.text) ?? 0;
    Provider.of<Providers>(context, listen: false)
        .fetchProfileFee(amount, context);
  }

  void _onAmountChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), _fetchProfileFee);
  }

  void _showOTPDialog(BuildContext context, String email, String recipient,
      String walletAddress, String amount, String feeValue) {
    String otpCode = '';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        title: const Text('Enter OTP Code'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "An OTP code has been sent to your email",
                style: TextStyle(fontSize: 14, color: Color(0xff667085)),
              ),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                  ),
                  child: OtpTextField(
                    textStyle: const TextStyle(fontSize: 17),
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    obscureText: true,
                    borderWidth: 1,
                    clearText: false,
                    borderRadius: BorderRadius.circular(5),
                    borderColor: Colors.black,
                    focusedBorderColor: const Color(0xff9739E3),
                    onSubmit: (code) async {
                      setState(() {
                        otpCode = code;
                      });
                      await userState.oTPSendVerification(context, otpCode,
                          recipient, walletAddress, amount, feeValue);
                    },
                  ),
                );
              }),
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextButton(
                  onPressed: userState.getLoading
                      ? null
                      : () async {
                          print('sentOTP');
                          try {
                            print('sentOTP');
                            await userState.sendGetOTP();
                          } catch (error) {
                            // Handle error or display a message to the user
                            Fluttertoast.showToast(
                                msg: 'Error while sending OTP: $error');
                          }
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
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<UserProvider>(builder: (context, userState, _) {
                return TextButton(
                  onPressed: userState.sendgetLoading
                      ? null
                      : () async {
                          try {
                            print('otpCode:$otpCode');
                            if (otpCode.length != 6 || otpCode.isEmpty) {
                              Fluttertoast.showToast(msg: 'Enter OTP Code');
                              return;
                            } else {
                              await userState.oTPSendVerification(
                                  context,
                                  otpCode,
                                  recipient,
                                  walletAddress,
                                  amount,
                                  feeValue);
                            }
                          } catch (error) {
                            // Handle error or display a message to the user
                            Fluttertoast.showToast(
                                msg: 'Error during OTP verification: $error');
                          }
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

  String barcode = "";
  Future<void> scanQRCode() async {
    // try {
    //   ScanResult result = await BarcodeScanner.scan(); // Scanning QR code

    //   setState(() {
    //     recipientController.text = result.rawContent ?? '';
    //   });
    // } catch (e) {
    //   // Handle exception or error, if any
    //   print('Error while scanning QR code: $e');
    // }
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() {
        recipientController.text = barcode.rawContent ?? '';
      });
      setState(() => this.barcode = barcode.rawContent);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'No camera permission!';
        });
      } else {
        setState(() => barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<Providers>(context);
    final getuser = Provider.of<UserProvider>(context).getuser;

    //final feeValue = Provider.of<UserProvider>(context).profileFee;
    final getWallet = Provider.of<UserProvider>(context).getuserWallet;
    final walletAddress = getWallet.walletAddress!;

    return Form(
      child: Consumer<UserProvider>(builder: (context, transactionData, _) {
        final feeValue = transactionData.profileFee;
        return Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: recipientController,
              decoration: InputDecoration(
                  hintText: "Recipient Account",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: scanQRCode,
                    icon: const Icon(
                      Icons
                          .qr_code, // Replace this with the scan icon you'd like to use
                      color: Colors.grey, // Adjust the color as needed
                    ),
                  )),
            ),
            Text(
              barcode,
              style: TextStyle(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                cursorColor: kPrimaryColor,
                controller: amountController,
                onChanged: _onAmountChanged,
                decoration: const InputDecoration(
                  hintText: "Enter Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
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
                  Text(
                    '${feeValue ?? '0.0'}',
                    style: const TextStyle(
                      color: walletpinkColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
                        if (recipientController.text.isEmpty ||
                            amountController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Fill up all fields');
                          return;
                        }

                        _showOTPDialog(
                            context,
                            getuser.email!,
                            recipientController.text,
                            walletAddress,
                            amountController.text,
                            feeValue.toString());
                      },
                child: userState.isLoading
                    ? const CircularProgressIndicator(color: Color(0xFF9739E3))
                    : const Text("Send"),
              ),
            ),
            const SizedBox(height: defaultPadding),
            const SizedBox(height: defaultPadding),
          ],
        );
      }),
    );
  }
}
