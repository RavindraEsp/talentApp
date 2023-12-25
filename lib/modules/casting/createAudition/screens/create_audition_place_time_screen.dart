import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_place_time_provider.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_provider.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/date_time_row_widget.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

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

    _markers.add(
        const Marker(
          // given marker id
          markerId: MarkerId("0"),
          // given marker icon
          // given position
          position: LatLng(22.719568, 75.857727),
          infoWindow: InfoWindow(
            // given title for marker
           // title: 'Location: '+i.toString(),
          ),
        )
    );

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
// ---vkk aadd this funtion --------
//                     if (createAuditionPlaceTimeProvider.dateController.text.isNotEmpty &&
//                         createAuditionPlaceTimeProvider
//                             .timeController.text.isNotEmpty &&
//                         createAuditionPlaceTimeProvider
//                             .spotsController.text.isNotEmpty) {
//
//
//                       createAuditionPlaceTimeProvider.dateTimeList.add(
//                           DateTimeModel(
//                               createAuditionPlaceTimeProvider
//                                   .dateController.text,
//                               createAuditionPlaceTimeProvider
//                                   .timeController.text,
//                               createAuditionPlaceTimeProvider
//                                   .spotsController.text));
//
//                       createAuditionPlaceTimeProvider.dateController.clear();
//                       createAuditionPlaceTimeProvider.timeController.clear();
//                       createAuditionPlaceTimeProvider.spotsController.clear();
//                     }
// -------
                    if (createAuditionPlaceTimeProvider
                        .auditionLocationController.text.isEmpty) {
                      Common.showErrorSnackBar(context, "Please fill Location");
                    } else if (createAuditionPlaceTimeProvider
                        .dateTimeList.isEmpty) {
                      Common.showErrorSnackBar(
                          context, "Please Add Date,Time and Spots");
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
                          SimpleTextField(
                            controller: createAuditionPlaceTimeProvider
                                .auditionLocationController,
                            hintText: "Location picker",
                            maxLine: 1,
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            height: 170.sp,
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                  tilt: 50,
                                  target: LatLng(22.719568, 75.857727),
                                 // target: LatLng(0, 0),
                                  zoom: 15),
                              markers: Set<Marker>.of(_markers),
                              onMapCreated: (GoogleMapController controller) {},
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
                                        time: createAuditionPlaceTimeProvider
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
