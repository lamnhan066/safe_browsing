# Safe Browsing

Using google safe browsing API to detect whether the URL is safe.

## Usage

Create the instance

``` dart
final safeBrowsing = SafeBrowsing(
  options: DefaultFirebaseOptions.currentPlatform,
  isDebug: !kReleaseMode,
);
```

``` dart
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
