// lib/features/auth/data/repositories/otp_repository_impl.dart
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_remote_datasource.dart';
import '../models/otp_request_models.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource remote;

  OtpRepositoryImpl(this.remote);

  @override
  Future<String> sendOtp({required String phone, required String captchaCode}) async {
    try {
      final requestModel = SendOtpRequestModel(
        phone: phone,
        captcha: captchaCode,
      );

      final responseModel = await remote.sendOtp(requestModel);
      return responseModel.msg; // معمولا "کد ارسال شد"
    } catch (e) {
      // اینجا می‌توانید خطاهای Dio را مدیریت یا تبدیل کنید
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp({required String phone, required String otpCode}) async {
    try {
      final requestModel = VerifyOtpRequestModel(
        phone: phone,
        code: otpCode,
      );

      await remote.verifyOtp(requestModel);
      return true; // اگر Exception پرتاب نشود، یعنی موفقیت‌آمیز بوده است
    } catch (e) {
      rethrow; // برای دریافت متن خطا در Provider
    }
  }
}
