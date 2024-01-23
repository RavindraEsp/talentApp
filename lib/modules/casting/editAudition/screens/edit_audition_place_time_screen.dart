// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/date_time_row_widget.dart';
import 'package:talent_app/modules/casting/editAudition/model/edit_audition_sceen1_model.dart';
import 'package:talent_app/modules/casting/editAudition/provider/edit_audition_place_time_provider.dart';
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
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

import 'package:google_maps_webservice/places.dart';

class EditAuditionPlaceTimeScreen extends StatefulWidget {
  EditAuditionScreen1DataModel editAuditionScreen1DataModel;

  EditAuditionPlaceTimeScreen(
      {super.key, required this.editAuditionScreen1DataModel});

  @override
  State<EditAuditionPlaceTimeScreen> createState() =>
      _EditAuditionPlaceTimeScreenState();
}

class _EditAuditionPlaceTimeScreenState
    extends State<EditAuditionPlaceTimeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    AppLogger.logD("location init call ");

    Provider.of<EditAuditionPlaceTimeScreenProvider>(context, listen: false)
        .intializeSceen1Data(widget.editAuditionScreen1DataModel);
  }

  @override
  Widget build(BuildContext context) {
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
              child: Consumer<EditAuditionPlaceTimeScreenProvider>(
                  builder: (BuildContext context, provider, child) {
                return provider.isLoading == true
                    ? Container()
                    : CustomButton(
                        //  buttonText: context.loc.buttonPublish,
                        buttonText: provider.dateTimeList.isEmpty
                            ? context.loc.buttonNext
                            : context.loc.buttonUpdate,
                        buttonType: ButtonType.yellow,
                        onTap: () {
                          if (provider.location == null) {
                            Common.showErrorSnackBar(
                                context, StringsUtility.validationLocation);
                          } else if (provider.dateTimeList.isEmpty) {
                            Common.showErrorSnackBar(
                                context, StringsUtility.validationAddDAteTime);
                          } else {
                            Common.showLoadingDialog(context);
                            provider.updateBtnClick(
                                context: context,
                                onSuccess: (message) {
                                  Navigator.pop(context);
                                  showAuditionAuditionCreateSuccessDialog(
                                      context: context);
                                },
                                onFailure: (message) {
                                  Navigator.pop(context);
                                  Common.showErrorSnackBar(context, message);
                                });
                          }
                        },
                      );
              }),
            )
          ],
        ),
      ),
      body: Consumer<EditAuditionPlaceTimeScreenProvider>(
          builder: (BuildContext context, provider, child) {
        return provider.isLoading == true
            ? const CustomCircularLoaderWidget()
            : Form(
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
                                      context.loc.headerEditAudition,
                                      style: StyleUtility
                                          .kantumruyProSMedium18TextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize18.sp),
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
                            margin: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 18.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.loc.titleAuditionLocation,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    provider.openPicker(context, provider);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          provider.location ??
                                              "Select location",
                                          style: StyleUtility.inputTextStyle
                                              .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize15.sp,
                                          ),
                                        )),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                            width: 22.sp,
                                            height: 22.sp,
                                            child: Image.asset(
                                                ImageUtility.dropDownArrowIcon))
                                      ],
                                    ),
                                  ),
                                ),

                                // SimpleTextField(
                                //   controller:
                                //       provider.auditionLocationController,
                                //   hintText: "Location picker",
                                //   maxLine: 1,
                                // ),
                                SizedBox(height: 15.h),
                                SizedBox(
                                  height: 170.sp,
                                  child: GoogleMap(
                                    initialCameraPosition:
                                        provider.initialCameraPosition ??
                                            const CameraPosition(
                                                tilt: 50,
                                                target: LatLng(0.0, 0.0),
                                                zoom: 15),
                                    markers: Set<Marker>.of(provider.markers),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      provider.controller.complete(controller);
                                    },
                                  ),
                                ),
                                SizedBox(height: 36.h),
                                Text(
                                  context.loc.createAuditionDateTimeDesc,
                                  style: StyleUtility
                                      .quicksandRegularBlackTextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
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
                                                  fontSize: TextSizeUtility
                                                      .textSize15),
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
                                                  fontSize: TextSizeUtility
                                                      .textSize15),
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
                                                  fontSize: TextSizeUtility
                                                      .textSize15),
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
                                // ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   const VideoPlayerScreen(
                                //                       videoUrl:
                                //                           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')));
                                //       // print(
                                //       //     'aaaaa->${provider.ganareteAuditionDateTimeSpotsList(provider.dateTimeList)}');
                                //     },
                                //     child: const Text('test btn')),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: provider.dateTimeList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 16.h),
                                          child: DateTimeRowWidget(
                                              onRemoveIconTap: () {
                                                provider.dateTimeList
                                                    .removeAt(index);
                                                setState(() {});
                                              },
                                              date: provider
                                                      .dateTimeList?[index]
                                                      .date ??
                                                  "",
                                              time: provider
                                                      .dateTimeList?[index]
                                                      .time ??
                                                  "",
                                              spots: provider
                                                      .dateTimeList?[index]
                                                      .spots ??
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
                                            Common.selectDate(context,
                                                provider.dateController);
                                          },
                                          child: SimpleTextField(
                                            controller: provider.dateController,
                                            hintText: "DD/MM/YYYY",
                                            isEnable: false,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    // Expanded(
                                    //     flex: 2,
                                    //     child: SimpleTextField(
                                    //         controller: timeController,
                                    //         hintText: "00:00")),
                                    Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            Common.selectTime(context,
                                                provider.timeController);
                                          },
                                          child: SimpleTextField(
                                              controller:
                                                  provider.timeController,
                                              hintText: "00:00",
                                              isEnable: false),
                                        )),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: SimpleTextField(
                                          controller: provider.spotsController,
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
                                            provider.datetimespotPlusBtnClick(
                                                context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: ColorUtility
                                                          .color5457BE)),
                                              child: Center(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15.sp,
                                                          bottom: 15.sp),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 15.sp,
                                                        color: ColorUtility
                                                            .color5457BE,
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
              );
      }),
    );
  }

  Future<dynamic> showAuditionAuditionCreateSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogGoodJob,
            description: context.loc.dialogEditAuditionSuccessDesc,
            onCrossTap: () {},
          );
        }).then((value) {
      // Navigator.pop(context);
      // Navigator.pop(context);

      Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.castBottomBarScreen,
          arguments: {"selectIndex": 0},
          (route) => false);
    });
  }
}
