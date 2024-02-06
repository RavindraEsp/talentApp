import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/talentdata_response_model_new.dart';
//import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class TalentCreateCardStepTwoProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();
  TalentDataResponseModelNew? talentDataResponseModel;




  List<LookingFor>? lookingForModel;

  List<BodyData>? selectValueList = [];

  List<int> talentBodyData = [];
  List<int>? selectedLookingForIds = [];

  bool isLoading = true;


  getTalentData({
    required ValueChanged<String> onFailure,
  }) {
    auditionRepository.getTalentDataForCreateAuditionNew().then((value) {
      if (value.success == true) {
        talentDataResponseModel = value;

        lookingForModel = talentDataResponseModel?.data?.lookingFor;

        isLoading = false;
        notifyListeners();
      } else {
        onFailure.call(value.msg ?? "");
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

  bool setTalentBodyValue() {

    talentBodyData = [];

    for(var a = 0; a< (talentDataResponseModel?.data?.bodyDetail?.length ?? 0); a++){
      if(talentDataResponseModel?.data?.bodyDetail?[a].selectDropDown != null){
        talentBodyData.add(talentDataResponseModel?.data?.bodyDetail?[a].selectDropDown?.id ?? 0);
      }
    }

    return true;

  }
}
