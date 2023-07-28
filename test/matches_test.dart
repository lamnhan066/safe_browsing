import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:safe_browsing/src/models/threat_match.dart';

String matchesString = '''
{
  "matches": [{
    "threatType":      "MALWARE",
    "platformType":    "WINDOWS",
    "threatEntryType": "URL",
    "threat":          {"url": "http://www.urltocheck1.org/"},
    "threatEntryMetadata": {
      "entries": [{
        "key": "malware_threat_type",
        "value": "landing"
     }]
    },
    "cacheDuration": "300.000s"
  }, {
    "threatType":      "MALWARE",
    "platformType":    "WINDOWS",
    "threatEntryType": "URL",
    "threat":          {"url": "http://www.urltocheck2.org/"},
    "threatEntryMetadata": {
      "entries": [{
        "key":   "malware_threat_type",
        "value": "landing"
     }]
    },
    "cacheDuration": "300.000s"
  }]
}''';

void main() {
  test('Matches', () {
    final matches = ThreatMatch.matchesFromMap(jsonDecode(matchesString));

    expect(matches.length, equals(2));
    expect(matches.first.threat.url, 'http://www.urltocheck1.org/');
    // for (final match in matches) {
    // print('$match\n');
    // }
  });
}
