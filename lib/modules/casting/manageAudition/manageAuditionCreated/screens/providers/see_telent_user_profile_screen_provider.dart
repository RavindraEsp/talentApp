import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/model/telent_user_profile_model.dart';
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
    auditionRepository.getTalentProfile(
        queryParameters: {"userType": 2, "talentUserId": userId}).then((value) {
      if (value.success == true) {
        talantUserProfileModel = value;
        isLoading = false;
        notifyListeners();
        initializeValriable();
      } else {
        isLoading = false;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call("Server Error");
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
    // isTrainingNeeded =
    //     auditionDetailsModel.data?.professionalTraining == 1 ? true : false;
    // isRepresented =
    //     auditionDetailsModel.data?.candidateRepresentation == 1 ? true : false;
    // minAgeController.text = '${auditionDetailsModel.data?.ageRangeMin ?? 0}';
    // maxAgeController.text = '${auditionDetailsModel.data?.ageRangeMax ?? 0}';
    // minWeightController.text =
    //     '${auditionDetailsModel.data?.weightRangeMin ?? 0}';
    // maxWeightController.text =
    //     '${auditionDetailsModel.data?.weightRangeMax ?? 0}';
    // minHeightController.text =
    //     '${auditionDetailsModel.data?.heightRangeMin ?? 0}';
    // maxHeightController.text =
    //     '${auditionDetailsModel.data?.heightRangeMax ?? 0}';

    // for (NameSelectedAttrButeModel item
    //     in auditionDetailsModel.data?.eyeColor ?? []) {
    //   eyeColorModelList.add(AuditionPropertyModel(
    //       id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    // }
    // for (NameSelectedAttrButeModel item
    //     in auditionDetailsModel.data?.hairColor ?? []) {
    //   hairColorModelList.add(AuditionPropertyModel(
    //       item.name ?? "", item.isSelected == "1" ? true : false,
    //       id: item.id));
    // }
    // for (NameSelectedAttrButeModel item
    //     in auditionDetailsModel.data?.pantSize ?? []) {
    //   painsSizeModelList.add(AuditionPropertyModel(
    //       id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    // }
    // for (NameSelectedAttrButeModel item
    //     in auditionDetailsModel.data?.shirtSize ?? []) {
    //   shirtSizeModelList.add(AuditionPropertyModel(
    //       id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    // }
    // for (NameSelectedAttrButeModel item
    //     in auditionDetailsModel.data?.shoeSize ?? []) {
    //   shoeSizeModelList.add(AuditionPropertyModel(
    //       id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    // }

    notifyListeners();
  }
}
