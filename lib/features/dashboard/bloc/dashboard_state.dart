part of 'dashboard_bloc.dart';

enum DashboardStatus {
  initial,
  loading,
  success,
  failed,
  initSuccess,
  locationDisable,
  postSuccess
}

class DashboardState extends Equatable {
  const DashboardState(
      {this.status = DashboardStatus.initial,
      this.isClockIn = false,
      this.name = '',
      this.role = '',
      this.location = '',
      this.clockInTime = '--:--',
      this.clockOutTime = '--:--',
      this.workingHours = '--:--',
      this.position,
      this.companyAddress = '--:--',
      this.companyLat = 0,
      this.companyLong = 0,
      this.accuracy = 0,
      this.historyList = const [],
      this.isNearLocation});
  final DashboardStatus status;
  final bool isClockIn;
  final String name;
  final String role;
  final String clockInTime;
  final String clockOutTime;
  final String workingHours;
  final String location;
  final Position? position;
  final String companyAddress;
  final double companyLat;
  final double companyLong;
  final double accuracy;
  final List<DashboardHistoryData> historyList;
  final bool? isNearLocation;

  DashboardState copyWith(
      {DashboardStatus? status,
      bool? isClockIn,
      String? name,
      String? role,
      String? clockInTime,
      String? clockOutTime,
      String? workingHours,
      String? location,
      Position? position,
      String? companyAddress,
      double? companyLong,
      double? companyLat,
      double? accuracy,
      List<DashboardHistoryData>? historyList,
      bool? isNearLocation}) {
    return DashboardState(
      status: status ?? this.status,
      isClockIn: isClockIn ?? this.isClockIn,
      name: name ?? this.name,
      role: role ?? this.role,
      clockInTime: clockInTime ?? this.clockInTime,
      clockOutTime: clockOutTime ?? this.clockOutTime,
      workingHours: workingHours ?? this.workingHours,
      location: location ?? this.location,
      position: position ?? this.position,
      companyAddress: companyAddress ?? this.companyAddress,
      companyLat: companyLat ?? this.companyLat,
      companyLong: companyLong ?? this.companyLong,
      accuracy: accuracy ?? this.accuracy,
      historyList: historyList ?? this.historyList,
      isNearLocation: isNearLocation,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isClockIn,
        name,
        role,
        clockInTime,
        clockOutTime,
        workingHours,
        location,
        position,
        companyAddress,
        companyLat,
        companyLong,
        accuracy,
        historyList,
        isNearLocation
      ];
}
