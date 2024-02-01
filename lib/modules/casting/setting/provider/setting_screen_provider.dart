import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class SettingScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  deleteAccount({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
  }) {
    authRepository.deleteAccount().then((value) {
      if (value.success == true) {
        Preference().clearSharedPreference();

        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString());
    });
  }
}
