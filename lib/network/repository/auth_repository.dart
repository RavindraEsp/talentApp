import 'package:dio/dio.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_response_model.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_edit_response_model.dart';
import 'package:talent_app/modules/talent/profile/model/talent_category_response_model.dart';
import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/request/auth/login_request.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
import 'package:talent_app/network/model/response/auth/login/login_response.dart';
import 'package:talent_app/network/model/response/auth/signup/SignUpSendOtpResponse.dart';
import 'package:talent_app/network/model/response/basic_response.dart';
import 'package:talent_app/network/model/response/profile/caster_profile_response_model.dart';
import 'package:talent_app/network/model/response/profile/caster_profile_update_response.dart';

class AuthRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<SignupSendOtpResponse> signUpGetOtp(SignupSendOtpRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.signUpSendOtp,
            data: request.toJson())
        .then((value) => SignupSendOtpResponse.fromJson(value));
  }

  // Future<BasicResponse> signUp(SignupRequest request) {
  //   return dioHttpService
  //       .post(Endpoints.baseUrl + Endpoints.apiEndPoints.signUp,
  //           data: request.toJson())
  //       .then((value) => BasicResponse.fromJson(value));
  // }

  Future<LoginResponse> signUp(SignupRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.signUp,
        data: request.toJson())
        .then((value) => LoginResponse.fromJson(value));
  }

  Future<LoginResponse> login(LoginRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.login,
            data: request.toJson())
        .then((value) => LoginResponse.fromJson(value));
  }

  Future<SignupSendOtpResponse> forgotPassGetOtp(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.forgotPasswordGetOtp,
            data: request)
        .then((value) => SignupSendOtpResponse.fromJson(value));
  }

  Future<BasicResponse> forgotPassSetNewPass(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.forgotPassSetNewPass,
            data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<BasicResponse> forgotPassMobileotpVerify(Map request) {
    return dioHttpService
        .post(
            Endpoints.baseUrl +
                Endpoints.apiEndPoints.forgotPassMobileotpVerify,
            data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<CasterProfileResponseModel> getCasterProfile() {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getCasterProfile)
        .then((value) => CasterProfileResponseModel.fromJson(value));
  }

  Future<CasterProfileUpdateResponse> updateCasterProfile(
      Map<String, dynamic> request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.updateCasterProfile,
            data: FormData.fromMap(request))
        .then((value) => CasterProfileUpdateResponse.fromJson(value));
  }

  Future<BasicResponse> deleteAccount() {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.deleteAccount)
        .then((value) => BasicResponse.fromJson(value));
  }

  //return await postRequest(path, perms: FormData.fromMap(data));

  ///Talent Module API

  Future<CasterProfileUpdateResponse> createTalentCard(
      Map<String, dynamic> request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.createTalentCard,
            data: FormData.fromMap(request))
        .then((value) => CasterProfileUpdateResponse.fromJson(value));
  }

  Future<TalantUserProfileModel> getTalentProfile(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getTalentProfile,
            queryParameters: queryParameters)
        .then((value) => TalantUserProfileModel.fromJson(value));
  }

  Future<CasterProfileUpdateResponse> updateTalentProfile(
      Map<String, dynamic> request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.updateTalentProfile,
            data: FormData.fromMap(request))
        .then((value) => CasterProfileUpdateResponse.fromJson(value));
  }

  Future<TalentCategoryResponseModel> getTalentCategory(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getEditlookingData,
            queryParameters: queryParameters)
        .then((value) => TalentCategoryResponseModel.fromJson(value));
  }

  // Future<TalentBodyResponseModel> getTalentBody(
  //     {Map<String, dynamic>? queryParameters}) {
  //   return dioHttpService
  //       .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getEditTalentBody,
  //           queryParameters: queryParameters)
  //       .then((value) => TalentBodyResponseModel.fromJson(value));
  // }  // OLDAPI

  Future<TalentBodyEditResponseMode> getTalentBodyDynamic(
      {Map<String, dynamic>? queryParameters}) {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getEditTalentBodyNew,
        queryParameters: queryParameters)
        .then((value) => TalentBodyEditResponseMode.fromJson(value));
  }

  Future<BasicResponse> deleteTalentFile(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.deleteProfileFiles,
            data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

// Future<TalentProfileResponseModel> getTalentProfile() {
//   return dioHttpService
//       .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getCasterProfile)
//       .then((value) => TalentProfileResponseModel.fromJson(value));
// }
}
