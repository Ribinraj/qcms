import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qcms/core/urls.dart';
import 'package:qcms/data/complaint_categorymodel.dart';
import 'package:qcms/data/complaint_listmodel.dart';
import 'package:qcms/data/complaintrequest_model.dart';
import 'package:qcms/data/dashboard_model.dart';
import 'package:qcms/data/departmentmodel.dart';
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
  ///////////// Fetch fetchdepartments/////////////
  Future<ApiResponse<List<DepartmentModel>>> fetchdepartments() async {
    try {
      // final token = await getUserToken();
      Response response = await dio.get(
        Endpoints.fetchdepartments,
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> departmentlist = responseData['data'];
        List<DepartmentModel> departments = departmentlist
            .map((category) => DepartmentModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: departments,
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
 ///////////// Fetch complaintcategorys/////////////
  Future<ApiResponse<List<ComplaintCategorymodel>>> fetchcomplaintcategories() async {
    try {
      // final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchcomplaintcategories,data:{
    "complaintId": "1410"
}
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> complaintcategorylists = responseData['data'];
        List<ComplaintCategorymodel> complaintcategoires = complaintcategorylists
            .map((category) => ComplaintCategorymodel.fromJson(category))
            .toList();
        return ApiResponse(
          data: complaintcategoires,
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
    /////////////Complaint request/////////////
  Future<ApiResponse> complaintRequest({
    required ComplaintRequestModel complaint
  }) async {
    try {
     final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.requestComplaint,
        data: complaint,
      options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        
        return ApiResponse(
          data: null,
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
    ///////////// Complaint list model/////////////
  Future<ApiResponse<List<ComplaintListmodel>>> complaintlists() async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchcomplaintlists,
     
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> complaintlists = responseData['data'];
        List<ComplaintListmodel> complaints = complaintlists
            .map((category) => ComplaintListmodel.fromJson(category))
            .toList();
        return ApiResponse(
          data: complaints,
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
  //////////////cancel complaint/////////////
  Future<ApiResponse> cancelcomplaint({required String complaintId}) async {
    try {
      final token = await getUserToken();
      Response response =
          await dio.post(Endpoints.cancelcomplaint, data: {"complaintId":complaintId},options:Options(headers: {'Authorization': token}));

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
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
