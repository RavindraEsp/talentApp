import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_detail_model.dart';

class EditAuditionScreen1DataModel {
  String description;
  List<AuditionPropertyModel> lookingForModelList;
  bool isExperienceNeeded;
  bool isTrainingNeeded;
  bool isRepresented;

  String minAge;
  String maxAge;
  String minWeight;
  String maxWeight;
  String minHeight;
  String maxHeight;
  List<int> auditionTalentAllData;

  // List<AuditionPropertyModel> eyeColorModelList;
  // List<AuditionPropertyModel> hairColorModelList;
  // List<AuditionPropertyModel> painsSizeModelList;
  // List<AuditionPropertyModel> shirtSizeModelList;
  // List<AuditionPropertyModel> shoeSizeModelList;

  EditAuditionDetailModel auditionDetailsModelInitialData;

  EditAuditionScreen1DataModel({
    required this.description,
    required this.lookingForModelList,
    required this.isExperienceNeeded,
    required this.isTrainingNeeded,
    required this.isRepresented,
    required this.minAge,
    required this.maxAge,
    required this.minWeight,
    required this.maxWeight,
    required this.minHeight,
    required this.maxHeight,
    required this.auditionTalentAllData,
    // required this.eyeColorModelList,
    // required this.hairColorModelList,
    // required this.painsSizeModelList,
    // required this.shirtSizeModelList,
    // required this.shoeSizeModelList,
    required this.auditionDetailsModelInitialData,
  });
}
