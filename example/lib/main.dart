import 'package:flutter/material.dart';
import 'package:opencmp/opencmp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open CMP Sample',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          backgroundColor: Colors.green,
          body: Stack(children: <Widget>[
            OpenCMPView.instance(
              domain: 'traffective.com',
              paywall: true,
              acceptOrReject: (cookies, googleConsent, xymaticConsent) {},
              showUi: () {
                // Every time the cmp is opened, this callback is triggered for your own code.
              },
              hideUi: () {
                // Every time the cmp is closed, this callback is triggered for your own code.
              },
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            onPressed: () => {OpenCMPView.instance().showUiByUser()},
            child: const Icon(Icons.cookie_outlined),
          )),
    );
  }
}
