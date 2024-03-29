class Endpoints {
  const Endpoints._();

  static const baseUrl = "https://espsofttech.in:7272/api/";
  static ApiEndPoints apiEndPoints = ApiEndPoints();

  static const imageBaseUrl = "https://espsofttech.in:7272/api/auth/uploads/";

}


class ApiEndPoints {
  String get signUpSendOtp => "auth/emailVerification";
  String get signUp => "auth/userRegister";
  String get login => "auth/login";
  String get forgotPasswordGetOtp => "auth/forgotPassword";
  String get forgotPassSetNewPass => "auth/resetpassword";
  String get forgotPassMobileotpVerify => "auth/mobileemailotpVerify";
  String get updateCasterProfile => "auth/updateCasterProfile";
  String get getCasterProfile => "get/getCasterProfile";
  String get getWebContent => "get/getWebContent";
  String get getNotification => "get/getNotification";
  String get getTalentData => "get/gettalentData";
  String get createAudition => "auth/createAudition";
  String get getCreatedFinishedAuditionList => "get/getCreatedFinishedAuditionList";
}
