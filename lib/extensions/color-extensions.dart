import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  String toHtmlHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  static MaterialColor materialColorFromHexadecimal(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');

    buffer.write(hexString.replaceFirst('#', ''));

    var cor = Color(int.parse(buffer.toString(), radix: 16));

    Map<int, Color> color = {
      50: cor.withOpacity(0.1),
      100: cor.withOpacity(0.2),
      200: cor.withOpacity(0.3),
      300: cor.withOpacity(0.4),
      400: cor.withOpacity(0.5),
      500: cor.withOpacity(0.6),
      600: cor.withOpacity(0.7),
      700: cor.withOpacity(0.8),
      800: cor.withOpacity(0.9),
      900: cor.withOpacity(1.0),
    };

    return MaterialColor(cor.value, color);
  }
}
