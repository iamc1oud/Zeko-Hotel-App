import 'dart:convert';

class ApiResponse<T> {
  T? data;
  String? message;
  bool? status;
  String? errorCode;

  ApiResponse({this.data, this.message, this.status, this.errorCode});

  factory ApiResponse.fromJson(Map<String, dynamic> json, Function? fromJson) {
    return ApiResponse(
      data: fromJson != null ? fromJson(json['data']) : json['data'],
      message: json['message'],
      status: json['status'],
      errorCode: json['errorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'message': message,
      'status': status,
      'errorCode': errorCode,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
