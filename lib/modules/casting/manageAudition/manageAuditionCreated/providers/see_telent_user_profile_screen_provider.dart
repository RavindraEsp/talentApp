import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class SeeTelentUserProfileScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  TalantUserProfileModel? talantUserProfileModel;

  getTalentUserProfile(
    int userId, {
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    auditionRepository.getTalentProfileInCasterApp(
        queryParameters: {"userType": 2, "talentUserId": userId}).then((value) {
      if (value.success == true) {
        talantUserProfileModel = value;
        isLoading = false;
        notifyListeners();
        initializeValriable();
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

  // ------ variable ----------

  List<String> lookingForList = [];

  List<String> bodyList = [];
  bool isExperienceNeeded = false;
  bool isParticipate = false;

  List<Files> videoList = [];
  List<Files> audioList = [];

  // - ----- intitalize variables ----
  Future<void> initializeValriable() async {
    for (String item in talantUserProfileModel?.data?.first.lookingFor ?? []) {
      lookingForList.add(item);
    }
    for (String item in talantUserProfileModel?.data?.first.bodyList ?? []) {
      bodyList.add(item);
    }

    isExperienceNeeded =
        talantUserProfileModel?.data?.first.experience == 1 ? true : false;
    isParticipate =
        talantUserProfileModel?.data?.first.participated == 1 ? true : false;

    for (Files item in talantUserProfileModel?.data?.first.videoFiles ?? []) {
      videoList.add(item);
    }
    for (Files item in talantUserProfileModel?.data?.first.audioFiles ?? []) {
      audioList.add(item);
    }

    notifyListeners();
  }
}
