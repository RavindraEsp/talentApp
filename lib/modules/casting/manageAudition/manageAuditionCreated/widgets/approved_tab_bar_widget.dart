import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/manage_audition_created_screen_provider.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_dialog.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/chat_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class ApprovedTabBarWidget extends StatelessWidget {
  final int auditionId;

  const ApprovedTabBarWidget({
    super.key,
    required this.auditionId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageAuditionCreatedScreenProvider>(
        builder: (context, provider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: provider.managAuditionCreatedScreenModel?.data
                        ?.approvedUsers?.length ??
                    0,
                padding: EdgeInsets.only(top: 20.h),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, mainIndex) {
                  ApprovedUsers? approveGroupList = provider
                      .managAuditionCreatedScreenModel
                      ?.data
                      ?.approvedUsers?[mainIndex];
                  return Container(
                    margin:
                        EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 14.w, bottom: 14.w, left: 12.w, right: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                            color: ColorUtility.color5457BE,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.calenderCheckIcon,
                                    width: 14.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    // "18/8/2023",
                                    approveGroupList?.date ?? "",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.clockIcon,
                                    width: 14.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    //  "09:00",
                                    approveGroupList?.time ?? "",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.userIcon,
                                    width: 16.w,
                                    color: ColorUtility.colorWhite,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    //  "46/50",
                                    "${approveGroupList?.appliedCount ?? ""}/${approveGroupList?.spotCount ?? ""}",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            color: ColorUtility.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 4,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: provider
                                      .managAuditionCreatedScreenModel
                                      ?.data
                                      ?.approvedUsers?[mainIndex]
                                      .userList
                                      ?.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, innerIndex) {
                                    UserList? userList = provider
                                        .managAuditionCreatedScreenModel
                                        ?.data
                                        ?.approvedUsers?[mainIndex]
                                        .userList?[innerIndex];
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w, right: 20.w),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName
                                                              .seeUserProfileScreen,
                                                          arguments: {
                                                            "telentUserId":
                                                                userList
                                                                    ?.talentUserId,
                                                            "roomId":userList
                                                                ?.roomId,
                                                          });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5.w,
                                                                      left:
                                                                          5.w),
                                                              child: ClipOval(
                                                                child: CachedNetworkImage(
                                                                    width: 45.sp,
                                                                    height: 45.sp,
                                                                    fit: BoxFit.cover,
                                                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                                    errorWidget: (context, url, error) => Container(
                                                                        color: Colors.grey,
                                                                        child: Center(
                                                                            child: Icon(
                                                                          Icons
                                                                              .error,
                                                                          size:
                                                                              25.sp,
                                                                        ))),
                                                                    imageUrl: "${Endpoints.imageBaseUrl}${userList?.profilePic ?? ''}"),
                                                              ),

                                                              //  Image
                                                              //     .asset(
                                                              //   ImageUtility
                                                              //       .dummyProfileImage,
                                                              //   width:
                                                              //       45.w,
                                                              //   height:
                                                              //       45.w,
                                                              //   fit: BoxFit
                                                              //       .fill,
                                                              // ),
                                                            ),
                                                            Image.asset(
                                                              ImageUtility
                                                                  .popularIcon,
                                                              width: 20.w,
                                                              height: 20.w,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    userList?.fullname ??
                                                                        "",
                                                                    style: StyleUtility
                                                                        .quicksandSemiBoldBlackTextStyle
                                                                        .copyWith(
                                                                            fontSize:
                                                                                TextSizeUtility.textSize16),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 4,
                                                                        left: 5
                                                                            .w),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          15.w,
                                                                      child: Image
                                                                          .asset(
                                                                        ImageUtility
                                                                            .eyeOpenIcon,
                                                                        color: ColorUtility
                                                                            .color8B8B8B,
                                                                        width:
                                                                            15.w,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 7.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    userList?.age ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    style: StyleUtility
                                                                        .quicksandRegular8B8B8BTextStyle
                                                                        .copyWith(
                                                                            fontSize:
                                                                                TextSizeUtility.textSize12),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            7.w),
                                                                    child:
                                                                        Container(
                                                                      width: 1,
                                                                      color: ColorUtility
                                                                          .color8B8B8B,
                                                                      height:
                                                                          10.sp,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    userList?.address ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    style: StyleUtility
                                                                        .quicksandRegular8B8B8BTextStyle
                                                                        .copyWith(
                                                                            fontSize:
                                                                                TextSizeUtility.textSize12),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            7.w),
                                                                    child:
                                                                        Container(
                                                                      width: 1,
                                                                      color: ColorUtility
                                                                          .color8B8B8B,
                                                                      height:
                                                                          10.sp,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    // userList?.gender ??
                                                                    //     "",

                                                                    userList?.gender ==
                                                                            1
                                                                        ? context.loc.male
                                                                        : userList?.gender ==
                                                                                2
                                                                            ? context.loc.female
                                                                            : context.loc.other,
                                                                    maxLines: 1,
                                                                    style: StyleUtility
                                                                        .quicksandRegular8B8B8BTextStyle
                                                                        .copyWith(
                                                                            fontSize:
                                                                                TextSizeUtility.textSize12),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    AppLogger.logD(
                                                        "UserName is ${userList?.username}");
                                                    AppLogger.logD(
                                                        "Applied id is ${userList?.appliedId}");

                                                    CommonDialog
                                                        .showLoadingDialog(
                                                            context);
                                                    provider
                                                        .declineApprovedUserApi(
                                                            appliedId: userList
                                                                    ?.appliedId ??
                                                                0,
                                                            onSuccess:
                                                                (message) {
                                                              Navigator.pop(
                                                                  context);

                                                              //For refresh page
                                                              provider.isLoading =
                                                                  true;
                                                              provider
                                                                  .updateUi();
                                                              provider.getCreatedAuditionManage(
                                                                  auditionId,
                                                                  onFailure:
                                                                      (message) {
                                                                Common
                                                                    .showErrorSnackBar(
                                                                        context,
                                                                        message);
                                                              });
                                                            },
                                                            onFailure:
                                                                (message) {
                                                              Navigator.pop(
                                                                  context);
                                                              Common
                                                                  .showErrorSnackBar(
                                                                      context,
                                                                      message);
                                                            });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        ImageUtility
                                                            .declineIcon,
                                                        width: 14.w,
                                                      ),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      Text(
                                                        context.loc.decline,
                                                        style: StyleUtility
                                                            .quicksandRegular9F9E9ETextStyle
                                                            .copyWith(
                                                                fontSize:
                                                                    TextSizeUtility
                                                                        .textSize10
                                                                        .sp),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 9.h,
                                            ),
                                            Container(
                                              height: 1,
                                              color: ColorUtility.colorE4E4E8,
                                            ),
                                          ],
                                        ));
                                  }),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 16.h,
                                    left: 12.w,
                                    right: 20.w,
                                    top: 12.h),
                                child: ChatButton(
                                    buttonText:
                                        context.loc.buttonSendAGroupMessage,
                                    icon: ImageUtility.messageNavIcon,
                                    onTap: () {

                                      Navigator.pushNamed(context,
                                          RouteName.chatScreen,
                                          arguments: {
                                            "userType": UserType.cast,
                                            "receiverId":provider.managAuditionCreatedScreenModel?.data?.approvedUsers?[mainIndex].groupId,  // pass group id in this
                                             "roomId":provider.managAuditionCreatedScreenModel?.data?.approvedUsers?[mainIndex].groupRoomId,
                                            "title":provider.managAuditionCreatedScreenModel?.data?.approvedUsers?[mainIndex].groupName ?? "",
                                            "chatType":ChatType.group
                                          }
                                      );


                                    }),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomOutlineButton(
                buttonText: context.loc.buttonCloseRegistration,
                onTap: () {
                  Common.showLoadingDialog(context);
                  provider.closeRegistrationApi(
                      id: auditionId,
                      context: context,
                      onFailure: (message) {
                        Navigator.pop(context);
                        Common.showErrorSnackBar(context, message);
                      },
                      onSuccess: (message) {
                        Navigator.pop(context);

                        Common.showSuccessToast(context, message);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.castBottomBarScreen,
                            arguments: {"selectIndex": 0},
                            (route) => false);
                      });
                },
                buttonColor: ColorUtility.color5457BE,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 17.h),
            //   child: CustomOutlineButton(
            //       buttonText: context.loc.buttonManageTimeSlots,
            //       onTap: () {},
            //       buttonColor: ColorUtility.color5457BE),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 17.h),
              child: CustomOutlineButton(
                  buttonText: context.loc.buttonCancelTheAudition,
                  onTap: () {
                    showCancelDialog(
                        context: context,
                        onYesTap: () {
                          Common.showLoadingDialog(context);
                          provider.cancelTheAuditionApi(
                              id: auditionId,
                              context: context,
                              onFailure: (message) {
                                Navigator.pop(context);

                                Common.showErrorSnackBar(context, message);
                              },
                              onSuccess: (message) {
                                Navigator.pop(context);

                                showAuditionCancelSuccessDialog(
                                    context: context);
                              });
                        });
                  },
                  buttonColor: ColorUtility.color5457BE),
            ),
            SizedBox(
              height: 35.h,
            )
          ],
        ),
      );
    });
  }

  Future<dynamic> showCancelDialog({
    required BuildContext context,
    required VoidCallback onYesTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            onYesTap: onYesTap,
            title: context.loc.dialogAreYouSureCancelAudition,
          );
        }).then((value) {});
  }

  Future<dynamic> showAuditionCancelSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogYouHaveCanceledAudition,
            description: context.loc.dialogCancelAuditionSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {
      // Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.castBottomBarScreen,
          arguments: {"selectIndex": 0},
          (route) => false);
    });
  }
}
