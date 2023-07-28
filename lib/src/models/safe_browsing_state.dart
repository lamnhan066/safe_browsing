import 'package:safe_browsing/src/models/match.dart';

/// Result state of the Safe Browsing
enum SafeBrowsingState {
  /// Safe
  safe,

  /// Not safe. See `SafeBrowsingState.matches` for more information.
  notSafe,

  /// Empty threat entry
  empty,

  /// Error with the request
  requestError,

  /// Unknow error
  unknown;

  /// List of matched threats
  static List<Match> matches = const [];
}
