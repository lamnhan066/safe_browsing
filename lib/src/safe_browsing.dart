import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:safe_browsing/src/models/safe_browsing_result.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SafeBrowsing {
  static bool validateUrl(String url) {
    String patttern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(patttern);
    return regExp.hasMatch(url);
  }

  /// Make sure that you're enabled the SafeBrowsing API in your google cloud console.
  ///
  /// https://console.cloud.google.com/apis/
  SafeBrowsing({required this.options, this.debugLog = false});

  /// Procide the configuration of the firebase.
  final FirebaseOptions options;

  /// Print the debug log
  final bool debugLog;

  /// Returns:
  ///   `true` if it's safe
  ///   `false` if it's not safe
  ///   `null` if there is error occurred
  ///
  /// Use [check] to have a better result message with [SafeBrowsingState]
  Future<bool?> isSafe(String url) async {
    final result = await check(url);

    if (result == SafeBrowsingState.safe) {
      return true;
    } else if (result == SafeBrowsingState.notSafe) {
      return false;
    }

    return null;
  }

  /// Check if the given url is safe or not safe.
  Future<SafeBrowsingState> check(String url) async {
    if (url.isEmpty) {
      _print('This URL is empty');
      return SafeBrowsingState.empty;
    }
    if (!validateUrl(url)) {
      _print('This URL is invalid');
      return SafeBrowsingState.invalidURL;
    }
    if (!await canLaunchUrlString(url)) {
      _print('This URL cannot be launched');
      return SafeBrowsingState.cannotLaunch;
    }

    final apiKey = options.apiKey;
    final clientId = options.projectId;

    final encodedUrl = base64Url.encode(utf8.encode(url));
    final apiUrl =
        'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey';
    final requestBody = {
      'client': {'clientId': clientId, 'clientVersion': '1.5.2'},
      'threatInfo': {
        'threatTypes': [
          'MALWARE',
          'SOCIAL_ENGINEERING',
          'UNWANTED_SOFTWARE',
          'POTENTIALLY_HARMFUL_APPLICATION'
        ],
        'platformTypes': ['ANY_PLATFORM'],
        'threatEntryTypes': ['URL'],
        'threatEntries': [
          {'url': encodedUrl}
        ]
      }
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: json.encode(requestBody),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final isSafe = jsonBody.isEmpty;

        if (isSafe) {
          _print('This URL is safe');
          return SafeBrowsingState.safe;
        } else {
          _print('This URL is not safe');
          return SafeBrowsingState.notSafe;
        }
      }
    } on HttpException catch (e) {
      _print('Cannot complete the request: ${e.message}');
      return SafeBrowsingState.requestError;
    } catch (_) {
      rethrow;
    }

    _print('This area may not be reached');
    return SafeBrowsingState.unknown;
  }

  void _print(Object? object) =>
      // ignore: avoid_print
      debugLog ? print('[Safe Browsing] $object') : null;
}
