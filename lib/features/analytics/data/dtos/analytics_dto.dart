import 'package:equatable/equatable.dart';

class AnalyticsDTO extends Equatable {
  final String startTime;
  final String endTime;

  const AnalyticsDTO({required this.startTime, required this.endTime});

  @override
  List<Object?> get props => [startTime, endTime];

  Map<String, dynamic> toJson() {
    return {
      'start_time': '2024-09-01T18:30:00.000Z',
      'end_time': '2024-09-30T18:30:00.000Z'
    };
  }
}
