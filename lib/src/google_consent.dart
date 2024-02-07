import 'dart:core';

import 'package:opencmp/models/consent_cookies.dart';

class GoogleConsent {
  final ConsentCookies? cookies;

  GoogleConsent(this.cookies);

  bool get isConsentGiven {
    if (cookies == null) {
      return (false);
    }

    if (isAbleToGiveConsent == false) {
      return (true);
    }

    var purposes = collectAllPurposes();

    return (isPurposeGiven(purposes));
  }

  bool get isAbleToGiveConsent {
    if (cookies?.preferences.gdprApplies == 0) {
      return (false);
    }
    return (true);
  }

  bool isPurposeGiven(List<int> purposes) {
    return (purposes.contains(1));
  }

  List<int> collectAllPurposes() {
    var purposes = <int>[];

    if (_isConsentGiven) {
      purposes.addAll(collectPurpose(cookies!.preferences.purposeConsents));
    }

    if (_isLegitimateInterestGiven) {
      purposes.addAll(
          collectPurpose(cookies!.preferences.purposeLegitimateInterests),);
    }

    return (purposes);
  }

  List<int> collectPurpose(String purposeString) {
    var purposes = <int>[];
    for (var purpose in _castToList(purposeString)) {
      if (purpose == 1) {
        purposes.add(purpose);
      }
    }
    return (purposes);
  }

  bool get _isConsentGiven {
    if (_validateConsent(cookies!.preferences.vendorConsents) == 1) {
      return (true);
    }
    return (false);
  }

  bool get _isLegitimateInterestGiven {
    if (_validateConsent(cookies!.preferences.vendorLegitimateInterests) == 1) {
      return (true);
    }
    return (false);
  }

  int? _validateConsent(String purposeString) {
    var purposes = _castToList(purposeString);
    if (purposes.length > 754) {
      return (purposes.elementAt(754));
    }
    return (null);
  }

  List<int> _castToList(String string) {
    return (string.runes
        .map((rune) => int.parse(String.fromCharCode(rune)))
        .toList());
  }
}
