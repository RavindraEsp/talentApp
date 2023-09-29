import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/home/widgets/Audition_finished_widget.dart';
import 'package:talent_app/modules/casting/home/widgets/audition_created_widget.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/create_audition_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class CastHomeScreen extends StatefulWidget {
  const CastHomeScreen({super.key});

  @override
  State<CastHomeScreen> createState() => _CastHomeScreenState();
}

class _CastHomeScreenState extends State<CastHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50.sp),
                  height: 160.h,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
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
                      padding:
                          EdgeInsets.only(left: 18.w, right: 18.w, top: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SettingButtonWidget(),
                          Text(
                            "Hello Alon",
                            style: StyleUtility.kantumruyProSMedium18TextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize18.sp),
                          ),
                          const MenuButtonWidget()
                        ],
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  ImageUtility.dummyProfileImage,
                  width: 100.sp,
                  height: 100.sp,
                  fit: BoxFit.fill,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 16.h),
              padding: EdgeInsets.only(
                  left: 13.w, right: 13.w, top: 12.h, bottom: 18.h),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorUtility.colorD6D6D8),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Text(
                      context.loc.hereYouCanDesc,
                      style: StyleUtility.quicksandRegularBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CreateAuditionButton(
                    buttonText: context.loc.buttonCreateAnAudition,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.createAuditionScreen);
                    },
                    buttonType: ButtonType.yellow,
                    icon: ImageUtility.editIcon,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CreateAuditionButton(
                    buttonText: context.loc.buttonCreateAJob,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.createAuditionScreen);
                    },
                    buttonType: ButtonType.yellow,
                    icon: ImageUtility.editIcon,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TabBar(
              labelPadding: const EdgeInsets.all(0),
              unselectedLabelColor: Colors.black,
              labelColor: ColorUtility.color5457BE,
              labelStyle: StyleUtility.quicksandRegular16TextStyle
                  .copyWith(fontSize: TextSizeUtility.textSize16.sp),
              unselectedLabelStyle: StyleUtility.hintTextStyle,

              indicator: BoxDecoration(
                gradient: const LinearGradient(
                  colors: ColorUtility.blueGradientColor
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.r),
                ),
              ),
              indicatorWeight: 1,
              indicatorPadding: EdgeInsets.only(top: 40, left: 16.w, right: 16.w),

              tabs: [
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabAuditionsCreated,
                    textAlign: TextAlign.center,
                  )),
                ),
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabFinishedAuditions,
                    textAlign: TextAlign.center,
                  )),
                ),
              ],
            ),
            const Expanded(
                child: TabBarView(
              children: [
                AuditionCreatedWidget(),
                AuditionFinishedWidget(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
