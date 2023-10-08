import 'dart:convert';

class ThreatEntryMetadata {
  final List<Entry> entries;

  /// Meta data of the threat.
  const ThreatEntryMetadata({
    required this.entries,
  });

  factory ThreatEntryMetadata.fromJson(String str) =>
      ThreatEntryMetadata.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThreatEntryMetadata.fromMap(Map<String, dynamic> json) =>
      ThreatEntryMetadata(
        entries: List<Entry>.from(json["entries"].map((x) => Entry.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "entries": List<dynamic>.from(entries.map((x) => x.toMap())),
      };
}

class Entry {
  final String key;
  final String value;

  /// Entry of the threat.
  const Entry({
    required this.key,
    required this.value,
  });

  factory Entry.fromJson(String str) => Entry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Entry.fromMap(Map<String, dynamic> json) => Entry(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}
