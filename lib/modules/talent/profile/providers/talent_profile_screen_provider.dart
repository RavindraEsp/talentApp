import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class TalentProfileScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  bool isLoading = false;

  TalantUserProfileModel? talantUserProfileModel;

  getTalentProfile({
    required ValueChanged<String> onFailure,
    required ValueChanged<TalantUserProfileModel> onSuccess,
  }) {
    isLoading = true;
    talantUserProfileModel = TalantUserProfileModel();
    authRepository.getTalentProfile(queryParameters: {
      "userType": 1, //Here us Talent app
    }).then((value) {
      if (value.success == true) {
        talantUserProfileModel = value;
        isLoading = false;
        onSuccess.call(talantUserProfileModel!);
        notifyListeners();
      } else {
        isLoading = false;
        onFailure.call(value.msg ?? "");
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    });
  }

  deleteFile({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int id,
  }) async {
    Map<String, dynamic> rawData = {"id": id};
    await authRepository.deleteTalentFile(rawData).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg!);
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
  }

  updateUi() {
    notifyListeners();
  }
}
