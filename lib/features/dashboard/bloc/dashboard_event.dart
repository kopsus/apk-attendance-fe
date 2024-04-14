part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class InitEvent extends DashboardEvent {}

class GetDashboardStatus extends DashboardEvent {}

class GetDashboardHistory extends DashboardEvent {}

class GetUserDetail extends DashboardEvent {}

class RefreshLocation extends DashboardEvent {}

class CheckNearLocation extends DashboardEvent {
  Position currentPosition;
  double companyLat;
  double companyLong;

  CheckNearLocation(
      {required this.currentPosition,
      required this.companyLat,
      required this.companyLong});
}

class SendAttendanceData extends DashboardEvent {
  XFile image;

  SendAttendanceData({required this.image});
}
