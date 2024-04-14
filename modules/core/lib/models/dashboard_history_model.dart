class DashboardHistoryModel {
  bool? success;
  List<DashboardHistoryData>? data;
  String? message;
  int? code;

  DashboardHistoryModel({this.success, this.data, this.message, this.code});

  DashboardHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DashboardHistoryData>[];
      json['data'].forEach((v) {
        data!.add(DashboardHistoryData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class DashboardHistoryData {
  String? action;
  int? timestamp;
  String? status;

  DashboardHistoryData({this.action, this.timestamp, this.status});

  DashboardHistoryData.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    timestamp = json['timestamp'];
    status = json['status'];
  }
}
