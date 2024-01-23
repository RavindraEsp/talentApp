// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/editAudition/model/adition_details_model.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_sceen1_model.dart';
import 'package:talent_app/network/repository/audition_repository.dart';
import 'package:talent_app/utilities/common.dart';

import 'package:google_maps_webservice/places.dart';
class EditAuditionPlaceTimeScreenProvider extends ChangeNotifier {
  final AuditionRepository auditionRepository = AuditionRepository();
  bool isLoading = false;

  String? location;
  double? lat;
  double? lng;

  final List<Marker> markers = <Marker>[];


  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  // scren 1
  late EditAuditionScreen1DataModel editAuditionScreen1DataModel;


   CameraPosition? initialCameraPosition;

  Future<void> intializeSceen1Data(EditAuditionScreen1DataModel data) async {
    editAuditionScreen1DataModel = data;

    await intializeScreen2Variable();
  }

  Future<void> intializeScreen2Variable() async {
    // auditionLocationController.text = editAuditionScreen1DataModel
    //         .auditionDetailsModelInitialData.data?.location ??
    //     "";
    location = editAuditionScreen1DataModel
            .auditionDetailsModelInitialData.data?.location ?? "";

   lat = double.parse(editAuditionScreen1DataModel
       .auditionDetailsModelInitialData.data?.latitude ?? "0.0");

    lng = double.parse(editAuditionScreen1DataModel
        .auditionDetailsModelInitialData.data?.longitude ?? "0.0");

    dateTimeList = await getDateTimeListData(); // spot time init

    initialCameraPosition =  CameraPosition(
        tilt: 50, target: LatLng(
      lat ?? 0.0 , lng ?? 0.0

    ), zoom: 15);
    addMarker();


  }



  openPicker(
      BuildContext context,
      EditAuditionPlaceTimeScreenProvider
      editAuditionPlaceTimeScreenProvider) async {
    Prediction? p = await PlacesAutocomplete.show(
        offset: 0,
        radius: 1000,
        types: [],
        strictbounds: false,
        region: "ar",
        context: context,
        apiKey: "AIzaSyC0apFqdYGTRVuRDkuD7AurpXUVk-IZy3w",
        mode: Mode.overlay,
        language: "en",
        components: [Component(Component.country, "ind")]);

    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: "AIzaSyC0apFqdYGTRVuRDkuD7AurpXUVk-IZy3w",
      ); //Same API_KEY as above
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId!);

      Map<String, dynamic> data;

      if (detail.result.addressComponents.isNotEmpty) {
        var selectLocation = p.description!;

        editAuditionPlaceTimeScreenProvider.location = selectLocation;

        editAuditionPlaceTimeScreenProvider.lat =
            detail.result.geometry?.location.lat.toDouble() ?? 0.0;
        editAuditionPlaceTimeScreenProvider.lng =
            detail.result.geometry?.location.lng.toDouble() ?? 0.0;

        AppLogger.logD(
            "Lat long is - ${editAuditionPlaceTimeScreenProvider.lat} ${editAuditionPlaceTimeScreenProvider.lng}");
        AppLogger.logD("selectLocation - $selectLocation");

        addMarker();


      }
    }
  }

  addMarker() {
    markers.clear();

    markers.add(Marker(
      // given marker id
      markerId: const MarkerId("0"),
      position: LatLng(lat!,
          lng!),
      infoWindow: const InfoWindow(

      ),
    ));
    notifyListeners();
    _goToTheLake();
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controllerLocal = await controller.future;
    await controllerLocal
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat ?? 0,
          lng ?? 0), // New map center
      zoom: 15.0, // New zoom level
    )));

  }



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

  // Future<void> datetimespotRowValueAdd() async {
  //   if (dateController.text.isNotEmpty &&
  //       timeController.text.isNotEmpty &&
  //       spotsController.text.isNotEmpty) {
  //     dateTimeList.add(DateTimeModel(
  //         dateController.text, timeController.text, spotsController.text));
  //
  //     dateController.clear();
  //     timeController.clear();
  //     spotsController.clear();
  //   }
  //   notifyListeners();
  // }

  Future<void> updateBtnClick({required BuildContext context,
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,}) async {
 //   await datetimespotRowValueAdd();
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
     // "location": auditionLocationController.text,
      "location": location,

      "latitude": lat,
      "longitude": lng,

      "auditionTalentdata": ganareteIdListFromModel(
              editAuditionScreen1DataModel.eyeColorModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.hairColorModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.painsSizeModelList) +
          ganareteIdListFromModel(
              editAuditionScreen1DataModel.shirtSizeModelList) +
          ganareteIdListFromModel(editAuditionScreen1DataModel
              .shoeSizeModelList), // [  3 ],       // selectedEyeIds ,selectedHairColorIds ,selectedPansSizeIds ,selectedShirtSizeIds ,selectedShoeSizeIds
      "auditionDates": ganareteAuditionDateTimeSpotsList(
          dateTimeList), // [    {"date": "10-04-2023", "time": "07:14:52", "spot": "2"}]
    };

    print('update audition api perms ===>$request');
    print(
        'date time perms auditionDates---->${ganareteAuditionDateTimeSpotsList(dateTimeList)}');
    await auditionRepository.updateAudition(request).then((value) async {
      if (value.success == true) {
        onSuccess.call("");
        // Navigator.pop(context);
        // Navigator.pop(context);
        // await showAuditionAuditionCreateSuccessDialog(context: context);
      } else {
        Common.showErrorSnackBar(context, value.msg ?? "");
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      Common.showErrorSnackBar(context, error.toString());
      onFailure.call(error.toString());
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
