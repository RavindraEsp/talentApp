import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/menu/web_content_response_model.dart';
import 'package:talent_app/network/repository/menu_repository.dart';
import 'package:talent_app/utilities/enums.dart';

class WebContentProvider extends ChangeNotifier {
  final MenuRepository menuRepository = MenuRepository();
  WebContentResponseModel? webContentResponseModel;

  bool isLoading = true;

  getWebContentData({
    required ValueChanged<String> onFailure,
  }) {
    menuRepository.getWebContent().then((value) {
      if (value.success == true) {
        webContentResponseModel = value;
        isLoading = false;
        notifyListeners();
      } else {
        onFailure.call(value.message ?? "");
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

  String getHtmlData(PageName pageName) {
    if (pageName == PageName.aboutUs) {
      AppLogger.logD("About data");
      return webContentResponseModel?.data?.aboutus ?? "";
    } else if (pageName == PageName.termCondition) {
      AppLogger.logD("Term Condition data");

      return webContentResponseModel?.data?.termscondition ?? "";
    } else {
      AppLogger.logD("Policy data");

      return webContentResponseModel?.data?.privacypolicy ?? "";
    }
  }
}
