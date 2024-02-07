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



    // //set eye color
    // talentBodyResponseModel.data!.eyeColorArr?.forEach((element) {
    //   if(element.value == true){
    //     selectEyeColor = element;
    //   }
    // });
    //
    // //set hair color
    // talentBodyResponseModel.data!.hairColorArr?.forEach((element) {
    //   if(element.value == true){
    //     selectHairColor = element;
    //   }
    // });
    //
    // //set shirt size
    // talentBodyResponseModel.data!.shirtSizeArr?.forEach((element) {
    //   if(element.value == true){
    //     selectShirtSize = element;
    //   }
    // });
    //
    // //set Paints size
    // talentBodyResponseModel.data!.pantSizeArr?.forEach((element) {
    //   if(element.value == true){
    //     selectPansSize = element;
    //   }
    // });
    //
    // //set Shoe size
    // talentBodyResponseModel.data!.shoeSizeArr?.forEach((element) {
    //   if(element.value == true){
    //     selectShoeSize = element;
    //   }
    // });

  }



  bool setTalentBodyArrayData() {

    talentBodyData = [];
    talentBodyEditResponseModel.data!.bodyDetail?.forEach((bodyDetail) {
      if(bodyDetail.selectDropDown != null){
        talentBodyData.add(bodyDetail.selectDropDown?.id ?? 0);
      }

    });



    // if(selectEyeColor != null){
    //   talentBodyData.add(selectEyeColor?.id ?? 0);
    // }
    // if(selectHairColor != null){
    //   talentBodyData.add(selectHairColor?.id ?? 0);
    // }
    //
    // if(selectPansSize != null){
    //   talentBodyData.add(selectPansSize?.id ?? 0);
    // }
    // if(selectShirtSize != null){
    //   talentBodyData.add(selectShirtSize?.id ?? 0);
    // }
    // if(selectShoeSize != null){
    //   talentBodyData.add(selectShoeSize?.id ?? 0);
    // }
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
