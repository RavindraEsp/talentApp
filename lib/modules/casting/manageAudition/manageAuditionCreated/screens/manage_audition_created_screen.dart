import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/manage_audition_created_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/applied_tab_bar_widget.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/approved_tab_bar_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class ManageAuditionCreatedScreen extends StatefulWidget {
  final int auditionId;

  const ManageAuditionCreatedScreen({super.key, required this.auditionId});

  @override
  State<ManageAuditionCreatedScreen> createState() =>
      _ManageAuditionCreatedScreenState();
}

class _ManageAuditionCreatedScreenState
    extends State<ManageAuditionCreatedScreen> {
  @override
  void initState() {
    super.initState();

    AppLogger.logD("auditionId ${widget.auditionId}");

    Provider.of<ManageAuditionCreatedScreenProvider>(context, listen: false)
        .getCreatedAuditionManage(widget.auditionId, onFailure: (message) {

          Navigator.pop(context);
          Common.showErrorToast(context, message);
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorUtility.colorWhite,
        body: Consumer<ManageAuditionCreatedScreenProvider>(
            builder: (context, provider, child) {
          return provider.isLoading == true
              ? const CustomCircularLoaderWidget()
              : Column(
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
                              colors: ColorUtility.castHeaderGradientColor)),
                      child: SafeArea(
                        bottom: false,
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
                                    context.loc.headerManageAudition,
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
                      child: provider.managAuditionCreatedScreenModel?.data ==
                              null
                          ? const NoDataWidget()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 18.h),
                                  child: Text(
                                    context.loc.titleAuditionDescription,
                                    style: StyleUtility
                                        .quicksandSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 20.w),
                                  child: Text(
                                    provider.managAuditionCreatedScreenModel
                                            ?.data?.description ??
                                        "",
                                    style: StyleUtility
                                        .quicksandMediumBlackTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 20.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.calenderIcon,
                                            width: 16.w,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            // provider.managAuditionCreatedScreenModel
                                            //             ?.data?.datetime ==
                                            //         null
                                            //     ? ""
                                            //     : CommonMethod.getDate(provider
                                            //             .managAuditionCreatedScreenModel
                                            //             ?.data
                                            //             ?.datetime ??
                                            //         ""),

                                            provider.managAuditionCreatedScreenModel
                                                    ?.data?.auditionDate ??
                                                "",

                                            // "dsd",
                                            style: StyleUtility
                                                .quicksandRegular8B8B8BTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.eyeOpenIcon,
                                            width: 16.w,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "${provider.managAuditionCreatedScreenModel?.data?.viewCount}",
                                            style: StyleUtility
                                                .quicksandRegular8B8B8BTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtility.userIcon,
                                            width: 16.w,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "${provider.managAuditionCreatedScreenModel?.data?.appliedCount} Applied",
                                            style: StyleUtility
                                                .quicksandRegular8B8B8BTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TabBar(
                                  labelPadding: const EdgeInsets.all(0),
                                  unselectedLabelColor: Colors.black,
                                  labelColor: ColorUtility.color5457BE,
                                  labelStyle: StyleUtility.unSelectTabTextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                  unselectedLabelStyle:
                                      StyleUtility.hintTextStyle,
                                  indicator: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: ColorUtility.blueGradientColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                  indicatorWeight: 1,
                                  indicatorPadding: EdgeInsets.only(
                                      top: 40, left: 16.w, right: 16.w),
                                  tabs: [
                                    Tab(
                                      child: Center(
                                          child: Text(
                                        "${context.loc.tabApplied} (${provider.managAuditionCreatedScreenModel?.data?.appliedUsers?.length})",
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                    Tab(
                                      child: Center(
                                          child: Text(
                                        "${context.loc.tabApproved} (${provider.managAuditionCreatedScreenModel?.data?.approvedUsers?.length})",
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: TabBarView(
                                  children: [
                                    (provider.managAuditionCreatedScreenModel?.data
                                                    ?.appliedUsers?.length ??
                                                0) >
                                            0
                                        ? AppliedTabBarWidget(
                                            searchController: searchController,
                                            auditionId: widget.auditionId)
                                        : const Center(
                                            child: NoDataWidget(),
                                          ),
                                    (provider.managAuditionCreatedScreenModel?.data
                                                    ?.approvedUsers?.length ??
                                                0) >
                                            0
                                        ? ApprovedTabBarWidget(
                                            auditionId: widget.auditionId)
                                        : const Center(
                                            child: NoDataWidget(),
                                          ),
                                  ],
                                )),
                              ],
                            ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}