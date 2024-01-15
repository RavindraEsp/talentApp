
import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/modules/talent/profile/model/talent_profile_resposne_model.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class TalentProfileScreenProvider extends ChangeNotifier{


  final AuthRepository authRepository = AuthRepository();



  bool isLoading = false;

  TalantUserProfileModel? talantUserProfileModel;

  getTalentProfile(
      {
        required ValueChanged<String> onFailure,
        required ValueChanged<TalantUserProfileModel> onSuccess,
      }) {
    isLoading = true;
    authRepository.getTalentProfile(
        queryParameters: {
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
    })
        .onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    }
    )
    ;
  }

  updateUi(){
    notifyListeners();
  }
}