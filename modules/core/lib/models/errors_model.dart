class ErrorModel {
  final bool? success;
  final String? message;
  final String? data;
  final int? code;

  const ErrorModel({this.success, this.message, this.data, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
      success: json['success'],
      message: json['message'],
      data: null,
      code: json['code']);
}
