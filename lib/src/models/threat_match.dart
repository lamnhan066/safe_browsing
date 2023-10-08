import 'dart:convert';

import 'package:safe_browsing/src/models/threat_entry.dart';

import 'platform_type.dart';
import 'threat_entry_meta_data.dart';
import 'threat_entry_type.dart';
import 'threat_type.dart';

class ThreatMatch {
  /// Type of threat.
  final ThreatType threatType;

  /// Typr of platform.
  final PlatformType platformType;

  /// Type of threat entry.
  final ThreatEntryType threatEntryType;

  /// Threat entry.
  final ThreatEntry threat;

  /// Metadata of threat entry
  final ThreatEntryMetadata threatEntryMetadata;

  /// Cache duration.
  final String cacheDuration;

  /// Matched threat.
  const ThreatMatch({
    required this.threatType,
    required this.platformType,
    required this.threatEntryType,
    required this.threat,
    required this.threatEntryMetadata,
    required this.cacheDuration,
  });

  /// Convert the result as String to List<Match>.
  static List<ThreatMatch> matchesFromJson(String str) {
    return matchesFromMap(jsonDecode(str));
  }

  /// Convert the result as Map to List<Match>.
  static List<ThreatMatch> matchesFromMap(Map<String, dynamic> json) {
    return List<ThreatMatch>.from(
        json["matches"].map((x) => ThreatMatch.fromMap(x)));
  }

  /// Convert String to Match.
  factory ThreatMatch.fromJson(String str) =>
      ThreatMatch.fromMap(json.decode(str));

  /// Convert Map to Match.
  factory ThreatMatch.fromMap(Map<String, dynamic> json) => ThreatMatch(
        threatType: ThreatType.values.byName(json["threatType"]),
        platformType: PlatformType.values.byName(json["platformType"]),
        threatEntryType: ThreatEntryType.values.byName(json["threatEntryType"]),
        threat: ThreatEntry.fromMap(json["threat"]),
        threatEntryMetadata:
            ThreatEntryMetadata.fromMap(json["threatEntryMetadata"]),
        cacheDuration: json["cacheDuration"],
      );

  @override
  String toString() {
    return '''
"threatType":      "${threatType.name}",
"platformType":    "${platformType.name}",
"threatEntryType": "${threatEntryType.name}",
"threat":          ${threat.toMap()},
"threatEntryMetadata": ${threatEntryMetadata.toMap()},
"cacheDuration": "$cacheDuration"
''';
  }
}
