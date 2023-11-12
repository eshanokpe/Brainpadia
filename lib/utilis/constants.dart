//const baseUrl = "https://api.brainepedia.com/api";
const baseUrl = "https://api.infobrain.com.ng/api";

// Create a constants file for API endpoints
class APIEndpoints {
  static const String authLogin = '$baseUrl/Account/auth_login';
  static const String register = '$baseUrl/Account/register';
  static const String postOTP = '$baseUrl/Account/post_otp';
  static const String resendOTP = '$baseUrl/Account/resend_otp';
  static const String passwordReset = '$baseUrl/Account/reset_password';
}
