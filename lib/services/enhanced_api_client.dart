import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DioClient {
  final Dio _dio;

  DioClient._internal(this._dio);

  factory DioClient({required String baseUrl}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.addAll([
      _AuthInterceptor(),
      _ErrorInterceptor(),
      _LoggingInterceptor(),
    ]);

    return DioClient._internal(dio);
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    return _dio.post(endpoint, data: data, options: Options(headers: headers));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams, Map<String, dynamic>? headers}) async {
    return _dio.get(endpoint, queryParameters: queryParams, options: Options(headers: headers));
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add authentication token logic if needed
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh logic if applicable
    }
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String errorMessage = 'An unexpected error occurred';
    if (err.type == DioErrorType.connectTimeout) {
      errorMessage = 'Connection timeout';
    } else if (err.type == DioErrorType.receiveTimeout) {
      errorMessage = 'Receive timeout';
    } else if (err.type == DioErrorType.response) {
      errorMessage = 'Server error: ${err.response?.statusCode}';
    }
    err.error = errorMessage;
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request: ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: ${err.message}');
    handler.next(err);
  }
}

class ApiService {
  final DioClient _client;

  ApiService(this._client);

  Future<Response> submitNewsletterSignup(Map<String, dynamic> data) {
    return _client.post('https://neureveal.ai/', data: data);
  }

  Future<Response> fetchYouTubePlayerDetails(Map<String, dynamic> headers) {
    return _client.post(
      'https://www.youtube.com/youtubei/v1/player?prettyPrint=false',
      headers: headers,
    );
  }

  Future<Response> trackYouTubeQoEStats(Map<String, dynamic> headers) {
    return _client.post(
      'https://www.youtube.com/api/stats/qoe',
      headers: headers,
    );
  }

  Future<Response> fetchYouTubeNextVideoDetails(Map<String, dynamic> headers) {
    return _client.post(
      'https://www.youtube.com/youtubei/v1/next?prettyPrint=false',
      headers: headers,
    );
  }

  Future<Response> trackWebsiteAnalytics(Map<String, dynamic> queryParams) {
    return _client.get(
      'https://events.api.secureserver.net/t/1/tl/event',
      queryParams: queryParams,
    );
  }

  Future<Response> logWebsiteEvents(Map<String, dynamic> headers) {
    return _client.post(
      'https://csp.secureserver.net/eventbus/web',
      headers: headers,
    );
  }
}

class NetworkConnectivity {
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

class RetryPolicy {
  static Future<Response> retryRequest(Future<Response> Function() request, {int retries = 3}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        return await request();
      } catch (e) {
        attempt++;
        if (attempt >= retries) rethrow;
      }
    }
    throw Exception('Max retries reached');
  }
}

void main() {
  final dioClient = DioClient(baseUrl: 'https://neureveal.ai/');
  final apiService = ApiService(dioClient);

  // Example usage
  apiService.submitNewsletterSignup({
    'form_fields[field_eb37685]': true,
    'form_fields[email]': 'example@example.com',
  }).then((response) {
    print('Newsletter signup successful: ${response.data}');
  }).catchError((error) {
    print('Error: $error');
  });
}
