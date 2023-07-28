import 'dart:convert';

import 'package:safe_browsing/src/models/threat_entry.dart';

import 'platform_type.dart';
import 'threat_entry_meta_data.dart';
import 'threat_entry_type.dart';
import 'threat_type.dart';

class Match {
  final ThreatType threatType;
  final PlatformType platformType;
  final ThreatEntryType threatEntryType;
  final ThreatEntry threat;
  final ThreatEntryMetadata threatEntryMetadata;
  final String cacheDuration;

  /// Matched threat
  const Match({
    required this.threatType,
    required this.platformType,
    required this.threatEntryType,
    required this.threat,
    required this.threatEntryMetadata,
    required this.cacheDuration,
  });

  /// Convert the result as String to List<Match>
  static List<Match> matchesFromJson(String str) {
    return matchesFromMap(jsonDecode(str));
  }

  /// Convert the result as Map to List<Match>
  static List<Match> matchesFromMap(Map<String, dynamic> json) {
    return List<Match>.from(json["matches"].map((x) => Match.fromMap(x)));
  }

  /// Convert String to Match
  factory Match.fromJson(String str) => Match.fromMap(json.decode(str));

  /// Convert Map to Match
  factory Match.fromMap(Map<String, dynamic> json) => Match(
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
