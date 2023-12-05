import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/home/providers/cast_home_screen_provider.dart';
import 'package:talent_app/modules/casting/home/widgets/Audition_finished_widget.dart';
import 'package:talent_app/modules/casting/home/widgets/audition_created_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/create_audition_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class CastHomeScreen extends StatefulWidget {
  const CastHomeScreen({super.key});

  @override
  State<CastHomeScreen> createState() => _CastHomeScreenState();
}

class _CastHomeScreenState extends State<CastHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CastHomeScreenProvider>(context, listen: false)
        .getHomeDataForCaster(onFailure: (message) {
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
                          colors: [
                            ColorUtility.color1B215C,
                            ColorUtility.color263287,
                            ColorUtility.color857784,
                            ColorUtility.colorEFC275,
                          ])),
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
                            const MenuButtonWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
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
            Expanded(child: Consumer<CastHomeScreenProvider>(
                builder: (context, castHomeScreenProvider, child) {
              return TabBarView(
                children: [
                  castHomeScreenProvider.isLoading == truegit
                      ? const CustomCircularLoaderWidget()
                      : AuditionCreatedWidget(
                          createAudition: castHomeScreenProvider
                              .castHomeResponseModel?.data?.createAudition,
                        ),
                  AuditionFinishedWidget(
                      finishedAudition: castHomeScreenProvider
                          .castHomeResponseModel?.data?.finishedAudition),
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
