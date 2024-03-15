import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/shared_preference.dart';

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
    required UserType userType,
  }) {
    authRepository.signUp(request).then((value) {
      if (value.success == true) {

        Preference.setProfileImage(value.data?.profilePic ?? "");
        Preference.setAccessToken(value.data?.jwtToken ?? "");
        Preference.setUserName(value.data?.userName ?? "");
        Preference.setUserId(value.data?.id ?? 0);
        Preference.setBoosterCount(value.data?.boostCount ?? 0);

        if (userType == UserType.cast) {
          Preference.setUserType(2);
        } else {
          Preference.setUserType(1);
        }


        onSuccess.call("${value.msg}");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");

      onFailure.call("Server Error");
    });
  }
}
