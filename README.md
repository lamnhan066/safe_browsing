# Safe Browsing

Using google safe browsing API to detect whether the URL is safe.

## Required

Make sure that you're enabled the SafeBrowsing API in your google cloud console:

- **STEP 1:** Go to <https://console.cloud.google.com/apis/library/safebrowsing.googleapis.com>
- **STEP 2:** Choose your current project
- **STEP 3:** Press `Enable`

## Usage

This plugin requires you to use `flutterfire_cli` to create the `DefaultFirebaseOptions` for your project. [Read more](https://firebase.flutter.dev/).

### Create the instance

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
final state = await safeBrowsing.checkUrl(url);

/// Check whether the URL is safe and return `bool`
final isSafe = await safeBrowsing.isUrlSafe(url);
```

### Result state of the checking

``` dart
state.isSafe // Means the result is safe
state.isNotSafe // Means the result is not safe. Different with `!state.isSafe`
state.isError // Means there is issue with the request
```

Please notice that the `!state.isSafe` is different from `state.isNotSafe` because the `state.isError` maybe occured.

More specific result by using `state.type`:

``` dart
/// Safe
SafeBrowsingStateType.safe

/// Not safe. See `SafeBrowsingState.matches` for the details.
SafeBrowsingStateType.notSafe

/// Empty input
SafeBrowsingStateType.empty

/// Error with the request
SafeBrowsingStateType.requestError

/// Unknow error
SafeBrowsingStateType.unknown
```

## Advanced

``` dart
/// Check the entries
final state = safeBrowsing.check{
  [ThreatEntry(url: 'url')],

  threatTypes: [
      ThreatType.MALWARE,
      ThreatType.SOCIAL_ENGINEERING,
      ThreatType.UNWANTED_SOFTWARE,
      ThreatType.POTENTIALLY_HARMFUL_APPLICATION,    
  ],

  platformTypes: [
      PlatformType.ALL_PLATFORMS,    
  ], 

  threatEntryTypes: [
      ThreatEntryType.URL,
  ],
}
```

## Additional

Use this method to validate the URL

``` dart
SafeBrowsing.validateUrl(url);
```
