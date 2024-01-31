import 'package:flutter/material.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class ManageAuditionCreatedScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;

  ManagAuditionCreatedScreenModel? managAuditionCreatedScreenModel;

  AppliedUsers? appliedUser;

  int currentAppliedIndex = 0;

  getCreatedAuditionManage(
    int auditionId, {
    required ValueChanged<String> onFailure,
  }) {
    isLoading = true;
    appliedUser = AppliedUsers();
    managAuditionCreatedScreenModel = ManagAuditionCreatedScreenModel();
    auditionRepository.getcreatedAuditionmanage(
            queryParameters: {'auditionId': auditionId}).then((value) {
      if (value.success == true) {
        managAuditionCreatedScreenModel = value;

        if ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ?? 0) >
            0) {
          appliedUser = managAuditionCreatedScreenModel?.data?.appliedUsers?[0];
        }

        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    })
        //     .onError((error, stackTrace) {
        //   AppLogger.logD("error $error");
        //   onFailure.call("Server Error");
        //   isLoading = false;
        //   notifyListeners();
        // }
        // )
        ;
  }

  Future<void> approveUserAuditionApi({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required int appliedId,
  }) async {
    //  status 1 = approve, 2=reject
    Map<String, dynamic> request = {"appliedId": appliedId, "status": "1"};
    auditionRepository.approveDeclineUserAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString() ?? "");
    });
  }

  Future<void> declineUserAuditionApi({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required int appliedId,
  }) async {
    //  status 1 = approve, 2=reject
    Map<String, dynamic> request = {"appliedId": appliedId, "status": "2"};
    auditionRepository.approveDeclineUserAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("Error $error");
      onFailure.call(error.toString() ?? "");
    });
  }

  Future<void> cancelTheAuditionApi({
    required int id,
    required BuildContext context,
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
  }) async {
    notifyListeners();
    auditionRepository.cancelAudition({"id": id}).then((value) {
      if (value["success"] == true) {
        onSuccess.call("");
      } else {
        onFailure.call(value['msg']);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");

      notifyListeners();
      onFailure.call("Server error");
    });

    notifyListeners();
  }

  Future closeRegistrationApi({
    required int id,
    required BuildContext context,
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
  }) async {
    notifyListeners();
    auditionRepository.closeRegistration({"id": id}).then((value) {
      if (value.success == true) {
        onSuccess.call("");
      } else {
        onFailure.call(value.msg ?? "");
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      notifyListeners();
      onFailure.call("Server error");
    });

    notifyListeners();
  }

  // onNextPress() {
  //   if ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ?? 0) >
  //       currentAppliedIndex + 1) {
  //     currentAppliedIndex = currentAppliedIndex + 1;
  //     appliedUser = managAuditionCreatedScreenModel
  //         ?.data?.appliedUsers?[currentAppliedIndex];
  //     notifyListeners();
  //   }
  // }
  //
  // onBackPress() {
  //   if (currentAppliedIndex != 0) {
  //     currentAppliedIndex = currentAppliedIndex - 1;
  //     appliedUser = managAuditionCreatedScreenModel
  //         ?.data?.appliedUsers?[currentAppliedIndex];
  //     notifyListeners();
  //   }
  // }

  //With scroll

  onNextPress() {
    if ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ?? 0) >
        1) {
      if ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ?? 0) ==
          currentAppliedIndex + 1) {
        currentAppliedIndex = 0;
        appliedUser = managAuditionCreatedScreenModel
            ?.data?.appliedUsers?[currentAppliedIndex];
      } else {
        currentAppliedIndex = currentAppliedIndex + 1;
        appliedUser = managAuditionCreatedScreenModel
            ?.data?.appliedUsers?[currentAppliedIndex];
      }

      notifyListeners();
    }
  }

  onBackPress() {
    if ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ?? 0) >
        1) {
      if (currentAppliedIndex == 0) {
        currentAppliedIndex =
            ((managAuditionCreatedScreenModel?.data?.appliedUsers?.length ??
                    1) -
                1);
        appliedUser = managAuditionCreatedScreenModel
            ?.data?.appliedUsers?[currentAppliedIndex];
      } else {
        currentAppliedIndex = currentAppliedIndex - 1;
        appliedUser = managAuditionCreatedScreenModel
            ?.data?.appliedUsers?[currentAppliedIndex];
      }

      notifyListeners();
    }
  }

  updateUi() {
    notifyListeners();
  }
}
