import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';

class Api {
  late Dio _dio;
  Api() {
    _dio = Dio(
      BaseOptions(
          baseUrl: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          receiveDataWhenStatusError: true,
          method: "GET",
          queryParameters: {
            "api_key": "dWRh6mFxteiuT5DnX2RgQbncS0VgkuOwtqDc7Wzo"
          }),
    );
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: log,
        retries: 5,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
          Duration(seconds: 4),
          Duration(seconds: 5),
        ],
        retryableExtraStatuses: {status403Forbidden},
      ),
    );
  }

  Future<List<dynamic>> fetchLatestPhotos() async {
    try {
      final Response response = await _dio.request("/latest_photos");
      return response.data['latest_photos'];
    } catch (e) {
      if (e is DioException) {
        debugPrint(e.message);
      } else {
        debugPrint('Normal Error: $e');
      }
      return [];
    }
  }
}
