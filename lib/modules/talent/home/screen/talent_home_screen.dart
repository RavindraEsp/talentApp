import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/main.dart';
import 'package:talent_app/modules/intro/intro_screen.dart';
import 'package:talent_app/modules/talent/home/providers/talent_home_screen_provider.dart';
import 'package:talent_app/modules/talent/home/widgets/approved_audition_widget.dart';
import 'package:talent_app/modules/talent/home/widgets/audition_for_you_widget.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class TalentHomeScreen extends StatefulWidget {
  const TalentHomeScreen({super.key});

  @override
  State<TalentHomeScreen> createState() => _TalentHomeScreenState();
}

class _TalentHomeScreenState extends State<TalentHomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<TalentHomeScreenProvider>(context, listen: false)
        .getHomeDataForTalent(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    });
  }


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
                    child: Container(
                      height: 124.h,
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 24.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const SettingButtonWidget(),

                            Text(
                              //  "Hello, Michal",
                              "${context.loc.helloUserName} ${Preference().getUserName()}",
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
                            ),
                            const TalentMenuButtonWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Image.asset(
                //   ImageUtility.dummyProfileImage,
                //   width: 100.sp,
                //   height: 100.sp,
                //   fit: BoxFit.fill,
                // )
                ClipOval(
                  child: CachedNetworkImage(
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                          color: Colors.grey,
                          child: Center(
                              child: Icon(
                            Icons.error,
                            size: 25.sp,
                          ))),
                      // imageUrl: "https://espsofttech.in:7272/api/auth/uploads/image-1696339902307.jpg"),
                      imageUrl:
                          "${Endpoints.imageBaseUrl}${Preference().getProfileImage()}"),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            TabBar(
              labelPadding: const EdgeInsets.all(0),
              unselectedLabelColor: Colors.black,
              labelColor: ColorUtility.color5457BE,
              // labelStyle: StyleUtility.quicksandRegular16TextStyle
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

              tabs: [
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabAuditionForYou,
                    textAlign: TextAlign.center,
                  )),
                ),
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabApprovedAuditions,
                    textAlign: TextAlign.center,
                  )),
                ),
              ],
            ),
            Expanded(child: Consumer<TalentHomeScreenProvider>(
                builder: (context, talentHomeScreenProvider, child) {
              return TabBarView(
                children: [
                  talentHomeScreenProvider.isLoading == true
                      ? const CustomCircularLoaderWidget()
                      : AuditionForYouWidget(
                          auditionforyouList: talentHomeScreenProvider
                              .talentHomeResponseModel
                              ?.data
                              ?.auditionforyouList,
                          talentHomeScreenProvider: talentHomeScreenProvider,
                        ),
                  talentHomeScreenProvider.isLoading == true
                      ? const CustomCircularLoaderWidget()
                      : ApprovedAuditionWidget(
                          approvedAuditionList: talentHomeScreenProvider
                              .talentHomeResponseModel
                              ?.data
                              ?.approvedAuditionList,
                      talentHomeScreenProvider:talentHomeScreenProvider

                        ),
                ],
              );
            }))
          ],
        ),
      ),
    );
  }


}


