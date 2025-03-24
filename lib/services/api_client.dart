import 'dart:convert';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String baseUrl = 'https://neureveal.ai/';

  ApiClient() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
  }

  // Newsletter Signup
  Future<Response> submitNewsletterSignup({
    required bool newsletter,
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        '/',
        data: {
          'form_fields[field_eb37685]': newsletter ? 'on' : null,
          'form_fields[email]': email,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to submit newsletter signup: $e');
    }
  }

  // Fetch YouTube Player Details
  Future<Response> fetchYouTubePlayerDetails({
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio.post(
        'https://www.youtube.com/youtubei/v1/player?prettyPrint=false',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch YouTube player details: $e');
    }
  }

  // Track YouTube QoE Stats
  Future<Response> trackYouTubeQoEStats({
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio.post(
        'https://www.youtube.com/api/stats/qoe',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to track YouTube QoE stats: $e');
    }
  }

  // Fetch Next Video Details
  Future<Response> fetchNextVideoDetails({
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio.post(
        'https://www.youtube.com/youtubei/v1/next?prettyPrint=false',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch next video details: $e');
    }
  }

  // Track Website Analytics
  Future<Response> trackWebsiteAnalytics({
    required Map<String, String> queryParams,
  }) async {
    try {
      final response = await _dio.get(
        'https://events.api.secureserver.net/t/1/tl/event',
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to track website analytics: $e');
    }
  }

  // Log Website Events
  Future<Response> logWebsiteEvents({
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio.post(
        'https://csp.secureserver.net/eventbus/web',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to log website events: $e');
    }
  }

  // Caching Strategy (Example for YouTube Player Details)
  Future<Response> fetchYouTubePlayerDetailsWithCache({
    required Map<String, String> headers,
  }) async {
    final cacheKey = 'youtube_player_details';
    final cachedResponse = _getFromCache(cacheKey);
    if (cachedResponse != null) {
      return cachedResponse;
    }

    final response = await fetchYouTubePlayerDetails(headers: headers);
    _saveToCache(cacheKey, response);
    return response;
  }

  // Simple Cache Implementation
  final Map<String, Response> _cache = {};

  Response? _getFromCache(String key) {
    return _cache[key];
  }

  void _saveToCache(String key, Response response) {
    _cache[key] = response;
  }
}
