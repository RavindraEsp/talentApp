import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/auditionDetails/model/audition_detail_response_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';

class AuditionDetailsScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();

  bool isLoading = false;
  AuditionDetailResponseModel? auditionDetailResponseModel;

  final List<Marker> markers = <Marker>[];

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();


  geAuditionDetails(
      {required ValueChanged<String> onFailure,
      required int auditionId}) async {
    isLoading = true;
    await auditionRepository
        .geAuditionDetails({"auditionId": auditionId}).then((value) {
      if (value.success == true) {
        auditionDetailResponseModel = value;
        addMarker();
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
      isLoading = false;
      notifyListeners();
    });
  }

  applyAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? casterUserId,
    required int? auditionId,
    required int? auditionDateId,
  }) {
    Map request = {
      "casterUserId": casterUserId,
      "auditionId": auditionId,
      "auditionDateId": auditionDateId
    };
    auditionRepository.applyAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
  }

  rescheduleAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? casterUserId,
    required int? auditionId,
    required int? auditionDateId,
    required int? applyId,
    required int? applyStatus,
  }) {
    Map request = {
      "casterUserId": casterUserId,
      "auditionId": auditionId,
      "auditionDateId": auditionDateId,
      "applyId": applyId,
      "applyStatus": applyStatus
    };
    auditionRepository.rescheduleAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
  }

  withdrawAudition({
    required ValueChanged<String> onFailure,
    required ValueChanged<String> onSuccess,
    required int? appliedId,
  }) {
    Map request = {"appliedId": appliedId};

    auditionRepository.withdrawAudition(request).then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
    notifyListeners();
  }

  addMarker() {


    markers.clear();

    markers.add(Marker(
      // given marker id
      markerId: const MarkerId("0"),
      // given marker icon
      // given position
      position: LatLng(double.parse(auditionDetailResponseModel?.data?.latitude ?? "0.0"),
        double.parse(auditionDetailResponseModel?.data?.longitude ?? "0.0")),
      // position: LatLng(lat!, lng!),
      infoWindow: const InfoWindow(
          // given title for marker
          // title: 'Location: '+i.toString(),
          ),
    ));
  }

  updateUi() {
    notifyListeners();
  }
}
