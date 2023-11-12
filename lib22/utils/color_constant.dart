import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color primaryColor = fromHex('#9739E3');

  static Color formbgcolor = fromHex('#F0EFFF');
  static Color formbordercolor = fromHex('#A7A3FF');

  static Color blueA400 = fromHex('#337af0');

  static Color lightBlue100 = fromHex('#b5e3f7');

  static Color gray80000 = fromHex('#004f3636');

  static Color green700 = fromHex('#457a4a');

  static Color greenA700 = fromHex('#1cbd30');

  static Color black90040 = fromHex('#4000050d');

  static Color pink700 = fromHex('#cc1440');

  static Color gray606 = fromHex('#7d7d7d');

  static Color gray607 = fromHex('#6e6e6e');

  static Color lightBlue40035 = fromHex('#351cb0f2');

  static Color blue50 = fromHex('#e8f5fa');

  static Color blue51 = fromHex('#e8f2f7');

  static Color bluegray801 = fromHex('#294f5e');

  static Color bluegray800 = fromHex('#263d4a');

  static Color bluegray601 = fromHex('#4d6e7d');

  static Color bluegray403 = fromHex('#888888');

  static Color bluegray600 = fromHex('#547585');

  static Color bluegray402 = fromHex('#878785');

  static Color bluegray401 = fromHex('#8c8c8c');

  static Color bluegray400 = fromHex('#8a8a8a');

  static Color bluegray200 = fromHex('#b5bac9');

  static Color bluegray4007b = fromHex('#7b878787');

  static Color whiteA700 = fromHex('#ffffff');

  static Color whiteA7005e = fromHex('#5effffff');

  static Color red901 = fromHex('#bd1c1c');

  static Color lightBlue200 = fromHex('#80ccf0');

  static Color red900 = fromHex('#ad1717');

  static Color gray900Cc = fromHex('#cc1c1a38');

  static Color indigoA200 = fromHex('#6b63fa');

  static Color lightBlue400 = fromHex('#1cb0f2');

  static Color green800 = fromHex('#128221');

  static Color gray50 = fromHex('#fcfcfc');

  static Color black900 = fromHex('#000000');

  static Color black902 = fromHex('#000303');

  static Color black901 = fromHex('#030303');

  static Color gray507 = fromHex('#a3a3a3');

  static Color gray501 = fromHex('#adadad');

  static Color gray502 = fromHex('#a8a8a8');

  static Color gray700 = fromHex('#5e5e5e');

  static Color gray500 = fromHex('#9e9e9e');

  static Color gray505 = fromHex('#a1a1a1');

  static Color lightBlue4007b = fromHex('#7b1cb0f2');

  static Color gray506 = fromHex('#969696');

  static Color gray503 = fromHex('#667085');
  static Color clickmecolor = fromHex('#3B4054');

  static Color lightBlue4007a = fromHex('#7a1cb0f2');

  static Color gray701 = fromHex('#595959');

  static Color gray504 = fromHex('#ababab');

  static Color gray702 = fromHex('#666666');

  static Color gray900 = fromHex('#1c1a38');

  static Color bluegray100 = fromHex('#d1d1d1');

  static Color black90080 = fromHex('#80000000');

  static Color teal50 = fromHex('#d9e8f2');

  static Color gray300 = fromHex('#e0e0e0');

  static Color gray100 = fromHex('#f7f7f7');

  static Color bluegray900 = fromHex('#2b2947');

  static Color cyan300 = fromHex('#45d4e6');

  static Color bluegray701 = fromHex('#3d4d63');

  static Color bluegray700 = fromHex('#474f69');

  static Color black90033 = fromHex('#33000000');

  static Color bluegray104 = fromHex('#d1d1d6');

  static Color bluegray103 = fromHex('#d4d4d4');

  static Color bluegray102 = fromHex('#cfcfcf');

  static Color bluegray101 = fromHex('#cfd1d9');

  static Color blue400 = fromHex('#3babe3');

  static Color cyan900 = fromHex('#0f5978');

  static Color bluegray901 = fromHex('#0d1f3d');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
