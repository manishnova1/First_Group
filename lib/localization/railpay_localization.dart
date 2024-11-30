import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RailPayLocalizations {
  RailPayLocalizations(this.locale);

  final Locale locale;

  static RailPayLocalizations? of(BuildContext context) {
    return Localizations.of<RailPayLocalizations>(
        context, RailPayLocalizations);
  }

  Map<String, String>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString('lib/languages/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues![key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<RailPayLocalizations> delegate =
      _RailPayLocalizationsDelegate();
}

class _RailPayLocalizationsDelegate
    extends LocalizationsDelegate<RailPayLocalizations> {
  const _RailPayLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<RailPayLocalizations> load(Locale locale) async {
    RailPayLocalizations localization = RailPayLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<RailPayLocalizations> old) => false;
}
