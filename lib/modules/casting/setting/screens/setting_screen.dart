import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/bottomBar/screen/cast_bottom_bar_screen.dart';
import 'package:talent_app/modules/intro/intro_screen.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: ColorUtility.colorWhite,
        centerTitle: true,
        elevation: 0,
        title: Text(
          context.loc.headerSettings,
          style: StyleUtility.kantumruyProMedium5457BETextStyle
              .copyWith(fontSize: TextSizeUtility.textSize20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            SettingTileWidget(
              title: context.loc.settingEditProfile,
              image: ImageUtility.editProfileIcon,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.castBottomBarScreen,
                    arguments: {"selectIndex": 3},
                        (route) => false);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 14.h, bottom: 14.h),
                child: Row(
                  children: [
                    Image.asset(
                      ImageUtility.languageIcon,
                      width: 26.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      context.loc.settingLanguage,
                      style: StyleUtility.quicksandMediumBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize18),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "EN",
                          style: StyleUtility.quicksandMediumBlackTextStyle
                              .copyWith(fontSize: TextSizeUtility.textSize18),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          ImageUtility.arrowForwardIcon,
                          height: 17.w,
                          fit: BoxFit.fill,
                          color: ColorUtility.color5457BE,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.settingDeleteAccount,
              image: ImageUtility.deleteAccountIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.settingAccountStatus,
              image: ImageUtility.accountStatusIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.settingNotificationSettings,
              image: ImageUtility.notificationSettingIconIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.settingSignOut,
              image: ImageUtility.signOutIcon,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IntroScreen()),
                    (route) => false);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SizedBox(
              height: 35.h,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTileWidget extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const SettingTileWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 14.h, bottom: 14.h),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 26.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              title,
              style: StyleUtility.quicksandMediumBlackTextStyle
                  .copyWith(fontSize: TextSizeUtility.textSize18),
            )
          ],
        ),
      ),
    );
  }
}
