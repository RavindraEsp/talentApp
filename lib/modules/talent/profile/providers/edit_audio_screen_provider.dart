import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:dio/dio.dart' as dio;
import 'package:talent_app/network/repository/auth_repository.dart';

class EditAudioScreenProvider extends ChangeNotifier {
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
      required List<FilePickerResult> selectedAudios}) async {
    List<dio.MultipartFile> multipartAudioList = [];

    if (selectedAudios != null) {
      for (var a = 0; a < selectedAudios.length; a++) {
        dio.MultipartFile? multipartAudio = await dio.MultipartFile.fromFile(
          selectedAudios[a].files.single.path!,
          filename: selectedAudios[a].files.single.name,
        );
        multipartAudioList.add(multipartAudio);
        AppLogger.logD("multipartAudio ${multipartAudio}");
      }
    }

    AppLogger.logD("multi part audio ${multipartAudioList}");

    Map<String, dynamic>? rawData;

    rawData = {"id": id, "audio": multipartAudioList};

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
