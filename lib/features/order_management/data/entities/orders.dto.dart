import 'package:equatable/equatable.dart';

class AcceptOrderDTO extends Equatable {
  final int orderId;

  const AcceptOrderDTO({required this.orderId});

  @override
  List<Object?> get props => [orderId];

  Map<String, dynamic> toJson() {
    return {'order_id': orderId};
  }
}

class SuccessAcceptOrderDTO extends Equatable {
  final String? status;
  final String? message;

  factory SuccessAcceptOrderDTO.fromJson(Map<String, dynamic> json) {
    return SuccessAcceptOrderDTO(status: json['status']);
  }

  const SuccessAcceptOrderDTO({this.status, this.message});

  @override
  List<Object?> get props => [status];
}
