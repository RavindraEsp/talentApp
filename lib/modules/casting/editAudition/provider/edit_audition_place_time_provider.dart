// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_sceen1_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:talent_app/utilities/common.dart';

class EditAuditionPlaceTimeScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();
  bool isLoading = false;

  // scren 1
  late EditAuditionScreen1DataModel editAuditionScreen1DataModel;

  Future<void> intializeSceen1Data(EditAuditionScreen1DataModel data) async {
    editAuditionScreen1DataModel = data;

    await intializeScreen2Variable();
  }

  Future<void> intializeScreen2Variable() async {
    auditionLocationController.text = editAuditionScreen1DataModel
            .auditionDetailsModelInitialData.data?.location ??
        "";
  }

  // ----- page 2 variable

  TextEditingController auditionLocationController = TextEditingController();

  List<DateTimeModel> dateTimeList = [];

  List<int> ganareteIdListFromModel(List<AuditionPropertyModel> listCome) {
    List<int> eyeList = [];
    for (AuditionPropertyModel element in listCome) {
      if (element.isSelect) {
        eyeList.add(element.id ?? 0);
      }
    }

    return eyeList;
  }

  Future<void> updateBtnClick(BuildContext context) async {
    Map<String, dynamic> request = {
      // "id": "3",
      // "description": "Hello first autdition update",
      // "careerTag": ["2"],
      // "workExperience": "1",
      // "professionalTraining": "0",
      // "candidateRepresentation": "1",
      // "ageRangeMin": "10",
      // "ageRangeMax": "40",
      // "weightRangeMin": "20",
      // "weightRangeMax": "50",
      // "heightRangeMin": "10",
      // "heightRangeMax": "20",
      // "eyeColor": ["1", "2"],
      // "hairColor": ["2"],
      // "pantSize": ["2"],
      // "shirtSize": ["2"],
      // "shoeSize": [1],
      // "location": "indore",
      // "auditionTalentdata": [3],
      // "auditionDates": [
      //   {"date": "10-04-2023", "time": "07:14:52", "spot": "2"}
      // ]
      "id":
          editAuditionScreen1DataModel.auditionDetailsModelInitialData.data?.id,
      "description": editAuditionScreen1DataModel.description,
      "careerTag": ["2"], // looking for hai ye
      "workExperience":
          editAuditionScreen1DataModel.isExperienceNeeded == true ? "1" : "0",
      "professionalTraining":
          editAuditionScreen1DataModel.isTrainingNeeded == true ? "1" : "0",
      "candidateRepresentation":
          editAuditionScreen1DataModel.isRepresented == true ? "1" : "0",
      "ageRangeMin": editAuditionScreen1DataModel.minAge,
      "ageRangeMax": editAuditionScreen1DataModel.maxAge,
      "weightRangeMin": editAuditionScreen1DataModel.minWeight,
      "weightRangeMax": editAuditionScreen1DataModel.maxWeight,
      "heightRangeMin": editAuditionScreen1DataModel.minHeight,
      "heightRangeMax": editAuditionScreen1DataModel.maxHeight,
      "eyeColor": ganareteIdListFromModel(
          editAuditionScreen1DataModel.eyeColorModelList), // ["1", "2"],
      "hairColor": ganareteIdListFromModel(
          editAuditionScreen1DataModel.hairColorModelList), // ["2"],
      "pantSize": ganareteIdListFromModel(
          editAuditionScreen1DataModel.painsSizeModelList), // ["2"],
      "shirtSize": ganareteIdListFromModel(
          editAuditionScreen1DataModel.shirtSizeModelList), //["2"],
      "shoeSize": ganareteIdListFromModel(
          editAuditionScreen1DataModel.shirtSizeModelList), // [1],
      "location": auditionLocationController.text,
      "auditionTalentdata": [3],
      "auditionDates": [
        {"date": "10-04-2023", "time": "07:14:52", "spot": "2"}
      ]
    };

    await auditionRepository.updateAudition(request).then((value) {
      if (value.success == true) {
        Navigator.pop(context);
        showAuditionAuditionCreateSuccessDialog(context: context);
      } else {
        Common.showErrorSnackBar(context, value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      Common.showErrorSnackBar(context, error.toString());
    });
  }
}
