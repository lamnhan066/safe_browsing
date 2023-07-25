# Safe Browsing

Using google safe browsing API to detect whether the URL is safe.

## Required

Make sure that you're enabled the SafeBrowsing API in your google cloud console:

- **STEP 1:** Go to <https://console.cloud.google.com/apis/library/safebrowsing.googleapis.com>
- **STEP 2:** Choose your current project
- **STEP 3:** Press `Enable`

## Usage

This plugin requires you to use `flutterfire_cli` to create the `DefaultFirebaseOptions` for your project. [Read more](https://firebase.flutter.dev/).

Create the instance

``` dart
/// Create the instance from the `DefaultFirebaseOptions`
/// This class is created by `flutterfire_cli`
final safeBrowsing = SafeBrowsing(
  options: DefaultFirebaseOptions.currentPlatform,
  isDebug: !kReleaseMode,
);

/// The URL you want to check
final url = 'https://example.com';

/// Check whether the URL is safe and return `SafeBrowsingState`
final result = await safeBrowsing.check(url);

/// Check whether the URL is safe and return `bool`
final isSafe = await safeBrowsing.isSafe(url);
```

## Additional

Use this method to validate the URL

``` dart
SafeBrowsing.validateUrl(url);
```
