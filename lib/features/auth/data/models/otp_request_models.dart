// lib/features/auth/data/models/otp_request_models.dart

class SendOtpRequestModel {
  final String phone;
  final String captcha;

  SendOtpRequestModel({required this.phone, required this.captcha});

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'captcha': captcha,
  };
}

class VerifyOtpRequestModel {
  final String phone;
  final String code;

  VerifyOtpRequestModel({required this.phone, required this.code});

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'code': code,
  };
}

class OtpResponseModel {
  final String msg;

  OtpResponseModel({required this.msg});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      msg: json['msg'] ?? '',
    );
  }
}
