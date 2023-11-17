import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';

late Dio _dio;

class Api {
  Api() {
    _dio = Dio(
      BaseOptions(
          // 6: 1 - 3 - 2
          baseUrl: 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          receiveDataWhenStatusError: true,
          method: 'GET',
          queryParameters: {
            "api_key": 'dWRh6mFxteiuT5DnX2RgQbncS0VgkuOwtqDc7Wzo'
          }),
    );
    _dio.interceptors.add(
      RetryInterceptor(
        // 5 : 3 retr*
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

  Future<List<dynamic>> fetchLatestPhotos(
      {int page = 1, int pageSize = 20}) async {
    try {
      final Response response = await _dio.request('/latest_photos');
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

  Future<List<dynamic>> fetchDatePhotos(String earthDate) async {
    try {
      final Response response = await _dio.request(
        "/photos",
        queryParameters: {'earth_date': earthDate},
      );
      return response.data['photos'];
    } catch (e) {
      if (e is DioException) {
        debugPrint(e.message);
      } else {
        debugPrint('Normal Error: $e');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchCuriosityData() async {
    try {
      final Response response = await _dio.request("");
      return response.data['rover'];
    } catch (e) {
      if (e is DioException) {
        debugPrint(e.message);
      } else {
        debugPrint('Normal Error: $e');
      }
      return {};
    }
  }
}
