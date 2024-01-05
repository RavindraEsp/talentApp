import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class TalentCreateCardStepTwoProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();
  TalentDataResponseModel? talentDataResponseModel;



  List<EyeColor>? eyeColorModel;
  List<EyeColor>? hairColorModel;
  List<EyeColor>? painsSizeModel;
  List<EyeColor>? shirtSizeModel;
  List<EyeColor>? shoeSizeModel;
  List<LookingFor>? lookingForModel;


  EyeColor? selectEyeColor;
  EyeColor? selectHairColor;
  EyeColor? selectPainsSize;
  EyeColor? selectShirtSize;
  EyeColor? selectShoeSize;

  List<int> talentBodyData = [];
  List<int>? selectedLookingForIds = [];

  bool isLoading = true;

  getTalentData({
    required ValueChanged<String> onFailure,
  }) {
    auditionRepository.getTalentDataForCreateAudition().then((value) {
      if (value.success == true) {
        talentDataResponseModel = value;

        eyeColorModel = talentDataResponseModel?.data?.eyeColor;
        hairColorModel = talentDataResponseModel?.data?.hairColor;
        painsSizeModel = talentDataResponseModel?.data?.pantSize;
        shirtSizeModel = talentDataResponseModel?.data?.shirtSize;
        shoeSizeModel = talentDataResponseModel?.data?.shoeSize;
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

  bool setTalentBodyValue() {

    talentBodyData = [];

    if(selectEyeColor != null){
      talentBodyData.add(selectEyeColor?.id ?? 0);
    }
    if(selectHairColor != null){
      talentBodyData.add(selectHairColor?.id ?? 0);
    }

    if(selectPainsSize != null){
      talentBodyData.add(selectPainsSize?.id ?? 0);
    }
    if(selectShirtSize != null){
      talentBodyData.add(selectShirtSize?.id ?? 0);
    }
    if(selectShoeSize != null){
      talentBodyData.add(selectShoeSize?.id ?? 0);
    }

    return true;

  }
}
