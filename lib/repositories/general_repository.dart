// Abstract Repository Interface
abstract class ApiRepository {
  Future<Map<String, dynamic>> fetchYouTubePlayerDetails(Map<String, String> headers);
  Future<Map<String, dynamic>> trackYouTubeQoEStats(Map<String, String> headers);
  Future<Map<String, dynamic>> fetchNextVideoDetails(Map<String, String> headers);
  Future<Map<String, dynamic>> trackWebsiteAnalytics(Map<String, String> queryParams);
  Future<Map<String, dynamic>> logWebsiteEvents(Map<String, String> headers);
}

// Concrete Implementation
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository {
  final http.Client client;

  ApiRepositoryImpl(this.client);

  @override
  Future<Map<String, dynamic>> fetchYouTubePlayerDetails(Map<String, String> headers) async {
    const url = 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false';
    try {
      final response = await client.post(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> trackYouTubeQoEStats(Map<String, String> headers) async {
    const url = 'https://www.youtube.com/api/stats/qoe';
    try {
      final response = await client.post(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> fetchNextVideoDetails(Map<String, String> headers) async {
    const url = 'https://www.youtube.com/youtubei/v1/next?prettyPrint=false';
    try {
      final response = await client.post(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> trackWebsiteAnalytics(Map<String, String> queryParams) async {
    const url = 'https://events.api.secureserver.net/t/1/tl/event';
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await client.get(uri);
      return _handleResponse(response);
    } catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logWebsiteEvents(Map<String, String> headers) async {
    const url = 'https://csp.secureserver.net/eventbus/web';
    try {
      final response = await client.post(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Exception _mapError(dynamic error) {
    if (error is http.ClientException) {
      return NetworkException(error.message);
    } else {
      return UnknownException(error.toString());
    }
  }
}

// Domain Exceptions
class ApiException implements Exception {
  final int statusCode;
  final String responseBody;

  ApiException(this.statusCode, this.responseBody);

  @override
  String toString() => 'ApiException: $statusCode - $responseBody';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}
