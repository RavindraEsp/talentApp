import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/managefinishedAudition/model/manage_finish_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class ManageFinishedAuditionScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  ManageFinishedAuditionScreenModel? manageFinishedAuditionScreenModel;

  getfinishedAuditionmanage(
    int auditionId, {
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    auditionRepository.getfinishedAuditionmanage(
        queryParameters: {'auditionId': auditionId}).then((value) {
      if (value.success == true) {
        manageFinishedAuditionScreenModel = value;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    });
  }
}
