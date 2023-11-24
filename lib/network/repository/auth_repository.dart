import 'package:dio/dio.dart';
import 'package:talent_app/network/client/dio_http_service.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/network/model/request/auth/login_request.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
import 'package:talent_app/network/model/response/auth/login/login_response.dart';
import 'package:talent_app/network/model/response/auth/signup/SignUpSendOtpResponse.dart';
import 'package:talent_app/network/model/response/basic_response.dart';

class AuthRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<SignupSendOtpResponse> signUpGetOtp(SignupSendOtpRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.signUpSendOtp,
            data: request.toJson())
        .then((value) => SignupSendOtpResponse.fromJson(value));
  }

  Future<BasicResponse> signUp(SignupRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.signUp, data: request.toJson())
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<LoginResponse> login(LoginRequest request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.login, data: request.toJson())
        .then((value) => LoginResponse.fromJson(value));
  }

  Future<SignupSendOtpResponse> forgotPassGetOtp(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.forgotPasswordGetOtp,
        data: request)
        .then((value) => SignupSendOtpResponse.fromJson(value));
  }

  Future<BasicResponse> forgotPassSetNewPass(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.forgotPassSetNewPass,
        data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<BasicResponse> forgotPassMobileotpVerify(Map request) {
    return dioHttpService
        .post(Endpoints.baseUrl + Endpoints.auth.forgotPassMobileotpVerify,
        data: request)
        .then((value) => BasicResponse.fromJson(value));
  }

  // Future<BasicResponse> updateCasterProfile(Map request) {
  //   return dioHttpService
  //       .post(Endpoints.baseUrl + Endpoints.auth.updateCasterProfile,
  //       data:FormData.fromMap(request)
  //   )
  //       .then((value) => BasicResponse.fromJson(value));
  // }

  //return await postRequest(path, perms: FormData.fromMap(data));




}
