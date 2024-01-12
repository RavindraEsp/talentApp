import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/auditionDetails/screens/audition_detail_screen.dart';
import 'package:talent_app/modules/talent/home/providers/talent_home_screen_provider.dart';
import 'package:talent_app/network/model/response/talent/talent_home/talent_home_response_model.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/no_data_widget.dart';

class AuditionForYouWidget extends StatelessWidget {
  final List<AuditionforyouList>? auditionforyouList;
  final TalentHomeScreenProvider? talentHomeScreenProvider;

  const AuditionForYouWidget({
    super.key,
    this.auditionforyouList,
    this.talentHomeScreenProvider,
  });

  @override
  Widget build(BuildContext context) {
    return (auditionforyouList?.length ?? 0) == 0
        ? const NoDataWidget()
        : ListView.builder(
            //  itemCount: 4,
            itemCount: auditionforyouList?.length ?? 0,
            padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
            itemBuilder: (context, index) {
              return auditionforyouList?[index].applyStatus == 0
                  ?
                  //Apply more details
                  Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 18.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorUtility.color703297,
                                        ColorUtility.color65389A,
                                        ColorUtility.color445DB8
                                      ]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    bottomLeft: Radius.circular(10.r),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                ImageUtility.calenderIcon,
                                                width: 14.w,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                //  "Audition date 18/8/2023  |  19/8/2023",
                                                "${context.loc.auditionDate} ${auditionforyouList?[index].getAuditionDateArr?[0].date ?? ""}",
                                                style: StyleUtility
                                                    .quicksandRegular8B8B8BTextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize13.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                      Text(
                                        // "Actors are needed for a variety of roles Extras and more",
                                        auditionforyouList?[index]
                                                .description ??
                                            "",
                                        style: StyleUtility
                                            .quicksandRegularBlackTextStyle
                                            .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      CustomButtonTopToBottomColor(
                                        buttonText:
                                            context.loc.buttonMoreDetails,
                                        height: 34,
                                        onTap: () {
                                          goToAuditionDetailsScreen(
                                              context: context,
                                              auditionDetailType:
                                                  AuditionDetailType.apply,
                                              auditionId:
                                                  auditionforyouList?[index]
                                                      .auditionId);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : auditionforyouList?[index].applyStatus == 1
                      ?
                      //Awaiting
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 18.h),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: ColorUtility.color909EAF,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        bottomLeft: Radius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                ImageUtility.calenderIcon,
                                                width: 14.w,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                //  "Audition date 18/8/2023  |  19/8/2023",
                                                "${context.loc.auditionDate} ${auditionforyouList?[index].getAuditionDateArr?[0].date ?? ""}",

                                                style: StyleUtility
                                                    .quicksandRegular8B8B8BTextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize13.sp),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                          Text(
                                            //  "Actors are needed for a variety of roles Extras and more",
                                            auditionforyouList?[index]
                                                    .description ??
                                                "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                              fontSize:
                                                  TextSizeUtility.textSize16.sp,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 13.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorUtility.color909EAF,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                ),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      goToAuditionDetailsScreen(
                                                          context: context,
                                                          auditionDetailType:
                                                              AuditionDetailType
                                                                  .awaiting,
                                                          auditionId:
                                                              auditionforyouList?[
                                                                      index]
                                                                  .auditionId);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.w),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            ImageUtility
                                                                .awaitingIcon,
                                                            height: 20.h,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                              context.loc
                                                                  .buttonAwaitingApproval,
                                                              maxLines: 1,
                                                              style: StyleUtility
                                                                  .buttonTextStyle
                                                                  .copyWith(
                                                                fontSize:
                                                                    TextSizeUtility
                                                                        .textSize16
                                                                        .sp,
                                                              )),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {
                                                  showWithdrawDialog(
                                                      context: context,
                                                      appliedId:
                                                          auditionforyouList?[
                                                                  index]
                                                              .applyId);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.sp),
                                                  child: Text(
                                                    context.loc.withdraw,
                                                    style: StyleUtility
                                                        .kantumruyProRegular5457BETextStyle
                                                        .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      :
                      //reschedule
                      auditionforyouList?[index].applyStatus == 2
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 18.h),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 15,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                ColorUtility.color4FCC48,
                                                ColorUtility.color31B42C,
                                                ColorUtility.color1B9D16
                                              ]),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        ImageUtility
                                                            .calenderIcon,
                                                        width: 14.w,
                                                        fit: BoxFit.fill,
                                                        color: ColorUtility
                                                            .colorE24848,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        //  "Schedule changed. Please reschedule.",
                                                        "${context.loc.auditionDate} ${auditionforyouList?[index].getAuditionDateArr?[0].date ?? ""}",

                                                        style: StyleUtility
                                                            .quicksandRegular8B8B8BTextStyle
                                                            .copyWith(
                                                                color: ColorUtility
                                                                    .colorE24848,
                                                                fontSize:
                                                                    TextSizeUtility
                                                                        .textSize13
                                                                        .sp),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 17,
                                              ),
                                              Text(
                                                //  "Actors are needed for a variety of roles Extras and more",
                                                auditionforyouList?[index]
                                                        .description ??
                                                    "",
                                                style: StyleUtility
                                                    .quicksandRegularBlackTextStyle
                                                    .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize16.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 13.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomButtonTopToBottomColor(
                                                    buttonType:
                                                        ButtonType.green,
                                                    buttonText: context
                                                        .loc.buttonReschedule,
                                                    height: 34,
                                                    icon: ImageUtility
                                                        .rescheduleIcon,
                                                    onTap: () {
                                                      goToAuditionDetailsScreen(
                                                          context: context,
                                                          auditionDetailType:
                                                              AuditionDetailType
                                                                  .reschedule,
                                                          auditionId:
                                                              auditionforyouList?[
                                                                      index]
                                                                  .auditionId);
                                                    },
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showWithdrawDialog(
                                                          context: context,
                                                          appliedId:
                                                              auditionforyouList?[
                                                                      index]
                                                                  .applyId);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(2.sp),
                                                      child: Text(
                                                        context.loc.withdraw,
                                                        style: StyleUtility
                                                            .kantumruyProRegular5457BETextStyle
                                                            .copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          //no
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            );
            });
  }

  goToAuditionDetailsScreen({
    required BuildContext context,
    required AuditionDetailType auditionDetailType,
    required int? auditionId,
  }) {
    Navigator.pushNamed(context, RouteName.auditionDetailScreen, arguments: {
      "auditionDetailType": auditionDetailType,
      "auditionId": auditionId,
    }).then((value) {
      if (value == true) {
        AppLogger.logD("Refresh page");
        talentHomeScreenProvider?.isLoading = true;
        talentHomeScreenProvider?.updateUi();
        talentHomeScreenProvider?.getHomeDataForTalent(onFailure: (message) {
          Common.showErrorSnackBar(context, message);
        });
      }
    });
  }

  Future<dynamic> showWithdrawDialog(
      {required BuildContext context, required int? appliedId}) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            userType: UserType.talent,
            onYesTap: () {
              Common.showLoadingDialog(context);
              talentHomeScreenProvider?.withdrawAudition(
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
      talentHomeScreenProvider?.isLoading = true;
      talentHomeScreenProvider?.updateUi();
      talentHomeScreenProvider?.getHomeDataForTalent(onFailure: (message) {
        Common.showErrorSnackBar(context, message);
      });
    });
  }
}
