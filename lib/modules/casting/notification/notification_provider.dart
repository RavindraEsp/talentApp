import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/notification/notification_response_model.dart';
import 'package:talent_app/network/repository/menu_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final MenuRepository menuRepository = MenuRepository();
  NotificationResponseModel? notificationResponseModel;

  bool isLoading = true;

  getNotification({
    required String userType,
    required ValueChanged<String> onFailure,
  }) {
    menuRepository.getNotification(queryParameters: {
      "userType":userType
    }).then((value) {

      if (value.success == true) {
        notificationResponseModel = value;
        isLoading = false;
        notifyListeners();
      } else {
        onFailure.call(value.msg ?? "");
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
