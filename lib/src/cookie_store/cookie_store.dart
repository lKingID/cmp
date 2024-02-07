import 'package:opencmp/src/constants.dart';
import 'package:opencmp/src/cookie_store/cookie_store_coding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/consent_cookies.dart';

class CookieStore {
  Future<void> store(ConsentCookies cookies) async {
    String cookieData = encode(cookies);
    await (await SharedPreferences.getInstance()).setString(Constants.cookieStoreName, cookieData);
  }

  Future<ConsentCookies?> load() async {
    String? cookieData = (await SharedPreferences.getInstance()).getString(Constants.cookieStoreName);
    if (cookieData != null) {
      return (decode(cookieData));
    }
    return (null);
  }
}