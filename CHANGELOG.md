## 0.1.0-rc.2

* Rename `Match` to `ThreatMatch` to avoid duplicate with the Flutter default class.
* `SafeBrowsingState` is now a class with different parameters from the older one.
* Add `type`, `matches`, `isSafe`, `isNotSafe` and `isError` to `SafeBrowsingState`.
* Add `SafeBrowsingStateType` to replace the older `SafeBrowsingState` enum.

## 0.1.0-rc.1

* Remove `cannotLaunch`, `invalidURL` from `SafeBrowsingState`.
* Method `check()` is now have more parameters.
* Add `checkUrl()` and `isUrlSafe()` methods.
* Add `ThreatType`, `ThreatEntryType`, `PlatformType` enums.
* Add `Match`, `ThreatEntry`, `ThreatEntryMetadata` classes.

## 0.0.5

* Add support for web platform

## 0.0.2

* Improve README

## 0.0.1

* Initial release
