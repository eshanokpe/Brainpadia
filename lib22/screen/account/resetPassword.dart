import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatelessWidget {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DialogBox dialogBox = DialogBox();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _password,
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _conpassword,
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // Handle reset password logic
                  if (_password.text.isEmpty || _conpassword.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'FIll up all fields');
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final String password = _password.text.trim();
                      final String conpassword = _conpassword.text.trim();
                      // Fluttertoast.showToast(
                      //   msg: 'ok SUCCESS');
                      // Show OTP model dialog and get OTP value
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OTPModel(
                                password: password, conpassword: conpassword);
                          });
                    } catch (e) {
                      //Navigator.pop(context);
                      dialogBox.information(
                          context, 'Status', 'Unable to sign in');
                    }
                  } else {
                    // Fluttertoast.showToast(
                    //   msg: 'No SUCCESS');
                  }
                },
                child: const Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPModel extends StatelessWidget {
  String password;
  String conpassword;
  OTPModel({
    super.key,
    required this.password,
    required this.conpassword,
  });
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();
  DialogBox dialogBox = DialogBox();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        // contentPadding: EdgeInsets.zero,
        title: Column(
          children: [
            Text(password),
            Text(conpassword),
            const Text('Enter OTP'),
            Row(
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Colors.red, // Customize the icon color
                ),
                SizedBox(width: 8.0),
                Text(
                  'An OTP has been sent to your email.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black, // Customize the text color
                  ),
                ),
              ],
            ),
          ],
        ),
        content: TextFormField(
          obscureText: true,
          controller: _otp,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'OTP',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter OTP';
            }
            return null;
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var url = Uri.parse("$baseUrl/Account/reset_password");
                dialogBox.waiting(context, 'Loading ...');
                var timer = Timer(const Duration(milliseconds: 30000), () {
                  Navigator.pop(context);
                  dialogBox.information(context, 'Status', 'Service timed out');
                  return;
                });
                final headers = {'Content-Type': 'application/json'};

                //print("email:$email");
                //print("Password:$password");
                final body = jsonEncode({
                  "password": password,
                  "confirmPassword": conpassword,
                  "email": "string",
                  "otp": _otp,
                });
                final response = await http.post(
                  url,
                  headers: headers,
                  body: body,
                );
                print(response.statusCode);
                if (response.statusCode == 200) {
                  Map<String, dynamic> data = jsonDecode(response.body);
                  print('reset:$data');
                  timer.cancel();
                  Navigator.pop(context);
                  dialogBox.information(context, 'Sucess', 'Successful');
                } else {
                  timer.cancel();
                  Navigator.pop(context);
                  dialogBox.information(
                      context, 'Error', 'Transaction response Error');
                }
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
