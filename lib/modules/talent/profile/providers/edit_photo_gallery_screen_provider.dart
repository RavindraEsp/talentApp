import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:dio/dio.dart' as dio;
import 'package:talent_app/network/repository/auth_repository.dart';

class EditPhotoGalleryScreenProvider extends ChangeNotifier {
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
      required List<XFile> selectedImages}) async {
    List<dio.MultipartFile> multipartImageList = [];

    if (selectedImages != null) {
      for (var a = 0; a < selectedImages.length; a++) {
        dio.MultipartFile? multipartImage = await dio.MultipartFile.fromFile(
          selectedImages[a].path,
          filename: selectedImages[a].name,
        );
        multipartImageList.add(multipartImage);
        AppLogger.logD("multipartImage ${multipartImage}");
      }
    }

    AppLogger.logD("multi part image ${multipartImageList}");

    Map<String, dynamic>? rawData;

    rawData = {"id": id, "image": multipartImageList};

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
