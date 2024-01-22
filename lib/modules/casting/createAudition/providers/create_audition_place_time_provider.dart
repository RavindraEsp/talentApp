import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class CreateAuditionPlaceTimeProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  List<DateTimeModel> dateTimeList = [];
 // TextEditingController auditionLocationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController spotsController = TextEditingController();

  // double lat = 22.7533;
  // double lng = 75.8937;

  String? location;
  double? lat;
  double? lng;



  List<Map<String, dynamic>> auditionDateTimeSpotsList = [];

  createAudition({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required String description,
    required String workExperience,
    required String professionalTraining,
    required String candidateRepresentation,
    required String ageRangeMin,
    required String ageRangeMax,
    required String weightRangeMin,
    required String weightRangeMax,
    required String heightRangeMin,
    required String heightRangeMax,
    required List<int> auditionTalentdata,
    required List<int> careerTag
  }) {
    auditionDateTimeSpotsList = [];

    for (var a = 0; a < (dateTimeList?.length ?? 0); a++) {
      auditionDateTimeSpotsList.add(
        {
          "date": dateTimeList[a].date,
          "time": dateTimeList[a].time,
          "spot": dateTimeList[a].spots,
        },
      );
    }

    AppLogger.logD("data is $auditionDateTimeSpotsList");

    Map<String, dynamic> request = {
      "description": description,
      "workExperience": workExperience,
      "professionalTraining": professionalTraining,
      "candidateRepresentation": candidateRepresentation,
      "ageRangeMin": ageRangeMin,
      "ageRangeMax": ageRangeMax,
      "weightRangeMin": weightRangeMin,
      "weightRangeMax": weightRangeMax,
      "heightRangeMin": heightRangeMin,
      "heightRangeMax": heightRangeMax,
      "auditionTalentdata": auditionTalentdata,
      "careerTag": careerTag,
      "location": location,
      "latitude": lat,
      "longitude": lng,
      "auditionDates": auditionDateTimeSpotsList
    };

    auditionRepository.createAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call("${value.msg}" ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");

      onFailure.call(error.toString());
    });
  }

  removeDateTimeSpots(int index) {
    dateTimeList.removeAt(index);
    notifyListeners();
  }
}
