import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qcms/core/urls.dart';
import 'package:qcms/data/dashboard_model.dart';
import 'package:qcms/data/divisions_model.dart';
import 'package:qcms/data/quarters_model.dart';
import 'package:qcms/widgets/custom_sharedpreferences.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class Apprepo {
  final Dio dio;

  Apprepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              // connectTimeout: const Duration(seconds: 30),
              // receiveTimeout: const Duration(seconds: 30),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  ///////////// Fetch divisions/////////////
  Future<ApiResponse<List<DivisionsModel>>> fetchdivisions() async {
    try {
      // final token = await getUserToken();
      Response response = await dio.get(
        Endpoints.fetchdevisions,
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> divisionlist = responseData['data'];
        List<DivisionsModel> divisions = divisionlist
            .map((category) => DivisionsModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: divisions,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  ///////////// Fetch quarters/////////////
  Future<ApiResponse<List<QuartersModel>>> fetchquarters({
    required String divisionId,
  }) async {
    try {
      // final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchquarters,
        data: {"cityId": divisionId},
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> quarterslist = responseData['data'];
        List<QuartersModel> quarters = quarterslist
            .map((category) => QuartersModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: quarters,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ////////////////////fetch dashboard/////////////////////

  Future<ApiResponse<DashboardModel>> fetchdashboard() async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.post(
        Endpoints.fetchdashboard,
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final dasbord = DashboardModel.fromJson(responseData['data']);

        return ApiResponse(
          data: dasbord,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
}
