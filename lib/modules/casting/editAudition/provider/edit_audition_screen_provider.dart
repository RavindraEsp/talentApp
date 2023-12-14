import 'package:flutter/material.dart';

import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_sceen1_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:talent_app/routes/route_name.dart';

class EditAuditionScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  AuditionDetails auditionDetailsModel = AuditionDetails();

  // ---------- screen 1 variables --------
  final formKey = GlobalKey<FormState>();
  TextEditingController auditionDescriptionController = TextEditingController();

  List<AuditionPropertyModel> lookingForModel = [];

  bool? isExperienceNeeded;
  bool? isTrainingNeeded;
  bool? isRepresented;

  TextEditingController minAgeController = TextEditingController();
  TextEditingController maxAgeController = TextEditingController();
  TextEditingController minWeightController = TextEditingController();
  TextEditingController maxWeightController = TextEditingController();
  TextEditingController minHeightController = TextEditingController();
  TextEditingController maxHeightController = TextEditingController();

  List<AuditionPropertyModel> eyeColorModelList = [];
  List<AuditionPropertyModel> hairColorModelList = [];

  List<AuditionPropertyModel> painsSizeModelList = [];

  List<AuditionPropertyModel> shirtSizeModelList = [];
  List<AuditionPropertyModel> shoeSizeModelList = [];

  // ----------  --------

// ---- call api -- get data --------
  getAuditionDetailById(
    int auditionId, {
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    auditionRepository.getAuditionDetailById({'id': auditionId}).then((value) {
      if (value.success == true) {
        auditionDetailsModel = value;
        isLoading = false;
        notifyListeners();
        initializeValriable();
      } else {
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

// - ----- intitalize variables ----
  Future<void> initializeValriable() async {
    auditionDescriptionController.text =
        auditionDetailsModel.data?.description ?? "";

    for (LookingFor item in auditionDetailsModel.data?.lookingFor ?? []) {
      lookingForModel.add(AuditionPropertyModel(
          item.name ?? "", item.isSelected == 0 ? false : true,
          id: item.id));
    }
    isExperienceNeeded =
        auditionDetailsModel.data?.workExperience == 1 ? true : false;
    isTrainingNeeded =
        auditionDetailsModel.data?.professionalTraining == 1 ? true : false;
    isRepresented =
        auditionDetailsModel.data?.candidateRepresentation == 1 ? true : false;
    minAgeController.text = '${auditionDetailsModel.data?.ageRangeMin ?? 0}';
    maxAgeController.text = '${auditionDetailsModel.data?.ageRangeMax ?? 0}';
    minWeightController.text =
        '${auditionDetailsModel.data?.weightRangeMin ?? 0}';
    maxWeightController.text =
        '${auditionDetailsModel.data?.weightRangeMax ?? 0}';
    minHeightController.text =
        '${auditionDetailsModel.data?.heightRangeMin ?? 0}';
    maxHeightController.text =
        '${auditionDetailsModel.data?.heightRangeMax ?? 0}';

    for (NameSelectedAttrButeModel item
        in auditionDetailsModel.data?.eyeColor ?? []) {
      eyeColorModelList.add(AuditionPropertyModel(
          id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    }
    for (NameSelectedAttrButeModel item
        in auditionDetailsModel.data?.hairColor ?? []) {
      hairColorModelList.add(AuditionPropertyModel(
          item.name ?? "", item.isSelected == "1" ? true : false,
          id: item.id));
    }
    for (NameSelectedAttrButeModel item
        in auditionDetailsModel.data?.pantSize ?? []) {
      painsSizeModelList.add(AuditionPropertyModel(
          id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    }
    for (NameSelectedAttrButeModel item
        in auditionDetailsModel.data?.shirtSize ?? []) {
      shirtSizeModelList.add(AuditionPropertyModel(
          id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    }
    for (NameSelectedAttrButeModel item
        in auditionDetailsModel.data?.shoeSize ?? []) {
      shoeSizeModelList.add(AuditionPropertyModel(
          id: item.id, item.name ?? "", item.isSelected == "1" ? true : false));
    }

    notifyListeners();
  }

  //-------- toggle ---------
  toggelWorkExperience(bool val) {
    isExperienceNeeded = val;
    notifyListeners();
  }

  toggelTrainingNeeded(bool val) {
    isTrainingNeeded = val;
    notifyListeners();
  }

  toggelRepresented(bool val) {
    isRepresented = val;
    notifyListeners();
  }

  // -- select all btn click
  selectAll(item) {
    item.isSelect = true;
    notifyListeners();
  }

  // --- page 1 next btn click     ----

  Future<void> nextBtnClick(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;


    // AppLogger.logD("provider.shoeSizeModelList ${shoeSizeModelList.length}");
    // AppLogger.logD("provider.shoeSizeModelList ${shoeSizeModelList[0].id}");
    // AppLogger.logD("provider.shoeSizeModelList ${shoeSizeModelList[1].id}");
    Navigator.pushNamed(context, RouteName.editAuditionPlaceTimeScreen,
        arguments: {
          "editAuditionScreen1DataModel": EditAuditionScreen1DataModel(
              description: auditionDescriptionController.text,
              lookingForModelList: lookingForModel,
              isExperienceNeeded: isExperienceNeeded ?? false,
              isTrainingNeeded: isTrainingNeeded ?? false,
              isRepresented: isRepresented ?? false,
              minAge: minAgeController.text,
              maxAge: maxAgeController.text,
              minWeight: minWeightController.text,
              maxWeight: maxWeightController.text,
              minHeight: minHeightController.text,
              maxHeight: maxHeightController.text,
              eyeColorModelList: eyeColorModelList,
              hairColorModelList: hairColorModelList,
              painsSizeModelList: painsSizeModelList,
              shirtSizeModelList: shirtSizeModelList,
              shoeSizeModelList: shoeSizeModelList,
              auditionDetailsModelInitialData: auditionDetailsModel),
        });
  }
}
