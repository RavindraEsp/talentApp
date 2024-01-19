import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:dio/dio.dart' as dio;
import 'package:talent_app/network/repository/auth_repository.dart';

class EditVideoGalleryScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  final AuthRepository authRepository = AuthRepository();

  bool isLoading = true;

  updateUi() {
    notifyListeners();
  }

  updateTalentProfileData(
      {required ValueChanged<String> onSuccess,
      required ValueChanged<String> onFailure,
      required int id,
      required List<XFile> selectedVideos}) async {
    List<dio.MultipartFile> multipartVideoList = [];

    if (selectedVideos != null) {
      for (var a = 0; a < selectedVideos.length; a++) {
        dio.MultipartFile? multipartVideo = await dio.MultipartFile.fromFile(
          selectedVideos[a].path,
          filename: selectedVideos[a].name,
        );
        multipartVideoList.add(multipartVideo);
        AppLogger.logD("multipart $multipartVideo");
      }
    }

    AppLogger.logD("multi part video list $multipartVideoList");

    Map<String, dynamic>? rawData;

    rawData = {"id": id, "video": multipartVideoList};

    authRepository.updateTalentProfile(rawData).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString());
    });
  }
}
