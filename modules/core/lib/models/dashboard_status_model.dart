class DashboardStatusModel {
  final bool success;
  final DashboardStatusData data;
  final String message;
  final int code;

  const DashboardStatusModel(
      {required this.success,
      required this.data,
      required this.message,
      required this.code});

  factory DashboardStatusModel.fromJson(Map<String, dynamic> json) =>
      DashboardStatusModel(
          success: json['success'],
          data: DashboardStatusData.fromJson(json['data']),
          message: json['message'],
          code: json['code']);
}

class DashboardStatusData {
  String? action;
  int? clockIn;
  int? clockOut;
  String? companyAddress;
  double? companyLatitude;
  double? companyLongitude;

  DashboardStatusData(
      {this.action,
      this.clockIn,
      this.clockOut,
      this.companyAddress,
      this.companyLatitude,
      this.companyLongitude});

  DashboardStatusData.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    companyAddress = json['companyAddress'];
    // companyLatitude = -7.326245;
    // companyLongitude = 108.224199;
    companyLatitude = json['companyLatitude'];
    companyLongitude = json['companyLongitude'];
  }
}
