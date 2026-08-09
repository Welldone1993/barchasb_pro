abstract class OtpRepository {
  Future<String> sendOtp({required String phone, required String captchaCode});

  Future<bool> verifyOtp({required String phone, required String otpCode});
}
