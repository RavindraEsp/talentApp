class Endpoints {
  const Endpoints._();

  static const baseUrl = "https://espsofttech.in:7272/api/";
  static AuthEndPoints auth = AuthEndPoints();

  static const imageBaseUrl = "https://espsofttech.in:7272/api/auth/uploads/";

}


class AuthEndPoints {
  String get signUpSendOtp => "auth/emailVerification";
  String get signUp => "auth/userRegister";
  String get login => "auth/login";
  String get forgotPasswordGetOtp => "auth/forgotPassword";
  String get forgotPassSetNewPass => "auth/resetpassword";
  String get forgotPassMobileotpVerify => "auth/mobileemailotpVerify";
  String get updateCasterProfile => "auth/updateCasterProfile";
  String get getCasterProfile => "get/getCasterProfile";
  String get getWebContent => "get/getWebContent";
}
