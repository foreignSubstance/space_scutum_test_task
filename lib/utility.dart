import 'package:flutter/services.dart';

extension FixedString on String {
  String fixString() {
    return replaceAll('&#039;', '\'')
        .replaceAll('&quot;', '"')
        .replaceAll('&eacute;', 'é')
        .replaceAll('&aacute;', 'á')
        .replaceAll('&amp;', '&')
        .replaceAll('&Delta;', 'Δ')
        .replaceAll('&Ntilde;', 'Ñ')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&auml;', 'ä')
        .replaceAll('&ouml;', 'ö')
        .replaceAll('&uuml;', 'ü')
        .replaceAll('&rsquo;', '’')
        .replaceAll('&rdquo;', '”')
        .replaceAll('&ldquo;', '“')
        .replaceAll('&reg;', '®')
        .replaceAll('&trade;', '™')
        .replaceAll('&ndash;', '–')
        .replaceAll('&ntilde;', 'ñ')
        .replaceAll('&euml;', 'ë');
  }
}

Future<void> hideSystemUi() async {
  return SystemChrome.setSystemUIChangeCallback((isVisible) async {
    if (isVisible) {
      Future.delayed(
        const Duration(seconds: 5),
        () {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.immersive,
          );
        },
      );
    }
  });
}

Future<void> setOrientation() async {
  return SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> setUIMode() async {
  return SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
}
