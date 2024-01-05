import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
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

  List<int> auditionTalentAllData = [];
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

 bool getAllValue() {
    List<EyeColor>? selectedEyeColors =
        eyeColorModel?.where((eyeColor) => eyeColor.isSelect == true).toList();
    List<EyeColor>? selectedHairColor = hairColorModel
        ?.where((hairColor) => hairColor.isSelect == true)
        .toList();
    List<EyeColor>? selectedPansSize =
        painsSizeModel?.where((pansSize) => pansSize.isSelect == true).toList();
    List<EyeColor>? selectedShirtSize = shirtSizeModel
        ?.where((shirtSize) => shirtSize.isSelect == true)
        .toList();
    List<EyeColor>? selectedShoeSize =
        shoeSizeModel?.where((shoeSize) => shoeSize.isSelect == true).toList();

    // Get a list of ids from selectedEyeColors

    List<int>? selectedEyeIds =
        selectedEyeColors?.map((eyeColor) => eyeColor.id ?? 0).toList();
    List<int>? selectedHairColorIds =
        selectedHairColor?.map((hairColor) => hairColor.id ?? 0).toList();
    List<int>? selectedPansSizeIds =
        selectedPansSize?.map((pansSize) => pansSize.id ?? 0).toList();
    List<int>? selectedShirtSizeIds =
        selectedShirtSize?.map((shirtSize) => shirtSize.id ?? 0).toList();
    List<int>? selectedShoeSizeIds =
        selectedShoeSize?.map((shoeSize) => shoeSize.id ?? 0).toList();

    // Add each list to the mergedList using addAll or the + operator

    auditionTalentAllData = [];
    selectedLookingForIds = [];

    auditionTalentAllData.addAll(selectedEyeIds ?? []);
    auditionTalentAllData.addAll(selectedHairColorIds ?? []);
    auditionTalentAllData.addAll(selectedPansSizeIds ?? []);
    auditionTalentAllData.addAll(selectedShirtSizeIds ?? []);
    auditionTalentAllData.addAll(selectedShoeSizeIds ?? []);

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
