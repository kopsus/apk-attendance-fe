class LoginModel {
  final bool success;
  final String message;
  final LoginData data;
  final int code;

  const LoginModel(
      {required this.success,
      required this.message,
      required this.data,
      required this.code});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      success: json['success'],
      message: json['message'],
      data: LoginData.fromJson(json['data']),
      code: json['code']);
}

class LoginData {
  final String accessToken;
  final int expiredAt;
  final String role;
  final String name;

  const LoginData(
      {required this.accessToken,
      required this.expiredAt,
      required this.role,
      required this.name});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
      accessToken: json['accessToken'],
      expiredAt: json['expiredAt'],
      role: json['role'] ?? '',
      name: json['name'] ?? '');
}
