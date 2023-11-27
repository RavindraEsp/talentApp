import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/audition/talent_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class CreateAuditionProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();
  TalentDataResponseModel? talentDataResponseModel;




  bool? isExperienceNeeded;
  bool? isTrainingNeeded;
  bool? isRepresented;

  TextEditingController auditionDescriptionController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();
  TextEditingController maxAgeController = TextEditingController();
  TextEditingController minWeightController = TextEditingController();
  TextEditingController maxWeightController = TextEditingController();
  TextEditingController minHeightController = TextEditingController();
  TextEditingController maxHeightController = TextEditingController();

  List<EyeColor>? eyeColorModel;
  List<EyeColor>? hairColorModel;
  List<EyeColor>? painsSizeModel;
  List<EyeColor>? shirtSizeModel;
  List<EyeColor>? shoeSizeModel;
  List<LookingFor>? lookingForModel;



  bool isLoading = true;

  getTalentData({
    required ValueChanged<String> onFailure,
  }) {
    auditionRepository.getTalentData().then((value) {

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

  updateUi(){
    notifyListeners();
  }

}
