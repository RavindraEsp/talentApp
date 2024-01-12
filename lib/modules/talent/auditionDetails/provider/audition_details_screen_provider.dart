import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/auditionDetails/model/audition_detail_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class AuditionDetailsScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;
  AuditionDetailResponseModel? auditionDetailResponseModel;


  geAuditionDetails({
    required ValueChanged<String> onFailure,
    required int auditionId
  }) {
    isLoading = true;
    auditionRepository.geAuditionDetails({
      "auditionId":auditionId
    }).then((value) {
      if (value.success == true) {
        auditionDetailResponseModel = value;

        notifyListeners();
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




  applyAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? casterUserId,
    required int? auditionId,
    required int? auditionDateId,
  }) {

    Map request = {
      "casterUserId":casterUserId,
      "auditionId":auditionId,
      "auditionDateId":auditionDateId
    };
    auditionRepository.applyAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");

      }else{
        onFailure.call(value.msg ?? "");
      }

    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
  }

  rescheduleAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? casterUserId,
    required int? auditionId,
    required int? auditionDateId,
    required int? applyId,
  }) {

    Map request = {
     "casterUserId":casterUserId,
        "auditionId":auditionId,
        "auditionDateId":auditionDateId,
        "applyId":applyId


    };
    auditionRepository.rescheduleAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");

      }else{
        onFailure.call(value.msg ?? "");
      }

    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
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


  updateUi(){
    notifyListeners();
  }
}
