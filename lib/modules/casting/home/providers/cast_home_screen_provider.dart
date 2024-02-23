import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/casterAudition/CasterHomeResponseModel.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class CastHomeScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  CastHomeResponseModel? castHomeResponseModel;

  getHomeDataForCaster({
    required ValueChanged<String> onFailure,
  }) {

    isLoading = true;
    auditionRepository.getHomeDataForCaster().then((value) {
      if (value.success == true) {
        castHomeResponseModel = value;
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
}
