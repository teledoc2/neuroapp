import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Newsletter Signup Provider
class NewsletterSignupProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _isSubmitted = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSubmitted => _isSubmitted;

  Future<void> submitNewsletterSignup({required bool newsletter, required String email}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://neureveal.ai/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'form_fields[field_eb37685]': newsletter,
          'form_fields[email]': email,
        }),
      );

      if (response.statusCode == 200) {
        _isSubmitted = true;
      } else {
        _error = 'Failed to submit the form. Please try again.';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// YouTube API Provider
class YouTubeApiProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _data;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get data => _data;

  Future<void> fetchYouTubePlayerDetails(Map<String, String> headers) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://www.youtube.com/youtubei/v1/player?prettyPrint=false');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
      } else {
        _error = 'Failed to fetch player details.';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextVideoDetails(Map<String, String> headers) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://www.youtube.com/youtubei/v1/next?prettyPrint=false');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
      } else {
        _error = 'Failed to fetch next video details.';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Website Analytics Provider
class WebsiteAnalyticsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _data;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get data => _data;

  Future<void> trackAnalytics(Map<String, String> queryParams) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.https('events.api.secureserver.net', '/t/1/tl/event', queryParams);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
      } else {
        _error = 'Failed to track analytics.';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logEvents(Map<String, String> headers) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse('https://csp.secureserver.net/eventbus/web');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
      } else {
        _error = 'Failed to log events.';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Helper Methods for UI Consumption
class ApiHelper {
  static Map<String, String> buildHeaders({
    required String platform,
    required String referer,
    required String clientName,
    required String clientVersion,
    required String visitorId,
    required String userAgent,
    required String contentType,
  }) {
    return {
      'sec-ch-ua-platform': platform,
      'referer': referer,
      'x-youtube-client-name': clientName,
      'x-youtube-client-version': clientVersion,
      'x-goog-visitor-id': visitorId,
      'user-agent': userAgent,
      'content-type': contentType,
    };
  }

  static Map<String, String> buildQueryParams({
    required String dh,
    required String ua,
    required String clientName,
    required String cv,
    required String vg,
    required String dp,
    required String traceId,
    required String cts,
    required String hitId,
    required String ht,
    required String ap,
    required String vci,
    required String z,
  }) {
    return {
      'dh': dh,
      'ua': ua,
      'client_name': clientName,
      'cv': cv,
      'vg': vg,
      'dp': dp,
      'trace_id': traceId,
      'cts': cts,
      'hit_id': hitId,
      'ht': ht,
      'ap': ap,
      'vci': vci,
      'z': z,
    };
  }
}
