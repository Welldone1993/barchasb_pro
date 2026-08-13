class ApiEndpoints {
  // Auth
  static const authController = '/auth';
  static const String login = '$authController/login';
  static const String register = '$authController/register';
  static const String getUser = '$authController/me';

  // OTP
  static const otpController = '/otp';
  static const String sendOtp = '$otpController/send';

  // ads
  static const adsController = '/ads';
  static const String jobseekerAds = '$adsController/jobseeker';
  static const String employerAds = '$adsController/employer';
  static const String sellerAds = '$adsController/seller';
  static const String digitalAds = '$adsController/digital';

  static const String createDigitalAd = '$adsController/digital';
  static const String createEmployerAd = '$adsController/employer';
  static const String createSellerAd = '$adsController/seller';
  static const String createJobseekerAd = '$adsController/jobseeker';

  // user-view
  static const userViewController = '/user-views';
  static const weeklyStats =
      '$userViewController?period=weekly&adType=JobSeekerAd';

  // public
  static const getProvinces = '/provinces';
}
