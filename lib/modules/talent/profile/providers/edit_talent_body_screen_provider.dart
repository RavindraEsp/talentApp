import 'package:flutter/cupertino.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_response_model.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_edit_response_model.dart';
import 'package:talent_app/network/repository/auth_repository.dart';

class EditTalentBodyScreenProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

 // TalentBodyResponseModel talentBodyResponseModel = TalentBodyResponseModel();
  TalentBodyEditResponseMode talentBodyEditResponseModel = TalentBodyEditResponseMode();

  // EyeColorArr? selectEyeColor;
  // EyeColorArr? selectHairColor;
  //
  // EyeColorArr? selectShirtSize;
  // EyeColorArr? selectPansSize;
  // EyeColorArr? selectShoeSize;


  bool isLoading = true;

  List<int> talentBodyData = [];

  fetchTalentBody({
    required ValueChanged<TalentBodyEditResponseMode> onSuccess,
    required ValueChanged<String> onFailure,
  }) async {
    await authRepository.getTalentBodyDynamic().then((value) {
      isLoading = true;
      if (value.success == true) {
        talentBodyEditResponseModel = value;
        setAutofillValue();
        onSuccess.call(talentBodyEditResponseModel);
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


  setAutofillValue(){


    talentBodyEditResponseModel.data!.bodyDetail?.forEach((bodyDetail) {

      bodyDetail.bodyData?.forEach((bodyData) {
        if(bodyData.value == true){
          bodyDetail.selectDropDown = bodyData;
        }
      });
    });


  }



  bool setTalentBodyArrayData() {

    talentBodyData = [];
    talentBodyEditResponseModel.data!.bodyDetail?.forEach((bodyDetail) {
      if(bodyDetail.selectDropDown != null){
        talentBodyData.add(bodyDetail.selectDropDown?.id ?? 0);
      }

    });

    AppLogger.logD("Body data $talentBodyData");
    return true;

  }

  updateTalentProfileData(
      {required ValueChanged<String> onSuccess,
        required ValueChanged<String> onFailure,
        required int id}) async {
    Map<String, dynamic>? rawData;

    AppLogger.logD("talentBodyData is $talentBodyData");

    rawData = {"id": id,
      "profileTalentdata": talentBodyData};

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

  updateUi() {
    notifyListeners();
  }

}
