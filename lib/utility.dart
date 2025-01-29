import 'package:flutter/services.dart';

String getFixedString(String initialString) {
  return initialString
      .replaceAll('&#039;', '\'')
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

void hideSystemUi() {
  SystemChrome.setSystemUIChangeCallback((isVisible) async {
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

void setOrientation() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void setUIMode() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
}
