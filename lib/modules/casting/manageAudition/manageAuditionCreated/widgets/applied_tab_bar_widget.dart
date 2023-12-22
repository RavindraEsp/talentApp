import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/manage_audition_created_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/applied_view_pager_widget.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_dialog.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/chat_button.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class AppliedTabBarWidget extends StatefulWidget {
  const AppliedTabBarWidget({
    super.key,
    required this.searchController,
    required this.auditionId,
  });

  final TextEditingController searchController;
  final int auditionId;

  @override
  State<AppliedTabBarWidget> createState() => _AppliedTabBarWidgetState();
}

class _AppliedTabBarWidgetState extends State<AppliedTabBarWidget> {
  bool closeRegistration = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageAuditionCreatedScreenProvider>(
        builder: (context,  provider, child) {
      return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SearchTextField(
                      controller: widget.searchController,
                      hintText: context.loc.hintSearchCandidate),
                ),
                SizedBox(
                  height: 12.h,
                ),

                Expanded(
                  child:
                  // ListView.builder(
                  //     itemCount: (provider.managAuditionCreatedScreenModel?.data
                  //         ?.appliedUsers?.length ?? 0)> 0 ? 1 :0 ,
                  //     itemBuilder: (context, i) {
                  //       AppliedUsers? appliedUser = provider
                  //           .managAuditionCreatedScreenModel
                  //           ?.data
                  //           ?.appliedUsers?[i];
                  //       return

                          closeRegistration == false
                            ? SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   provider.appliedUser?.profileFiles?.isEmpty ?? true
                                        ? Container()
                                        : SizedBox(
                                            height: 420.h,
                                            child: AppliedViewPagerWidget(
                                              appliedUsers:  provider.appliedUser!,
                                              onCloseRegistration: () {
                                                closeRegistration = true;
                                                setState(() {});
                                              },
                                                onAddThisCandidate: (){

                                                  CommonDialog.showLoadingDialog(context);

                                                  provider.approveUserAuditionApi(
                                                      appliedId: provider.appliedUser!.appliedId ?? 0,
                                                      onSuccess: (message){
                                                        Navigator.pop(context);

                                                        //For refresh page
                                                        provider.isLoading = true;
                                                        provider.notifyListeners();
                                                        provider.getCreatedAuditionManage(widget.auditionId, onFailure: (message){
                                                          Common.showErrorSnackBar(context, message);

                                                        });

                                                      }, onFailure: (message){
                                                    Navigator.pop(context);
                                                    Common.showErrorSnackBar(context, message);
                                                  });

                                                },
                                              onDecline:(){
                                                CommonDialog.showLoadingDialog(context);
                                                provider.declineUserAuditionApi(
                                                    appliedId: provider.appliedUser!.appliedId ?? 0,
                                                    onSuccess: (message){
                                                      Navigator.pop(context);

                                                      //For refresh page
                                                      provider.isLoading = true;
                                                      provider.updateUi();
                                                      provider.getCreatedAuditionManage(widget.auditionId, onFailure: (message){
                                                        Common.showErrorSnackBar(context, message);

                                                      });

                                                    }, onFailure: (message){
                                                  Navigator.pop(context);
                                                  Common.showErrorSnackBar(context, message);
                                                });
                                              },
                                            )),
                                    SizedBox(
                                      height: 26.h,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.loc.titleCategory,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          Wrap(
                                            children: [
                                              for (var item
                                                  in  provider.appliedUser?.lookingFor ?? [])
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 9.w, top: 12.h),
                                                    padding: EdgeInsets.only(
                                                        left: 20.sp,
                                                        right: 20.sp,
                                                        top: 9.sp,
                                                        bottom: 12.sp),
                                                    decoration: BoxDecoration(
                                                        color: ColorUtility
                                                            .colorWhite,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30.r),
                                                        border: Border.all(
                                                            color: ColorUtility
                                                                .colorD3D6D6)),
                                                    child: Text(
                                                      item,
                                                      style: StyleUtility
                                                          .quicksandRegularBlackTextStyle
                                                          .copyWith(
                                                              fontSize:
                                                                  TextSizeUtility
                                                                      .textSize14
                                                                      .sp),
                                                    ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            context.loc.titleBody,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          Wrap(
                                            children: [
                                              for (var item
                                                  in  provider.appliedUser?.bodyList ?? [])
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 9.w, top: 12.h),
                                                    padding: EdgeInsets.only(
                                                        left: 20.sp,
                                                        right: 20.sp,
                                                        top: 9.sp,
                                                        bottom: 12.sp),
                                                    decoration: BoxDecoration(
                                                        color: ColorUtility
                                                            .colorWhite,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30.r),
                                                        border: Border.all(
                                                            color: ColorUtility
                                                                .colorD3D6D6)),
                                                    child: Text(
                                                      item,
                                                      style: StyleUtility
                                                          .quicksandRegularBlackTextStyle
                                                          .copyWith(
                                                              fontSize:
                                                                  TextSizeUtility
                                                                      .textSize14
                                                                      .sp),
                                                    ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            context.loc.titleIntroText,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            provider.appliedUser?.introText ?? '',
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 28.h,
                                          ),
                                          CustomOutlineButton(
                                            buttonText:
                                                context.loc.buttonSeeFullProfile,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.seeUserProfileScreen,
                                                  arguments: {
                                                    "telentUserId":
                                                    provider.appliedUser?.talentUserId
                                                  });
                                            },
                                            buttonColor: ColorUtility.color5457BE,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          ChatButton(
                                              buttonText:
                                                  "${context.loc.buttonChatWith} ${ provider.appliedUser?.username}",
                                              icon: ImageUtility.messageNavIcon,
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteName.chatScreen);
                                              }),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                            )
                            : Padding(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                child: Column(
                                  children: [
                                    Text(
                                      context.loc.thisAuditionIsClosed,
                                      style: StyleUtility
                                          .kantumruyProSemiBoldE03939TextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize24.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      context.loc.closedAuditionDesc,
                                      style: StyleUtility
                                          .quicksandRegularBlackTextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    CustomButton(
                                      buttonText:
                                          context.loc.buttonAddMoreSpots,
                                      buttonType: ButtonType.yellow,
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              )



                      // }),
                )
              ],
            );
    });
  }
}
