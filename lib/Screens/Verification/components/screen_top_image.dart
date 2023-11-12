import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ScreenTopImage extends StatelessWidget {
  const ScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/successimg.png"),
            ),
            const Spacer(),
          ],
        ),
        //SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
