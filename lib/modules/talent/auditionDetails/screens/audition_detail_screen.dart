import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/auditionDetails/provider/audition_details_screen_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/buttons/custom_text_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class AuditionDetailScreen extends StatefulWidget {
  final AuditionDetailType auditionDetailType;
  final int auditionId;

  const AuditionDetailScreen(
      {super.key, required this.auditionDetailType, required this.auditionId});

  @override
  State<AuditionDetailScreen> createState() => _AuditionDetailScreenState();
}

class _AuditionDetailScreenState extends State<AuditionDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuditionDetailsScreenProvider>(context, listen: false)
        .geAuditionDetails(
            auditionId: widget.auditionId,
            onFailure: (message) {
              Common.showErrorToast(context, message);
              Navigator.pop(context);
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuditionDetailsScreenProvider>(
          builder: (context, auditionDetailsScreenProvider, child) {
        var auditionDetails =
            auditionDetailsScreenProvider.auditionDetailResponseModel?.data;
        return auditionDetailsScreenProvider.isLoading == true
            ? const CustomCircularLoaderWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 18.sp),
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(40.r)),
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: ColorUtility.talentHeaderGradientColor)),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 20.h),
                        child: Column(
                          children: [
                            Row(
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
                                      context.loc.buttonBack,
                                      style: StyleUtility
                                          .kantumruyProSMedium18TextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize18.sp),
                                    ),
                                  ],
                                ),
                                const TalentMenuButtonWidget()
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Actors are needed for a variety of roles - Extras and more",
                                style: StyleUtility
                                    .quicksandRegularWhiteTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize18.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(6.sp),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18.sp),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.r),
                                      // Adjust the values as needed
                                      bottomLeft: Radius.circular(15.r),
                                    ),
                                    child:
                                        // Image.asset(
                                        //   ImageUtility.helloCastBgImage,
                                        //   width: 63.sp,
                                        //   height: 63.sp,
                                        //   fit: BoxFit.fill,
                                        // ),
                                        (auditionDetails?.casterProfile != "" &&
                                                auditionDetails
                                                        ?.casterProfile !=
                                                    null)
                                            ? CachedNetworkImage(
                                                width: 63.sp,
                                                height: 63.sp,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        //  color: Colors.grey,
                                                        child: Center(
                                                            child: Icon(
                                                      Icons.error,
                                                      size: 25.sp,
                                                    ))),
                                                // imageUrl: "https://espsofttech.in:7272/api/auth/uploads/image-1696339902307.jpg"),
                                                imageUrl:
                                                    "${Endpoints.imageBaseUrl}${auditionDetails?.casterProfile}")
                                            : const SizedBox(
                                                width: 0,
                                                height: 0,
                                              ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${context.loc.titleCaster} : ",
                                              style: StyleUtility
                                                  .quicksandSemiBold5457BETextStyle
                                                  .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize14.sp),
                                            ),
                                            Expanded(
                                                child: Text(
                                              // "Nir David",
                                              auditionDetails?.castername ?? "",
                                              style: StyleUtility
                                                  .quicksandSemiBoldBlackTextStyle
                                                  .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize14.sp),
                                            )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${context.loc.titleCompany} : ",
                                              style: StyleUtility
                                                  .quicksandSemiBold5457BETextStyle
                                                  .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize14.sp),
                                            ),
                                            Expanded(
                                                child: Text(
                                              //  "Telenteam",
                                              auditionDetails?.companyName ??
                                                  "",
                                              style: StyleUtility
                                                  .quicksandSemiBoldBlackTextStyle
                                                  .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize14.sp),
                                            )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                  // Image.asset(
                                  //   ImageUtility.talentTeamIcon,
                                  //   height: 64.sp,
                                  //   fit: BoxFit.fill,
                                  // ),
                                  (auditionDetails?.casterLogo != "" &&
                                          auditionDetails?.casterLogo != null)
                                      ? CachedNetworkImage(
                                          height: 64.sp,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                  //  color: Colors.grey,
                                                  child: Center(
                                                      child: Icon(
                                                Icons.error,
                                                size: 25.sp,
                                              ))),
                                          // imageUrl: "https://espsofttech.in:7272/api/auth/uploads/image-1696339902307.jpg"),
                                          imageUrl:
                                              "${Endpoints.imageBaseUrl}${auditionDetails?.casterLogo}")
                                      : const SizedBox(
                                          width: 0,
                                          height: 0,
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            context.loc.titleDetails,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            //  "I’m looking for self-motivated, reliable, responsible and hard working person. I am a mature team worker and adaptable to all .",
                            auditionDetails?.description ?? "",
                            style: StyleUtility.quicksandRegularBlackTextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            context.loc.titleLocation,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            //  "Vijay Nagar,Indore.",
                            auditionDetails?.location ?? "",
                            style: StyleUtility.quicksandRegularBlackTextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          SizedBox(
                            height: 170.sp,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  tilt: 50,
                                  //  target: LatLng(22.719568, 75.857727),
                                  //  target: LatLng(22.719600, 75.857700),
                                  // target: LatLng(
                                  //     auditionDetailsScreenProvider.lat,
                                  //     auditionDetailsScreenProvider.lng),


                                  target: LatLng(
                                      double.parse(auditionDetails?.latitude ?? "0.0"),
                                    double.parse(auditionDetails?.longitude ?? "0.0"),),


                                  zoom: 15),
                              markers: Set<Marker>.of(
                                  auditionDetailsScreenProvider.markers),
                              // onMapCreated: (GoogleMapController controller) {},

                              onMapCreated: (GoogleMapController controller) {
                                auditionDetailsScreenProvider.controller
                                    .complete(controller);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            context.loc.titleChooseTimeAndDateForTheAudition,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),

                          //date list view

                          ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  auditionDetails?.getAuditionDateArr?.length ??
                                      0,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    for (var dateArr in auditionDetails!
                                        .getAuditionDateArr!) {
                                      dateArr.isSelected = false;
                                    }
                                    auditionDetails.getAuditionDateArr?[index]
                                        .isSelected = true;

                                    auditionDetailsScreenProvider.updateUi();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD6D6D8)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                //  dateModel[index].isSelect ==
                                                auditionDetails
                                                            ?.getAuditionDateArr?[
                                                                index]
                                                            .isSelected ==
                                                        true
                                                    ? ImageUtility
                                                        .selectRadioIcon
                                                    : ImageUtility
                                                        .unSelectRadioIcon,
                                                width: 34.w,
                                                height: 34.w,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                auditionDetails
                                                        ?.getAuditionDateArr?[
                                                            index]
                                                        .date ??
                                                    "",
                                                style: auditionDetails
                                                            ?.getAuditionDateArr?[
                                                                index]
                                                            .isSelected ==
                                                        true
                                                    ? StyleUtility
                                                        .quicksandRegular5457BETextStyle
                                                        .copyWith(
                                                            fontSize:
                                                                TextSizeUtility
                                                                    .textSize16
                                                                    .sp)
                                                    : StyleUtility
                                                        .quicksandRegular9A9A9FTextStyle
                                                        .copyWith(
                                                            fontSize:
                                                                TextSizeUtility
                                                                    .textSize16
                                                                    .sp),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            auditionDetails
                                                    ?.getAuditionDateArr?[index]
                                                    .time ??
                                                "",
                                            style: auditionDetails
                                                        ?.getAuditionDateArr?[
                                                            index]
                                                        .isSelected ==
                                                    true
                                                ? StyleUtility
                                                    .quicksandRegular5457BETextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize16.sp)
                                                : StyleUtility
                                                    .quicksandRegular9A9A9FTextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize16.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),

                          //For Apply

                          widget.auditionDetailType == AuditionDetailType.apply
                              ? Container(
                                  margin: EdgeInsets.only(top: 32.h),
                                  child: CustomButtonTopToBottomColor(
                                    width: double.infinity,
                                    buttonText:
                                        context.loc.buttonApplyForTheAudition,
                                    onTap: () {
                                      bool isDateSelect = false;
                                      int? selectDateId;
                                      for (var dateArr in auditionDetails!
                                          .getAuditionDateArr!) {
                                        if (dateArr.isSelected == true) {
                                          isDateSelect = true;
                                          selectDateId = dateArr.id;
                                        }
                                      }

                                      if (isDateSelect == true) {
                                        Common.showLoadingDialog(context);
                                        auditionDetailsScreenProvider
                                            .applyAudition(
                                                onFailure: (message) {
                                                  Navigator.pop(context);
                                                  Common.showErrorSnackBar(
                                                      context, message);
                                                },
                                                onSuccess: (message) {
                                                  Navigator.pop(context);
                                                  showApplyAuditionSuccessDialog(
                                                      context: context);
                                                },
                                                casterUserId: auditionDetails
                                                    .casterUserId,
                                                auditionId:
                                                    auditionDetails.auditionId,
                                                auditionDateId: selectDateId);
                                      } else {
                                        Common.showErrorSnackBar(context,
                                            StringsUtility.selectAuditionDate);
                                      }
                                    },
                                  ),
                                )
                              : const SizedBox(),

                          //For Reschedule
                          widget.auditionDetailType ==
                                  AuditionDetailType.reschedule
                              ? Container(
                                  margin: EdgeInsets.only(top: 32.h),
                                  child: CustomButtonTopToBottomColor(
                                    width: double.infinity,
                                    buttonText: context
                                        .loc.buttonSendNewScheduleApproval,
                                    onTap: () {
                                      bool isDateSelect = false;
                                      int? selectDateId;
                                      for (var dateArr in auditionDetails!
                                          .getAuditionDateArr!) {
                                        if (dateArr.isSelected == true) {
                                          isDateSelect = true;
                                          selectDateId = dateArr.id;
                                        }
                                      }

                                      if (isDateSelect == true) {
                                        Common.showLoadingDialog(context);
                                        auditionDetailsScreenProvider
                                            .rescheduleAudition(
                                          onFailure: (message) {
                                            Navigator.pop(context);
                                            Common.showErrorSnackBar(
                                                context, message);
                                          },
                                          onSuccess: (message) {
                                            Navigator.pop(context);
                                            showNewScheduleSuccessDialog(
                                                context: context);
                                          },
                                          casterUserId:
                                              auditionDetails.casterUserId,
                                          auditionId:
                                              auditionDetails.auditionId,
                                          auditionDateId: selectDateId,
                                          applyId: auditionDetails.applyId,
                                          applyStatus:
                                              auditionDetails.applyStatus,
                                        );
                                      } else {
                                        Common.showErrorSnackBar(context,
                                            StringsUtility.selectAuditionDate);
                                      }

                                      // showNewScheduleSuccessDialog(
                                      //     context: context);
                                    },
                                  ),
                                )
                              : const SizedBox(),

                          // For Awaiting

                          widget.auditionDetailType ==
                                  AuditionDetailType.awaiting
                              ? Container(
                                  margin: EdgeInsets.only(top: 32.h),
                                  height: TextSizeUtility.buttonHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorUtility.color909EAF,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              ImageUtility.awaitingIcon,
                                              height: 20.h,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                                context.loc
                                                    .buttonAwaitingForCasterApproval,
                                                maxLines: 1,
                                                style: StyleUtility
                                                    .buttonTextStyle
                                                    .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize16.sp,
                                                )),
                                          ],
                                        ),
                                      )),
                                )
                              : const SizedBox(),

                          //For Reschedule And awaitning both
                          widget.auditionDetailType ==
                                      AuditionDetailType.reschedule ||
                                  widget.auditionDetailType ==
                                      AuditionDetailType.awaiting
                              ? Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  child: CustomOutlineButton(
                                    buttonText:
                                        context.loc.buttonWithdrawApplication,
                                    onTap: () {
                                      showWithdrawDialog(
                                          context: context,
                                          appliedId: auditionDetails?.applyId,
                                          auditionDetailsScreenProvider:
                                              auditionDetailsScreenProvider);
                                    },
                                    buttonColor: ColorUtility.color5457BE,
                                  ),
                                )
                              : const SizedBox(),

                          //For Denied
                          widget.auditionDetailType == AuditionDetailType.denied
                              ? Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  height: TextSizeUtility.buttonHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorUtility.colorDD4F4F,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                context
                                                    .loc.buttonDeniedAudition,
                                                maxLines: 1,
                                                style: StyleUtility
                                                    .buttonTextStyle
                                                    .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize16.sp,
                                                )),
                                          ],
                                        ),
                                      )),
                                )
                              : const SizedBox(),

                          SizedBox(
                            height: 15.h,
                          ),
                          CustomTextButton(
                            width: double.infinity,
                            buttonText: context.loc.buttonClose,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              );
      }),
    );
  }

  Future<dynamic> showApplyAuditionSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogApplyAuditionSuccessTitle,
            description: context.loc.dialogApplyAuditionSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {
      Navigator.pop(context, true);
    });
  }

  Future<dynamic> showWithdrawDialog({
    required BuildContext context,
    required AuditionDetailsScreenProvider auditionDetailsScreenProvider,
    required int? appliedId,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            userType: UserType.talent,
            onYesTap: () {
              Common.showLoadingDialog(context);
              auditionDetailsScreenProvider.withdrawAudition(
                  onFailure: (message) {
                    Navigator.pop(context);
                    Common.showErrorSnackBar(context, message);
                  },
                  onSuccess: (message) {
                    Navigator.pop(context);
                    showWithdrawAuditionSuccessDialog(context: context);
                  },
                  appliedId: appliedId);
            },
            title: context.loc.dialogAreYouSureYouWantToWithdrawYourApplication,
          );
        }).then((value) {});
  }

  Future<dynamic> showWithdrawAuditionSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogWithdrawSuccessTitle,
            description: context.loc.dialogWithdrawSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {
      Navigator.pop(context, true);
    });
  }

  Future<dynamic> showNewScheduleSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogNewScheduleSuccessTitle,
            description: context.loc.dialogNewScheduleSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {
      Navigator.pop(context, true);
    });
  }
}

class DateModel {
  String? date;
  String? time;
  bool isSelect;

  DateModel({required this.date, required this.time, required this.isSelect});
}
