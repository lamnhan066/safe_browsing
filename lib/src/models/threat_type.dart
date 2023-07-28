// ignore_for_file: constant_identifier_names

/// Type of the threat
enum ThreatType {
  /// Unknown.
  THREAT_TYPE_UNSPECIFIED,

  /// Malware threat type.
  MALWARE,

  /// Social engineering threat type.
  SOCIAL_ENGINEERING,

  /// Unwanted software threat type.
  UNWANTED_SOFTWARE,

  /// Potentially harmful application threat type.
  POTENTIALLY_HARMFUL_APPLICATION;
}
