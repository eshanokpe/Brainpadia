import 'package:brainepadia/Screens/dashboard/profile/components/profile_component.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSellPostAds extends StatelessWidget {
  final num amount;
  final num price;
  final num limitForm;
  final num limitTo;
  final int p2PSellAdsId;

  const EditSellPostAds({
    super.key,
    required this.amount,
    required this.price,
    required this.limitForm,
    required this.limitTo,
    required this.p2PSellAdsId,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController amountController =
        TextEditingController(text: amount.toString());
    final TextEditingController priceController =
        TextEditingController(text: price.toString());
    final TextEditingController limitFromController =
        TextEditingController(text: limitForm.toString());
    final TextEditingController limitToController =
        TextEditingController(text: limitTo.toString());

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Edit Buy PostAds '),
      body: Form(
        key: _formKey,
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          'Edit Amount',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: amountController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          'Edit Price',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: priceController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          'Edit Limit Form',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: limitFromController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your limitFrom';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter limitFrom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Text(
                          'Edit Limit To',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: limitToController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your limiTo';
                      }
                      // Add any additional validation logic here
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter limitTo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<P2PPostAdsProvider>(
                      builder: (context, userState, _) {
                    return Hero(
                      tag: "login_btn",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: kPrimaryColor,
                          padding: const EdgeInsets.all(defaultPadding),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the value as needed
                          ),
                        ),
                        onPressed: userState.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  await userState.editSellPostAds(
                                      context,
                                      p2PSellAdsId,
                                      amountController.text,
                                      priceController.text,
                                      limitFromController.text,
                                      limitToController.text);
                                }
                              },
                        child: userState.isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xFF9739E3),
                              )
                            : const Text(
                                "UPDATE",
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
