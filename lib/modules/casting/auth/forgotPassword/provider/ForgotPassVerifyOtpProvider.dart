

import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class ForgotPassVerifyOtpProvider with ChangeNotifier{
  final AuthRepository authRepository = AuthRepository();


  forgotPassMobileotpVerify({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required Map request,
  }) {
    authRepository.forgotPassMobileotpVerify(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      onFailure.call("Server Error");
    });
  }

}