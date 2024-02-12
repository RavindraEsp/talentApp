import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/education/model/education_list_response_model.dart';
import 'package:talent_app/modules/talent/education/model/fliter_list_response_model.dart';
import 'package:talent_app/network/repository/education_repository.dart';

class EducationListScreenProvider extends ChangeNotifier {
  EducationRepository educationRepository = EducationRepository();
  bool isLoading = false;
  bool filterLoading = false;

  EducationListResponseModel? educationListResponseModel;
  FilterListResponseModel? filterListResponseModel;

  List<int> subjectsIds = [];
  List<int> filterIds = [];
  List<int> levelsIds = [];

  getEducationList({
    required ValueChanged<String> onFailure,
  }) {
    // Map<String, dynamic> data = {
    //   "eduSubIds":[],
    //   "eduFilterIds":[],
    //   "eduLevIds":[]
    // };

    Map<String, dynamic> data = {
      "eduSubIds": subjectsIds,
      "eduFilterIds": filterIds,
      "eduLevIds": levelsIds
    };
    educationListResponseModel = EducationListResponseModel();
    isLoading = true;
    educationRepository.getEducationList(request: data).then((value) {
      if (value.success == true) {
        educationListResponseModel = value;
      } else {
        onFailure.call(value.msg ?? "");
      }
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    });
  }

  filterList({
    required ValueChanged<String> onFailure,
  }) {
    filterLoading = true;
    educationRepository.filterList().then((value) {
      if (value.success == true) {
        filterListResponseModel = value;
      } else {
        onFailure.call(value.msg ?? "");
      }
      filterLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString());
      filterLoading = false;
      notifyListeners();
    });
  }

  getIds(){

    subjectsIds = [];
    levelsIds = [];
    filterIds = [];


     subjectsIds =  filterListResponseModel?.data?.subjects
        ?.where((subject) => subject.isSelect == true)
        .toList().map((e) => e.id ?? 0).toList() ?? [];


     levelsIds =  filterListResponseModel?.data?.levels
     ?.where((level) => level.isSelect == true)
         .toList().map((e) => e.id ?? 0).toList() ?? [];


     filterIds =  filterListResponseModel?.data?.filterby
     ?.where((filterby) => filterby.isSelect == true)
         .toList().map((e) => e.id ?? 0).toList() ?? [];



    AppLogger.logD("Selected Subjects ids ");
    AppLogger.logD(subjectsIds);

     AppLogger.logD("Selected Levels ids ");
     AppLogger.logD(levelsIds);

     AppLogger.logD("Selected Filter ids ");
     AppLogger.logD(filterIds);



    // List<LookingFor>? selectedLookingFor = lookingForModel
    //     ?.where((lookingFor) => lookingFor.isSelect == true)
    //     .toList();
    //
    // selectedLookingForIds =
    //     selectedLookingFor?.map((lookingFo) => lookingFo.id ?? 0).toList();





  }


}
