import 'dart:convert';

class ThreatEntry {
  /// A hash prefix, consisting of the most significant 4-32 bytes of a SHA256 hash. This field is in binary format.
  final String hash;

  /// A URL.
  final String url;

  /// The digest of an executable in SHA256 format. The API supports both binary and hex digests.
  final String digest;

  /// Entry of the threat
  ThreatEntry({this.hash = '', this.url = '', this.digest = ''}) {
    assert(
      hash.isNotEmpty || url.isNotEmpty || digest.isNotEmpty,
      'hash or url or digest must not be empty',
    );
  }

  Map<String, String> toBase64Map() {
    Map<String, String> entryMap = {};
    if (hash != '') {
      entryMap.addAll({'hash': base64.encode(utf8.encode(hash))});
    }
    if (url != '') {
      entryMap.addAll({'url': base64Url.encode(utf8.encode(url))});
    }
    if (hash != '') {
      entryMap.addAll({'digest': base64.encode(utf8.encode(digest))});
    }
    return entryMap;
  }

  Map<String, String> toMap() {
    Map<String, String> entryMap = {};
    if (hash != '') {
      entryMap.addAll({'hash': hash});
    }
    if (url != '') {
      entryMap.addAll({'url': url});
    }
    if (hash != '') {
      entryMap.addAll({'digest': digest});
    }
    return entryMap;
  }

  factory ThreatEntry.fromMap(Map<String, dynamic> json) {
    final String hash = json['hash'] ?? '';
    final String url = json['url'] ?? '';
    final String digest = json['digest'] ?? '';
    return ThreatEntry(
      hash: hash,
      url: url,
      digest: digest,
    );
  }
}
