import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class CastVerifyPhoneProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  reSendOtp({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required SignupSendOtpRequest request,
  }) {
    authRepository.signUpGetOtp(request).then((value) {
      if (value.success == true) {
        onSuccess.call("${value.msg} ${value.data}" ?? "");
      } else {
        onFailure.call(value.msg ?? "");

      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      onFailure.call(error.toString());
    });
  }


  signUp({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required SignupRequest request,
  }) {
    authRepository.signUp(request).then((value) {
      if (value.success == true) {
        onSuccess.call("${value.msg}");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      onFailure.call("Server Error");
    });
  }
}
