import 'package:brainepadia/components/resend_otp.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class OTPCodeForm extends StatefulWidget {
  const OTPCodeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPCodeForm> createState() => _OTPCodeFormState();
}

class _OTPCodeFormState extends State<OTPCodeForm> {
  bool _isLoading = false;

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //Text(widget.email),

          Consumer<Providers>(builder: (context, userState, _) {
            String otpCode = '';
            return Column(
              children: [
                OtpTextField(
                  textStyle: const TextStyle(fontSize: 17),
                  numberOfFields: 6,
                  showFieldAsBox: true,
                  obscureText: true,
                  borderWidth: 2,
                  clearText: true,
                  borderRadius: BorderRadius.circular(5),
                  borderColor: Colors.black,
                  focusedBorderColor: const Color(0xff9739E3),
                  onSubmit: (code) async {
                    otpCode = code;

                    userState.setOTPCode(otpCode);
                    userState.validateOTPCode(context);
                  },
                ),
                const SizedBox(height: defaultPadding * 4),
                ElevatedButton(
                  onPressed: userState.isLoading
                      ? null
                      : () async {
                          userState.setOTPCode(otpCode);
                          await userState.validateOTPCode(context);
                        },
                  child: userState.isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF9739E3),
                        )
                      : const Text("Submit OTP"),
                ),
              ],
            );
          }),

          const SizedBox(height: defaultPadding * 4),
          SendOTP(
            press: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Resend OTP'),
                  content: const Text(
                      'Do you want to resend the OTP code to your email?'),
                  actions: [
                    Consumer<Providers>(builder: (context, userState, _) {
                      return TextButton(
                        onPressed: userState.isLoading
                            ? null
                            : () async {
                                await userState.resendOTPCode(context);
                              },
                        child: userState.isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xFF9739E3),
                              )
                            : const Text(
                                'Resend',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ),
                              ),
                      );
                    }),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
