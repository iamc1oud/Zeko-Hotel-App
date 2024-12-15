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

class ListingApiResponse<T> {
  List<T>? data;
  String? message;
  bool? status;
  String? errorCode;

  ListingApiResponse({this.data, this.message, this.status, this.errorCode});

  factory ListingApiResponse.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    return ListingApiResponse(
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((item) => fromJson(item))
              .toList() as List<T>
          : [],
      message: json['message'],
      status: json['status'],
      errorCode: json['errorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => (item as dynamic).toJson()).toList(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
    };
  }
}
