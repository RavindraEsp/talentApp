import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_place_time_provider.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/date_time_row_widget.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';
import 'package:google_maps_webservice/places.dart';





class CreateAuditionPlaceTimeScreen extends StatefulWidget {
  final List<int> auditionTalentAllData;
  final List<int> careerTag;

  final String description;
  final String workExperience;
  final String professionalTraining;
  final String candidateRepresentation;
  final String ageRangeMin;
  final String ageRangeMax;
  final String weightRangeMin;
  final String weightRangeMax;
  final String heightRangeMin;
  final String heightRangeMax;

  const CreateAuditionPlaceTimeScreen(
      {super.key,
      required this.description,
      required this.workExperience,
      required this.professionalTraining,
      required this.candidateRepresentation,
      required this.ageRangeMin,
      required this.ageRangeMax,
      required this.weightRangeMin,
      required this.weightRangeMax,
      required this.heightRangeMin,
      required this.heightRangeMax,
      required this.careerTag,
      required this.auditionTalentAllData});

  @override
  State<CreateAuditionPlaceTimeScreen> createState() =>
      _CreateAuditionPlaceTimeScreenState();
}

class _CreateAuditionPlaceTimeScreenState
    extends State<CreateAuditionPlaceTimeScreen> {
  final _formKey = GlobalKey<FormState>();


  final List<Marker> _markers = <Marker>[];

  String? location;
  double? lat;
  double? lng;

  late CameraPosition initialCameraPosition;

  //
  // Future<void> _handlePressButton(BuildContext context) async {
  //   // show input autocomplete with selected mode
  //   // then get the Prediction selected
  //   Prediction? p = await PlacesAutocomplete.show(
  //     // offset: 0,
  //     // radius: 1000,
  //      types: [],
  //     strictbounds: false,
  //
  //
  //     context: context,
  //     apiKey: "AIzaSyC0apFqdYGTRVuRDkuD7AurpXUVk-IZy3w",
  //    // onError: onError,
  //     mode: Mode.overlay,
  //     language: "en",
  //
  //
  //    // components: [Component(Component.country, "fr")],
  //     components: [Component(Component.country, "ind")],
  //   );
  //
  //   AppLogger.logD("data $p");
  //
  //  // displayPrediction(p, homeScaffoldKey.currentState);
  // }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  openPicker(BuildContext context,CreateAuditionPlaceTimeProvider createAuditionPlaceTimeProvider) async {
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
        // for (var i = 0; i < detail.result.addressComponents.length; i++) {
        //   for (var j = 0;
        //   j < detail.result.addressComponents[i].types.length;
        //   j++) {
        //    // Log.logData(detail.result.addressComponents[i].types[j]);
        //     if (detail.result.addressComponents[i].types[j] == 'postal_code') {
        //       var getPostalCode = detail.result.addressComponents[i].longName;
        //     }
        //     if (detail.result.addressComponents[i].types[j] == 'locality') {
        //       var getCity = detail.result.addressComponents[i].longName;
        //     }
        //     if (detail.result.addressComponents[i].types[j] == 'adminArea') {
        //       var getState = detail.result.addressComponents[i].longName;
        //     }
        //   }
        // }

        var  selectLocation = p.description!;

        createAuditionPlaceTimeProvider
            .auditionLocationController.text = selectLocation;

        location = selectLocation;
        //
        // Log.logData("Selected location is - $selectLocation");
        //
          lat = detail.result.geometry?.location.lat.toDouble() ?? 0.0;
          lng = detail.result.geometry?.location.lng.toDouble() ?? 0.0;


        // setMarkers();


         AppLogger.logD("Lat long is - $lat $lng");
         AppLogger.logD("selectLocation - $selectLocation");

        addMarker();
         setState(() {

         });
        // Log.logData(latt);
        // Log.logData(lngg);
        // notifyListeners();
      }
    }
  }

  addMarker(){

    _markers.clear();

    _markers.add(
         Marker(
          // given marker id
          markerId: const MarkerId("0"),
          // given marker icon
          // given position
         // position: LatLng(22.719568, 75.857727),
          position: LatLng(lat!, lng!),
          infoWindow: const InfoWindow(
            // given title for marker
            // title: 'Location: '+i.toString(),
          ),
        )
    );

    _goToTheLake();

  }


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat ?? 0, lng ?? 0), // New map center
      zoom: 15.0, // New zoom level
    )));
  }







  // GestureDetector(
  // onTap: () async {
  // await provider.openPicker(context);
  // },
  // child: Container(
  // height: TextSizeUtility.dropdownHeight,
  // width: double.infinity,
  // decoration: BoxDecoration(
  // color: ColorUtility.whiteTextColor,
  // borderRadius: BorderRadius.circular(10.r),
  // ),
  // // padding: EdgeInsets.only(left: 5),
  // child: Row(
  // children: [
  // Container(width: 10.w),
  // Expanded(
  // child: Text(
  // provider.latt == null
  // ? context.loc.hint_select_location
  //     : provider.selectLocation ?? "",
  // style: provider.latt == null
  // ? StyleUtility.hintTextStyle
  //     : StyleUtility.inputTextStyle,
  // maxLines: 1,
  // ),
  // ),
  // Padding(
  // padding: EdgeInsets.only(right: 8.w),
  // child: Image.asset(
  // ImageUtility.iconDown,
  // width: 12.sp,
  // ),
  // ),
  // Container(width: 2.w),
  // ],
  // ),
  // )),




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppLogger.logD("description ${widget.description}");
    AppLogger.logD("workExperience ${widget.workExperience}");
    AppLogger.logD("professionalTraining ${widget.professionalTraining}");
    AppLogger.logD("candidateRepresentation ${widget.candidateRepresentation}");
    AppLogger.logD("ageRangeMin ${widget.ageRangeMin}");
    AppLogger.logD("ageRangeMax ${widget.ageRangeMax}");
    AppLogger.logD("weightRangeMin ${widget.weightRangeMin}");
    AppLogger.logD("weightRangeMax ${widget.weightRangeMax}");
    AppLogger.logD("heightRangeMin ${widget.heightRangeMin}");
    AppLogger.logD("heightRangeMax ${widget.heightRangeMax}");
    AppLogger.logD("careerTag ${widget.careerTag}");
    AppLogger.logD("auditionTalentAllData ${widget.auditionTalentAllData}");


    initialCameraPosition = const CameraPosition(
            tilt: 50,
            target: LatLng(22.719568, 75.857727),
            zoom: 15);
    // _markers.add(
    //     const Marker(
    //       // given marker id
    //       markerId: MarkerId("0"),
    //       // given marker icon
    //       // given position
    //       position: LatLng(22.719568, 75.857727),
    //       infoWindow: InfoWindow(
    //         // given title for marker
    //        // title: 'Location: '+i.toString(),
    //       ),
    //     )
    // );

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAuditionPlaceTimeProvider>(
        builder: (context, createAuditionPlaceTimeProvider, child) {
      return Scaffold(
        backgroundColor: ColorUtility.colorWhite,
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: 20.h, top: 20.h, left: 20.w, right: 20.w),
          child: Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                    buttonText: context.loc.buttonBack,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonColor: ColorUtility.color5457BE),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: CustomButton(
                //  buttonText: context.loc.buttonPublish,
                  buttonText:
                  createAuditionPlaceTimeProvider.dateTimeList.isEmpty
                      ? context.loc.buttonNext
                      : context.loc.buttonPublish,
                  buttonType: ButtonType.yellow,
                  onTap: () {

                    CommonMethod.hideKeyBoard(context);

                    if (createAuditionPlaceTimeProvider
                        .auditionLocationController.text.isEmpty) {
                      Common.showErrorSnackBar(context, StringsUtility.validationLocation);
                    } else if (createAuditionPlaceTimeProvider
                        .dateTimeList.isEmpty) {
                      Common.showErrorSnackBar(
                          context, StringsUtility.validationAddDAteTime);
                    } else {
                      Common.showLoadingDialog(context);
                      createAuditionPlaceTimeProvider.createAudition(
                        onSuccess: (msg) {
                          Navigator.pop(context);
                          showAuditionAuditionCreateSuccessDialog(
                              context: context);
                        },
                        onFailure: (msg) {
                          Common.showErrorSnackBar(context, msg);
                        },
                        description: widget.description,
                        workExperience: widget.workExperience,
                        professionalTraining: widget.professionalTraining,
                        candidateRepresentation: widget.candidateRepresentation,
                        ageRangeMin: widget.ageRangeMin,
                        ageRangeMax: widget.ageRangeMax,
                        weightRangeMin: widget.weightRangeMin,
                        weightRangeMax: widget.weightRangeMax,
                        heightRangeMin: widget.heightRangeMin,
                        heightRangeMax: widget.heightRangeMax,
                        auditionTalentdata: widget.auditionTalentAllData,
                        careerTag: widget.careerTag,
                      );
                    }

                    // showAuditionAuditionCreateSuccessDialog(context: context);
                  },
                ),
              )
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              CommonMethod.hideKeyBoard(context);
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.r),
                          bottomRight: Radius.circular(40.r)),
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            ColorUtility.color1B215C,
                            ColorUtility.color263287,
                            ColorUtility.color857784,
                            ColorUtility.colorEFC275,
                          ])),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 18.w,
                          right: 18.w,
                          // top: 24.h, bottom: 24.h
                          top: 14.h,
                          bottom: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SettingButtonWidget(),
                          Row(
                            children: [
                              const BackButton(
                                color: Colors.white,
                              ),
                              Text(
                                context.loc.headerCreateAnAudition,
                                style: StyleUtility
                                    .kantumruyProSMedium18TextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize18.sp),
                              ),
                            ],
                          ),
                          const MenuButtonWidget()
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.titleAuditionLocation,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          // GestureDetector(
                          //   onTap: (){
                          //    // _handlePressButton(context);
                          //     openPicker(context,createAuditionPlaceTimeProvider); // us
                          //   },
                          //     child: Text("Picker")),
                          SimpleTextField(
                            controller: createAuditionPlaceTimeProvider
                                .auditionLocationController,
                            hintText: "Location picker",
                            maxLine: 1,
                            // suffixImage: ImageUtility.dropDownArrowIcon,
                            // onPrefixIconTap: (){
                            //
                            //   // _handlePressButton(context);
                            //   openPicker(context,createAuditionPlaceTimeProvider); // us
                            //
                            // },


                          ),



                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         location ??
                          //
                          //         "Select Location",style: StyleUtility.inputTextStyle.copyWith(
                          //         fontSize: TextSizeUtility.textSize15.sp,
                          //       ),),
                          //     ),
                          //     SizedBox(
                          //       width: 25.w,
                          //     ),
                          //
                          //     GestureDetector(
                          //       onTap: (){
                          //         openPicker(context, createAuditionPlaceTimeProvider);
                          //       },
                          //         child: Icon(Icons.arrow_drop_down_circle_outlined,size: 25.sp,color: Colors.black,))
                          //   ],
                          // ),



                          SizedBox(height: 15.h),
                          SizedBox(
                            height: 170.sp,
                            child: GoogleMap(
                              initialCameraPosition:  initialCameraPosition,
                              markers: Set<Marker>.of(_markers),
                             // onMapCreated: (GoogleMapController controller) {},

                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                          SizedBox(height: 36.h),
                          Text(
                            context.loc.createAuditionDateTimeDesc,
                            style: StyleUtility.quicksandRegularBlackTextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Center(
                                      child: Text(
                                    context.loc.titleDate,
                                    style: StyleUtility
                                        .quicksandSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize15),
                                  ))),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Text(
                                    context.loc.titleTime,
                                    style: StyleUtility
                                        .quicksandSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize15),
                                  ))),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Text(
                                    context.loc.titleSpots,
                                    style: StyleUtility
                                        .quicksandSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize15),
                                  ))),
                              SizedBox(
                                width: 7.w,
                              ),
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: createAuditionPlaceTimeProvider
                                      .dateTimeList.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: DateTimeRowWidget(
                                        onRemoveIconTap: () {
                                          createAuditionPlaceTimeProvider
                                              .removeDateTimeSpots(index);
                                        },
                                        date: createAuditionPlaceTimeProvider
                                                .dateTimeList[index].date ??
                                            "",
                                        time:
                                        createAuditionPlaceTimeProvider
                                                .dateTimeList[index].time ??
                                            "",
                                        spots: createAuditionPlaceTimeProvider
                                                .dateTimeList[index].spots ??
                                            ""));
                              }),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      Common.selectDate(
                                          context,
                                          createAuditionPlaceTimeProvider
                                              .dateController);
                                    },
                                    child: SimpleTextField(
                                        controller:
                                            createAuditionPlaceTimeProvider
                                                .dateController,
                                        hintText: "DD/MM/YYYY",
                                        isEnable: false
                                        // suffixImage: ImageUtility.calenderIcon,
                                        ),
                                  )),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                      Common.selectTime(
                                          context,
                                          createAuditionPlaceTimeProvider
                                              .timeController);
                                    },
                                    child: SimpleTextField(
                                        controller:
                                            createAuditionPlaceTimeProvider
                                                .timeController,
                                        hintText: "00:00",
                                        isEnable: false),
                                  )),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: SimpleTextField(
                                    controller: createAuditionPlaceTimeProvider
                                        .spotsController,
                                    hintText: "0",
                                    textInputType: TextInputType.number,
                                  )),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (createAuditionPlaceTimeProvider.dateController.text.isNotEmpty &&
                                          createAuditionPlaceTimeProvider
                                              .timeController.text.isNotEmpty &&
                                          createAuditionPlaceTimeProvider
                                              .spotsController
                                              .text
                                              .isNotEmpty) {
                                        createAuditionPlaceTimeProvider.dateTimeList
                                            ?.add(DateTimeModel(
                                                createAuditionPlaceTimeProvider
                                                    .dateController.text,
                                                createAuditionPlaceTimeProvider
                                                    .timeController.text,
                                                createAuditionPlaceTimeProvider
                                                    .spotsController.text));

                                        createAuditionPlaceTimeProvider
                                            .dateController
                                            .clear();
                                        createAuditionPlaceTimeProvider
                                            .timeController
                                            .clear();
                                        createAuditionPlaceTimeProvider
                                            .spotsController
                                            .clear();
                                      } else {
                                        Common.showErrorSnackBar(context,
                                            context.loc.dateTimeAddValidation);
                                      }

                                      createAuditionPlaceTimeProvider
                                          .notifyListeners();

                                      //   setState(() {});
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color:
                                                    ColorUtility.color5457BE)),
                                        child: Center(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15.sp, bottom: 15.sp),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 15.sp,
                                                  color:
                                                      ColorUtility.color5457BE,
                                                )))),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}




Future<dynamic> showAuditionAuditionCreateSuccessDialog({
  required BuildContext context,
}) {
  return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SuccessAlertDialog(
          title: context.loc.dialogGoodJob,
          description: context.loc.dialogCreateAuditionSuccessDesc,
          onCrossTap: () {},
        );
      }).then((value) {

    Navigator
        .pushNamedAndRemoveUntil(
        context,
        RouteName
            .castBottomBarScreen,
        arguments: {
          "selectIndex": 0
        },
            (route) => false);
  });
}
