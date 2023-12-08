import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class ManageAuditionCreatedScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  ManagAuditionCreatedScreenModel? managAuditionCreatedScreenModel;

  getcreatedAuditionmanage(
    int auditionId, {
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    auditionRepository.getcreatedAuditionmanage(
        queryParameters: {'auditionId': auditionId}).then((value) {
      if (value.success == true) {
        managAuditionCreatedScreenModel = value;
        isLoading = false;
        notifyListeners();
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
}
