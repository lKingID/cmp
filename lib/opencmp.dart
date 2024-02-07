library opencmp;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:opencmp/models/consent_cookies.dart';
import 'package:opencmp/src/constants.dart';
import 'package:opencmp/src/cookie_store/cookie_store.dart';
import 'package:opencmp/src/cookie_store/cookie_store_coding.dart';
import 'package:opencmp/src/google_consent.dart';
import 'package:opencmp/src/showui_status.dart';
import 'package:opencmp/src/xymatic_consent.dart';

class OpenCMPView extends StatefulWidget {
  late final String domain;

  final bool paywall;

  final void Function(
    ConsentCookies? cookies,
    bool googleConsent,
    bool xymaticConsent,
  ) acceptOrReject;

  final Function() showUi;

  final Function() hideUi;

  final _OpenCMPViewState _state = _OpenCMPViewState();

  static OpenCMPView? _instance;

  OpenCMPView._({
    required this.acceptOrReject,
    required this.paywall,
    required this.showUi,
    required this.domain,
    required this.hideUi,
  });

  static OpenCMPView instance({
    domain,
    paywall,
    acceptOrReject,
    showUi,
    hideUi,
  }) {
    OpenCMPView._instance ??= OpenCMPView._(
      domain: domain,
      paywall: paywall,
      acceptOrReject: acceptOrReject,
      showUi: showUi,
      hideUi: hideUi,
    );
    return (OpenCMPView._instance!);
  }

  static OpenCMPView newDomain(String domain) {
    OpenCMPView._instance!.domain = domain;
    return (OpenCMPView._instance!);
  }

  @override
  State<OpenCMPView> createState() => _OpenCMPViewState();

  void showUiByUser() {
    // Shows the cookie consent banner by triggering the js api.
    _state.showUiByUser();
  }
}

class _OpenCMPViewState extends State<OpenCMPView> {
  late HeadlessInAppWebView _headlessWebView;

  ShowUiStatus _shouldShowUi = ShowUiStatus.hide;

  @override
  void initState() {
    super.initState();

    _headlessWebView = HeadlessInAppWebView(
      initialData: InAppWebViewInitialData(
        data: _loadHtmlAsString(widget.domain, _showPaywall ? 1 : 0),
      ),
      initialSettings: InAppWebViewSettings(
        cacheEnabled: false,
        applicationNameForUserAgent: _customUserAgent,
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        controller.addJavaScriptHandler(
          handlerName: 'getConsent',
          callback: ((message) async {
            String promiseId = message.first;
            CookieStore cookieStore = CookieStore();
            ConsentCookies? cookies = await cookieStore.load();
            String cookieJson = '{}';

            if (cookies != null) {
              cookieJson = cookieStore.encode(cookies);
            }

            await controller.evaluateJavascript(
              source: "trfCmpResolvePromise('$promiseId', '$cookieJson')",
            );

            GoogleConsent googleConsent = GoogleConsent(cookies);
            XymaticConsent xymaticConsent = XymaticConsent(cookies);
            widget.acceptOrReject(
              cookies,
              googleConsent.isConsentGiven,
              xymaticConsent.isConsentGiven,
            );
          }),
        );

        controller.addJavaScriptHandler(
          handlerName: 'showUi',
          callback: ((message) {
            setState(() {
              _shouldShowUi = ShowUiStatus.show;
            });
          }),
        );
      },
      onConsoleMessage: (controller, consoleMessage) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _headlessWebView.dispose();
  }

  Future<int> initiateCookieConsent() async {
    if (!_headlessWebView.isRunning()) {
      await _headlessWebView.dispose();
      await _headlessWebView.run();
    }
    return (0);
  }

  @override
  Widget build(BuildContext context) {
    return (FutureBuilder<int>(
      future: initiateCookieConsent(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData && _shouldShowUi == ShowUiStatus.hide) {
          return (Container());
        }

        return (InAppWebView(
          initialData: InAppWebViewInitialData(
            data: _loadHtmlAsString(widget.domain, _showPaywall ? 1 : 0),
          ),
          initialSettings: InAppWebViewSettings(
            cacheEnabled: false,
            applicationNameForUserAgent: _customUserAgent,
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            controller.addJavaScriptHandler(
              handlerName: 'getConsent',
              callback: ((message) async {
                String promiseId = message.first;
                CookieStore cookieStore = CookieStore();
                ConsentCookies? cookies = await cookieStore.load();
                String cookieJson = '{}';
                if (cookies != null) {
                  cookieJson = cookieStore.encode(cookies);
                }
                await controller.evaluateJavascript(
                  source: "trfCmpResolvePromise('$promiseId', '$cookieJson')",
                );

                if (_shouldShowUi == ShowUiStatus.showByUser) {
                  // Shows the cookie consent banner by triggering the js api.
                  await controller.evaluateJavascript(
                    source: "__tcfapi('showUi', 2, function(){})",
                  );
                }
              }),
            );

            controller.addJavaScriptHandler(
              handlerName: 'setConsent',
              callback: ((message) async {
                CookieStore cookieStore = CookieStore();
                ConsentCookies? cookies = cookieStore.decode(message.first);

                if (cookies != null) {
                  await cookieStore.store(cookies);
                }

                GoogleConsent googleConsent = GoogleConsent(cookies);
                XymaticConsent xymaticConsent = XymaticConsent(cookies);
                widget.acceptOrReject(
                  cookies,
                  googleConsent.isConsentGiven,
                  xymaticConsent.isConsentGiven,
                );
              }),
            );

            controller.addJavaScriptHandler(
              handlerName: 'showUi',
              callback: ((message) {}),
            );

            controller.addJavaScriptHandler(
              handlerName: 'hideUi',
              callback: ((message) {
                setState(() {
                  _shouldShowUi = ShowUiStatus.hide;
                });
              }),
            );
          },
          onConsoleMessage: (controller, consoleMessage) {},
        ));
      },
    ));
  }

  void showUiByUser() {
    setState(() {
      _shouldShowUi = ShowUiStatus.showByUser;
    });
  }

  String get _customUserAgent {
    if (Platform.isAndroid) {
      return (Constants.androidCustomUserAgent);
    }
    return (Constants.iOSCustomUserAgent);
  }

  bool get _showPaywall {
    if (Platform.isAndroid) {
      return (true);
    }

    if (Platform.isIOS && widget.paywall) {
      return (true);
    }

    return (false);
  }
}

String _loadHtmlAsString(String domain, int paywall) => '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, minimal-ui'>
    <meta name='apple-mobile-web-app-capable' content='yes'>
    <meta http-equiv='X-UA-Compatible' content='edge, chrome=1'>
    <script>
      if(!document.__defineGetter__) {
        Object.defineProperty(document, 'cookie', {
          get: function() {return ''},
          set: function() {return true},
        });
      } else {
        document.__defineGetter__('cookie', function() { return '';});
        document.__defineSetter__('cookie', function() {});
      }
    </script>
    <script src='https://cdn.opencmp.net/tcf-v2/cmp-stub-latest.js' type='text/javascript' id='open-cmp-stub' data-domain='$domain' data-mode-production='1' data-paywall-enabled='$paywall'></script>
    <style type='text/css'>
      .cmp_overlay {
        background: transparent !important;
      }
    </style>
  </head>
  <body>
  </body>
</html>
,
''';
