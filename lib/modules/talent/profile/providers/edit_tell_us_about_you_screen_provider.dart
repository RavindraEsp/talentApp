import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class EditTellUsAboutScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  updateTalentProfileData(
      {required ValueChanged<String> onSuccess,
      required ValueChanged<String> onFailure,
      required String about,
      required int id
      }) async {
    Map<String, dynamic>? rawData;

    rawData = {
      "id": id,
      "About": about
    };

    authRepository.updateTalentProfile(rawData).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
  }
}
