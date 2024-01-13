class Endpoints {
  const Endpoints._();

  static const baseUrl = "https://espsofttech.in:7272/api/";
  static ApiEndPoints apiEndPoints = ApiEndPoints();

  static const imageBaseUrl = "https://espsofttech.in:7272/api/auth/uploads/";
}

class ApiEndPoints {

  /// for caster app
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
  String get updateAudition => "/auth/updateAudition";
  String get getCreatedFinishedAuditionList =>
      "get/getCreatedFinishedAuditionList";
  String get getfinishedAuditionmanage => "get/getfinishedAuditionmanage";
  String get getcreatedAuditionmanage => "get/getcreatedAuditionmanage";

  String get getAuditionDetailById => "auth/getAuditionDetailById";
  String get cancelAudition => "auth/cancelAudition";

  String get getTalentProfile => "get/getTalentProfile";
  String get approverejectApplyAudition => "auth/approverejectApplyAudition";


  ///for talent app


  String get createTalentCard => "auth/addEditTalentProfile";
  String get getAlltalentdashboardAuditionList => "get/getAlltalentdashboardAuditionList";
  String get getAuditionDetailbytalent => "get/getAuditionDetailbytalent";
  String get applyAudition => "auth/applyAudition";
  String get withdrawAudition => "auth/withdrawAudition";
  String get gettalentdeclinedAuditionList => "get/gettalentdeclinedAuditionList";
}
