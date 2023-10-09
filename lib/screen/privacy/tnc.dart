import 'package:flutter/material.dart';

class Tnc extends StatefulWidget {
  final bool tnc;

  const Tnc({Key? key, required this.tnc}) : super(key: key);

  @override
  State<Tnc> createState() => _TncState();
}

class _TncState extends State<Tnc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.tnc ? Text("Terms and Conditions") : Text("Privacy Policy"),
      ),
    );
  }
}
