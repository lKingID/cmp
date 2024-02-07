# Traffective Consent Management Platform

# Flutter integration
Our Open CMP framework is developed in Flutter. Therefore, it becomes easy to add the view of the Cookie Consent Banner into your app code. You will receive the cookie data via the ***acceptOrReject*** callback. It will dismiss the Open CMP view whenever the user accepted or rejected the consent.

You can hide the paywall on iOS only if you set the parameter ***paywall*** to false. It never hides the paywall on Android.

> You will receive the stored 'cookies' and the information if the Google consent is given.

```java
OpenCMPView.instance(
  domain: 'traffective.com',
  paywall: true,
  acceptOrReject: (cookies, googleConsent, xymaticConsent) {
    print('Cookies: $cookies');
    print('Google Consent: $googleConsent');
    print('Xymatic Consent: $xymaticConsent');
  },
  showUi: () {
    // Every time the cmp is opened, this callback is triggered for your own code.
  },
  hideUi: () {
    // Every time the cmp is closed, this callback is triggered for your own code.
  },
)
```

**Show the consent ui again if a user clicks a button**

```java
OpenCMPView.instance?.showUiByUser()
```

**Hint**
> You will get the new cookie consent again in the ‘acceptOrReject’ closure.

# Give it a try with our example
You should bring some Flutter knowledge before you proceed with our Android and iOS examples. You can start the examples in the subfolder 'example'.

```bash
cd ./example
flutter run
```

# Copyright
Copyright 2022 Traffective GmbH
