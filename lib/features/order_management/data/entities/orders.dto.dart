import 'package:equatable/equatable.dart';

class AcceptOrderDTO extends Equatable {
  final int orderId;
  final List<int>? items;

  const AcceptOrderDTO({required this.orderId, this.items = const []});

  @override
  List<Object?> get props => [orderId];

  Map<String, dynamic> toJson() {
    return {'order_id': orderId, 'order_items': items};
  }
}

class RejectOrderDTO extends Equatable {
  final int orderId;
  final String reason;

  const RejectOrderDTO({required this.orderId, this.reason = ''});

  @override
  List<Object?> get props => [orderId];

  Map<String, dynamic> toJson() {
    return {'order_id': orderId, 'custom_reason': reason};
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
