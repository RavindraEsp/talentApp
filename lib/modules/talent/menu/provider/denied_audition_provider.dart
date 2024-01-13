import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/menu/model/denied_audition_response_model.dart';
import 'package:talent_app/network/model/response/talent/talent_home/talent_home_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class DeniedAuditionProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  //
  DeniedAuditionResponseModel? deniedAuditionResponseModel;

  getDeniedAuditionList({
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    deniedAuditionResponseModel = DeniedAuditionResponseModel();
    auditionRepository.getDeniedAuditionList().then((value) {
      if (value.success == true) {
        deniedAuditionResponseModel = value;
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


  updateUi() {
    notifyListeners();
  }
}
