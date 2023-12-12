// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
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

    dateTimeList = await getDateTimeListData(); // spot time init
    notifyListeners();
  }

  // ----- page 2 variable

  TextEditingController auditionLocationController = TextEditingController();

  List<DateTimeModel> dateTimeList = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController spotsController = TextEditingController();

  // ------------

  Future<List<DateTimeModel>> getDateTimeListData() async {
    List<DateTimeModel> dateTimeList1 = [];

    for (AuditionDates element in editAuditionScreen1DataModel
            .auditionDetailsModelInitialData.data?.auditionDates ??
        []) {
      dateTimeList1.add(DateTimeModel(
          element.date ?? '', element.time ?? '', element.spot.toString()));
    }
    return dateTimeList1;
  }

  Future<void> datetimespotPlusBtnClick(BuildContext context) async {
    if (dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        spotsController.text.isNotEmpty) {
      dateTimeList.add(DateTimeModel(
          dateController.text, timeController.text, spotsController.text));

      dateController.clear();
      timeController.clear();
      spotsController.clear();
    } else {
      Common.showErrorToast(context, "Please Fill All field");
    }

    notifyListeners();
  }

  Future<void> datetimespotRowValueAdd(BuildContext context) async {
    if (dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        spotsController.text.isNotEmpty) {
      dateTimeList.add(DateTimeModel(
          dateController.text, timeController.text, spotsController.text));

      dateController.clear();
      timeController.clear();
      spotsController.clear();
    }
    notifyListeners();
  }

  Future<void> updateBtnClick(BuildContext context) async {
    await datetimespotRowValueAdd(context);
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
      "careerTag": ganareteIdListFromModel(editAuditionScreen1DataModel
          .lookingForModelList), // ["2"], // looking for hai ye
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
      "auditionTalentdata": ganareteIdListFromModel(
              editAuditionScreen1DataModel.eyeColorModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.hairColorModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.painsSizeModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.shirtSizeModelList) +
          ganareteIdListFromModel(editAuditionScreen1DataModel
              .shirtSizeModelList), // [  3 ],       // selectedEyeIds ,selectedHairColorIds ,selectedPansSizeIds ,selectedShirtSizeIds ,selectedShoeSizeIds
      "auditionDates": ganareteAuditionDateTimeSpotsList(
          dateTimeList), // [    {"date": "10-04-2023", "time": "07:14:52", "spot": "2"}]
    };

    print('update audition api perms ===>$request');
    print(
        'date time perms auditionDates---->${ganareteAuditionDateTimeSpotsList(dateTimeList)}');
    await auditionRepository.updateAudition(request).then((value) async {
      if (value.success == true) {
        Navigator.pop(context);
        Navigator.pop(context);
        await showAuditionAuditionCreateSuccessDialog(context: context);
      } else {
        Common.showErrorSnackBar(context, value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      Common.showErrorSnackBar(context, error.toString());
    });
  }

  List<int> ganareteIdListFromModel(List<AuditionPropertyModel> listCome) {
    List<int> eyeList = [];
    for (AuditionPropertyModel element in listCome) {
      if (element.isSelect) {
        eyeList.add(element.id ?? 0);
      }
    }

    return eyeList;
  }

  List<Map<String, dynamic>> ganareteAuditionDateTimeSpotsList(
      List<DateTimeModel> listCome) {
    List<Map<String, dynamic>> auditionDateTimeSpotsList = [];
    for (var a = 0; a < (listCome.length); a++) {
      auditionDateTimeSpotsList.add(
        {
          "date": listCome[a].date,
          "time": listCome[a].time,
          "spot": listCome[a].spots,
        },
      );
    }

    return auditionDateTimeSpotsList;
  }
}
