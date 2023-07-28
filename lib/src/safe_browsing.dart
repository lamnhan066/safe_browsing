import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:safe_browsing/src/models/safe_browsing_state.dart';
import 'package:safe_browsing/src/models/threat_entry.dart';
import 'package:safe_browsing/src/models/threat_entry_type.dart';

import 'models/match.dart' as match;
import 'models/platform_type.dart';
import 'models/threat_type.dart';

class SafeBrowsing {
  /// Use this method to validate the URL
  static bool validateUrl(String url) {
    String patttern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(patttern);
    return regExp.hasMatch(url);
  }

  /// Make sure that you're enabled the SafeBrowsing API in your google cloud console.
  ///
  /// https://console.cloud.google.com/apis/
  SafeBrowsing({
    required this.options,
    this.debugLog = false,
  });

  /// Procide the configuration of the firebase.
  final FirebaseOptions options;

  /// Print the debug log
  final bool debugLog;

  /// Returns:
  ///   `true` if it's safe
  ///   `false` if it's not safe
  ///   `null` if there is error occurred
  ///
  /// Use [check] to have more settings and a better result message with [SafeBrowsingState]
  Future<bool?> isUrlSafe(String url) async {
    final result = await checkUrl(url);

    if (result == SafeBrowsingState.safe) {
      return true;
    } else if (result == SafeBrowsingState.notSafe) {
      return false;
    }

    return null;
  }

  /// Check a specific URL
  ///
  /// Use [check] to have more settings and a better result message with [SafeBrowsingState]
  Future<SafeBrowsingState> checkUrl(String url) async {
    return check([ThreatEntry(url: url)]);
  }

  /// Check whether the given url is safe.
  Future<SafeBrowsingState> check(
    /// Threat entries
    List<ThreatEntry> entries, {
    /// Threat types
    List<ThreatType> threatTypes = const [
      ThreatType.MALWARE,
      ThreatType.SOCIAL_ENGINEERING,
      ThreatType.UNWANTED_SOFTWARE,
      ThreatType.POTENTIALLY_HARMFUL_APPLICATION,
    ],

    /// Platform types
    List<PlatformType> platformTypes = const [
      PlatformType.ALL_PLATFORMS,
    ],

    /// Threat entry types
    List<ThreatEntryType> threatEntryTypes = const [
      ThreatEntryType.URL,
    ],

    /// Version of the client (clientVersion)
    String version = '1.5.2',
  }) async {
    SafeBrowsingState.matches = [];
    if (entries.isEmpty) {
      _print('This URL is empty');
      return SafeBrowsingState.empty;
    }

    final apiKey = options.apiKey;
    final clientId = options.projectId;

    final threatEntryNames = [for (final type in entries) type.toBase64Map()];
    final threatTypeNames = [for (final type in threatTypes) type.name];
    final platformTypeNames = [for (final type in platformTypes) type.name];
    final threatEntryTypeNames = [
      for (final type in threatEntryTypes) type.name
    ];
    final apiUrl =
        'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey';
    final requestBody = {
      'client': {'clientId': clientId, 'clientVersion': version},
      'threatInfo': {
        'threatTypes': threatTypeNames,
        'platformTypes': platformTypeNames,
        'threatEntryTypes': threatEntryTypeNames,
        'threatEntries': threatEntryNames,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final isSafe = jsonBody.isEmpty;

        if (isSafe) {
          _print('This URL is safe');
          return SafeBrowsingState.safe;
        } else {
          final matches = match.Match.matchesFromMap(jsonBody);
          _print('This URL is not safe: $matches');
          SafeBrowsingState.matches = matches;
          return SafeBrowsingState.notSafe;
        }
      }
    } on HttpException catch (e) {
      _print('Cannot complete the request: ${e.message}');
      return SafeBrowsingState.requestError;
    } catch (e) {
      _print('Cannot complete the request with unknow error: $e');
      rethrow;
    }

    _print('This area may not be reached');
    return SafeBrowsingState.unknown;
  }

  void _print(Object? object) =>
      // ignore: avoid_print
      debugLog ? print('[Safe Browsing] $object') : null;
}
