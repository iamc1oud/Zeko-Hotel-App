part of 'order_history_cubit.dart';

class OrderHistoryState {
  OrderHistoryState({this.startTime, this.endTime});

  DateTime? startTime;
  DateTime? endTime;

  OrderHistoryState copyWith({DateTime? startTime, DateTime? endTime}) {
    return OrderHistoryState(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }
}
