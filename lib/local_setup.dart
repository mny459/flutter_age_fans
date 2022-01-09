import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// 国际化
Locale loadSupportedLocals(Locale? locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    Intl.defaultLocale = S.delegate.supportedLocales.first.languageCode;
    return supportedLocales.first;
  }

  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode ||
        supportedLocale.countryCode == locale.countryCode) {
      Intl.defaultLocale = supportedLocale.languageCode;
      return supportedLocale;
    }
  }

  Intl.defaultLocale = supportedLocales.first.languageCode;
  return supportedLocales.first;
}

// 国际化
List<LocalizationsDelegate> get localizationsDelegates {
  return [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
