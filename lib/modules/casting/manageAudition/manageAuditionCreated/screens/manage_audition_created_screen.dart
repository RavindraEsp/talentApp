import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/applied_tab_bar_widget.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/approved_tab_bar_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class ManageAuditionCreatedScreen extends StatefulWidget {
  const ManageAuditionCreatedScreen({super.key});

  @override
  State<ManageAuditionCreatedScreen> createState() =>
      _ManageAuditionCreatedScreenState();
}

class _ManageAuditionCreatedScreenState
    extends State<ManageAuditionCreatedScreen> {
  List<String> categoryList = ["Modeling", "Acting", "Singing"];
  List<String> bodyList = [
    "Eye color: Blue",
    "Hair color: blond",
    "W :55k",
    "Pans Size : XS",
    "Shirt Size : S",
    "H :1.7cm"
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorUtility.colorWhite,
        body: Column(
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
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 18.w, right: 18.w, top: 24.h, bottom: 24.h),
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
                            style: StyleUtility.kantumruyProSMedium18TextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize18.sp),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                    child: Text(
                      context.loc.titleAuditionDescription,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Text(
                      "I’m looking for self-motivated, reliable, responsible and hard working person….",
                      style: StyleUtility.quicksandMediumBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              "23/8/2023",
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              "230",
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              "20 Applied",
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
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
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    unselectedLabelStyle: StyleUtility.hintTextStyle,
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: ColorUtility.blueGradientColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                    ),
                    indicatorWeight: 1,
                    indicatorPadding:
                        EdgeInsets.only(top: 40, left: 16.w, right: 16.w),
                    tabs:  [
                      Tab(
                        child: Center(
                            child: Text(
                          "${context.loc.tabApplied} (120)",
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Tab(
                        child: Center(
                            child: Text(
                          "${context.loc.tabApproved} (86)",
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      AppliedTabBarWidget(
                          searchController: searchController,
                          categoryList: categoryList,
                          bodyList: bodyList),
                      const ApprovedTabBarWidget()
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
