import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class SignUpScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  signUpGetOtp({
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

      onFailure.call("Server Error");
    });
  }

  updateUi(){
    notifyListeners();
  }
}
