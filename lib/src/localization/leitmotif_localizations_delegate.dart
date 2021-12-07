import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'package:flutter/material.dart';
import 'package:leitmotif/localization.dart';

/// A Leitmotif delegate class initializing the [LeitmotifLocalizations].
class LeitmotifLocalizationsDelegate
    extends LocalizationsDelegate<LeitmotifLocalizations> {
  const LeitmotifLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LeitmotifLocalizations.languages().contains(locale.languageCode);

  @override
  Future<LeitmotifLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of LeitmotifLocalizations.
    return SynchronousFuture<LeitmotifLocalizations>(
      LeitmotifLocalizations(locale),
    );
  }

  @override
  bool shouldReload(LeitmotifLocalizationsDelegate old) => false;
}
