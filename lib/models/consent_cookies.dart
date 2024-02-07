library opencmp;

import 'consent_meta_data.dart';
import 'consent_preferences.dart';

class ConsentCookies {
  final String tcf;
  final String? google;
  final String custom;
  final ConsentMetaData meta;
  final ConsentPreferences preferences;

  ConsentCookies(
      this.tcf, this.google, this.custom, this.meta, this.preferences,);

  ConsentCookies.fromJson(Map<String, dynamic> json)
      : tcf = json['tcf'],
        google = json['google'],
        custom = json['custom'],
        meta = ConsentMetaData.fromJson(json['meta']),
        preferences = ConsentPreferences.fromJson(json['preferences']);

  Map<String, dynamic> toJson() => {
        'tcf': tcf,
        'google': google,
        'custom': custom,
        'meta': meta.toJson(),
        'preferences': preferences.toJson(),
      };
}
