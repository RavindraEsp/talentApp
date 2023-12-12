import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/home/providers/cast_home_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:talent_app/utilities/common.dart';

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

  Future<void> cancelTheAuditionApi(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    auditionRepository.cancelAudition(
        {"id": managAuditionCreatedScreenModel?.data?.id}).then((value) {
      if (value["success"] == true) {
        Common.showSuccessToast(context, value['msg'] ?? "");

        isLoading = false;
        notifyListeners();

        // Provider.of<CastHomeScreenProvider>(context, listen: false)
        //     .getHomeDataForCaster(onFailure: (message) {
        //   // Common.showErrorSnackBar(context, message);
        // });
        Navigator.pop(
          context,
        );
      } else {
        Common.showErrorSnackBar(context, value['msg'] ?? "");
        isLoading = false;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      isLoading = false;
      notifyListeners();
    });

    isLoading = false;
    notifyListeners();
  }
}
