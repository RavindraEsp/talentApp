import 'package:dio/dio.dart';
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

  Future<BasicResponse> signUp(SignupRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.signUp, data: request.toJson())
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<LoginResponse> login(LoginRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.login, data: request.toJson())
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
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.forgotPassMobileotpVerify,
        data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<CasterProfileResponseModel> getCasterProfile() {
    return dioHttpService
        .get(Endpoints.baseUrl + Endpoints.apiEndPoints.getCasterProfile)
        .then((value) => CasterProfileResponseModel.fromJson(value));
  }


  Future<CasterProfileUpdateResponse> updateCasterProfile(Map<String, dynamic>  request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.apiEndPoints.updateCasterProfile,
        data:FormData.fromMap(request)
    )
        .then((value) => CasterProfileUpdateResponse.fromJson(value));
  }

  //return await postRequest(path, perms: FormData.fromMap(data));




}
