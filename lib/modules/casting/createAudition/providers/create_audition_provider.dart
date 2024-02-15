import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/talentdata_response_model_new.dart';
//import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class CreateAuditionProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

 // TalentDataResponseModel? talentDataResponseModel;
  TalentDataResponseModelNew? talentDataResponseModelNew;

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

  // List<EyeColor>? eyeColorModel;
  // List<EyeColor>? hairColorModel;
  // List<EyeColor>? painsSizeModel;
  // List<EyeColor>? shirtSizeModel;
  // List<EyeColor>? shoeSizeModel;
  List<LookingFor>? lookingForModel;

  List<int> auditionTalentAllData = [];
  List<int>? selectedLookingForIds = [];

  bool isLoading = true;

  getTalentData({
    required ValueChanged<String> onFailure,
  }) {
    auditionRepository.getTalentDataForCreateAuditionNew().then((value) {
      if (value.success == true) {
        talentDataResponseModelNew = value;

        // eyeColorModel = talentDataResponseModel?.data?.eyeColor;
        // hairColorModel = talentDataResponseModel?.data?.hairColor;
        // painsSizeModel = talentDataResponseModel?.data?.pantSize;
        // shirtSizeModel = talentDataResponseModel?.data?.shirtSize;
        // shoeSizeModel = talentDataResponseModel?.data?.shoeSize;
        lookingForModel = talentDataResponseModelNew?.data?.lookingFor;

        isLoading = false;
        notifyListeners();
      } else {
        onFailure.call(value.msg ?? "");
        isLoading = false;
        notifyListeners();
      }
    })
        .onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    })

    ;
  }

  updateUi() {
    notifyListeners();
  }

 bool getAllValue() {
   auditionTalentAllData = [];

    for(var i = 0;i< talentDataResponseModelNew!.data!.bodyDetail!.length; i++){


     // for(var j = 0;j< talentDataResponseModelNew!.data!.body![i].bodyData!.length; i++){


        List<BodyData>? selectedBodyData =
        talentDataResponseModelNew!.data!.bodyDetail![i].bodyData?.where((bodyData) => bodyData.isSelect == true).toList();


        List<int>? selectedEyeIds =
        selectedBodyData?.map((bodyData) => bodyData.id ?? 0).toList();

        auditionTalentAllData.addAll(selectedEyeIds ?? []);

    //  }

    }




    selectedLookingForIds = [];




    List<LookingFor>? selectedLookingFor = lookingForModel
        ?.where((lookingFor) => lookingFor.isSelect == true)
        .toList();

    selectedLookingForIds =
        selectedLookingFor?.map((lookingFo) => lookingFo.id ?? 0).toList();





    AppLogger.logD('All Talent Data: $auditionTalentAllData');
    AppLogger.logD('Selected Looking List: $selectedLookingForIds');

    return true;

  }
}
