import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/buttons/custom_text_button.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class AuditionDetailScreen extends StatefulWidget {
  final AuditionDetailType auditionDetailType;

  const AuditionDetailScreen({super.key, required this.auditionDetailType});

  @override
  State<AuditionDetailScreen> createState() => _AuditionDetailScreenState();
}

class _AuditionDetailScreenState extends State<AuditionDetailScreen> {
  List<DateModel> dateModel = [
    DateModel(date: '18/09/2023', time: "09:00", isSelect: true),
    DateModel(date: '19/09/2023', time: "10:30", isSelect: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              child: Padding(
                padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.h),
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
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
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
                        style: StyleUtility.quicksandRegularWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize18.sp),
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
                            child: Image.asset(
                              ImageUtility.helloCastBgImage,
                              width: 63.sp,
                              height: 63.sp,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${context.loc.titleCaster} ",
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Nir David",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${context.loc.titleCompany} ",
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Telenteam",
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
                          Image.asset(
                            ImageUtility.talentTeamIcon,
                            height: 64.sp,
                            fit: BoxFit.fill,
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
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "I’m looking for self-motivated, reliable, responsible and hard working person. I am a mature team worker and adaptable to all .",
                    style: StyleUtility.quicksandRegularBlackTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    context.loc.titleLocation,
                    style: StyleUtility.quicksandSemiBold5457BETextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Vijay Nagar,Indore.",
                    style: StyleUtility.quicksandRegularBlackTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 170.sp,
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                          tilt: 50,
                          target: LatLng(22.719568, 75.857727),
                          zoom: 15),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    context.loc.titleChooseTimeAndDateForTheAudition,
                    style: StyleUtility.quicksandSemiBold5457BETextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dateModel.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (dateModel[index].isSelect == true) {
                              dateModel[index].isSelect = false;
                            } else {
                              dateModel[index].isSelect = true;
                            }
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
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
                                        dateModel[index].isSelect == true
                                            ? ImageUtility.selectRadioIcon
                                            : ImageUtility.unSelectRadioIcon,
                                        width: 34.w,
                                        height: 34.w,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        dateModel[index].date ?? "",
                                        style: dateModel[index].isSelect == true
                                            ? StyleUtility
                                                .quicksandRegular5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp)
                                            : StyleUtility
                                                .quicksandRegular9A9A9FTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    dateModel[index].time ?? "",
                                    style: dateModel[index].isSelect == true
                                        ? StyleUtility
                                            .quicksandRegular5457BETextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize16.sp)
                                        : StyleUtility
                                            .quicksandRegular9A9A9FTextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
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
                            buttonText: context.loc.buttonApplyForTheAudition,
                            onTap: () {
                              showApplyAuditionSuccessDialog(context: context);
                            },
                          ),
                        )
                      : const SizedBox(),

                  //For Reschedule
                  widget.auditionDetailType == AuditionDetailType.reschedule
                      ? Container(
                          margin: EdgeInsets.only(top: 32.h),
                          child: CustomButtonTopToBottomColor(
                            width: double.infinity,
                            buttonText:
                                context.loc.buttonSendNewScheduleApproval,
                            onTap: () {
                              //  showApplyAuditionSuccessDialog(context: context);
                            },
                          ),
                        )
                      : const SizedBox(),

                  // For Awaiting

                  widget.auditionDetailType == AuditionDetailType.awaiting
                      ? Container(
                          margin: EdgeInsets.only(top: 32.h),
                          height: TextSizeUtility.buttonHeight,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorUtility.color909EAF,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: ElevatedButton(
                              onPressed: () {

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageUtility.awaitingIcon,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text("Awaiting for casting approval",
                                        maxLines: 1,
                                        style: StyleUtility.buttonTextStyle
                                            .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp,
                                        )),
                                  ],
                                ),
                              )),
                        )
                      : const SizedBox(),

                  //For Reschedule
                  widget.auditionDetailType == AuditionDetailType.reschedule ||
                          widget.auditionDetailType ==
                              AuditionDetailType.awaiting
                      ? Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: CustomOutlineButton(
                            buttonText: context.loc.buttonWithdrawApplication,
                            onTap: () {
                              showWithdrawDialog(context: context);
                            },
                            buttonColor: ColorUtility.color5457BE,
                          ),
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
      ),
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
      Navigator.pop(context);
    });
  }


  Future<dynamic> showWithdrawDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            userType: UserType.talent,
            onYesTap: () {
              showWithdrawAuditionSuccessDialog(context: context);
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
      Navigator.pop(context);
    });
  }




}

class DateModel {
  String? date;
  String? time;
  bool isSelect;

  DateModel({required this.date, required this.time, required this.isSelect});
}
