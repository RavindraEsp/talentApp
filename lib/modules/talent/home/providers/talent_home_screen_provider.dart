import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/talent/talent_home/talent_home_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class TalentHomeScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  //
  TalentHomeResponseModel? talentHomeResponseModel;

  getHomeDataForTalent({
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    talentHomeResponseModel = TalentHomeResponseModel();
    auditionRepository.getHomeDataForTalent().then((value) {
      if (value.success == true) {
        talentHomeResponseModel = value;
        notifyListeners();
      } else {
        onFailure.call(value.msg ?? "");
      }
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    });
  }

  withdrawAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? appliedId,
  }) {
    Map request = {"appliedId": appliedId};

    auditionRepository.withdrawAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
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
