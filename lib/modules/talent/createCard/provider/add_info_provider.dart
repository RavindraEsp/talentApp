import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/createCard/models/talent_create_card_model.dart';
import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:dio/dio.dart' as dio;
import 'package:talent_app/network/repository/auth_repository.dart';

class AddInfoProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  final AuthRepository authRepository = AuthRepository();

  TalentDataResponseModel? talentDataResponseModel;

  List<LookingFor>? lookingForModel;

  List<int>? selectedLookingForIds = [];

  bool isLoading = true;

  getTalentData({
    required ValueChanged<String> onFailure,
  }) {
    auditionRepository.getTalentData().then((value) {
      if (value.success == true) {
        talentDataResponseModel = value;

        lookingForModel = talentDataResponseModel?.data?.lookingFor;

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

  updateUi() {
    notifyListeners();
  }

  bool setCategoryValue() {
    selectedLookingForIds = [];

    List<LookingFor>? selectedLookingFor = lookingForModel
        ?.where((lookingFor) => lookingFor.isSelect == true)
        .toList();

    selectedLookingForIds =
        selectedLookingFor?.map((lookingFo) => lookingFo.id ?? 0).toList();

    AppLogger.logD('Selected Looking List: $selectedLookingForIds');

    return true;
  }

  createTalentCard(
      {required ValueChanged<String> onSuccess,
      required ValueChanged<String> onFailure,
      required TalentCreateCardModel? talentCreateCardModel,
      required List<XFile> selectedImages}) async {


    dio.MultipartFile? multipartImage;
    List<dio.MultipartFile> multipartImageList = [];

    if (selectedImages != null) {
      for(var a = 0;a<selectedImages.length;a++){
        multipartImage = await dio.MultipartFile.fromFile(
          selectedImages[a].path,
          filename: selectedImages[a].name,
        );
        multipartImageList.add(multipartImage);
        print("multipartImage ${multipartImage}");
      }

    }
    dio.MultipartFile? multipartFileProfileImage;

    AppLogger.logD("multi part image ${multipartImage?.filename}");
    AppLogger.logD("multi part logo ${multipartFileProfileImage?.filename}");

    Map<String, dynamic>? rawData;

      rawData = {
        //  userId:34
        "FirstName": talentCreateCardModel?.firstName,
        "LastName": talentCreateCardModel?.lastName,
        "Gender": talentCreateCardModel?.gender,
        "Address": talentCreateCardModel?.address,
        "Dateofbirth": talentCreateCardModel?.dateofbirth,
        "About": talentCreateCardModel?.about,
        "Height": talentCreateCardModel?.height,
        "Weight": talentCreateCardModel?.weight,
        "experience": talentCreateCardModel?.experience,
        "participated": talentCreateCardModel?.participated,
        "profileTalentdata": talentCreateCardModel?.profileTalentdata,
        "careerModel": talentCreateCardModel?.careerModel,
        "instalink": talentCreateCardModel?.instalink,
        "facebooklink": talentCreateCardModel?.facebooklink,
        "youtubelink": talentCreateCardModel?.youtubelink,
        "tiktoklink": talentCreateCardModel?.tiktoklink,
        "GovtId": talentCreateCardModel?.govtId,
        "image": multipartImageList
      };


    authRepository.createTalentCard(rawData).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });

    // final res = await authRepository.updateCasterProfile(rawData);
    //
    // if (value.success == true) {
    //   onSuccess.call(value);
    // } else {
    //   onFailure.call(value.msg ?? "");
    // }
  }
}
