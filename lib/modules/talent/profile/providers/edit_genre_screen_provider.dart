import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/profile/model/talent_category_response_model.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class EditGenreScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  TalentCategoryResponseModel talentCategoryResponseModel =
      TalentCategoryResponseModel();

  bool isLoading = true;

  List<int>? selectedLookingForIds = [];

  fetchTalentCategory({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
  }) async {
    await authRepository.getTalentCategory().then((value) {
      isLoading = true;
      if (value.success == true) {
        talentCategoryResponseModel = value;
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    isLoading = false;
    notifyListeners();
  }

  bool setCategoryValue() {
    selectedLookingForIds = [];

    List<LookingForArr>? selectedLookingFor = talentCategoryResponseModel
        .data?.lookingForArr
        ?.where((lookingFor) => lookingFor.value == true)
        .toList();

    selectedLookingForIds =
        selectedLookingFor?.map((lookingFo) => lookingFo.id ?? 0).toList();

    AppLogger.logD('Selected Looking List: $selectedLookingForIds');

    return true;
  }

  updateUi() {
    notifyListeners();
  }

  updateTalentProfileData(
      {required ValueChanged<String> onSuccess,
      required ValueChanged<String> onFailure,
      required int id}) async {
    Map<String, dynamic>? rawData;

    AppLogger.logD("Carrer model is $selectedLookingForIds");

    rawData = {"id": id, "careerModel": selectedLookingForIds};

    authRepository.updateTalentProfile(rawData).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString());
    });
  }
}
