import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../components/profile_component.dart';

class EditBank extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final bankDetailsId;
  final accountNo;
  final accountName;
  final bankName;
  final profileId;

  EditBank(
      {Key? key,
      this.bankDetailsId,
      this.bankName,
      this.accountNo,
      this.profileId,
      this.accountName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _bankName =
        TextEditingController(text: bankName.toString());
    final TextEditingController _accountNo =
        TextEditingController(text: accountNo.toString());
    final TextEditingController _accountName =
        TextEditingController(text: accountName.toString());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Edit Bank Details'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: Text(
                        'Enter Bank name',
                        style: Theme.of(context).textTheme.bodyMedium!,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Bank Name',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your bank name';
                    }
                    // Add any additional validation logic here
                    return null;
                  },
                  controller: _bankName,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: Text(
                        'Enter Account Number',
                        style: Theme.of(context).textTheme.bodyMedium!,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Account Number',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your AccountNo';
                    }
                    if (value.length != 10) {
                      return 'Account number must 10 characters long';
                    }
                    // Add any additional validation logic here
                    return null;
                  },
                  controller: _accountNo,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: Text(
                        'Enter Account name',
                        style: Theme.of(context).textTheme.bodyMedium!,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Account name',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your account name';
                    }

                    return null;
                  },
                  controller: _accountName,
                ),
                const SizedBox(height: 30.0),
                Consumer<UserProvider>(builder: (context, userState, _) {
                  return Hero(
                    tag: "Changed Password",
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: kPrimaryColor,
                        padding: EdgeInsets.all(defaultPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value as needed
                        ),
                      ),
                      onPressed: userState.isLoadingSend
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await userState.editBankDetails(
                                  context,
                                  bankDetailsId,
                                  bankName,
                                  accountNo,
                                  accountName,
                                );
                              }
                            },
                      child: userState.isLoadingSend
                          ? const CircularProgressIndicator(
                              color: Color(0xFF9739E3),
                            )
                          : const Text('Update'),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
