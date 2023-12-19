import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/manage_audition_created_screen_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/manage_audition_created_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/add_more_spot_dialog.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'approved_dialog.dart';

class AppliedViewPagerWidget extends StatefulWidget {
  final VoidCallback onCloseRegistration;

  final AppliedUsers appliedUsers;

  const AppliedViewPagerWidget(
      {super.key,
      required this.onCloseRegistration,
      required this.appliedUsers});

  @override
  State<AppliedViewPagerWidget> createState() => _AppliedViewPagerWidgetState();
}

class _AppliedViewPagerWidgetState extends State<AppliedViewPagerWidget> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;

  // int pageLength = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ManageAuditionCreatedScreenProvider>(
          builder: (context, provider, child) {
        return provider.isLoading == true
            ? const CustomCircularLoaderWidget()
            : Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _activePage = page;
                      });
                    },
                    itemCount: widget.appliedUsers.images?.length,
                    itemBuilder: (BuildContext context, int index1) {
                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(right: 20.w, left: 20.w),
                        child: SizedBox(
                          height: 420.sp,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.sp),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 420.sp,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                      width: 100.sp,
                                      height: 100.sp,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              color: Colors.grey,
                                              child: Center(
                                                  child: Icon(
                                                Icons.error,
                                                size: 25.sp,
                                              ))),

                                      imageUrl:
                                          "${Endpoints.imageBaseUrl}${widget.appliedUsers.images?[index1].files}"),
                                ),
                                Container(
                                  height: 420.sp,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, bottom: 10.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.userIcon,
                                            color: Colors.white,
                                            width: 18.w,
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.w),
                                                child: Text(
                                                  "${widget.appliedUsers.username ?? ""} ${widget.appliedUsers.age ?? ""}",
                                                  style: StyleUtility
                                                      .quicksandBoldWhiteTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize18
                                                                  .sp),
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            ImageUtility.locationIcon,
                                            color: Colors.white,
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.w),
                                                child: Text(
                                                  widget.appliedUsers.address ??
                                                      "",
                                                  style: StyleUtility
                                                      .quicksandMediumWhiteTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize16
                                                                  .sp),
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              provider.onBackPress();
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  ImageUtility.backCircleIcon,
                                                  width: 52.w,
                                                ),
                                                Text(
                                                  context.loc.buttonBack,
                                                  style: StyleUtility
                                                      .quicksandMediumWhiteTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize12.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                ImageUtility.declineCircleIcon,
                                                width: 52.w,
                                              ),
                                              Text(
                                                context.loc.decline,
                                                style: StyleUtility
                                                    .quicksandMediumWhiteTextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize12.sp),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              approvedDialog(context: context);
                                              // addMoreSpotDialog(context: context);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  ImageUtility.verifyGreenIcon,
                                                  width: 52.w,
                                                ),
                                                Text(
                                                  context.loc.approve,
                                                  style: StyleUtility
                                                      .quicksandMediumWhiteTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize12
                                                                  .sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              provider.onNextPress();
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  ImageUtility.nextCircleIcon,
                                                  width: 52.w,
                                                ),
                                                Text(
                                                  context.loc.buttonNext,
                                                  style: StyleUtility
                                                      .quicksandMediumWhiteTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize12.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 9.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          widget.appliedUsers.images?.length ?? 0,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () {
                                    _pageController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: Container(
                                    height: 4.h,
                                    width: 68.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: _activePage == index
                                            ? ColorUtility.color3D2D82
                                            : ColorUtility.colorWhite),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Future<dynamic> approvedDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ApprovedDialog(
              onAddMoreSpots: () {
                addMoreSpotDialog(context: context);
              },
              onCloseRegistration: widget.onCloseRegistration);
        }).then((value) {});
  }

  Future<dynamic> addMoreSpotDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AddMoreSpotDialog(
            onUpdateTap: () {},
            onBackTab: () {
              approvedDialog(context: context);
            },
            title: context.loc.dialogAreYouSureCancelAudition,
          );
        }).then((value) {});
  }
}
