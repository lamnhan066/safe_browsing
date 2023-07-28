import 'package:safe_browsing/src/models/safe_browsing_state_type.dart';
import 'package:safe_browsing/src/models/threat_match.dart';

/// Result state of the Safe Browsing
class SafeBrowsingState {
  /// Type of the state
  final SafeBrowsingStateType type;

  /// List of matched threats
  final List<ThreatMatch> matches;

  /// The entries are safe.
  ///
  /// Please notice that `!isSafe` is different from `isNotSafe` because `!isSafe` may includes
  /// the errors.
  bool get isSafe => type == SafeBrowsingStateType.safe;

  /// Is not safe without errors.
  ///
  /// Please notice that `!isNotSafe` is different from `isSafe` because `!isNotSafe` may includes
  /// the errors.
  bool get isNotSafe => type == SafeBrowsingStateType.notSafe;

  /// Any error occurs
  bool get isError => !isSafe && !isNotSafe;

  SafeBrowsingState(this.type, [this.matches = const []]);
}
