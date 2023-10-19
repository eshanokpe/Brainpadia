import 'package:flutter/material.dart';

import 'color_constant.dart';

class FormFieldConstant extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function? validateText;
  final void Function(String?)? onSaved;
  //final FocusNode focusNode;
  final bool manual;
  final bool? disable;

  const FormFieldConstant(
      {Key? key,
      required this.hintText,
      required this.onSaved,
      this.manual = false,
      //this.focusNode ,
      this.obscureText = false,
      this.validateText,
      required this.keyboardType,
      this.disable,
      required this.controller})
      : super(key: key);

  @override
  State<FormFieldConstant> createState() => _FormFieldConstantState();
}

class _FormFieldConstantState extends State<FormFieldConstant> {
  late String? validateText = '';
  //for passwords only
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    widget.controller.addListener(() {
      if (mounted) {
        String text = widget.controller.text;
        String returnedText = widget.validateText!(text.trim());
        if (validateText != returnedText) {
          setState(() {
            validateText = returnedText;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    final width = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.formbgcolor, // Set the background color
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: ColorConstant.formbordercolor, width: 0)),
      child: TextFormField(
        // focusNode: widget.focusNode,
        enabled: widget.disable,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        onSaved: widget.onSaved,
        validator: (String? val) =>
            validateText == "good" ? null : validateText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: ColorConstant.gray503, // Set the hint text color
          ),
          errorStyle: TextStyle(
              fontSize: width * .03, color: Theme.of(context).primaryColor),
          // errorBorder: myBorder,
          errorMaxLines: 3,
          // suffix: Icon(Icons.check_circle),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.obscureText,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: ColorConstant.primaryColor.withOpacity(.4)),
                    )),
              ),
            ],
          ),

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: ColorConstant.formbordercolor, width: 2.0)),
        ),
      ),
    );
  }
}

// class MyTextFormField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   @required
//   final TextInputType inputType;
//   @required
//   final Function validator;
//   final onSaved;
//   final bool obsureText;
//   final bool manual;

//   MyTextFormField({
//     required this.label,
//     required this.controller,
//     this.manual = false,
//     required this.focusNode,
//     this.onSaved,
//     required this.inputType,
//     this.obsureText = true,
//     required this.validator,
//   });

//   @override
//   _MyTextFormFieldState createState() => _MyTextFormFieldState();
// }

// class _MyTextFormFieldState extends State<MyTextFormField> {
//   String? validateText;

//   //for passwords only
//   late bool obscureText;

//   @override
//   void initState() {
//     super.initState();
//     obscureText = widget.obsureText;
//     widget.controller.addListener(() {
//       if (mounted) {
//         String text = widget.controller.text;
//         // if (text.isNotEmpty) {
//         String returnedText = widget.validator(text.trim());
//         if (validateText != returnedText)
//           setState(() {
//             validateText = returnedText;
//           });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Orientation orientation = MediaQuery.of(context).orientation;

//     final width = orientation == Orientation.portrait
//         ? MediaQuery.of(context).size.width
//         : MediaQuery.of(context).size.height;

//     InputBorder myBorder =
//         OutlineInputBorder(borderRadius: BorderRadius.circular(6));
//     return TextFormField(
//       focusNode: widget.focusNode,
//       keyboardType: widget.inputType,
//       style: TextStyle(
//         fontSize: width * .045,
//         // color: Theme.of(context).primaryColor,
//       ),
//       controller: widget.controller,
//       obscureText: obscureText,
//       onSaved: widget.onSaved,
//       validator: (String? val) => validateText == "good" ? null : validateText,
//       decoration: InputDecoration(
//           border: myBorder,
//           contentPadding: EdgeInsets.all(width * .04),
//           enabledBorder: myBorder,
//           disabledBorder: myBorder,
//           errorStyle: TextStyle(
//               fontSize: width * .03, color: Theme.of(context).primaryColor),
//           errorBorder: myBorder,
//           errorMaxLines: 3,
//           errorText: validateText == 'good' ? null : validateText,
//           suffix: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Visibility(
//                   visible: widget.obsureText,
//                   child: InkWell(
//                     onTap: () => setState(() => obscureText = !obscureText),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 3),
//                       child: Icon(
//                         obscureText ? Icons.visibility : Icons.visibility_off,
//                         size: 15,
//                         color: ColorConstant.primaryColor,
//                       ),
//                     ),
//                   )),
//               SizedBox(
//                 width: 5,
//               ),
//               (validateText == 'good' && widget.controller.text.isNotEmpty)
//                   ? Icon(
//                       Icons.check_circle,
//                       color: ColorConstant.primaryColor,
//                       size: 22,
//                     )
//                   : Container()
//             ],
//           ),
//           hintText: widget.label,
//           hintStyle: TextStyle(fontSize: width * .035),
//           labelStyle: TextStyle(
//             fontSize: width * .03,
//             color: ColorConstant.primaryColor,
//           )),
//     );
//   }
// }
