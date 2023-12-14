import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/request/auth/login_request.dart';
import 'package:talent_app/network/model/response/auth/login/login_response.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class CastLoginProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  login({
    required bool rememberMe,
    required UserType userType,
    required ValueChanged<LoginResponse> onSuccess,
    required ValueChanged<String> onFailure,
    required LoginRequest request,
  }) {
    authRepository.login(request).then((value) {
      if (value.success == true) {
        Preference.setProfileImage(value.data?.profilePic ?? "");
        Preference.setAccessToken(value.data?.jwtToken ?? "");
        Preference.setUserName(value.data?.userName ?? "");

        if (userType == UserType.cast) {
          Preference.setUserType(2);
        } else {
          Preference.setUserType(1);
        }

        if (rememberMe == true) {
          Preference.setUserLogin(true);
        } else {
          Preference.setUserLogin(false);
        }

        onSuccess.call(value);
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call("Server Error");
    });
  }

  updateUi() {
    notifyListeners();
  }
}
