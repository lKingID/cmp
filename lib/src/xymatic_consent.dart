import 'dart:core';

import 'package:opencmp/models/consent_cookies.dart';

class XymaticConsent {
  final ConsentCookies? cookies;

  XymaticConsent(this.cookies);

  bool get isConsentGiven {
    if (cookies == null) {
      return (false);
    }

    if (isAbleToGiveConsent == false) {
      return (true);
    }

    if (_isConsentGiven && _isPurposeConsentGiven) {
      return (true);
    }

    return (false);
  }

  bool get isAbleToGiveConsent {
    if (cookies?.preferences.gdprApplies == 0) {
      return (false);
    }
    return (true);
  }

  bool get _isConsentGiven {
    if (_validateConsent() == 1) {
      return (true);
    }
    return (false);
  }

  int? _validateConsent() {
    var consents = _castToList(cookies!.preferences.customVendorConsents);
    if (consents.length > 1176) {
      return (consents.elementAt(1176));
    }
    return (null);
  }

  bool get _isPurposeConsentGiven {
    for (var purpose in _castToList(cookies!.preferences.purposeConsents)) {
      if (purpose == 0) {
        return (false);
      }
    }
    return (true);
  }

  List<int> _castToList(String string) {
    return (string.runes
        .map((rune) => int.parse(String.fromCharCode(rune)))
        .toList());
  }
}
