import 'dart:convert';

import 'package:opencmp/src/cookie_store/cookie_store.dart';
import 'package:opencmp/models/consent_cookies.dart';

extension CookieStoreCoding on CookieStore {
  String encode(ConsentCookies cookies) {
    return (json.encode(cookies.toJson()));
  }

  ConsentCookies? decode(String cookieJson) {
    try {
      Map<String, dynamic> cookies = json.decode(cookieJson);
      return (ConsentCookies.fromJson(cookies));
    } catch (e) {
      print('Decoding aborts because of $e');
    }
    return (null);
  }
}
