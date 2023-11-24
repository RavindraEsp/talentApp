

import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class ForgotPassFindAccountProvider with ChangeNotifier{

  final AuthRepository authRepository = AuthRepository();

  forgotPassGetOtp({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required Map request,
  }) {
    authRepository.forgotPassGetOtp(request).then((value) {
      if (value.success == true) {
        onSuccess.call("${value.msg} ${value.data}" ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      onFailure.call("Server Error");
    });
  }

}